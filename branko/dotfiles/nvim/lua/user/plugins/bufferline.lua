require('bufferline').setup({
    options = {
        indicator = {
            icon = ' ',
        },
        tab_size = 0,
        max_name_length = 25,
        offsets = {
            {
                filetype = 'NvimTree',
                text = ' Files',
                highlight = 'StatusLine',
                text_align = 'left'
            }
        },
        separator_style = 'slant',
        modified_icon = '*',
        custom_areas = {
            left = function()
                return {
                    {
                        text = ' V ', fg = '#8fff6d'
                    }
                }
            end,
        },
    },
    highlights = {
        fill = {
            bg = { attribute = 'bg', highlight = 'StatusLine' },
        },
        background = {
            bg = { attribute = 'bg', highlight = 'StatusLine' },
        },
        tab = {
            bg = { attribute = 'bg', highlight = 'StatusLine' },
        },
        tab_close = {
            bg = { attribute = 'bg', highlight = 'StatusLine' },
        },
        close_button = {
            bg = { attribute = 'bg', highlight = 'StatusLine' },
        },
        close_button_visible = {
            bg = { attribute = 'bg', highlight = 'StatusLine' },
            fg = { attribute = 'fg', highlight = 'StatusLineNonText' },
        },
        close_button_selected = {
            fg = { attribute = 'fg', highlight = 'StatusLineNonText' },
        },
        buffer_visible = {
            bg = { attribute = 'bg', highlight = 'StatusLine' },
        },
        modified = {
            bg = { attribute = 'bg', highlight = 'StatusLine' },
        },
        modified_visible = {
            bg = { attribute = 'bg', highlight = 'StatusLine' },
        },
        duplicate = {
            bg = { attribute = 'bg', highlight = 'StatusLine' },
        },
        duplicate_visible = {
            bg = { attribute = 'bg', highlight = 'StatusLine' },
        },
        separator = {
            bg = { attribute = 'bg', highlight = 'Normal' },
            fg = { attribute = 'bg', highlight = 'StatusLine' },
        },
        separator_selected = {
            bg = { attribute = 'bg', highlight = 'StatusLine' },
            fg = { attribute = 'fg', highlight = 'Normal' },
        },
        separator_visible = {
            bg = { attribute = 'bg', highlight = 'StatusLine' },
            fg = { attribute = 'bg', highlight = 'StatusLine' },
        },
    }
})

