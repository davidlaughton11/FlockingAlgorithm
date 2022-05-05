function [commCells,adjMatrix] = communication(agentPositions,rComm)
%% communication
% Determines the adjacency matrix and communication cells of all agents
%
% Parameters:
%   agentPositions
%     n-by-2 vector of the x, y positions for n agents
%   rComm
%     Radius of communication for all agents
%
% Returns:
%   commCells
%     Cell array, where each cell is one communication group
%   adjMatrix
%     The symmetric adjacency matrix 
D = squareform(pdist(agentPositions));
    adjMatrix = D < rComm;
    commCells = rangesearch(agentPositions, agentPositions, rComm);
    commCells = commCells';

    for i = 1:size(commCells,2)
        commCells{i} = commCells{i}';
    end
end