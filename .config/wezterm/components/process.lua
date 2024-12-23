local wezterm = require("wezterm")

local icons = {
  ["bash"] = wezterm.nerdfonts.cod_terminal_bash,
  ["btop"] = wezterm.nerdfonts.md_chart_areaspline,
  ["bun"] = wezterm.nerdfonts.md_hamburger,
  ["cargo"] = wezterm.nerdfonts.dev_rust,
  ["curl"] = wezterm.nerdfonts.md_flattr,
  ["default"] = wezterm.nerdfonts.md_application,
  ["docker"] = wezterm.nerdfonts.linux_docker,
  ["docker-compose"] = wezterm.nerdfonts.linux_docker,
  ["gh"] = wezterm.nerdfonts.dev_github_badge,
  ["git"] = wezterm.nerdfonts.dev_git,
  ["go"] = wezterm.nerdfonts.md_language_go,
  ["htop"] = wezterm.nerdfonts.md_chart_areaspline,
  ["lazygit"] = wezterm.nerdfonts.cod_github,
  ["lua"] = wezterm.nerdfonts.seti_lua,
  ["make"] = wezterm.nerdfonts.seti_makefile,
  ["nix"] = wezterm.nerdfonts.linux_nixos,
  ["node"] = wezterm.nerdfonts.md_nodejs,
  ["npm"] = wezterm.nerdfonts.md_npm,
  ["nvim"] = wezterm.nerdfonts.custom_neovim,
  ["pnpm"] = wezterm.nerdfonts.md_npm,
  ["ruby"] = wezterm.nerdfonts.cod_ruby,
  ["rust"] = wezterm.nerdfonts.dev_rust,
  ["ssh"] = wezterm.nerdfonts.md_pipe,
  ["sudo"] = wezterm.nerdfonts.fa_hashtag,
  ["vim"] = wezterm.nerdfonts.dev_vim,
  ["wget"] = wezterm.nerdfonts.md_arrow_down_box,
  ["yarn"] = wezterm.nerdfonts.seti_yarn,
  ["zsh"] = wezterm.nerdfonts.cod_terminal_zsh,
}

local function basename(str)
  if str then
    return string.gsub(str, "(.*[/\\])(.*)", "%2")
  else
    return " "
  end
end

return function(window)
  local pane = window:active_pane()
  local process_full_name = pane:get_foreground_process_name()

  if process_full_name == nil then
    return ""
  end

  local process_name = basename(process_full_name)

  if process_name then
    local icon = icons[process_name]

    if icon then
      return " " .. icon .. " " .. process_name .. " "
    else
      return " " .. wezterm.nerdfonts.dev_terminal .. " " .. process_name .. " "
    end
  else
    return " "
  end
end
