function id = identity(name,type)
%%    ��ʶ�����ַ����Ƿ�һ��
 %
 %    id = identityType(ship,type)
 %
 %      name �������ַ���
 %      type ���������ַ���
 
%% ������
id =0;
 for i = 1:length(type)
     if contains( name , type(i) ) % �����type��'������'������ʹ��contains��������������
         id =1;
         return
     end
 end