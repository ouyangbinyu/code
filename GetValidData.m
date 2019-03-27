clear
valid_data = zeros(10, 256 ,256,1); %训练数据是100张256*256的欠采样重建的脑图，杨亲亲说直接用重建出来的实部数据，所以是一个通道
mask_dirname = 'C:\Users\xmu\Desktop\cartes\mask_2\cartes_20.tif' 
mask = imread(mask_dirname);
mask_logic = logical(mask);%先把mask矩阵转换为逻辑矩阵
for i=1:10
    file_name = sprintf("F:\\data\\brain\\db_valid\\%03d.png",i)
    image_original = imread(file_name);
    k_space = fft2(image_original);%二维傅里叶变换转换为k空间
    k_space_change = k_space;
    k_space_change = k_space_change .* mask_logic;%k空间数据与mask逻辑矩阵做点乘
    % k_space_downsam = k_space .*mask
    % amp=abs(k_space);
    % logamp=log(amp);
    % ampmax=max(max(logamp));
    % ampmin=min(min(logamp));
    % newamp=(logamp-ampmin)/(ampmax-ampmin);
    %figure;imagesc(fftshift(abs(newamp)));colormap jet;colorbar
    %figure;imagesc(fftshift(abs(k_space)));colormap jet;colorbar
    image_full = ifft2(k_space);  %这里是原来的K空间重建出来的全采样图像
    image_downsam = ifft2(k_space_change);%欠采样K空间重建出来的图像
    re_image_downsam = real(image_downsam);%得到实部
    im_image_downsam = imag(image_downsam);%得到虚部
    
    %ima_down = ifft2(k_space_downsam)
    valid_data(i,:,:,:) = re_image_downsam;%这里我们只采用实部数据
    
    %figure(1);imagesc((abs(image_full)));colormap(gray);colorbar
    % figure(2);imagesc((image_original));colormap(gray);colorbar
    figure(3);imagesc((abs(image_downsam)));colormap(gray);colorbar
%     figure(4);imagesc((abs(re_image_downsam)));colormap(gray);colorbar
   
end