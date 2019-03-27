valid_label = zeros(10, 256 ,256,1);
for i=1:100
    file_name = sprintf("F:\\data\\brain\\db_valid\\%03d.png",i);
    valid_label(i,:,:,1) = imread(file_name);
end
