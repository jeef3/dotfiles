local repo = vim.fn.fnamemodify(vim.fn.expand("<sfile>:p"), ":h:h")
vim.opt.rtp:append(repo .. "/.config/nvim")

local fixture = vim.fn.tempname()
vim.fn.mkdir(fixture .. "/packages/app/src", "p")
vim.fn.writefile({ '{"name":"@example/app"}' }, fixture .. "/packages/app/package.json")
vim.fn.writefile({ "export {}" }, fixture .. "/packages/app/src/index.ts")
vim.fn.writefile({ "plain" }, fixture .. "/README.md")

local footer = require("snacks_picker_footer")

local result = footer.footer_for({ file = "packages/app/src/index.ts" }, fixture)
assert(#result == 2)
assert(result[1][1] == " @example/app")
assert(result[1][2] == "SnacksPickerPackage")
assert(result[2][1] == " src")
assert(result[2][2] == "SnacksPickerFooter")

result = footer.footer_for({ file = "README.md" }, fixture)
assert(#result == 0)
assert(#footer.footer_for(nil, fixture) == 0)

vim.fn.delete(fixture, "rf")
print("snacks_picker_footer: OK")
