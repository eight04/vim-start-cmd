command -bang Cmd silent call StartCmd(<bang>0)

if !exists("g:start_cmd_clear_env")
  let g:start_cmd_clear_env = ["MYVIMRC", "VIM", "VIMRUNTIME", "LANG"]
endif

function StartCmd(from_root)
  if !a:from_root
    cd %:h
  endif
  let old_env = s:RemoveEnv(g:start_cmd_clear_env)
  !start cmd
  if !a:from_root
    cd -
  endif
  call s:AddEnv(old_env)
endfunction

function s:RemoveEnv(list)
  let result = {}
  for i in a:list
    execute "let result[i] = $" . i
    execute "unlet $" . i
  endfor
  return result
endfunction

function s:AddEnv(d)
  for [key, value] in items(a:d)
    execute "let $" . key . " = " . string(value)
  endfor
endfunction

