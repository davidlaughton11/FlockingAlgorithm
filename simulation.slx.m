duration = 100;
sides = 10;
rComm = 20;
rObs = 35;
agentNum = 10;
partitions = agentNum;
scaleFactor = 1;
maxVelocity = 0.6;
dt = 1;
clusters = 4;
agentPositionsX = randi([0,100], agentNum, 1);
agentPositionsY = randi([0,5], agentNum, 1);
agentPositions = horzcat(agentPositionsX, agentPositionsY);
distanceTravelled = randi([0,0], agentNum, 1);
energy = randi([1,1], agentNum, 1);
velocityType = "Constant Velocity";
density = calcDensity(1,1,sides,partitions);


for i = 1:dt:duration
x=0+rand(1,density(1,1))*(1-0);
y=0+rand(1,density(1,1))*(1-0);

[commCells, adjMatrix] = communication(agentPositions, rComm);
agentPoints = assignAgentPoints(agentPositions, commCells, sides*partitions, 1, rObs);
mass = calcMass(agentPoints,density,partitions);
centroids = calcCentroids(agentPoints, mass, density, 1, partitions);

for j = 1:sides*partitions
for k = 1:sides*partitions
xN = (j-1)+rand(1,density(j,k))*(j-(j-1));
yN = (k-1)+rand(1,density(j,k))*(k-(k-1));
x = horzcat(x, xN);
y = horzcat(y, yN);
end
end
clf
% Bin the data:
pts = linspace(0, sides*partitions, sides*partitions);
N = histcounts2(x(:), y(:), pts, pts);
% Plot data:
scatter(x, y, 1, 'r.');
axis equal;
set(gca, 'XLim', pts([1 end]), 'YLim', pts([1 end]));
hold on;
scatter(agentPositions(:,1),agentPositions(:,2),'b*','filled');
scatter(agentPoints{1}(:,1), agentPoints{1}(:,2), 'g.')
scatter(agentPoints{2}(:,1), agentPoints{2}(:,2), 'y.')
scatter(agentPoints{3}(:,1), agentPoints{3}(:,2), 'b.')
scatter(agentPoints{4}(:,1), agentPoints{4}(:,2), 'm.')
scatter(agentPoints{5}(:,1), agentPoints{5}(:,2), 'c.')
scatter(agentPoints{6}(:,1), agentPoints{6}(:,2), 'r.')
scatter(agentPoints{7}(:,1), agentPoints{7}(:,2), 'w.')
scatter(agentPoints{8}(:,1), agentPoints{8}(:,2), 'k.')
scatter(agentPoints{9}(:,1), agentPoints{9}(:,2), 'm.')
scatter(agentPoints{10}(:,1), agentPoints{10}(:,2), 'c.')

for j = 1:agentNum
% scatter(agentPoints{j}(:,1), agentPoints{j}(:,2), 'g.')
scatter(centroids(j,1), centroids(j, 2), [], "black", 'filled')
end

hold off;

agentPositions = moveAgents(agentPositions, ...
centroids,sides,dt,energy,velocityType,maxVelocity,scaleFactor);
pause(0.1);

end