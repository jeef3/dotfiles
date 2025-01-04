#!/usr/bin/env node

import fs from "node:fs";
import childProcess from "node:child_process";
import util from "node:util";

import { checkbox, confirm, Separator } from "@inquirer/prompts";
import { parse } from "yaml";
import chalk from "chalk";
import ora from "ora";

import

type Config = {
  taps: string[];

  templates: Template[];
};

type Template = {
  name: string;
  default: boolean;
  type: "formula" | "cask";
  items: Item[];
};

type Item =
  | string
  | {
      name: string;
      value?: string;
      description?: string;
      default?: boolean;
      type?: "formula" | "cask";
    };

const exec = util.promisify(childProcess.exec);
const readFile = util.promisify(fs.readFile);

const spinner = ora("Checking installed casks and formulas…");
spinner.start();

const { stdout: userInstalledFormulasRaw } = await exec(
  "brew leaves --installed-on-request",
);
const { stdout: allInstalledFormulasRaw } = await exec("brew list");
const { stdout: casksRaw } = await exec("brew list --casks");

spinner.stop();

const config: Config = parse(await readFile("../setup/install.yml", "utf-8"));

const userInstalledFormulas = userInstalledFormulasRaw
  .trim()
  .split("\n")
  .map((f) => f.match(/[^\/]+$/)?.[0] ?? "");
const allInstalledFormulas = allInstalledFormulasRaw
  .trim()
  .split("\n")
  .map((f) => f.match(/[^\/]+$/)?.[0] ?? "");
const installedCasks = casksRaw.trim().split("\n");

const theme: Parameters<typeof checkbox>[0]["theme"] = {
  prefix: {
    idle: chalk.blueBright("󰄾"),
    done: chalk.greenBright(" "),
  },
  icon: {
    checked: chalk.greenBright(""),
    unchecked: chalk.gray(""),
    cursor: "󰅂",
  },
  helpMode: "never",
};

const formularChoices: Parameters<typeof checkbox>[0]["choices"] =
  config.templates
    .filter((t) => t.type === "formula")
    .flatMap((c) => [
      new Separator(chalk.bold(c.name)),
      ...c.items.map((i) => ({
        ...(typeof i === "string"
          ? { name: i, value: i }
          : {
              name: i.name,
              value: i.value ?? i.name,
              description: i.description ?? "",
            }),
        checked: allInstalledFormulas.includes(
          typeof i === "string" ? i : (i.value ?? i.name),
        )
          ? true
          : c.default,
      })),
    ]);

const install = (await checkbox({
  message: "Select formulas/casks to install",
  pageSize: 14,
  choices: formularChoices,
  theme,
})) as string[];

const toInstall = install.filter((i) => !allInstalledFormulas.includes(i));
const toRemove = userInstalledFormulas.filter((i) => !install.includes(i));

if (toRemove.length) {
  console.log(chalk.bold("Uninstall Formulas?"));
  console.log(
    "The following packages have been deselected and can be uninstalled:",
  );

  toRemove.map((f) => console.log(` ${chalk.redBright("")} ${chalk.bold(f)}`));

  const answer = await confirm({
    message: "Uninstall these packages?",
    default: false,
  });

  if (answer) {
    for (const f of toRemove) {
      const spinner = ora(`${chalk.gray("Uninstalling")} ${chalk.bold(f)}…`);
      spinner.start();

      let result: { stdout: string; stderr: string };

      try {
        result = await exec(`brew uninstall ${f}`);
      } catch (e) {
        spinner.fail(`${chalk.bold(f)} ${chalk.dim("uninstall failed")}`);
        continue;
      }

      result.stderr
        ? spinner.fail(`${chalk.bold(f)} ${chalk.dim("uninstall failed")}`)
        : spinner.succeed(`${chalk.bold(f)} ${chalk.dim("uninstalled")}`);
    }
  }
}

if (toInstall.length) {
  console.log(chalk.bold("Install Formulas?"));
  console.log(
    "The following packages have been selected but are not installed:",
  );

  toInstall.map((f) => console.log(` ${chalk.cyan("")} ${chalk.bold(f)}`));

  const answer = await confirm({
    message: "Install these packages?",
    default: true,
  });

  if (answer) {
    for (const f of toInstall) {
      const spinner = ora(`${chalk.gray("Installing")} ${chalk.bold(f)}…`);
      spinner.start();

      let result: { stdout: string; stderr: string };

      try {
        result = await exec(`brew install ${f}`);
      } catch (e) {
        spinner.fail(`${chalk.bold(f)} ${chalk.dim("install failed")}`);
        continue;
      }

      result.stderr
        ? spinner.stopAndPersist({
            symbol: chalk.yellowBright(""),
            text: ` ${chalk.yellowBright.bold(f)} ${chalk.yellowBright(`install failed ↴\n ${chalk.white.dim(result.stderr)}`)}`,
          })
        : spinner.succeed(`${chalk.bold(f)} ${chalk.dim("installed")}`);
    }
  }
}

// console.log(JSON.stringify(re[0], null, 2));
