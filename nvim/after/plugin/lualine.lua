require('lualine').setup {
    options = {
        icons_enabled = true,
        theme = 'onedark',
        component_separators = { left = '', right = ''},
        section_separators = { left = '', right = ''},
        ignore_focus = {},
        show_tabs_always = true,
        always_divide_middle = true,
        globalstatus = false,
        refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
        }
    },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff'},
        lualine_c = {
            {'diagnostics',
                sources={'nvim_lsp'},
                update_in_insert = true,
            }
        },
        lualine_x = {},
        lualine_y = {},
        lualine_z = {'git_blame'}
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {
        lualine_a = {'filetype'},
        lualine_b = {{'filename', path=1}},
        lualine_c = {},
        lualine_x = {'progress'},
        lualine_y = {'location'},
        lualine_z = {'buffers'}
    },
    winbar = {},
    inactive_winbar = {},
    extensions = {}
}
