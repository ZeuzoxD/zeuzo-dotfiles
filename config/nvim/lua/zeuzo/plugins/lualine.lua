return {
   "nvim-lualine/lualine.nvim",
   dependencies = { "nvim-tree/nvim-web-devicons" },
   config = function()
      local lualine = require("lualine")
      local lazy_status = require("lazy.status") -- to configure lazy pending updates count

      local colors = {
         black = "#0d0e17",
         red = "#ff5f87",
         green = "#5fffaf",
         yellow = "#ffffaf",
         blue = "#5fafff",
         magenta = "#af87ff",
         cyan = "#87d7ff",
         white = "#d7d7d7",
         -- bg = "#1c1e26",
         bg = "#161616",
         fg = "#a1a6b2",
      }

      local my_lualine_theme = {
         normal = {
            a = { fg = colors.black, bg = colors.blue },
            b = { fg = colors.white, bg = colors.black },
            c = { fg = colors.white, bg = colors.bg },
         },
         insert = {
            a = { fg = colors.black, bg = colors.green },
            b = { fg = colors.white, bg = colors.black },
            c = { fg = colors.white, bg = colors.bg },
         },
         visual = {
            a = { fg = colors.black, bg = colors.yellow },
            b = { fg = colors.white, bg = colors.black },
            c = { fg = colors.white, bg = colors.bg },
         },
         replace = {
            a = { fg = colors.black, bg = colors.red },
            b = { fg = colors.white, bg = colors.black },
            c = { fg = colors.white, bg = colors.bg },
         },
         command = {
            a = { fg = colors.black, bg = colors.magenta },
            b = { fg = colors.white, bg = colors.black },
            c = { fg = colors.white, bg = colors.bg },
         },
         inactive = {
            a = { fg = colors.white, bg = colors.black },
            b = { fg = colors.white, bg = colors.black },
            c = { fg = colors.white, bg = colors.bg },
         },
      }

      -- configure lualine with modified theme
      lualine.setup({
         options = {
            theme = my_lualine_theme,
            icons_enabled = true,
            component_separators = { left = "", right = "" },
            section_separators = { left = "█", right = "█" },
         },
         sections = {
            lualine_x = {
               {
                  lazy_status.updates,
                  cond = lazy_status.has_updates,
                  color = { fg = "#ff9e64" },
               },
               { "encoding" },
               { "fileformat" },
               { "filetype" },
            },
         },
      })
   end,
}
