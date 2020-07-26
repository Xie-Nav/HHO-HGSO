function [Xmin,Fmin,FF]=WCA(obj,LB,UB,nvars,Npop,Nsr,dmax,max_it)
%% Information
% Last Revised: 4th April 2016

% Water Cycle Algorithm (WCA) (Standard Version)

% This code is prepared for single objective function (minimization), unconstrained, and continuous problems.
% Note that in order to obey the copy-right rules, please cite our published paper properly. Thank you.

% Hadi Eskandar, Ali Sadollah, Ardeshir Bahreininejad, Mohd Hamdi “Water cycle algorithm - a novel metaheuristic optimization method for solving constrained engineering optimization problems?, Computers & Structures, 110-111 (2012) 151-166.

% INPUTS:

% objective_function:           Objective function which you wish to minimize or maximize
% LB:                           Lower bound of a problem
% UB:                           Upper bound of a problem
% nvars:                        Number of design variables
% Npop                          Population size
% Nsr                           Number of rivers + sea
% dmax                          Evporation condition constant
% max_it:                       Maximum number of iterations

% OUTPUTS:

% Xmin:                         Global optimum solution
% Fmin:                         Cost of global optimum solution
% NFEs:                         Number of function evaluations
% Elapsed_Time                  Elasped time for solving an optimization problem
%% Default Values for WCA
format long g
if (nargin <5 || isempty(Npop)), Npop=42; end
if (nargin <6 || isempty(Nsr)), Nsr=4; end
if (nargin <7 || isempty(dmax)), dmax=1e-16; end
if (nargin <8 || isempty(max_it)), max_it=1000; end
%% --------------------------------------------------------------------------
% Create initial population and form sea, rivers, and streams
% tic
N_stream=Npop-Nsr;

ind.position=[];
ind.cost=[];

pop=repmat(ind,Npop,1);

for i=1:Npop
    pop(i).position=LB+(UB-LB).*rand(1,nvars);
    pop(i).cost=obj(pop(i).position);
end

[~, index]=sort([pop.cost]);
%------------- Forming Sea ------------------------------------------------
sea=pop(index(1));
%-------------Forming Rivers ----------------------------------------------
river=repmat(ind,Nsr-1,1);
for i=1:Nsr-1
    river(i)=pop(index(1+i));
end
%------------ Forming Streams----------------------------------------------
stream=repmat(ind,N_stream,1);
for i=1:N_stream
    stream(i)=pop(index(Nsr+i));
end
%--------- Designate streams to rivers and sea ------------------------
cs=[sea.cost;[river.cost]';stream(1).cost];
f=0;
if length(unique(cs))~=1
    CN=cs-max(cs);
else
    CN=cs;
    f=1;
end

NS=round(abs(CN/sum(CN))*N_stream);
if f~=1
    NS(end)=[];
end
NS=sort(NS,'descend');
% ------------------------- Modification on NS -----------------------
i=Nsr;
while sum(NS)>N_stream
    if NS(i)>1
        NS(i)=NS(i)-1;
    else
        i=i-1;
    end
end

i=1;
while sum(NS)<N_stream
    NS(i)=NS(i)+1;
end

if find(NS==0)
    index=find(NS==0);
    for i=1:size(index,1)
        while NS(index(i))==0
            NS(index(i))=NS(index(i))+round(NS(i)/6);
            NS(i)=NS(i)-round(NS(i)/6);
        end
    end
end

NS=sort(NS,'descend');
NB=NS(2:end);
%%
%----------- Main Loop for WCA --------------------------------------------
% disp('******************** Water Cycle Algorithm (WCA)********************');
% disp('*Iterations     Function Values *');
% disp('********************************************************************');
FF=zeros(max_it,1);
for i=1:max_it
    %---------- Moving stream to sea---------------------------------------
    for j=1:NS(1)
        stream(j).position=stream(j).position+2.*rand(1).*(sea.position-stream(j).position);
        
        stream(j).position=min(stream(j).position,UB);
        stream(j).position=max(stream(j).position,LB);
        
        stream(j).cost=obj(stream(j).position);
        
        if stream(j).cost<sea.cost
            new_sea=stream(j);
            stream(j)=sea;
            sea=new_sea;
        end
    end
    %---------- Moving Streams to rivers-----------------------------------
    for k=1:Nsr-1
        for j=1:NB(k)
            stream(j+sum(NS(1:k))).position=stream(j+sum(NS(1:k))).position+2.*rand(1,nvars).*(river(k).position-stream(j+sum(NS(1:k))).position);
            
            stream(j+sum(NS(1:k))).position=min(stream(j+sum(NS(1:k))).position,UB);
            stream(j+sum(NS(1:k))).position=max(stream(j+sum(NS(1:k))).position,LB);
            
            stream(j+sum(NS(1:k))).cost=obj(stream(j+sum(NS(1:k))).position);
            
            if stream(j+sum(NS(1:k))).cost<river(k).cost
                new_river=stream(j+sum(NS(1:k)));
                stream(j+sum(NS(1:k)))=river(k);
                river(k)=new_river;
  
                if river(k).cost<sea.cost
                    new_sea=river(k);
                    river(k)=sea;
                    sea=new_sea;
                end
            end
        end
    end
    %---------- Moving rivers to Sea --------------------------------------
    for j=1:Nsr-1
        river(j).position=river(j).position+2.*rand(1,nvars).*(sea.position-river(j).position);
        
        river(j).position=min(river(j).position,UB);
        river(j).position=max(river(j).position,LB);
        
        river(j).cost=obj(river(j).position);
        
        if river(j).cost<sea.cost
            new_sea=river(j);
            river(j)=sea;
            sea=new_sea;
        end
    end
    %-------------- Evaporation condition and raining process--------------
    % Check the evaporation condition for rivers and sea
    for k=1:Nsr-1
        if ((norm(river(k).position-sea.position)<dmax) || rand<0.1)
            for j=1:NB(k)
                stream(j+sum(NS(1:k))).position=LB+rand(1,nvars).*(UB-LB);
            end
        end
    end
    % Check the evaporation condition for streams and sea
    for j=1:NS(1)
        if ((norm(stream(j).position-sea.position)<dmax))
            stream(j).position=LB+rand(1,nvars).*(UB-LB);
        end
    end
    %----------------------------------------------------------------------
    dmax=dmax-(dmax/max_it);
    
%     disp(['Iteration: ',num2str(i),'   Fmin= ',num2str(sea.cost)]);
    FF(i)=sea.cost;
end
%% Results and Plot
% toc;
% Elapsed_Time=toc;
% plot(FF,'LineWidth',2);
% xlabel('Number of Iterations');
% ylabel('Function Values');
% NFEs=Npop*max_it;
Xmin=sea.position;
Fmin=obj(Xmin);
end
