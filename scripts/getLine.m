function out = getLine(file)

out = '%';
while ~isempty(out) && out(1)=='%'
    out = fgetl(file);
end

for i=1:length(out)
    if out(i) == '%'
        out = out(1:i-1);
        break;
    end
end


end

