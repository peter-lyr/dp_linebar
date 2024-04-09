local sta, B = pcall(require, 'dp_base')

if not sta then return print('Dp_base is required!', debug.getinfo(1)['source']) end

vim.cmd [[
  hi WinBar   guibg=#442288 guifg=yellow gui=bold
  hi WinBarNC guibg=#1a1a1a guifg=#999999 gui=bold
]]

function GetWinbarFname(fname)
  WinbarRoot = ''
  fname = vim.fn.fnamemodify(fname, ':p')
  if B.is_file(fname) == 1 then
    WinbarRoot = vim.fn['ProjectRootGet'](fname)
  end
  return B.get_relative_fname(fname, WinbarRoot)
end

function GetWinbarRoot()
  return WinbarRoot
end

function StatusLineFname()
  return string.gsub(vim.api.nvim_buf_get_name(0), '/', '\\')
end

vim.opt.winbar     = '%{v:lua.GetWinbarFname(expand("%f"))}%=%{v:lua.GetWinbarRoot()}'
vim.opt.statusline = [[%<%#Title#%{v:lua.StatusLineFname()} %h%m%r %#Character#%{mode()} %#Normal#%=%<%-14.(%l,%c%V%) %P]]
