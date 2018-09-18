%% 东方快车版命中公式 verOrientExpress
global fixList;
fixList = containers.Map;
% 阵型补正
fixList('opTrapezoid') = 41.4714402;
fixList('myTrapezoid') = 30.3019414;
fixList('opDoubleVertical') = 29.2450856;% 为什么对面复纵，我方还加了命中？（报告中特别说明了）
% 技能补正
fixList('skillPOW') = 5.01753365;
fixList('skillTirpitz') = 17.9854292;
fixList('skillWashington') = 7.2145505;
% 系统补正
fixList('track') = 5.40188054;
fixList('DD') = -17.522384;% 这里是单指DD还是小型船？
fixList('mediumShip') = 16.9745451;% 中型船反而增加被命中率？（报告中特别说明了）
% 舰娘补正
fixList('Renown') = 5.41931272;
fixList('POW') = -3.2873233;
fixList('Rodney') = -7.6158561;
fixList('Nelson') = -13.508293;
fixList('Incomparable') = -24.894264;
fixList('Lion') = -24.894264;
fixList('Maryland') = -8.1669418;
fixList('WestVirginia') = -14.199472;
fixList('Richelieu') = -4.0805655;
fixList('VittorioVeneto') = -1.26550768;
fixList('AndreaDoria') = -11.066786;
fixList('Tirpitz') = -27.634404;
fixList('Bismarck') = -2.6665562;
fixList('Hood') = -15.609903;