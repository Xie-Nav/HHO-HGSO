%___________________________________________________________________%
%  Dragonfly Algorithm (DA) source codes demo version 1.0           %
%     F1~F6是经典的多峰函数                 %

function [lb,ub,dim,fobj] = Multimodal_Functions(F)

d = 30;
switch F
    case 'F1'
        fobj = @F1;
        lb=-500;
        ub=500;
        dim = d;  
    case 'F2'
        fobj = @F2;
        lb=-5.12;
        ub=5.12;
        dim = d;
    case 'F3'
        fobj = @F3;
        lb=-32;
        ub=32;
        dim=d;
    case 'F4'
        fobj = @F4;
        lb=-600;
        ub=600;
        dim=d;
     case 'F5'
        fobj = @F5;
        lb=-50;
        ub=50;
        dim=d;
     case 'F6'
        fobj = @F6;
        lb=-50;
        ub=50;
        dim=d;
% %      case 'F7'
% %         fobj = @F7;
% %         lb=0;
% %         ub=1;
% %         dim=30;
     case 'F8'
        fobj = @F8;
        lb=0;
        ub=10;
        dim=d;
     case 'F9'
        fobj = @F9;
        lb=-1.28;
        ub=1.28;
        dim=d;
     case 'F10'
        fobj = @F10;
        lb=0;
        ub=10;
        dim=d;
     case 'F11'
        fobj = @F11;
        lb=-2*pi;
        ub=2*pi;
        dim=d;
     case 'F12'
        fobj = @F12;
        lb=-20;
        ub=20;
        dim=d;
%      case 'F14'
%         fobj = @F14;
%         lb=-5;
%         ub=10;
%         dim=30;
     case 'F13'
        fobj = @F13;
        lb=-500;
        ub=500;
        dim=d;
     case 'F14'
        fobj = @F14;
        lb=-600;
        ub=600;
        dim=d;
    case 'F15'
        fobj = @F15;
        lb=-50;
        ub=50;
        dim=d;
    case 'F16'
        fobj = @F16;
        lb=-50;
        ub=50;
        dim=d;
    case 'F17'
        fobj = @F17;
        lb=-10;
        ub=10;
        dim=d;
    case 'F18'
        fobj = @F18;
        lb=-10;
        ub=10;
        dim=d;
    case 'F19'
        fobj = @F19;
        lb=-1;
        ub=1;
        dim=d;
    case 'F20'
        fobj = @F20;
        lb=-100;
        ub=100;
        dim=d;
end

end


function o = F1(x)%最小值-418.9829*dim
o=sum(-x.*sin(sqrt(abs(x))));
end

function o = F2(x)%最小值0 
dim=size(x,2);
o=sum(x.^2-10*cos(2*pi.*x))+10*dim;
end

function o = F3(x)%最小值0
dim=size(x,2);
o=-20*exp(-0.2*sqrt((1/dim)*sum(x.*x)))-exp((1/dim)*sum(cos(2*pi*x)))+20+exp(1);
end

function o = F4(x)%最小值0
dim=size(x,2);
o=sum(x.^2)/4000-prod(cos(x./sqrt([1:dim])))+1;
end

function o = F5(x)%最小值0
dim=size(x,2);
o=(pi/dim)*(10*((sin(pi*(1+(x(1)+1)/4)))^2)+sum((((x(1:dim-1)+1)./4).^2).*...
(1+10.*((sin(pi.*(1+(x(2:dim)+1)./4)))).^2))+((x(dim)+1)/4)^2)+sum(Ufun(x,10,100,4));
end

function o = F6(x)%最小值0
dim=size(x,2);
o=.1*((sin(3*pi*x(1)))^2+sum((x(1:dim-1)-1).^2.*(1+(sin(3.*pi.*x(2:dim))).^2))+...
((x(dim)-1)^2)*(1+(sin(2*pi*x(dim)))^2))+sum(Ufun(x,5,100,4));
end
function o=Ufun(x,a,k,m)
o=k.*((x-a).^m).*(x>a)+k.*((-x-a).^m).*(x<(-a));
end

