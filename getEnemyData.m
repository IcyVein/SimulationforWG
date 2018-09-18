function ship = getEnemyData(shipFilePath)
% ship = getShipData(shipFilePath)
% ��shipFilePath��ȡ������Ϣ�б�������excel�ļ�
[num,txt,raw] = xlsread(shipFilePath);   %%  ��ȡExcel ���
shipnumber = length(raw(:,2))-1;        %%  ���㴬����
for i = 1 : shipnumber                  %%  ת������
    ship(i).id              =   cell2mat(raw(i+1,1));
    ship(i).name            =   char(raw(i+1,2));
    ship(i).type            =   char(raw(i+1,3));
    ship(i).level           =   cell2mat(raw(i+1,4));
    ship(i).maxHP           =   cell2mat(raw(i+1,5));
    ship(i).hp              =   ship(i).maxHP;
    ship(i).firepower       =   cell2mat(raw(i+1,6));    
    ship(i).accuracy        =   cell2mat(raw(i+1,7)) + ship(i).level*0.97; % û�л����������ݣ��Եȼ�*0.97���棬��Ĭ��97����
    ship(i).armor           =   cell2mat(raw(i+1,8));
    ship(i).torpedo         =   cell2mat(raw(i+1,9));
    ship(i).baseTorpedo     =   ship(i).torpedo;
    ship(i).evasion         =   cell2mat(raw(i+1,10));
    ship(i).AA              =   cell2mat(raw(i+1,11));
    ship(i).AAaug           =   cell2mat(raw(i+1,12));%%�Կղ���ϵ������
    ship(i).AS              =   cell2mat(raw(i+1,13));
    ship(i).reconnaissance  =   cell2mat(raw(i+1,14));
    ship(i).speed           =   cell2mat(raw(i+1,15));
    ship(i).range           =   char(raw(i+1,16));
    ship(i).luck            =   0;
    for hangarIndex = 1:4
        % ����ֲ�
        ship(i).hangar(hangarIndex) = cell2mat(raw(i+1,16+2*hangarIndex)); 
        % ����ս��ʼ����Ϣ
        aircraft(hangarIndex).count = ship(i).hangar(hangarIndex); % ��¼����ս����ʼʱ�ĸø�ɻ���
        aircraft(hangarIndex).loss = 0; % ��¼����ս������ʧ�ķɻ��������ᳬ�����ηŷ���
        aircraft(hangarIndex).value = cell2mat(raw(i+1,39+hangarIndex));
        aircraft(hangarIndex).type = cell2mat(raw(i+1,33+hangarIndex));   % �趨��1 Ϊ��ը��
                                          %      2 Ϊ���׻�
                                          %      3 Ϊս����
                                          %      4 Ϊ����
    end
    ship(i).aircraft = aircraft;
    ship(i).AANo = 1;                     % AANO��¼�ý��ڼ���ӭ���ɻ�����ʼΪ1
    ship(i).penetrate = 0.6;              % ����ϵ��
    %ship(i).number          =   raw(i+1,1);
    ship(i).crit            =   0.1;
    ship(i).opCrit          =   0;
    %δ���
    ship(i).attackNum       =   0;
    ship(i).hitNum          =   0;
    ship(i).missNum         =   0;
    ship(i).critNum         =   0;
    ship(i).type2           =   raw(i+1,50);   %������
    ship(i).order           =   cell2mat(raw(i+1,51));   %�Զ�������
    ship(i).skill           = '��';
    ship(i).equip(1:4)      = 0;
end