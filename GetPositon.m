function position = GetPositon ()
%%  GetPositon  获取位置信息
 %  
 %  position = GetPositon ()
 %  键盘输入1-6的数字，或输入N取消。其他字符无效
 %  返回1-6的数字，或’null‘ 取消
 %
 %% 主程序
 flag=0;
    while (1)
        com = input('请输入位置  或者输入N取消\n','s');
        if com == 'N'
           position = 'null';
           break;
        else
            flag=1;
            num = str2num(com); %字符转换数字
        end
        if flag == 1 && ~isempty(num) %判断num非空，即num为数字
            flag = 0;
            if num>=1 && num <= 6 && rem(num,1) == 0  % 判断位置为1-6的整数
                position = num;
                break
            end     
        end
    end
end