function fleetList = loadFleetEquip(fleetList, equipList)
% fleetList = loadFleetEquip(fleetList, equipList)
% 将装备属性实装到fleetList中所有舰船

%% 
global attributes;
for n = 1:length(fleetList)
    for i = 1:4
        equipNo = fleetList(n).equip(i);
        if equipNo == 0 % 没有装备
            continue;
        end
        equip = equipList(equipNo);
        if attributes(equip.range) > attributes(fleetList(n).range)
            fleetList(n).range = equip.range;
        end
        fleetList(n).firepower       = fleetList(n).firepower + equip.firepower;
        fleetList(n).accuracy        = fleetList(n).accuracy + equip.accuracy;
        fleetList(n).AA              = fleetList(n).AA + equip.AA;
        fleetList(n).AS              = fleetList(n).AS + equip.AS;
        fleetList(n).armor           = fleetList(n).armor + equip.armor;
        fleetList(n).evasion         = fleetList(n).evasion + equip.evasion;
        fleetList(n).reconnaissance  = fleetList(n).reconnaissance + equip.reconnaissance;
        fleetList(n).luck            = fleetList(n).luck + equip.luck;
        fleetList(n).penetrate       = fleetList(n).penetrate + equip.penetrate;

        if fleetList(n).aircraft(i).count>0
            fleetList(n).aircraft(i).type = attributes(char(equip.type));
            if contains(equip.type, '轰炸机')
                fleetList(n).aircraft(i).value = equip.bomb;
            elseif contains(equip.type, '鱼雷机')
                fleetList(n).aircraft(i).value = equip.torpedo;
            end
        end
    end
end

