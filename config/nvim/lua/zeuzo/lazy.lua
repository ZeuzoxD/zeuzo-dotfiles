local lazypath = vim.fn.stdpath("data").."/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/floke/lazy.nvim.git",
    "--branch=stable", -- latest stable version
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({ { import = "zeuzo.plugins" }, { import = "zeuzo.plugins.lsp" } },{
  checker = {
    enabled = true,
    notify = false,
  },
  change_detection = {
    notify = false,
  },
})

