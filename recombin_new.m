% RECOMBIN.M       (RECOMBINation high-level function)
%
% This function performs recombination between pairs of individuals
% and returns the new individuals after mating. The function handles
% multiple populations and calls the low-level recombination function
% for the actual recombination process.
%
% Syntax:  NewChrom = recombin(REC_F, OldChrom, RecOpt, SUBPOP)
%
% Input parameters:
%    REC_F     - String containing the name of the recombination or
%                crossover function
%    Chrom     - Matrix containing the chromosomes of the old
%                population. Each line corresponds to one individual
%    RecOpt    - (optional) Scalar containing the probability of 
%                recombination/crossover occurring between pairs
%                of individuals.
%                if omitted or NaN, 1 is assumed
%    SUBPOP    - (optional) Number of subpopulations
%                if omitted or NaN, 1 subpopulation is assumed
%
% Output parameter:
%    NewChrom  - Matrix containing the chromosomes of the population
%                after recombination in the same format as OldChrom.
%
%  Author:    Hartmut Pohlheim
%  History:   18.03.94     file created
%             22.01.03     tested under MATLAB v6 by Alex Shenfield
%                          (NOTE : doesn't work with low level recmut.m)

function NewChrom = recombin(REC_F, Chrom, FitnV)
   % Identify the population size (Nind)确认种群规模
   [Nind,Nvar] = size(Chrom);
   % Select individuals of one subpopulation and call low level function
   NewChrom = [];
   FitnVavg=sum(FitnV)/size(FitnV,1);
   for irun = 1:Nind
       %随机选择两个染色体进行交叉
       pick=rand(1,2);
       while prod(pick)==0
           pick=rand(1,2);
       end
       index = ceil(pick.*Nind);%Chrom((irun-1)*Nind+1:irun*Nind,:);
       FitnVavg=mean(FitnV);
       if max(FitnV(max(index))<=FitnVavg)
           RecOpt=1-0.5/(1+exp(acos(pi*(FitnVavg-FitnV(max(index)))/(FitnVavg-FitnV(min(index))))));
       else
           RecOpt=1.0;
       end
       ChromSub=Chrom(index,:);
       NewChromSub = feval(REC_F, ChromSub, RecOpt);
       NewChrom=[NewChrom; NewChromSub];
   end

% End of function