function position = GetPositon ()
%%  GetPositon  ��ȡλ����Ϣ
 %  
 %  position = GetPositon ()
 %  ��������1-6�����֣�������Nȡ���������ַ���Ч
 %  ����1-6�����֣���null�� ȡ��
 %
 %% ������
 flag=0;
    while (1)
        com = input('������λ��  ��������Nȡ��\n','s');
        if com == 'N'
           position = 'null';
           break;
        else
            flag=1;
            num = str2num(com); %�ַ�ת������
        end
        if flag == 1 && ~isempty(num) %�ж�num�ǿգ���numΪ����
            flag = 0;
            if num>=1 && num <= 6 && rem(num,1) == 0  % �ж�λ��Ϊ1-6������
                position = num;
                break
            end     
        end
    end
end