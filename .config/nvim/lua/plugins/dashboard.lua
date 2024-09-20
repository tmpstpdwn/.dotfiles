_G.OpenTODOFile = function()
    local todo_file = vim.fn.expand("~/TODO")
    vim.cmd("tabedit" .. todo_file)
end

require('dashboard').setup {
  theme = 'doom',
  config = {
    header = {'',
    '',
    '',
    '',
    '    ████████╗███╗   ███╗██████╗ ███████╗████████╗██████╗ ██████╗ ██╗    ██╗███╗   ██╗',
    '    ╚══██╔══╝████╗ ████║██╔══██╗██╔════╝╚══██╔══╝██╔══██╗██╔══██╗██║    ██║████╗  ██║',
    '       ██║   ██╔████╔██║██████╔╝███████╗   ██║   ██████╔╝██║  ██║██║ █╗ ██║██╔██╗ ██║',
    '       ██║   ██║╚██╔╝██║██╔═══╝ ╚════██║   ██║   ██╔═══╝ ██║  ██║██║███╗██║██║╚██╗██║',
    '       ██║   ██║ ╚═╝ ██║██║     ███████║   ██║   ██║     ██████╔╝╚███╔███╔╝██║ ╚████║',
    '       ╚═╝   ╚═╝     ╚═╝╚═╝     ╚══════╝   ╚═╝   ╚═╝     ╚═════╝  ╚══╝╚══╝ ╚═╝  ╚═══╝',
    '',
    '',
    ''},
    center = {
      {
        desc = '  Lazy',
        desc_hl = 'String',
        key = 'l',
        key_hl = 'Number',
        key_format = ' [%s]', -- remove default surrounding `[]`
        action = 'Lazy'
      },
      {
        desc = '  Recent Files',
        desc_hl = 'String',
        key = 'o',
        key_hl = 'Number',
        key_format = ' [%s]', -- remove default surrounding `[]`
        action = 'Telescope oldfiles'
      },
      {
        desc = '  Search Files',
        desc_hl = 'String',
        key = 'f',
        key_hl = 'Number',
        key_format = ' [%s]', -- remove default surrounding `[]`
        action = 'Telescope find_files'
      },
      {
        desc = '  TODO',
        desc_hl = 'String',
        key = 't',
        key_hl = 'Number',
        key_format = ' [%s]', -- remove default surrounding `[]`
        action = 'lua OpenTODOFile()'
      },
 
    },
    footer = {'', 'Carpe diem', ''}  
},
}


