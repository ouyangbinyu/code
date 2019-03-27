%merge the Multiple acquisition tempd data for deep learning
%coding by Ouyang binyu 2019.3.14
% @XMU
clear all;

% dir_name1 = 'C:\Users\xmu\Desktop\eeg2\tempd_oled4_4_1.ccb';%�д��Ż������������������ݵ�ʱ����Ҫ
% dir_name2 = 'C:\Users\xmu\Desktop\eeg2\tempd_oled4_4_2.ccb';
% dir_name3 = 'C:\Users\xmu\Desktop\eeg2\tempd_oled4_4_3.ccb';
% dir_name4 = 'C:\Users\xmu\Desktop\eeg2\tempd_oled4_4_4.ccb';

points = 256;    %��������
nums = 16;        %��ɴ���
line_single = points/nums;      %���β�������

re = zeros(nums,line_single,points);
im = zeros(nums,line_single,points);
k_uknown = zeros(nums,line_single,points);
% [re(1,:,:),im(1,:,:),k_unknown(1,:,:)] = ExtractTempData(dir_name1,points); %��ȡ�ļ��е�ʵ���鲿�ļ�
% [re(2,:,:),im(2,:,:),k_unknown(2,:,:)] = ExtractTempData(dir_name2,points);
% [re(3,:,:),im(3,:,:),k_unknown(3,:,:)] = ExtractTempData(dir_name3,points);
% [re(4,:,:),im(4,:,:),k_unknown(4,:,:)] = ExtractTempData(dir_name4,points);
for i=1:nums
    dir_name = sprintf("C:\\Users\\xmu\\Desktop\\eeg2\\OLED256\\tempd_oled256_16_%d.ccb",i);
    [re(i,:,:),im(i,:,:),k_unknown(i,:,:)] = ExtractTempData(dir_name,points);
end

merge_re = zeros(points,points);
merge_im = zeros(points,points);
echo_order=0;
line_order = 1;
for i=1:points  %����βɼ����Ĳɵ���������䵽һ��K�ռ�
    echo_order = echo_order + 1;
    
    merge_re(i,:) =  re(echo_order,line_order,:);
    merge_im(i,:) =  im(echo_order,line_order,:);
    if echo_order == nums
        echo_order = 0;
        line_order = line_order + 1;
    end
    
end
merge_k_space = merge_re + 1i*merge_im;%�ϲ���ɵ�K�ռ�
amp=abs(merge_re+merge_im*1i);
logamp=log(amp);
ampmax=max(max(logamp));
ampmin=min(min(logamp));
newamp=(logamp-ampmin)/(ampmax-ampmin);

fprintf('The rearranged data has %d row and %d column.\n',size(re));
fprintf('The total intensity of the signal is %d.\n',sum(sum(amp)));

amp = flipud(amp);
newamp = flipud(newamp);

% mapping
figure(1);imagesc(amp);
title('amplitude');colormap(jet);colorbar;
figure(2);imagesc(newamp);
title('Normalized amplitude');colormap(jet);colorbar;
c = colorbar;c.Label.String = 'intensity';


colormap jet  
mri = fftshift(ifft2(merge_k_space));%����Ҷ�任֮���ͼ��
figure(3);imagesc(abs(mri));


