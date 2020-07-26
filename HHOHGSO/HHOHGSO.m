function [vec_Xbest, var_Gbest,vec_Gbest_iter] = HHOHGSO(objfunc, dim,var_down,var_up,var_niter)
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
% En = [];
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
rand_Hawk_index1 = floor(var_n_gases*rand()+1);
rand_Hawk_index = 1;
% E=S(rand_Hawk_index, :);
E1=2*(1-(var_iter/var_niter));
% En(var_iter)=E;
% if var_iter==1   
% E0=S;   
% end

%% �ƶ���ʽ1������HGSO�㷨�������ƶ���ʽ�������ӵ�λ��
E0=2*rand()-1; %-1<E0<1
Escaping_Energy=E1*(E0);  % escaping energy of rabbit
vec_flag=[1,-1];
if abs(Escaping_Energy)>=1
   
for i=1:var_n_types  
    for j=1:var_n_gases/var_n_types
            gama=beta*exp(-(var_Gbest+.05)/(Group{i}.fitness(j)+.05));
            flag_index = floor(2*rand()+1);
            var_flag=vec_flag(flag_index);
            for k=1:dim
                Group{i}.Position(j,k)=Group{i}.Position(j,k)+...
                                       var_flag*rand*gama*(best_pos{i}(k)-Group{i}.Position(j,k))+...
                                       rand*alpha*var_flag*(4*S(i)*vec_Xbest(k)-Group{i}.Position(j,k));%HGSO�㷨�������ƶ���ʽ
            end
    end
end

else
%%  �ƶ���ʽ2��HHO�ƶ���ʽ
% % group=Group;
a=0;
for j=1:var_n_types
%     X(1+N*a:N+N*a,:)=Group{j}.Position;
    A=Group{j}.Position;
    group(1+N*a:N+N*a,:)=A;  
    a=a+1;    
end  
%%%%%%
Rabbit_Location=vec_Xbest;
for i=1:size(group,1)
flag_index = floor(2*rand()+1);
var_flag=vec_flag(flag_index);
% E0=2*rand()-1; %-1<E0<1
% Escaping_Energy=E1*(E0);  % escaping energy of rabbit

% if abs(Escaping_Energy)>=1
r=rand(); % probablity of each event
if r>=0.5 && abs(Escaping_Energy)<0.5 % Hard besiege
    group(i,:)=(Rabbit_Location)-4*var_flag*S(i,:)*abs(Rabbit_Location-group(i,:));
end

if r>=0.5 && abs(Escaping_Energy)>=0.5  % Soft besiege
    Jump_strength=2*(1-rand()); % random jump strength of the rabbit
    group(i,:)=(Rabbit_Location-group(i,:))-4*var_flag*S(i,:)*abs(Jump_strength*Rabbit_Location-group(i,:));
end
if r<0.5 && abs(Escaping_Energy)>=0.5% Soft besiege % rabbit try to escape by many zigzag deceptive motions

    Jump_strength=2*(1-rand());
    X1=Rabbit_Location-4*var_flag*S(i,:)*abs(Jump_strength*Rabbit_Location-group(i,:));

    if objfunc(X1)<objfunc(group(i,:)) % improved move?
        group(i,:)=X1;
    else % hawks perform levy-based short rapid dives around the rabbit
        X2=Rabbit_Location-4*var_flag*S(i,:)*abs(Jump_strength*Rabbit_Location-group(i,:))+rand(1,dim).*Levy(dim);
        if (objfunc(X2)<objfunc(group(i,:))) % improved move?
            group(i,:)=X2;
        end
    end
end

if r<0.5 && abs(Escaping_Energy)<0.5 % Hard besiege % rabbit try to escape by many zigzag deceptive motions
    % hawks try to decrease their average location with the rabbit
    Jump_strength=2*(1-rand());
    X1=Rabbit_Location-4*var_flag*S(i,:)*abs(Jump_strength*Rabbit_Location-mean(group));

    if objfunc(X1)<objfunc(group(i,:)) % improved move?
        group(i,:)=X1;
    else % Perform levy-based short rapid dives around the rabbit
        X2=Rabbit_Location-4*var_flag*S(i,:)*abs(Jump_strength*Rabbit_Location-mean(group))+rand(1,dim).*Levy(dim);
        if (objfunc(X2)<objfunc(group(i,:))) % improved move?
            group(i,:)=X2;
        end
    end
end
end

%%%%%%
i=0;
for j=1:var_n_types
    Group{j}.Position=group(1+N*i:N+N*i,:);%������������ӷ��䵽ÿһ����Ⱥ
    i=i+1;
end

end
%%%%%%
% end
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
% % a=0;
% % for j=1:var_n_types
% % %     X(1+N*a:N+N*a,:)=Group{j}.Position;
% %     A2=Group{j}.Position;
% %     group2(1+N*a:N+N*a,:)=A2;  
% %     a=a+1;    
% % end  
% % for i = 1:var_n_types
% % X=Group{i};
% % [~,X_index]=sort(X.fitness(:),'descend');
% %     M1N =M1*var_n_gases/var_n_types;
% %     M2N = M2*var_n_gases/var_n_types;
% % % %         Nw = round((M2N-M1N).*rand(1,1) + M1N);
% %     Nw = M2N; 
% % Rabbit_Location=vec_Xbest;
% %     for k=1:Nw
% %         for j=1:dim
% %             %%%%%%%
% %             q=rand();
% %             rand_Hawk_index = floor(N*rand()+1);
% %             X_rand = group2(rand_Hawk_index, :);
% %             if q>1
% %                 % perch based on other family members
% %                 Z=X_rand(:,j)-rand()*abs(X_rand(:,j)-2*rand()*X.Position(X_index(k),j));
% %                 if Z < var_down
% %                    Z = var_down;
% %                 end
% %                 if Z > var_up
% %                    Z = var_up;
% %                 end
% %                 X.Position(X_index(k),j)=Z;
% %             elseif q<=1
% % %                 for d=1:dim
% %                 Z = (Rabbit_Location(1,j)-mean(group2(:,j)))-((var_up-var_down)*rand+var_down)*rand();
% %                 if Z < var_down
% %                    Z = var_down;
% %                 end
% %                 if Z > var_up
% %                    Z = var_up;
% %                 end
% %                 X.Position(X_index(k),j)=Z;
% %             end
% %             %%%%%%%
% %         end
% %         X.fitness(X_index(k)) = objfunc(X.Position(X_index(k),:));
% %     end
% %  Group{i}=X;           
% % end

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
% figure,
% semilogy(En,'Marker','^','markersize',6,'markerindices',(1:30:1000),'Color','k','linewidth',1.5)
end


function o=Levy(d)
beta=1.5;
sigma=(gamma(1+beta)*sin(pi*beta/2)/(gamma((1+beta)/2)*beta*2^((beta-1)/2)))^(1/beta);
u=randn(1,d)*sigma;v=randn(1,d);step=u./abs(v).^(1/beta);
o=step;
end