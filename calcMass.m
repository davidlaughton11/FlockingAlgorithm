function mass = calcMass(agentPoints,density,partitions)
%% calcMass
% Calculates the mass of the observed region for each agent
%
% Parameters:
%   agentPoints
%     n-by-1 cell array, where cell i contains agent i's observed points
%   density
%     (sides*partitions)-by-(sides*partitions) matrix of the density for
%     the current iteration
%   partitions
%     Number of subdivisions within each unit length of the arena
%
% Returns:
%   mass
%     n-by-1 vector where the ith entry is the mass of agent i's observed
%     region (x) sum(density(partitions*[x(:,2) x(:,1)]),'all')

    mass = randi([0,0], size(agentPoints,1), 1);
    temp = 0;
    
    for i = 1:size(agentPoints,1)
         for j = 1:size(agentPoints{i}(:,1),1)
             temp = temp + density(agentPoints{i}(j,1),agentPoints{i}(j,2));
         end
         mass(i,1) = temp;
         temp = 0;
     end

end