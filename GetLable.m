label = zeros(100, 256 ,256,1);
for i=1:100
    file_name = sprintf("F:\\data\\brain\\db_train\\%03d.png",i);
    label(i,:,:,1) = imread(file_name);
end


