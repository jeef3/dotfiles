local M = {}

local package_names = {}

local function package_for_file(file, cwd)
  if not vim.fs.relpath(cwd, file) then
    return
  end

  local package_json = vim.fs.find("package.json", {
    path = vim.fs.dirname(file),
    upward = true,
    stop = cwd,
  })[1]
  if not package_json then
    return
  end

  if package_names[package_json] == nil then
    local package = vim.json.decode(table.concat(vim.fn.readfile(package_json), "\n"))
    package_names[package_json] = package.name or false
  end

  local name = package_names[package_json]
  return name and { name = name, root = vim.fs.dirname(package_json) } or nil
end

function M.footer_for(item, cwd)
  local footer = {}
  if not (item and item.file) then
    return footer
  end

  local file = item.file
  if file:sub(1, 1) ~= "/" then
    file = vim.fs.joinpath(cwd, file)
  end

  local package = package_for_file(file, cwd)
  local path = vim.fs.relpath(package and package.root or cwd, file) or file
  local directory = vim.fs.dirname(path)
  if package then
    footer[#footer + 1] = { " " .. package.name, "SnacksPickerPackage" }
  end
  if directory ~= "." then
    footer[#footer + 1] = { " " .. directory, "SnacksPickerFooter" }
  end
  return footer
end

function M.on_change(picker, item)
  local box = picker.layout.box_wins[3]
  if not (box and box.win) then
    return
  end

  local footer = M.footer_for(item, picker:cwd())
  vim.api.nvim_win_set_config(box.win, {
    footer = #footer > 0 and footer or "",
    footer_pos = "center",
  })
end

return M
