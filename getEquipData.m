function equip = getEquipData(equipFilePath)
% ship = getShipData(shipFilePath)
% 从shipFilePath读取舰船信息列表，必须是excel文件

%% 读取舰船信息
[num,txt,raw] = xlsread(equipFilePath);   %%  读取Excel表格
equipNumber = length(raw(:,2))-1;        %%  计算装备数量
for i = 1 : equipNumber                  %%  转换数据
    equip(i).no              =   cell2mat(raw(i+1,1));
    equip(i).name            =   char(raw(i+1,2));
    equip(i).range           =   char(raw(i+1,3));
    equip(i).firepower       =   cell2mat(raw(i+1,4));
    equip(i).accuracy        =   cell2mat(raw(i+1,5));
    equip(i).AA              =   cell2mat(raw(i+1,6));
    equip(i).AAMod           =   cell2mat(raw(i+1,7)); % 对空补正
    equip(i).torpedo         =   cell2mat(raw(i+1,8));
    equip(i).AS              =   cell2mat(raw(i+1,9));
    equip(i).bomb            =   cell2mat(raw(i+1,10));
    equip(i).armor           =   cell2mat(raw(i+1,11));
    equip(i).evasion         =   cell2mat(raw(i+1,12));
    equip(i).reconnaissance  =   cell2mat(raw(i+1,13));
    equip(i).luck            =   cell2mat(raw(i+1,14));
    equip(i).alu             =   cell2mat(raw(i+1,15)); % 铝耗

    equip(i).penetrate       =   cell2mat(raw(i+1,16)); % 附加穿甲系数
    equip(i).type            =   raw(i+1,17);           % 类型
end

%     Dock = containers.Map;  %初始化字典容器
%     Docknum =containers.Map;
%     for i = 1 : shipnumber
%         Dock( cell2mat( ship(i).name ) )=ship(i);                   %以船只名称为索引
%         Docknum( num2str( cell2mat( ship(i).number ) ) )=ship(i);   %以船只编号为索引
%     end
%         %% 这个不急
%     ship(1).repairOil = 4.8;% 暂时采用狮的数据测试
%     ship(1).repairSteel = 9;
%     ship(2).repairOil = 4.2;% 莉塞留
%     ship(2).repairSteel = 8;
