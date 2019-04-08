% RWS.m - Roulette Wheel Selection
%
%       Syntax:
%               NewChrIx = rws(FitnV, Nsel)
%
%       This function selects a given number of individuals Nsel from a
%       population. FitnV is a column vector containing the fitness
%       values of the individuals in the population.
%
%       The function returns another column vector containing the
%       indexes of the new generation of chromosomes relative to the
%       original population matrix, shuffled. The new population, ready
%       for mating, can be obtained by calculating
%       OldChrom(NewChrIx, :).
%
% Author: Carlos Fonseca, 	Updated: Andrew Chipperfield
% Date: 04/10/93,		Date: 27-Jan-94
%
% Tested under MATLAB v6 by Alex Shenfield (22-Jan-03)

function NewChrIx = rws_new(FitnV,Nsel);

for i=1:1:size(FitnV,1)
       for j=1:1:size(FitnV,1)-i
           if(FitnV(j)<FitnV(j+1))
               temp=FitnV(j);
               FitnV(j)=FitnV(j+1);
               FitnV(j+1)=temp;
           end
       end
end
FitnV(20)=FitnV(1);
FitnV(19)=FitnV(2);
FitnV(18)=FitnV(3);
FitnV(17)=FitnV(4);

% Identify the population size (Nind)
[Nind,ans] = size(FitnV);

% Perform Stochastic Sampling with Replacement
cumfit  = cumsum(FitnV);
trials = cumfit(Nind) .* rand(Nsel, 1);
Mf = cumfit(:, ones(1, Nsel));
Mt = trials(:, ones(1, Nind))';
[NewChrIx, ans] = find(Mt < Mf & ...
                        [ zeros(1, Nsel); Mf(1:Nind-1, :) ] <= Mt);
% end of function