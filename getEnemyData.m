function ship = getEnemyData(shipFilePath)
% ship = getShipData(shipFilePath)
% 从shipFilePath读取舰船信息列表，必须是excel文件
[num,txt,raw] = xlsread(shipFilePath);   %%  读取Excel 表格
shipnumber = length(raw(:,2))-1;        %%  计算船数量
for i = 1 : shipnumber                  %%  转换数据
    ship(i).id              =   cell2mat(raw(i+1,1));
    ship(i).name            =   char(raw(i+1,2));
    ship(i).type            =   char(raw(i+1,3));
    ship(i).level           =   cell2mat(raw(i+1,4));
    ship(i).maxHP           =   cell2mat(raw(i+1,5));
    ship(i).hp              =   ship(i).maxHP;
    ship(i).firepower       =   cell2mat(raw(i+1,6));    
    ship(i).accuracy        =   cell2mat(raw(i+1,7)) + ship(i).level*0.97; % 没有基础命中数据，以等级*0.97代替，即默认97命中
    ship(i).armor           =   cell2mat(raw(i+1,8));
    ship(i).torpedo         =   cell2mat(raw(i+1,9));
    ship(i).baseTorpedo     =   ship(i).torpedo;
    ship(i).evasion         =   cell2mat(raw(i+1,10));
    ship(i).AA              =   cell2mat(raw(i+1,11));
    ship(i).AAaug           =   cell2mat(raw(i+1,12));%%对空补正系数？？
    ship(i).AS              =   cell2mat(raw(i+1,13));
    ship(i).reconnaissance  =   cell2mat(raw(i+1,14));
    ship(i).speed           =   cell2mat(raw(i+1,15));
    ship(i).range           =   char(raw(i+1,16));
    ship(i).luck            =   0;
    for hangarIndex = 1:4
        % 机库分布
        ship(i).hangar(hangarIndex) = cell2mat(raw(i+1,16+2*hangarIndex)); 
        % 航空战初始化信息
        aircraft(hangarIndex).count = ship(i).hangar(hangarIndex); % 记录本次战斗开始时的该格飞机数
        aircraft(hangarIndex).loss = 0; % 记录本次战斗已损失的飞机数，不会超过单次放飞数
        aircraft(hangarIndex).value = cell2mat(raw(i+1,39+hangarIndex));
        aircraft(hangarIndex).type = cell2mat(raw(i+1,33+hangarIndex));   % 设定：1 为轰炸机
                                          %      2 为鱼雷机
                                          %      3 为战斗机
                                          %      4 为侦察机
    end
    ship(i).aircraft = aircraft;
    ship(i).AANo = 1;                     % AANO记录该舰第几次迎击飞机，初始为1
    ship(i).penetrate = 0.6;              % 穿甲系数
    %ship(i).number          =   raw(i+1,1);
    ship(i).crit            =   0.1;
    ship(i).opCrit          =   0;
    %未完成
    ship(i).attackNum       =   0;
    ship(i).hitNum          =   0;
    ship(i).missNum         =   0;
    ship(i).critNum         =   0;
    ship(i).type2           =   raw(i+1,50);   %主力舰
    ship(i).order           =   cell2mat(raw(i+1,51));   %自定义炮序
    ship(i).skill           = '无';
    ship(i).equip(1:4)      = 0;
end