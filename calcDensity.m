function density = calcDensity(clusters,sides,partitions,offset)
%% calcDensity
% Calculates the density matrix for the given iteration
%
% Parameters:
%   D  
%     Symbolic function of x, y, t, or matrix of symbolic functions of t
%   iteration
%     The current iteration
%   (optional) sides
%     Side length of the arena
%   (optional) partitions
%     Number of subdivisions within each unit length of the arena
%
% Returns:
%   density
%     (sides*partitions)-by-(sides*partitions) matrix of doubles
%     representing discretized density for the given iteration
    
s = sides*partitions;
clusterCount = clusters;
maxDensity = 10;
maxRadius = 10;
initialOffset = 60;

COMs = zeros(clusterCount,2);
D = randi([0,1], 100, 100);

change = offset;
if (change + initialOffset > s-maxRadius)
    change = s-maxRadius - initialOffset;
end

for i = 1:clusterCount
    COMs(i,1) = randi([30,80]);
    COMs(i,2) = randi([maxRadius,s-maxRadius]);
end

D = randi([0,1],s,s);

for n = 1:clusterCount
    for i = -maxRadius:maxRadius
        for j = -maxRadius:maxRadius
            densityPoint = [COMs(n,1)+i,COMs(n,2)+j];
            clusterPoint = [COMs(n,1),COMs(n,2)];
            distance = norm(clusterPoint-densityPoint);
            
            if (distance <= maxRadius ...
                    && densityPoint(1,1) > 0 && densityPoint(1,1) < s ...
                    && densityPoint(1,2) > 0 && densityPoint(1,2) < s)
                addingAmount = ceil((1 - distance / maxRadius) * maxDensity);
                if (distance == 0)
                    addingAmount = maxDensity;
                end
                D(COMs(n,1)+i,COMs(n,2)+j) = D(COMs(n,1)+i,COMs(n,2)+j) + addingAmount;
            end
        end
    end
end

density = D;

end