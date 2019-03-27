clear
valid_data = zeros(10, 256 ,256,1); %ѵ��������100��256*256��Ƿ�����ؽ�����ͼ��������˵ֱ�����ؽ�������ʵ�����ݣ�������һ��ͨ��
mask_dirname = 'C:\Users\xmu\Desktop\cartes\mask_2\cartes_20.tif' 
mask = imread(mask_dirname);
mask_logic = logical(mask);%�Ȱ�mask����ת��Ϊ�߼�����
for i=1:10
    file_name = sprintf("F:\\data\\brain\\db_valid\\%03d.png",i)
    image_original = imread(file_name);
    k_space = fft2(image_original);%��ά����Ҷ�任ת��Ϊk�ռ�
    k_space_change = k_space;
    k_space_change = k_space_change .* mask_logic;%k�ռ�������mask�߼����������
    % k_space_downsam = k_space .*mask
    % amp=abs(k_space);
    % logamp=log(amp);
    % ampmax=max(max(logamp));
    % ampmin=min(min(logamp));
    % newamp=(logamp-ampmin)/(ampmax-ampmin);
    %figure;imagesc(fftshift(abs(newamp)));colormap jet;colorbar
    %figure;imagesc(fftshift(abs(k_space)));colormap jet;colorbar
    image_full = ifft2(k_space);  %������ԭ����K�ռ��ؽ�������ȫ����ͼ��
    image_downsam = ifft2(k_space_change);%Ƿ����K�ռ��ؽ�������ͼ��
    re_image_downsam = real(image_downsam);%�õ�ʵ��
    im_image_downsam = imag(image_downsam);%�õ��鲿
    
    %ima_down = ifft2(k_space_downsam)
    valid_data(i,:,:,:) = re_image_downsam;%��������ֻ����ʵ������
    
    %figure(1);imagesc((abs(image_full)));colormap(gray);colorbar
    % figure(2);imagesc((image_original));colormap(gray);colorbar
    figure(3);imagesc((abs(image_downsam)));colormap(gray);colorbar
%     figure(4);imagesc((abs(re_image_downsam)));colormap(gray);colorbar
   
end