function [ ] = imgHist( I )
    %IMGHIST Shows an image's histogram.
    %IMGHIST(I) show the histogram of the image I.

    [m,n] = size(I);
    maxVal = max(max(I));

    histoArr = zeros(maxVal);

    for x = 1:m
        for y = 1:n
            histoArr(I(x,y)) = histoArr(I(x,y)) + 1;
        end
    end

    figure;
    plot(1:maxVal,histoArr);
end

