function fireTarget = chooseTarget (targetList, num, myFleetAns, opFleetAns,state)
%%  chooseTarget ��ȡ�����н�λ�ú������н������ظ����������
 %  fireTarget = chooseTarget (targetList, num)
 %
 %  targetList = �н�λ���б����飩
 %  num        = �н�����
 %  fireTarget = Ŀ���ڵз������е�λ�ã����飩
 
%%  ������
myTrautskill_all = ["��ɪ���ж�","�ɶ�ά�˾���"];
myTrautprocent_all = [-0.3, 0.3];

opTrautskill_all = ["��֮����","ϣ�������","ʢ����ӭ�绨","����߸�����"];
opTrautprocent_all = [0.22, 0.3 , 0.3, -0.3];

opTrautskill_night = ["ǿ�����"];
opTrautprocent_night = 0.4;

num = min(length(targetList), num);% Ŀ���������ɳ����н�����
fireTarget = zeros( 1, num );
trautRate = ones(1, length( opFleetAns ) );
for i  = 1 : length(trautRate) %��������ϵ��
    for j = 1: length( myTrautskill_all )
        if identity( myFleetAns(i).skill, myTrautskill_all( j ) )
            trautRate(i) = trautRate( i ) + myTrautprocent_all( j );
        end
    end
    for j = 1: length( opTrautskill_all )
        if identity( opFleetAns( i ).skill, opTrautskill_all( j ) )
            trautRate( i ) = trautRate( i ) + opTrautprocent_all( j );
        end
    end
    if identity( state , "night" )%����ҹս����ϵ��
        for j = 1: length( opTrautskill_night )
            if identity( opFleetAns( i ).skill, opTrautskill_night( j ) )
                trautRate( i ) = trautRate( i ) + opTrautprocent_night( j );
            end
        end
    end
end
% δ����˫�����ӳ��Ȳ���
for k = 1 : num
    sum = 0;
    for i = 1:length( targetList )
       sum = sum + trautRate( i );
    end

    index = sum * rand(1);
    flag = 0;
    for i =1 : length( targetList ) + 1
        if i== length( targetList ) + 1
            fireTarget(k) = targetList( end );
            break
        end
        flag = flag + trautRate( i );
        if index <= flag
            fireTarget(k) = targetList( i );
            break
        end
    end
    trautRate( i ) = 0;
end
% for i = 1:num
%     index = ceil(rand(1)*length(targetList));% ���ѡȡһ��Ŀ��
%     fireTarget(i) = targetList(index);
%     targetList(index) = [];
% end


% num = length(targetlist);
% target = num*rand(1);
% target = floor(target);
% firetarget = target+1;
% % firetarget =targetlist(target+1);
end