function pointList = drawStar(r,x,y,s)
pointList = [x + r/2 * (rem(1:s,2) + 1) .* sin(pi/s:2*pi/s:2*pi-pi/s);y + r/2 * (rem(1:s,2) + 1) .* cos(pi/s:2*pi/s:2*pi-pi/s)]';
end
