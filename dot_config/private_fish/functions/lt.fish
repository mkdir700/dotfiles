function lt --wraps='ls --tree' --wraps='lsd --tree' --description 'alias lt=lsd --tree'
  lsd --tree $argv; 
end
