%% 各种字符串属性转数字
global attributes;
attributes = containers.Map;

%% 射程
attributes('无') = 0;
attributes('短') = 1;
attributes('中') = 2;
attributes('长') = 3;
attributes('超长') = 4;

%% 飞机
attributes('无') = 0;
attributes('轰炸机') = 1;
attributes('鱼雷机') = 2;
attributes('战斗机') = 3;
attributes('侦察机') = 4;
