function ship = getShipData(shipFilePath)
% ship = getShipData(shipFilePath)
% 从shipFilePath读取舰船信息列表，必须是excel文件

%% 读取舰船信息
[num,txt,raw] = xlsread(shipFilePath);   %%  读取Excel 表格
shipnumber = length(raw(:,2))-1;        %%  计算船数量
for i = 1 : shipnumber                  %%  转换数据
    ship(i).name            =   char(raw(i+1,2));
    ship(i).range           =   char(raw(i+1,3));
    ship(i).maxHP           =   cell2mat(raw(i+1,4));
    ship(i).hp              =   ship(i).maxHP;
    ship(i).firepower       =   cell2mat(raw(i+1,5));
    ship(i).baseFirepower   =   ship(i).firepower;
    ship(i).accuracy        =   cell2mat(raw(i+1,6));
    ship(i).armor           =   cell2mat(raw(i+1,7));
    ship(i).evasion         =   cell2mat(raw(i+1,8));
    ship(i).torpedo         =   cell2mat(raw(i+1,9));
    ship(i).baseTorpedo     =   ship(i).torpedo;
    ship(i).AA              =   cell2mat(raw(i+1,10));
    ship(i).AS              =   cell2mat(raw(i+1,11));
    ship(i).reconnaissance  =   cell2mat(raw(i+1,12));
    ship(i).luck            =   cell2mat(raw(i+1,13));
%     ship(i).aircraft        =   raw(i+1,14);
    ship(i).speed           =   cell2mat(raw(i+1,15));
    for hangarIndex = 1:4
        % 机库分布
        ship(i).hangar(hangarIndex) = cell2mat(raw(i+1,15+hangarIndex)); 
        % 航空战初始化信息
        aircraft(hangarIndex).count = ship(i).hangar(hangarIndex); % 记录本次战斗开始时的该格飞机数
        aircraft(hangarIndex).loss = 0; % 记录本次战斗已损失的飞机数，不会超过单次放飞数
        aircraft(hangarIndex).value = 0;
        aircraft(hangarIndex).type = 0;   % 设定：1 为轰炸机
                                          %      2 为鱼雷机
                                          %      3 为战斗机
                                          %      4 为侦察机
    end
    ship(i).aircraft = aircraft;
    ship(i).AANo = 1;                     % AANO记录该舰第几次迎击飞机，初始为1
    ship(i).penetrate = 0.6;              % 穿甲系数
    ship(i).number          =   raw(i+1,1);
    ship(i).crit            =   0.1;      % 基础暴击率
    ship(i).opCrit          =   0;        % 基础被暴击率
    %未完成
    ship(i).attackNum       =   0;
    ship(i).hitNum          =   0;
    ship(i).missNum         =   0;
    ship(i).critNum         =   0;
    ship(i).type            =   raw(i+1,20);
    ship(i).type2           =   raw(i+1,21);   %主力舰
%         ship(2).type2           =   'sup';    %护卫舰
    for equipIndex = 1:4
        ship(i).equip(equipIndex) = cell2mat(raw(i+1,21+equipIndex));
    end
    ship(i).order           =   cell2mat(raw(i+1,26)); % 自定义炮序
    ship(i).skill           =   char(raw(i+1,27));     % 技能名，没有为‘无’
    ship(i).nation          =   char(raw(i+1,28));     % 国籍，没有为‘无’
    ship(i).repairOil = 4.2;% 暂时采用狮的数据测试
    ship(i).repairSteel = 8;
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
