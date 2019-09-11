function [] = ShowResults(results)
% Displays the interactions between factors A,B,C
for img = 1 : size(results,3)
    figure;image(results(:,:,img));title(['Image: ' num2str(img)]),colorbar;
end
end