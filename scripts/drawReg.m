function pointList = drawReg(r,x,y,s)
pointList = [x + r * sin(pi/s:2*pi/s:2*pi-pi/s);y + r * cos(pi/s:2*pi/s:2*pi-pi/s)]';
end

