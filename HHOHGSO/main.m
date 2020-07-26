clc;
clear all;

% % % % [Lb,Ub,dim,fobj] = Unimodal_Functions('F6');
% % % % figure;
% % % % Uni_plot('F6') 
% 
[Lb,Ub,dim,fobj] = Multimodal_Functions('F1');
figure;
Multi_plot('F1')
% 
% % % [Lb,Ub,dim,fobj] = fixed_Functions('F10');
% % % figure;
% % % fixed_plot('F10') 
          
fun=fobj; 

                           
var_niter=1000;  
[xf,fval,vec_Gbest_iter]=HGSO(fun,dim,Lb,Ub,var_niter);
[Rabbit_Energy,Rabbit_Location,vec_Gbest_iter2]=HHO(42,var_niter,Lb,Ub,dim,fun);
[Top_predator_fit,Top_predator_pos,vec_Gbest_iter3]=MPA(42,var_niter,Lb,Ub,dim,fun);
[Leader_score,Leader_pos,vec_Gbest_iter4]=WOA(42,var_niter,Lb,Ub,dim,fun);
vec_Gbest_iter5 =LSA(42,Lb,Ub,dim,var_niter,fun);
[Xmin,Fmin,vec_Gbest_iter6]=WCA(fun,Lb,Ub,dim);
[xf2,fval2,vec_Gbest_iter7]= HHOHGSO(fun,dim,Lb,Ub,var_niter);

%%
disp(['Iteration : ' num2str(1000) ' Minimum value(HGSO) =' num2str(vec_Gbest_iter(end))]);
disp(['Iteration : ' num2str(1000) ' Minimum value(HHO) =' num2str(vec_Gbest_iter2(end))]);
disp(['Iteration : ' num2str(1000) ' Minimum value(MPA) =' num2str(vec_Gbest_iter3(end))]);
disp(['Iteration : ' num2str(1000) ' Minimum value(WOA) =' num2str(vec_Gbest_iter4(end))]);
disp(['Iteration : ' num2str(1000) ' Minimum value(LSA) =' num2str(vec_Gbest_iter5(end))]);
disp(['Iteration : ' num2str(1000) ' Minimum value(WCA) =' num2str(vec_Gbest_iter6(end))]);
disp(['Iteration : ' num2str(1000) ' Minimum value(HH0-HGSO) =' num2str(vec_Gbest_iter7(end))]);
%%
figure,

% if (vec_Gbest_iter(end)<0)||(vec_Gbest_iter2(end)<0)||(vec_Gbest_iter3(end)<0)||(vec_Gbest_iter4(end)<0)||(vec_Gbest_iter5(end)<0)
%     plot(vec_Gbest_iter,'Marker','^','markersize',4,'markerindices',(1:30:1000),'Color','k','linewidth',1.5)
%     hold on
%     plot(vec_Gbest_iter2,'Marker','o','markersize',4,'markerindices',(1:30:1000),'Color','b','linewidth',1.5)
%     hold on
%     plot(vec_Gbest_iter3,'Marker','+','markersize',4,'markerindices',(1:30:1000),'Color','g','linewidth',1.5)
%     hold on
%     plot(vec_Gbest_iter4,'Marker','v','markersize',4,'markerindices',(1:30:1000),'Color','c','linewidth',1.5)
%     hold on
%     plot(vec_Gbest_iter5,'Marker','>','markersize',4,'markerindices',(1:30:1000),'Color','m','linewidth',1.5)
%     hold on
%     plot(vec_Gbest_iter6,'Marker','s','markersize',4,'markerindices',(1:30:1000),'Color',[0.3 0.5 0.9],'linewidth',1.5)
%     hold on
%     plot(vec_Gbest_iter7,'Marker','p','markersize',4,'markerindices',(1:30:1000),'Color','r','linewidth',1.5)
% else
    semilogy(vec_Gbest_iter,'Marker','^','markersize',4,'markerindices',(1:30:1000),'Color','k','linewidth',1.5)
    hold on
    semilogy(vec_Gbest_iter2,'Marker','o','markersize',4,'markerindices',(1:30:1000),'Color','b','linewidth',1.5)
    hold on
    semilogy(vec_Gbest_iter3,'Marker','+','markersize',4,'markerindices',(1:30:1000),'Color','g','linewidth',1.5)
    hold on
    semilogy(vec_Gbest_iter4,'Marker','v','markersize',4,'markerindices',(1:30:1000),'Color','c','linewidth',1.5)
    hold on
    semilogy(vec_Gbest_iter5,'Marker','>','markersize',4,'markerindices',(1:30:1000),'Color','m','linewidth',1.5)
    hold on
    semilogy(vec_Gbest_iter6,'Marker','s','markersize',4,'markerindices',(1:30:1000),'Color',[0.3 0.5 0.9],'linewidth',1.5)
    hold on
    semilogy(vec_Gbest_iter7,'Marker','p','markersize',4,'markerindices',(1:30:1000),'Color','r','linewidth',1.5)
% end
xlim([0 var_niter]);
title('Objective Space') 
xlabel('Iteration')
ylabel('Best score obtianed so far')
legend('HGSO','HHO','MPA','WOA','LSA','WCA','HHO-HGSO')
set(gca,'FontName','Times New Roman','FontSize',12,'LineWidth',1.5);

set(gcf,'color','w');

box off
