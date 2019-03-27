
function [re,im,k_unknown]=ExtractTempData(dir_name,point)
%K IN 3-D
% The two input parameters represent the signals of 3 channels and
% the number of points in each line after rearrangement, respectively.
% The three output parameters represent the real parts, imaginary parts 
% and an unknown parts of this signal in K space, respectively.
%���̴ϲ���ʦ��д��EEG�����tempd�ļ���������ʾ������������ά���ݵ���ʾ-ʵ���鲿��������֪����
%signal��������źţ���һ��һά�������������ų�һ���߶��ѣ�
%point��ʾreshape֮��һ�ж��ٸ���

if eq(mod(point,2),1)
    warning('The number of points must be 2^N.');
    re=[];
    im=[];
    k_unknown=[];
    return;
end
signal = load(dir_name)
% Split the signal into three one-dimensional signals.
re=signal(:,1); %ȡ����һ�е�����
im=signal(:,2);%ȡ���ڶ��е�����
k_unknown=signal(:,3);%ȡ�������е�����
% Rearrange data
re=reshape(re,point,[]);re=re'; 
im=reshape(im,point,[]);im=im';
k_unknown=reshape(k_unknown,point,[]);k_unknown=k_unknown';

[ro,co]=size(re);

% Flip the even rows and shift the first element to the last.
for i=1:ro
    if eq(mod(i,2),1)%�����в���
        re(i,:)=re(i,:);
        %re(i,:) = zeros();
    else
        re(i,:)=fliplr(re(i,:));
        b=[re(i,:),re(i,1)];
        b(1)=[];
        re(i,:)=b;
    end
end
for i=1:ro
    if eq(mod(i,2),1)
        im(i,:)=im(i,:);
        %im(i,:) = zeros();
    else
        im(i,:)=fliplr(im(i,:));
        b=[im(i,:),im(i,1)];b(1)=[];
        im(i,:)=b;
    end
end
for i=1:ro
    if eq(mod(i,2),1)
        k_unknown(i,:)=k_unknown(i,:);
    else
        k_unknown(i,:)=fliplr(k_unknown(i,:));
        b=[k_unknown(i,:),k_unknown(i,1)];b(1)=[];
        k_unknown(i,:)=b;
    end
end

% amplitude and the total intensity of the signal
amp=abs(re+im*1i);
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

k_space = re + 1i*im;
mri = fftshift(ifft2(k_space));
figure(3);imagesc(abs(mri));
colormap jet  
end
% saveas(gcf,'Normalized amplitude.jpg');