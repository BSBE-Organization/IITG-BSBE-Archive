function [F] = VRP(x)
x = round(x);

[cost, time, stationCost, stationTime, MaxTime, MaxCapacity, U] = VRPData;

order = 20;
bus = 8;

ord = x(1:order);
pr = x(1+order: 2*order);

%ord = [1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4]; % Example order assignments
%pr = [10, 15, 20, 25, 30, 35, 12, 18, 22, 28, 32, 38, 8, 14, 16, 24, 26, 6, 5, 7]; % Example priorities

mp = containers.Map('KeyType', 'int32', 'ValueType', 'any');
for i = 1:order
    if isKey(mp, ord(i))
        mp(ord(i)) = [mp(ord(i)), i];
    else
        mp(ord(i)) = i;
    end
end

totalCost = zeros(1, bus);
totalTime = zeros(1, bus);

keys = mp.keys;
for i = 1:length(keys)
    key = keys{i};
    houses = mp(key);

    % Sort houses by priority
    [~, sortedIndices] = sort(pr(houses), 'ascend');
    sortedHouses = houses(sortedIndices);

    % Calculate total cost for the group
    totalCost(key) = totalCost(key) + stationCost(sortedHouses(1));
    for j = 1:length(sortedHouses) - 1
        from = sortedHouses(j);
        to = sortedHouses(j + 1);
        totalCost(key) = totalCost(key) + cost(from, to);
    end
    totalCost(key) = totalCost(key) + stationCost(sortedHouses(end));

    % Calculate total time for the group
    totalTime(key) = totalTime(key) + stationTime(sortedHouses(1));
    for j = 1:length(sortedHouses) - 1
        from = sortedHouses(j);
        to = sortedHouses(j + 1);
        totalTime(key) = totalTime(key) + time(from, to);
    end
    totalTime(key) = totalTime(key) + stationTime(sortedHouses(end));
end

timePenalty = 0;
for i = 1:8
    if(totalTime(i) > MaxTime)
        timePenalty = timePenalty + U;
    end
end

capacityPenalty = 0;
for i = 1:length(keys)
    key = keys{i};
    houses = mp(key);
    if length(houses) > MaxCapacity
        capacityPenalty = capacityPenalty + U;
    end
end

f1 = sum(totalCost) + timePenalty + capacityPenalty;
f2 = max(totalTime);

F = [f1,f2];