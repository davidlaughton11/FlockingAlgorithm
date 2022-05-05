function centroids = calcCentroids(agentPoints, mass, density,...
    agentPositions, partitions)
%% calcCentroids
% Calculates the centroid of each agent's observed region
%
% Parameters:
%   agentPoints
%     n-by-1 cell array, where cell i contains agent i's observed points
%   mass
%     n-by-1 vector where the ith entry is the mass of agent i's observed
%     region
%   density
%     (sides*partitions)-by-(sides*partitions) matrix of the density for
%     the current iteration
%   agentPositions
%     n-by-2 vector of the x, y positions for n agents
%   partitions
%     Number of subdivisions within each unit length of the arena
%
% Returns:
%   centroids
%     n-by-2 vector of the x, y positions of the centroids of each region

    centroids = randi([0,0], size(agentPoints,1), 2);
    
%     Xavg = 0;
%     Yavg = 0;
% 
%     for i = 1:size(agentPoints,1)
%         for j = 1:size(agentPoints{i}(:,1),1)
%             Xavg = Xavg + density(agentPoints{i}(j,1),agentPoints{i}(j,2))*agentPoints{i}(j,1);
%             Yavg = Yavg + density(agentPoints{i}(j,1),agentPoints{i}(j,2))*agentPoints{i}(j,2);
%         end
%         centroids(i,1) = Xavg/mass(i,1);
%         centroids(i,2) = Yavg/mass(i,1);
%         Xavg = 0;
%         Yavg = 0;
%     end

    centroidsSum = randi([0,0], size(agentPoints,1), 2);
    for i = 1:size(agentPoints,1)
        for j = 1:size(agentPoints{i}(:,1),1)
            x = agentPoints{i}(j,1);
            y = agentPoints{i}(j,2);
            centroidsSum(i,1) = centroidsSum(i,1) + x*density(x,y);
            centroidsSum(i,2) = centroidsSum(i,2) + y*density(x,y);
        end
    end

    for i = 1:size(agentPoints,1)
        if mass(i) == 0 
            centroids(i,1) = agentPositions(i,1);
            centroids(i,2) = agentPositions(i,2);
        else 
            centroids(i,1) = centroidsSum(i,1)/mass(i);
            centroids(i,2) = centroidsSum(i,2)/mass(i);
        end
    end

end