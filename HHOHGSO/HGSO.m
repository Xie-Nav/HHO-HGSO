function [vec_Xbest, var_Gbest,vec_Gbest_iter] = HGSO(objfunc, dim,var_down,var_up,var_niter)
var_n_gases          = 42;       % The swarm size.
var_n_types         = 6;       % The number of group.
%constants in eq (7)
l1=5E-03;
l2=100;
l3=1E-02;
%constants in eq (10)
alpha=1;
beta=1;
%constant in eq (11)
M1=0.1;
M2=0.2;
%paramters setting in eq. (7)
K=l1*rand(var_n_types,1);
P=l2*rand(var_n_gases,1);
C=l3*rand(var_n_types,1);
%randomly initializes the position of agents in the search space
X=unifrnd(var_down,var_up,var_n_gases,dim);
%% ������ͬ���͵�������Ⱥ
% Group=Create_Groups(var_n_gases,var_n_types,X);
N=var_n_gases/var_n_types;%ÿ������Ⱥ�ڵ��������ӵĸ�����7����   
i=0;
for j=1:var_n_types
    Group{j}.Position=X(1+N*i:N+N*i,:);%������������ӷ��䵽ÿһ����Ⱥ
    i=i+1;
end

%% �ҳ�������Ⱥ�е�ȫ���������Ӻ�ÿ����Ⱥ�еľֲ���������
for i = 1:var_n_types     
    X=Group{i};  
    for j=1:N   
        X.fitness(j) = objfunc(X.Position(j,:));
    end
    [best_fit(i),index_best]=min(X.fitness(:));
    best_pos{i}=X.Position(index_best,:);
    Group{i}=X;
end
[var_Gbest, var_gbest] = min(best_fit);      
vec_Xbest = best_pos{var_gbest};
%%
for var_iter = 1:var_niter
    %% ��¼�ôε���������λ��
for i = 1:var_n_types     
    X=Group{i};  
    [best_fit(i),index_best]=min(X.fitness(:));
    best_pos{i}=X.Position(index_best,:);
    Group{i}=X;
end
    [var_Ybest, var_index] = min(best_fit);
    if var_Ybest<var_Gbest
        var_Gbest=var_Ybest;
        vec_Xbest = best_pos{var_index};
    end
   vec_Gbest_iter(var_iter)=var_Gbest;
%% ����������ܽ��ָ��S
    T=exp(-var_iter/var_niter);%ÿ���������Ӷ��в�ͬ���ܽ��
    T0= 298.15;
    i=1;
    for j=1:var_n_types
        K(j)=K(j)*exp(-C(j)*(1/T-1/T0));
        S(i:i+N,:)=P(i:i+N,:)*K(j);
        i=j*N+1;
        if i+N>var_n_gases
            i= j*N;
        end
    end
%    M(var_iter)=K(3);
%% ����HGSO�㷨�������ƶ���ʽ�������ӵ�λ��   
    vec_flag=[1,-1];
for i=1:var_n_types    
    for j=1:var_n_gases/var_n_types
        
        gama=beta*exp(-(var_Gbest+.05)/(Group{i}.fitness(j)+.05));
        flag_index = floor(2*rand()+1);
        var_flag=vec_flag(flag_index);
        for k=1:dim
            Group{i}.Position(j,k)=Group{i}.Position(j,k)+...
                                   var_flag*rand*gama*(best_pos{i}(k)-Group{i}.Position(j,k))+...
                                   rand*alpha*var_flag*(S(i)*vec_Xbest(k)-Group{i}.Position(j,k));%HGSO�㷨�������ƶ���ʽ
        end
        
    end
    
end
%%  �ƶ�֮��ѳ����߽�����ر߽�����
Lb=var_down*ones(1,dim);
Ub=var_up*ones(1,dim);
for j=1:var_n_types
    for m=1:var_n_gases/var_n_types
        isBelow1 =find(Group{j}.Position(m,:) < Lb);
        isAboveMax = find(Group{j}.Position(m,:) > Ub);
           Group{j}.Position(m,isBelow1) =var_down;  
           Group{j}.Position(m,isAboveMax) = var_up;
    end  
end
for k = 1:var_n_types     
    X=Group{k};  
    for f=1:N   
        X.fitness(f) = objfunc(X.Position(f,:));
    end
    Group{k}=X;
end
%% ����Ӧ��ֵ�ϲ��һЩ��������ֲ� 
    for i = 1:var_n_types
    X=Group{i};
   [~,X_index]=sort(X.fitness(:),'descend');
        M1N =M1*var_n_gases/var_n_types;
        M2N = M2*var_n_gases/var_n_types;
        Nw = round((M2N-M1N).*rand(1,1) + M1N);
        for k=1:Nw
            X.Position(X_index(k),:)=unifrnd(var_down,var_up,1,dim);
            X.fitness(X_index(k)) = objfunc(X.Position(X_index(k),:));
        end
     Group{i}=X;           
    end
end
end
