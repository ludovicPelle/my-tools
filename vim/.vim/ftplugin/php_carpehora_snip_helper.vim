if exists('s:did_carpehora_snip_helper') || &cp || !exists('loaded_snips')
    finish
endif
let s:did_carpehora_snip_helper = 1 

let g:snips_company = 'Carpe Hora SARL'

fun! SnippetUcFirst(str)
  return substitute(a:str, '\(^[a-z]\)', '\U\1', '')
endf

fun! SnippetExtendClass(str)
  if [[ -z str ]]
  then
    return " extends $str" ;
  else
    return "";
  fi
endf

function! Snippet_PHPClassNameFromFilename(...)
    let name = expand("%:t:r:r")
    if len(name) == 0
        if a:0 == 0
            let name = 'MyClass'
        else
            let name = a:1
        endif
    endif
    return name
endfunction

function! Snippet_Camelcase(s)
  "upcase the first letter
  let toReturn = substitute(a:s, '^\(.\)', '\=toupper(submatch(1))','')
  "turn all '_x' into 'X'
  return substitute(toReturn, '_\(.\)','\=toupper(submatch(1))', 'g')
endfunction
    
function! Snippet_Underscore(s)
  "down the first letter
  let toReturn = substitute(a:s, '^\(.\)', '\=tolower(submatch(1))', '')
  "turn all 'X' into '_x'
  return substitute(toReturn, '\([A-Z]\)', '\=tolower("_".submatch(1))', 'g')
endfunction
