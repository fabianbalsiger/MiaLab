
function [X,Y]=extractFeaturesSingleImage(path2Image,path2LabelImage,proportionSamples)

    myImage=mha_read_volume(path2Image);
    % preprocess image
     
    disp('----preprocessing image');
    myImage=preProcess(myImage);
    %Read label image so we sample on "femur" tissues 
    myImageLabel=mha_read_volume(path2LabelImage);    
    
    %Extract voxel values with class 1 (femur)
    I=find(myImageLabel==1);
    [If,Jf,Kf]=ind2sub(size(myImage),I);
    
    %do the same for non femur bone
     I=find(myImageLabel~=1);
    [Ib,Jb,Kb]=ind2sub(size(myImage),I);
     disp('----selecting samples from image...');
    %take a proportion for both background and foreground samples and store per row
    nsamples=round(proportionSamples*size(If,1));
    samplesForeground = datasample([If,Jf,Kf],nsamples);
    samplesBackground=datasample([Ib,Jb,Kb],nsamples);
    
    %init array to hold sample values
    Xf=zeros(size(samplesForeground,1),5); %3=nfeatures (av, std, entropy, etc..)
    Xb=zeros(size(Xf));
    Yf=zeros(size(samplesForeground,1),1);
    Yb=zeros(size(Yf));
    
    %compute average an std images
    imgAv=zeros(size(myImage));
    imgStd=zeros(size(myImage));
    imgEnt=zeros(size(myImage));
    imgSkw = zeros(size(myImage,2),size(myImage,3));
    imgLoc = zeros(size(myImage));
    pos = ceil(size(myImage, 2) * 0.6); % 60 percent in x-direction are femur
    
    h = fspecial('average');
    % option here is to use convolution
    for k=1:size(myImage,3)
        imgStd(:,:,k) = stdfilt(myImage(:,:,k));
        imgAv(:,:,k)=imfilter(myImage(:,:,k),h);
        imgEnt(:,:,k)=entropyfilt(myImage(:,:,k));
        imgSkw(:,k) = skewness(myImage(:,:,k));
        imgLoc(:,1:pos,k) = 1;
    end 
    
    disp('----building feature vector for samples...');
    for j=1:size(samplesForeground,1)
         av=imgAv(samplesForeground(j,1),samplesForeground(j,2),samplesForeground(j,3));
         vari=imgStd(samplesForeground(j,1),samplesForeground(j,2),samplesForeground(j,3));
         ent=imgEnt(samplesForeground(j,1),samplesForeground(j,2),samplesForeground(j,3));
         skw = imgSkw(samplesForeground(j,1),samplesForeground(j,3));
         pos = imgLoc(samplesForeground(j,1),samplesForeground(j,2),samplesForeground(j,3));
         Xf(j,:)=[av,vari,ent, skw, pos];
         Yf(j)=1;
         
         %same for background samples
         av=imgAv(samplesBackground(j,1),samplesBackground(j,2),samplesBackground(j,3));
         vari=imgStd(samplesBackground(j,1),samplesBackground(j,2),samplesBackground(j,3));
         ent=imgEnt(samplesBackground(j,1),samplesBackground(j,2),samplesBackground(j,3));
         skw = imgSkw(samplesBackground(j,1),samplesBackground(j,3));
         pos = imgLoc(samplesBackground(j,1),samplesBackground(j,2),samplesBackground(j,3));
         Xb(j,:)=[av,vari,ent, skw, pos];
         Yb(j)=0;
    end
    
    
    X=[Xf;Xb];
    Y=[Yf;Yb];