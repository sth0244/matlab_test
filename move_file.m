clear 
tic
%mdf文件和视频文件路径
source='F:\asuntianhao\replay\source\20240520_1211\2';
%将上述文件保存为source.mat
save('source.mat','source');

%创建三个字符串，代表source路径下的三个文件夹，ori文件夹，video文件夹
%和data文件夹
Ori_path=[source,'\ori\'];
Video_path=[source,'\video\'];
Data_path=[source,'\data\'];
Blf_path=[source,'\blf\'];
%创建文件夹
mkdir(Ori_path);
mkdir(Video_path);
mkdir(Data_path);
mkdir(Blf_path);
%创建字符串
Video_name='video.avi';
Mf4_files = dir(fullfile(source,'*.mf4'));%找到该文件夹下的所有mf4文件
Mf4_filenames = {Mf4_files.name}'; %将所有mf4文件的名称保存为元胞数组
[Mf4_files_num,~]=size(Mf4_filenames); %前面的~是占位符，意思是我只要Mf4_filenames的行数


%将source文件夹下的mf4文件转移到ori文件夹
for Mf4_files_index=1:Mf4_files_num 
    if strcmp(Mf4_filenames{Mf4_files_index}(1,1:8),'Recorder')
        continue;
    end

    All_mf4=[source,'\',Mf4_filenames{Mf4_files_index}];%创建mf4文件的索引路径字符串
    Ori_mf4=[Ori_path,Mf4_filenames{Mf4_files_index}]; %创建所有
    movefile(All_mf4, Ori_mf4);
end
%获取source文件夹下所有后缀为.avi文件的视频文件
Video_files = dir(fullfile(source,'*.avi'));
Video_filenames = {Video_files.name}'; 
[Video_num,~]=size(Video_filenames);
%同样的将source文件夹下所有的.avi文件转移到video路径
for Video_index=1:Video_num
    Ori_vdeo=[source,'\',Video_filenames{Video_index}];
    Video_avi=[Video_path,Video_filenames{Video_index}];
    movefile(Ori_vdeo, Video_avi);
end

Ori_files = dir(fullfile(Ori_path,'*.mf4'));
Ori_filenames = {Ori_files.name}'; 
[All_num,~]=size(Ori_filenames);
%获取ori文件下的所有mf4的数量
Chassis_num=All_num/3;%三个mf4文件，底盘，雷达和视觉感知文件对应一个视频文件

%度取mf4文件的第9到27个字符，获取数据采集时的日期，创建以日期为名的文件夹
for Chassis_index=1:Chassis_num
    k=[Data_path,Ori_filenames{Chassis_index}(9:27)];
    mkdir(k);
end

%获取source文件夹下所有的blf文件
blf_files=dir(fullfile(source,'*.blf'));
blf_filenames = {blf_files.name}';
[blf_num,~]=size(blf_filenames);
%将source文件夹下所有的.blf文件转移到blf路径
for blf_index=1:blf_num

    Ori_blf=[source,'\',blf_filenames{blf_index}];
    blf_new=[Blf_path,'\',blf_filenames{blf_index}];
    movefile(Ori_blf, blf_new);
end



