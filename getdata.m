    [num,txt,raw] = xlsread('shipsdata');   %%  ��ȡExcel ���
    shipnumber = length(raw(:,2))-1;        %%  ���㴬����
    for i = 1 : shipnumber                  %%  ת������
        ship(i).name            =   char(raw(i+1,2));
        ship(i).range           =   raw(i+1,3);
        ship(i).maxHP           =   cell2mat(raw(i+1,4));
        ship(i).hp              =   ship(i).maxHP;
        ship(i).firepower       =   cell2mat(raw(i+1,5));
        ship(i).accuracy        =   cell2mat(raw(i+1,6));
        ship(i).armor           =   cell2mat(raw(i+1,7));
        ship(i).evasion         =   cell2mat(raw(i+1,8));
        ship(i).torpedo         =   cell2mat(raw(i+1,9));
        ship(i).AA              =   cell2mat(raw(i+1,10));
        ship(i).AS              =   raw(i+1,11);
        ship(i).reconnaissance  =   cell2mat(raw(i+1,12));
        ship(i).luck            =   cell2mat(raw(i+1,13));
        ship(i).aircraft        =   raw(i+1,14);
        ship(i).speed           =   cell2mat(raw(i+1,15));
        for hangarIndex = 1:4
            % ����ֲ�
            ship(i).hangar(hangarIndex) = cell2mat(raw(i+1,15+hangarIndex)); 
            % ����ս��ʼ����Ϣ
            aircraft(hangarIndex).count = ship(i).hangar(hangarIndex);
            aircraft(hangarIndex).loss = 0;
            aircraft(hangarIndex).value = 10;
            aircraft(hangarIndex).type = 1;   % �趨��1 Ϊ��ը��
                                              %      2 Ϊ���׻�
                                              %      3 Ϊս����
                                              %      4 Ϊ����
        end
        ship(i).aircraft = aircraft;
        ship(i).AANo = 1;                     % AANO��¼�ý��ڼ���ӭ���ɻ�����ʼΪ1
        ship(i).penetrate = 0.6;              % ����ϵ��
        ship(i).number          =   raw(i+1,1);
        ship(i).crit            =   0.1;
        %δ���
        ship(i).attackNum       =   0;
        ship(i).hitNum          =   0;
        ship(i).missNum         =   0;
        ship(i).critNum         =   0;
        ship(i).type           =   'BB';
        ship(i).type2           =   'main';   %������
%         ship(2).type2           =   'sup';    %������
        ship(i).repairOil = 4.2;% ��ʱ����ʨ�����ݲ���
        ship(i).repairSteel = 8;
    end

%     Dock = containers.Map;  %��ʼ���ֵ�����
%     Docknum =containers.Map;
%     for i = 1 : shipnumber
%         Dock( cell2mat( ship(i).name ) )=ship(i);                   %�Դ�ֻ����Ϊ����
%         Docknum( num2str( cell2mat( ship(i).number ) ) )=ship(i);   %�Դ�ֻ���Ϊ����
%     end
%         %% �������
%     ship(1).repairOil = 4.8;% ��ʱ����ʨ�����ݲ���
%     ship(1).repairSteel = 9;
%     ship(2).repairOil = 4.2;% ������
%     ship(2).repairSteel = 8;
