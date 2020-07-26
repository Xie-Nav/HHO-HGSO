%___________________________________________________________________%
%  Dragonfly Algorithm (DA) source codes demo version 1.0           %
%                                                                   %
%  Developed in MATLAB R2011b(7.13)                                 %
%                                                                   %
%  Author and programmer: Seyedali Mirjalili                        %
%                                                                   %
%         e-Mail: ali.mirjalili@gmail.com                           %
%                 s-eyedali.mirjalili@griffithuni.edu.au             %
%                                                                   %
%       Homepage: http://www.alimirjalili.com                       %
%                                                                   %
%   Main paper:                                                     %
%                                                                   %
%   S. Mirjalili, Dragonfly algorithm: a new meta-heuristic         %
%   optimization technique for solving single-objective, discrete,  %
%    and multi-objective problems, Neural Computing and Applications% 
%   DOI: http://dx.doi.org/10.1007/s00521-015-1920-1                %
%                                                                   %
%___________________________________________________________________%

% This function draws the benchmark functions

function Multi_plot(func_name)

[~,~,~,fobj]=Multimodal_Functions(func_name);

switch func_name  
    case 'F1' 
        x=-100:0.1:100; y=x;%[-5,5] 
    case 'F2' 
        x=-3:0.05:3; y=x;%[-5,5] 
    case 'F3' 
        x=-20:0.05:20; y=x;%[-5,5] 
    case 'F4' 
        x=-10:0.1:10; y=x;%[-5,5] 
    case 'F5' 
        x=-10:0.05:10; y=x;%[-5,5] 
    case 'F6' 
        x=-5:0.05:5; y=x;%[-5,5] 
    case 'F7' 
        x=-5:0.05:5; y=x;%[-5,5] 
    case 'F8' 
        x=-10:0.05:10; y=x;%[-5,5] 
    case 'F9' 
        x=-5:0.05:5; y=x;%[-5,5] 
    case 'F10' 
        x=-1:0.05:1; y=x;%[-5,5] 
    case 'F11' 
        x=-10:0.05:10; y=x;%[-5,5] 
    case 'F12' 
        x=-10:0.05:10; y=x;%[-5,5] 

    case 'F13' 
        x=-500:1:500; y=x;%[-5,5] 
    case 'F14' 
        x=-200:5:200; y=x;%[-5,5] 
    case 'F15' 
        x=-10:0.05:10; y=x;%[-5,5] 
    case 'F16' 
        x=-5:0.05:5; y=x;%[-5,5] 
    case 'F17' 
        x=-10:0.05:10; y=x;%[-5,5] 
    case 'F18' 
        x=-10:0.05:10; y=x;%[-5,5] 
    case 'F19' 
        x=-1:0.01:1; y=x;%[-5,5] 
    case 'F20' 
        x=-100:1:100; y=x;%[-5,5] 
end    

    

L=length(x);
f=[];

for i=1:L
    for j=1:L
            f(i,j)=fobj([x(i),y(j)]);   
    end
end

surfc(x,y,f,'LineStyle','none');
set(gca,'FontName','Times New Roman','FontSize',14); 
set(gcf,'position',[60,60,468,468])
% set(gcf,'position',[0,0,468,468])
xlabel('x1','FontSize',16)
ylabel('x2','FontSize',16)
zlabel('F17(x1 , x2)','FontSize',16)
% title('yslice:600m;zslice:150m','FontName','Times New Roman','FontSize',7);
title('Parameter space','FontSize',16)
end

