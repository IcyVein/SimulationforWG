function attackerList = torpedoOrder (fleet)
%%  torpedoOrder ͨ���ҷ������б��ȡ�ܹ��������׵Ľ����б����ؽ����ڽ����е�λ��
 %   attackerList = torpedoOrder (fleet)
 %
 %  fleet = �ҷ�����
 %  attackerList = �������ڽ����е�λ��
 
%%  ������
attackerNum = 1;
attackerList = [];
for i = 1:length(fleet)
    if fleet(i).torpedo > 0  % ������ֵ����������ս�����������鲻ʹ������ֵ�����������Ƽ��������սЭ�������
        attackerList(attackerNum) = i;
        attackerNum = attackerNum+1;
    end
end

end