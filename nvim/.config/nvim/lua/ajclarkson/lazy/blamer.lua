return {
    'APZelos/blamer.nvim',
    config = function()
        vim.g.blamer_enabled = 0
        vim.g.blamer_relative_time = 1
        vim.g.blamer_delay = 250
        vim.keymap.set("n", "<leader>bl", ":BlamerToggle<CR>", { silent = true })
        -- Override to guard against oil:// virtual paths, which confuse git
        -- and cause errors because a git hook prints to stdout before the
        -- fatal error, breaking blamer's own 'fatal' prefix check.
        vim.cmd([[
            function! blamer#IsBufferGitTracked() abort
                let l:file_path = expand('%:p')
                if l:file_path =~# '^oil://'
                    return 0
                endif
                let l:file_path = shellescape(substitute(l:file_path, '\\', '/', 'g'))
                if empty(l:file_path)
                    return 0
                endif
                let l:dir_path = shellescape(substitute(expand('%:h'), '\\', '/', 'g'))
                let l:result = system('git -C ' . l:dir_path . ' ls-files --error-unmatch ' . l:file_path)
                if l:result[0:4] ==# 'fatal'
                    return 0
                endif
                return 1
            endfunction
        ]])
    end
}
