%___________________________________________________________________%
%  Dragonfly Algorithm (DA) source codes demo version 1.0           %
%                                                                   %
%  Developed in MATLAB R2011b(7.13)                                 %
%                                                                   %
%  Author and programmer: Seyedali Mirjalili                        %
%                                                                   %
%         e-Mail: ali.mirjalili@gmail.com                           %
%                 seyedali.mirjalili@griffithuni.edu.au             %
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

function Uni_plot(func_name)

[~,~,~,fobj]=Unimodal_Functions(func_name);

switch func_name 
    case 'F1' 
        x=-100:2:100; y=x; %[-100,100]
    case 'F2' 
        x=-100:2:100; y=x; %[-10,10]
    case 'F3' 
        x=-100:2:100; y=x; %[-100,100]
    case 'F4' 
        x=-100:2:100; y=x; %[-100,100]
    case 'F5' 
        x=-10:0.05:10; y=x; %[-5,5]
    case 'F6' 
        x=-5:0.01:5; y=x; %[-100,100]
    case 'F7' 
        x=-1:0.05:1; y=x; %[-100,100]
    case 'F8' 
        x=-1:0.01:1; y=x; %[-100,100]
    case 'F9' 
        x=-10:0.05:10; y=x; %[-100,100]
    case 'F10' 
        x=-1:0.01:1; y=x; %[-100,100]
    case 'F11' 
        x=-10:0.05:10; y=x; %[-100,100]
    case 'F12' 
        x=-10:0.05:10; y=x; %[-100,100]
    case 'F13' 
        x=-1:0.03:1; y=x; %[-100,100]
    case 'F14' 
        x=-5:0.05:5; y=x;%[-5,5] 
    case 'F15' 
        x=-10:0.05:10; y=x;%[-5,5] 
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
zlabel('F1(x1 , x2)','FontSize',16)
% title('yslice:600m;zslice:150m','FontName','Times New Roman','FontSize',7);
title('Parameter space','FontSize',16)
end

