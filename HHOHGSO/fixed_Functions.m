 %___________________________________________________________________%
%  Dragonfly Algorithm (DA) source codes demo version 1.0           %
%                                                                   %
%     F1~F10是经典的固定维度函数                 %

function [lb,ub,dim,fobj] = fixed_Functions(F)


switch F
    case 'F1'
        fobj = @F1;
        lb=-65.536;
        ub=65.536;
        dim=2;  
    case 'F2'
        fobj = @F2;
        lb=-5;
        ub=5;
        dim=4;
    case 'F3'
        fobj = @F3;
        lb=-5;
        ub=5;
        dim=2;
    case 'F4'
        fobj = @F4;
        lb=-5;
        ub=5;
        dim=2;
     case 'F5'
        fobj = @F5;
        lb=-2;
        ub=2;
        dim=2;
     case 'F6'
        fobj = @F6;
        lb=0;
        ub=1;
        dim=3;
     case 'F7'
        fobj = @F7;
        lb=0;
        ub=1;
        dim=6;
     case 'F8'
        fobj = @F8;
        lb=0;
        ub=10;
        dim=4;
     case 'F9'
        fobj = @F9;
        lb=0;
        ub=10;
        dim=4;
     case 'F10'
        fobj = @F10;
        lb=0;
        ub=10;
        dim=4;
     case 'F11'
        fobj = @F11;
        lb=-10;
        ub=10;
        dim=2;
     case 'F12'
        fobj = @F12;
        lb=-500;
        ub=500;
        dim=2;
%      case 'F14'
%         fobj = @F14;
%         lb=-5;
%         ub=10;
%         dim=30;
     case 'F13'
        fobj = @F13;
        lb=-100;
        ub=100;
        dim=2;
     case 'F14'
        fobj = @F14;
        lb=-100;
        ub=100;
        dim=2;
    case 'F15'
        fobj = @F15;
        lb=-1;
        ub=4;
        dim=2;
    case 'F16'
        fobj = @F16;
        lb=-50;
        ub=50;
        dim=2;
end

end

