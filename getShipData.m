function ship = getShipData(shipFilePath)
% ship = getShipData(shipFilePath)
% ��shipFilePath��ȡ������Ϣ�б�������excel�ļ�

%% ��ȡ������Ϣ
[num,txt,raw] = xlsread(shipFilePath);   %%  ��ȡExcel ���
shipnumber = length(raw(:,2))-1;        %%  ���㴬����
for i = 1 : shipnumber                  %%  ת������
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
        % ����ֲ�
        ship(i).hangar(hangarIndex) = cell2mat(raw(i+1,15+hangarIndex)); 
        % ����ս��ʼ����Ϣ
        aircraft(hangarIndex).count = ship(i).hangar(hangarIndex); % ��¼����ս����ʼʱ�ĸø�ɻ���
        aircraft(hangarIndex).loss = 0; % ��¼����ս������ʧ�ķɻ��������ᳬ�����ηŷ���
        aircraft(hangarIndex).value = 0;
        aircraft(hangarIndex).type = 0;   % �趨��1 Ϊ��ը��
                                          %      2 Ϊ���׻�
                                          %      3 Ϊս����
                                          %      4 Ϊ����
    end
    ship(i).aircraft = aircraft;
    ship(i).AANo = 1;                     % AANO��¼�ý��ڼ���ӭ���ɻ�����ʼΪ1
    ship(i).penetrate = 0.6;              % ����ϵ��
    ship(i).number          =   raw(i+1,1);
    ship(i).crit            =   0.1;      % ����������
    ship(i).opCrit          =   0;        % ������������
    %δ���
    ship(i).attackNum       =   0;
    ship(i).hitNum          =   0;
    ship(i).missNum         =   0;
    ship(i).critNum         =   0;
    ship(i).type            =   raw(i+1,20);
    ship(i).type2           =   raw(i+1,21);   %������
%         ship(2).type2           =   'sup';    %������
    for equipIndex = 1:4
        ship(i).equip(equipIndex) = cell2mat(raw(i+1,21+equipIndex));
    end
    ship(i).order           =   cell2mat(raw(i+1,26)); % �Զ�������
    ship(i).skill           =   char(raw(i+1,27));     % ��������û��Ϊ���ޡ�
    ship(i).nation          =   char(raw(i+1,28));     % ������û��Ϊ���ޡ�
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
