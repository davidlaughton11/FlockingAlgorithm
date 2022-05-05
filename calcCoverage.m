function coverage = calcCoverage(agentPoints, partitions, density,...
    totalMass)
%% coverage
% Calculates how much of the arena is being observed as a percentage.
% Considers a weighted average of the density matrix.
%
% Parameters:
%   agentPoints
%     n-by-1 cell array, where each cell is ni-by-2 list of (x,y) points
%     the ith agent is observing
%   partitions
%     Number of subdivisions within each unit length of the arena
%   density
%     (sides*partitions)-by-(sides*partitions) matrix of the density for
%     the current iteration
%   totalMass
%     Mass of entire arena
%
% Returns
%   coverage
%     Percent value between 0 and 1 representing coverage

    cvrDensity = 0;

    cell2mat(agentPoints);
    agentPoints = unique(cell2mat(agentPoints), "rows");
    agentPoints = mat2cell(agentPoints,size(agentPoints,1),size(agentPoints,2));

     for i = 1:size(agentPoints,1)
         for j = 1:size(agentPoints{i}(:,1),1)
             cvrDensity = cvrDensity + density(agentPoints{i}(j,1),agentPoints{i}(j,2));
         end 
     end

    coverage = cvrDensity/totalMass;

end