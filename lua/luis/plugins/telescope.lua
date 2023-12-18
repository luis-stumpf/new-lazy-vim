return {
  'nvim-telescope/telescope.nvim',
  -- tag = '0.1.5',
  branch = '0.1.x',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function ()

    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      defaults = {
        path_display = { "smart" },
        path = '~/.local/share/nvim/databases/telescope_history.sqlite3',
        limit = 1000,
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous, -- move to prev result
            ["<C-j>"] = actions.move_selection_next, -- move to next result
            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
          },
        },
      },
    })

    function vim.getVisualSelection()
      vim.cmd('noau normal! "vy"')
      local text = vim.fn.getreg('v')
      vim.fn.setreg('v', {})

      text = string.gsub(text, "\n", "")
      if #text > 0 then
        return text
      else
        return ''
      end
    end

    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
    vim.keymap.set('n', '<C-p>', builtin.git_files, {})
    vim.keymap.set('n', '<leader>ps', builtin.live_grep, {})
    vim.keymap.set('v', '<leader>ps', function ()
      local text = vim.getVisualSelection()
      builtin.live_grep({ default_text = text })
    end)
    vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})
  end
}

