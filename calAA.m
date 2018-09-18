function para = calAA(target,opFleet)
%% 计算炮击战浮动对空总系数
 %
 %  para = calAA(target,opFleet)
 % target   ：靶舰
 % opFleet  ：对方舰队
 % 暂不考虑对空补正
 %
 %% 主函数
 antiaircraft = target.AA;
 para = max(0,1-antiaircraft*rand()/150);
 