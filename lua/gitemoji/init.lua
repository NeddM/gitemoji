local M = {}

M.check_if_push = function(args)
  local push = true
  for _, arg in ipairs(args) do
    if arg == "--no-push" then
      push = false
    end
  end
  return push
end

M.start_with_mayus = function(comment)
  return comment:gsub("^%l", string.upper)
end

M.git_status = function()
  local success, result = vim.cmd("!git status")
  if success then
    print("")
  else
    print("Error adding files: " .. result)
    vim.notify("Error: " .. result, vim.log.levels.ERROR)
  end
end

M.git_add = function(args)
  local args_clear = {}
  for _, arg in ipairs(args) do
    if arg ~= "--no-push" then
      print("\n")
      table.insert(args_clear, arg)
    end
  end

  if #args_clear > 0 then
    for _, arg in ipairs(args_clear) do
      local success, result = vim.cmd("!git add " .. arg)
      if success then
        print(arg .. " added.\n")
      else
        print("Error adding files: " .. result)
        vim.notify("Error: " .. result, vim.log.levels.ERROR)
      end
    end
  else
    local success, result = vim.cmd("!git add .")
    if success then
      print("Data added.\n")
    else
      print("Error adding files: " .. result)
      vim.notify("Error: " .. result, vim.log.levels.ERROR)
    end
  end
end

M.git_commit = function()
  vim.ui.input({ prompt = "Add a comment: " }, function(comment)
    print("\n")
    print("1. 🚀 Initial commit")
    print("2. 📁 Add files")
    print("3. 🐛 Bug fix")
    print("4. 🎉 Feature implementation")
    print("5. 🛠️ Refactoring")
    print("6. ⚡ Performance optimization")
    print("7. 🔄 Dependency updates")
    print("8. 📚 Documentation")
    print("9. 🗑️ File deletion")
    print("10. 🌿 Branch merging")
    print("11. ⏪ Revert commit")
    print("12. 🤖 Github action")
    print("13. 🐋 Docker")
    print("14. ☸️  Kubernetes")
    print("15. 🏗️ Terraform")
    vim.ui.input({ prompt = "Set an option: " }, function(option_emoji)
      if option_emoji == "1" then
        Emoji = "🚀"
      elseif option_emoji == "2" then
        Emoji = "📁"
      elseif option_emoji == "3" then
        Emoji = "🐛"
      elseif option_emoji == "4" then
        Emoji = "🎉"
      elseif option_emoji == "5" then
        Emoji = "🛠️"
      elseif option_emoji == "6" then
        Emoji = "⚡"
      elseif option_emoji == "7" then
        Emoji = "🔄"
      elseif option_emoji == "8" then
        Emoji = "📚"
      elseif option_emoji == "9" then
        Emoji = "🗑️"
      elseif option_emoji == "10" then
        Emoji = "🌿"
      elseif option_emoji == "11" then
        Emoji = "⏪"
      elseif option_emoji == "12" then
        Emoji = "🤖"
      elseif option_emoji == "13" then
        Emoji = "🐋"
      elseif option_emoji == "14" then
        Emoji = "☸️"
      elseif option_emoji == "15" then
        Emoji = "🏗️"
      else
        Emoji = "😶"
      end
      local processed_comment = M.start_with_mayus(comment)
      local commit_comment = '!git commit -m "' .. Emoji .. " " .. processed_comment .. '"'
      local success, result = vim.cmd(commit_comment)
      if success then
        print("Comment " .. processed_comment .. " added.\n")
      else
        print("Error adding a comment: " .. result)
        vim.notify("Error" .. result, vim.log.levels.ERROR)
      end
    end)
  end)
end

M.git_push = function(check_push)
  if check_push == true then
    local success, result = vim.cmd("!git push")
    if success then
      print("Commit pushed!\n")
    else
      print("Error pushing: " .. result)
      vim.notify("Error" .. result, vim.log.levels.ERROR)
    end
  else
    print("Push skiped!")
  end
end

M.main = function(...)
  local args = { ... }
  local check_push = M.check_if_push(args)
  M.git_status()
  M.git_add(args)
  M.git_commit()
  M.git_push(check_push)
end

M.setup = function()
  vim.api.nvim_command("command! -nargs=* Gitemoji lua require('gitemoji').main(<f-args>)")
end

return M
