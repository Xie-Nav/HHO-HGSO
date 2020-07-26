
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function grandmin =LSA(N,low,up,dim,var_niter,fobj) 
% F_index = 1; % Function 1-6 % Refer to other test function 7-24 in [1].
% % [low,up,dim]=test_functions_range(F_index);

D = dim; % number of dimension
T = var_niter;

Dpoint=unifrnd(low,up,N,D);

ch_time = 0; % reset
max_ch_time = 10;
fit_old = 10^10*(ones(1,N));
direct = sign(unifrnd(-1,1,1,dim));
best_fit = inf;

for t = 1:T
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Evaluate performance
%     fit = fobj(Dpoint'); 
    for a=1:size(Dpoint,1)
        fit= fobj(Dpoint(a ,:));
        if fit<best_fit
            best_fit=fit;
            best_Location=Dpoint(a ,:);
        end
      Ec(a)= fit;
    end
    grandmin(t) = best_fit;
%     fitness(t) = min(fit);
%     Ec = fit;
    
    % update channel
    ch_time = ch_time+1;
    if ch_time >= max_ch_time
        [~,ds]=sort(Ec,'ascend');
        Dpoint(ds(N),:) = Dpoint(ds(1),:); % Eliminate the worst channel
        Ec(ds(N)) = Ec(ds(1)); % Update  
        ch_time = 0; % reset
    end
    
    % Rangking the fitness value
    [~,ds]=sort(Ec,'ascend');
    best = Ec(ds(1));
%     worst = Ec(ds(N));
    
    Energy = 2.05 - 2*exp(-5*(T-t)/T);% Update energy

    % update direction
    for d = 1:D
        Dpoint_test = Dpoint(ds(1),:);
        Dpoint_test(d) = Dpoint_test(d)+direct(d)*0.005*(up-low);
        fv_test = fobj(Dpoint_test);
        if fv_test < best % If better, +ve direction
            direct(d) = direct(d);
        else
            direct(d) = -1*direct(d);
        end
    end
    % update position
    for i = 1:N
        dist=Dpoint(i,:)-Dpoint(ds(1),:);
            for d = 1:D
                if Dpoint(i,:)==Dpoint(ds(1),:)
                    Dpoint_temp(d) = Dpoint(i,d)+direct(d)*abs(normrnd(0,Energy));
                else
                    if dist(d)<0
                        Dpoint_temp(d) = Dpoint(i,d)+exprnd(abs(dist(d)));
                    else
                        Dpoint_temp(d) = Dpoint(i,d)-exprnd(dist(d));
                    end
                end
                if (Dpoint_temp(d)>up)||(Dpoint_temp(d)<low)
                    Dpoint_temp(d) = rand(1)*(up-low)+low; % Re-initialized
                end
            end
            
            fv = fobj(Dpoint_temp);
            if fv < Ec(i)
                Dpoint(i,:) = Dpoint_temp;
                Ec(i) = fv;
                % Focking procedure
                if rand < 0.01
                    for d = 1:D 
                        Dpoint_fock(d) = up+low-Dpoint_temp(d);% Focking
                    end
                    fock_fit = fobj(Dpoint_fock); % Evaluate
                    if fock_fit < Ec(i) 
                        Dpoint(i,:) = Dpoint_fock; % Replace the channel
                        Ec(i) = fock_fit;
                    end
                end
            end   
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end