filename = input("file name: ", 's');
filename = strcat('hw_', filename, '.m');
fileID = fopen(filename, 'w');
fprintf(fileID, 'clear;\nclose all;\nclc;\n');
fclose(fileID);

% 打开文件
open(filename);
