function lla --wraps='cls clear' --wraps='lsd -la' --description 'alias lla=lsd -la'
  lsd -la $argv; 
end