function o = F222(x)%0
dim=size(x,2);
o=sum(100*(x(2:dim)-(x(1:dim-1).^2)).^2+(x(1:dim-1)-1).^2);
o=sum(abs(x.*sin(x)+0.1*x));
end

function o = F3333(x)%0
dim=size(x,2);
% o=sum(100*(x(2:dim)-(x(1:dim-1).^2)).^2+(x(1:dim-1)-1).^2);
% o=sum((x(1:dim-1).^2).^(x(2:dim).^2+1)+(x(2:dim).^2).^(x(1:dim-1).^2+1));
o=x(1)^2+10^6*sum(x(2:dim).^2);
end

function o = F4444(x)%-1
dim=size(x,2);
o=-exp(-0.5*sum(x.^2));
end

function o = F5555(x)%0
dim=size(x,2);
o=sum(x.^2)/4000-prod(cos(x./sqrt([1:dim])))+1;
end

% % function o = F6(x)
% % % dim=size(x,2);
% % o=sum(-(x.^2).*sin(sqrt(abs(x))));
% % end
% 
% % function o = F7(x)
% % dim=size(x,2);
% % o=(1-dim-sum(0.5*(x(1:dim-1)+x(2:dim)))).^(dim-sum(0.5*(x(1:dim-1)+x(2:dim))));
% % end

function o = F8(x)%0
dim=size(x,2);
o=((1/dim)*sum(abs(x))-(prod(abs(x)))^(1/dim))^2;
end

function o = F9(x)%0 %F9
dim=size(x,2);
o=sum(x.^2-10*cos(2*pi.*x))+10*dim;
end

function o = F10(x)%0
dim=size(x,2);
o=sum((x(2:dim)-1).^2+(x(1)-x(2:dim).^2).^2);
end

function o = F11(x)%0
% dim=size(x,2);
o=(sum(abs(x)))*exp(-sum(sin(x.^2)))^2;
end

function o = F12(x)%0  %气体算法测试没有图像
% dim=size(x,2);
o=(exp(-sum((x./15).^10))-2*exp(-sum((x).^2))*prod((cos(x)).^2))^2;
end

function o = F13(x)%-418.9829*dim
o=sum(-x.*sin(sqrt(abs(x))));
end

function o = F14(x)%0 %F8
dim=size(x,2);
o=sum(x.^2)/4000-prod(cos(x./sqrt([1:dim])))+1;
end

function o = F15(x)%0 %F11
dim=size(x,2);
o=(pi/dim)*(10*((sin(pi*(1+(x(1)+1)/4)))^2)+sum((((x(1:dim-1)+1)./4).^2).*...
(1+10.*((sin(pi.*(1+(x(2:dim)+1)./4)))).^2))+((x(dim)+1)/4)^2)+sum(Ufun(x,10,100,4));
end

function o = F16(x)%0 %F12
dim=size(x,2);
o=.1*((sin(3*pi*x(1)))^2+sum((x(1:dim-1)-1).^2.*(1+(sin(3.*pi.*x(2:dim))).^2))+...
((x(dim)-1)^2)*(1+(sin(2*pi*x(dim)))^2))+sum(Ufun(x,5,100,4));
end

function o = F17(x)%0 %F13
dim=size(x,2);
w=1+(x-1)/4;
sum_1=sum(((w(1:dim-1)-1).^2).*(1+(10*((sin(pi*w(1:dim-1)+1)).^2))));
sum_2=(sin(pi*w(1)))^2;
sum_3=((w(dim)-1)^2)*(1+10*((sin(pi*w(dim)))^2));
o=sum_1+sum_2+sum_3;
end

function o = F18(x)%0 %F20
dim=size(x,2);
o=(sum((x(1:dim-1).^2+x(2:dim).^2).^0.25+((x(1:dim-1).^2+x(2:dim).^2).^0.25).*(sin(50*((x(1:dim-1).^2+x(2:dim).^2).^0.1))).^2))/(dim-1);   
end

function o = F19(x)%0
% dim=size(x,2);
o=sum((x.^6).*(2+sin(1./x)));   
end

function o = F20(x)%0
% dim=size(x,2);
o=sum(abs(2*(x-24)+(x-24).*sin(x-24)));   
end
