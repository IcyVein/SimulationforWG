function equip = getEquipData(equipFilePath)
% ship = getShipData(shipFilePath)
% ��shipFilePath��ȡ������Ϣ�б�������excel�ļ�

%% ��ȡ������Ϣ
[num,txt,raw] = xlsread(equipFilePath);   %%  ��ȡExcel���
equipNumber = length(raw(:,2))-1;        %%  ����װ������
for i = 1 : equipNumber                  %%  ת������
    equip(i).no              =   cell2mat(raw(i+1,1));
    equip(i).name            =   char(raw(i+1,2));
    equip(i).range           =   char(raw(i+1,3));
    equip(i).firepower       =   cell2mat(raw(i+1,4));
    equip(i).accuracy        =   cell2mat(raw(i+1,5));
    equip(i).AA              =   cell2mat(raw(i+1,6));
    equip(i).AAMod           =   cell2mat(raw(i+1,7)); % �Կղ���
    equip(i).torpedo         =   cell2mat(raw(i+1,8));
    equip(i).AS              =   cell2mat(raw(i+1,9));
    equip(i).bomb            =   cell2mat(raw(i+1,10));
    equip(i).armor           =   cell2mat(raw(i+1,11));
    equip(i).evasion         =   cell2mat(raw(i+1,12));
    equip(i).reconnaissance  =   cell2mat(raw(i+1,13));
    equip(i).luck            =   cell2mat(raw(i+1,14));
    equip(i).alu             =   cell2mat(raw(i+1,15)); % ����

    equip(i).penetrate       =   cell2mat(raw(i+1,16)); % ���Ӵ���ϵ��
    equip(i).type            =   raw(i+1,17);           % ����
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
