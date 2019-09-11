function niceSurface(metric,figuresDir)
varToStr = @(x) inputname(1);
meticName = varToStr(metric);
fig = figure;
hMean = surf(metric,'FaceAlpha',0.8);colormap(a);
hMean.EdgeColor = 'none';
ax = gca; box on;ax.BoxStyle = 'full';
view(-20,30);
savefig(fig,fullfile(figuresDir,meticName,'.fig'));
close(fig);
end