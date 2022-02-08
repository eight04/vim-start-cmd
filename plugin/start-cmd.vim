command -bang Cmd silent call StartCmd(<bang>0)

if !exists("g:start_cmd_clear_env")
  let g:start_cmd_clear_env = ["MYVIMRC", "VIM", "VIMRUNTIME", "LANG"]
endif

function StartCmd(from_root)
  let cd_ok = 0
  if !a:from_root
    try
      cd %:h
      let cd_ok = 1
    catch
      " pass
    endtry
  endif
  let old_env = s:RemoveEnv(g:start_cmd_clear_env)
  !start cmd
  if !a:from_root && cd_ok
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