function o = F1(x)%文章说最小值是1，但是结果确实0.998
aS=[-32 -16 0 16 32 -32 -16 0 16 32 -32 -16 0 16 32 -32 -16 0 16 32 -32 -16 0 16 32;,...
-32 -32 -32 -32 -32 -16 -16 -16 -16 -16 0 0 0 0 0 16 16 16 16 16 32 32 32 32 32];
for j=1:25
    bS(j)=sum((x'-aS(:,j)).^6);
end
o=(1/500+sum(1./([1:25]+bS))).^(-1);
end

function o = F2(x)%最小值是0.00030
aK=[.1957 .1947 .1735 .16 .0844 .0627 .0456 .0342 .0323 .0235 .0246];
bK=[.25 .5 1 2 4 6 8 10 12 14 16];bK=1./bK;
o=sum((aK-((x(1).*(bK.^2+x(2).*bK))./(bK.^2+x(3).*bK+x(4)))).^2);
end

function o = F3(x)%最小值是-1.0316
o=4*(x(1)^2)-2.1*(x(1)^4)+(x(1)^6)/3+x(1)*x(2)-4*(x(2)^2)+4*(x(2)^4);
end

function o = F4(x)%最小值是0.398
o=(x(2)-(x(1)^2)*5.1/(4*(pi^2))+5/pi*x(1)-6)^2+10*(1-1/(8*pi))*cos(x(1))+10;
end

function o = F5(x)%最小值是3
o=(1+(x(1)+x(2)+1)^2*(19-14*x(1)+3*(x(1)^2)-14*x(2)+6*x(1)*x(2)+3*x(2)^2))*...
    (30+(2*x(1)-3*x(2))^2*(18-32*x(1)+12*(x(1)^2)+48*x(2)-36*x(1)*x(2)+27*(x(2)^2)));
end

function R = F6(x)%最小值是-3.86,(论文的范围是错的)
aH=[3 10 30;.1 10 35;3 10 30;.1 10 35];cH=[1 1.2 3 3.2];
pH=[.3689 .117 .2673;.4699 .4387 .747;.1091 .8732 .5547;.03815 .5743 .8828];
R=0;
for i=1:4
    R=R-cH(i)*exp(-(sum(aH(i,:).*((x-pH(i,:)).^2))));
end
end

function o = F7(x)%最小值是-3.32
aH=[10 3 17 3.5 1.7 8;.05 10 17 .1 8 14;3 3.5 1.7 10 17 8;17 8 .05 10 .1 14];
cH=[1 1.2 3 3.2];
pH=[.1312 .1696 .5569 .0124 .8283 .5886;.2329 .4135 .8307 .3736 .1004 .9991;...
.2348 .1415 .3522 .2883 .3047 .6650;.4047 .8828 .8732 .5743 .1091 .0381];
o=0;
for i=1:4
    o=o-cH(i)*exp(-(sum(aH(i,:).*((x-pH(i,:)).^2))));
end
end

function o = F8(x)%最小值是-10.1532
aSH=[4 4 4 4;1 1 1 1;8 8 8 8;6 6 6 6;3 7 3 7;2 9 2 9;5 5 3 3;8 1 8 1;6 2 6 2;7 3.6 7 3.6];
cSH=[.1 .2 .2 .4 .4 .6 .3 .7 .5 .5];
o=0;
for i=1:5
    o=o-((x-aSH(i,:))*(x-aSH(i,:))'+cSH(i))^(-1);
end
end

function o = F9(x)%最小值是-10.4028
aSH=[4 4 4 4;1 1 1 1;8 8 8 8;6 6 6 6;3 7 3 7;2 9 2 9;5 5 3 3;8 1 8 1;6 2 6 2;7 3.6 7 3.6];
cSH=[.1 .2 .2 .4 .4 .6 .3 .7 .5 .5];
o=0;
for i=1:7
    o=o-((x-aSH(i,:))*(x-aSH(i,:))'+cSH(i))^(-1);
end
end

% F23

function o = F10(x)%最小值是-10.536
aSH=[4 4 4 4;1 1 1 1;8 8 8 8;6 6 6 6;3 7 3 7;2 9 2 9;5 5 3 3;8 1 8 1;6 2 6 2;7 3.6 7 3.6];
cSH=[.1 .2 .2 .4 .4 .6 .3 .7 .5 .5];
o=0;
for i=1:10
    o=o-((x-aSH(i,:))*(x-aSH(i,:))'+cSH(i))^(-1);
end
end

function o = F111(x)%200
% dim=size(x,2);
o=-200*exp(-0.02*sqrt(x(1)^2+x(2)^2));
end

function o = F2222(x)%0
% dim=size(x,2);
o=x(1)^2+2*x(2)^2-0.3*cos(3*pi*x(1))-0.4*cos(4*pi*x(2))+0.7;
end

function o = F333(x)%0这个结果有争议
% dim=size(x,2);
o=x(1)^2+2*x(2)^2-0.3*cos(3*pi*x(1))*0.4*cos(4*pi*x(2))+0.3;
end

function o = F444(x)%0
% dim=size(x,2);
o=x(1)^2+2*x(2)^2-0.3*cos(3*pi*x(1)*4*pi*x(2))+0.3;
end

function o = F555(x)%0
% dim=size(x,2);
o=2*x(1)^2+1.05*x(1)^4+x(1)^6/6+x(1)*x(2)+x(2)^2;
end

function o = F6666(x)%-43.3159
o=x(1)^2+12*x(1)+11+10*cos((pi*x(1))/2)+8*sin((5*pi*x(1))/2)-sqrt(1/5)*exp(-0.5*(x(2)-0.5)^2);
end
% 
function o = F777(x)%-2.06261218
% dim=size(x,2);
o=-0.0001*(abs(sin(x(1))*sin(x(2))*exp(abs(100-[sqrt(x(1)^2+x(2)^2)/pi])))+1)^0.1;
end

function o = F888(x)%-1
% dim=size(x,2);
o=-1/(abs(exp(abs(100-sqrt(x(1)^2+x(2)^2)/pi))*sin(x(1))*sin(x(2)))+1)^0.1;
end

function o = F9999(x)%0 %F9
% dim=size(x,2);
o=x(1)^2+x(2)^2+25*((sin(x(1)))^2+(sin(x(2)))^2);
end

function o = F1000(x)%0
% dim=size(x,2);
o=0.26*(x(1)^2+x(2)^2)-0.04*x(1)*x(2);
end

function o = F11(x)%0.9
% dim=size(x,2);
o=1+(sin(x(1)))^2+(sin(x(2)))^2-0.1*exp(-x(1)^2-x(2)^2);
end

function o = F12(x)%0
% dim=size(x,2);
o=x(1)^2-x(1)*x(2)+x(2)^2;
end

function o = F13(x)%0
o=0.5+((sin((x(1)^2+x(2)^2)^2))^2-0.5)/(1+0.001*(x(1)^2+x(2)^2)^2);
end

function o = F14(x)%0 %F8
dim=size(x,2);
o=0.5+((sin((x(1)^2+x(2)^2)^0.5))^2-0.5)/(1+0.001*(x(1)^2+x(2)^2)^2);
end

function o = F15(x)%0 %F11
% dim=size(x,2);
o=(x(1)^2-4*x(2))^2+(x(2)^2-2*x(1)+4*x(2))^2;
end

function o = F16(x)%-400 %F12
o=x(1)^2-100*cos(x(1)^2)-100*cos((x(1)^2)/30)+x(2)^2-100*cos(x(2)^2)-100*cos((x(2)^2)/30);
end