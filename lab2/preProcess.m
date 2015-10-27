function imageOut=preProcess(image)

% wiener filtering
%imageOut = double(image);
imageOut=wiener3(image);
%include here other preprocessing steps
%imageOut=median3(image);


