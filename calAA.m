function para = calAA(target,opFleet)
%% �����ڻ�ս�����Կ���ϵ��
 %
 %  para = calAA(target,opFleet)
 % target   ���н�
 % opFleet  ���Է�����
 % �ݲ����ǶԿղ���
 %
 %% ������
 antiaircraft = target.AA;
 para = max(0,1-antiaircraft*rand()/150);
 