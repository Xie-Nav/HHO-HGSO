%___________________________________________________________________%
%  F1~F7为最经典的单峰函数           %


function [lb,ub,dim,fobj] = Unimodal_Functions(F)

d = 30;
switch F
    case 'F1'
        fobj = @F1;
        lb=-100;
        ub=100;
        dim=d;
        
    case 'F2'
        fobj = @F2;
        lb=-10;
        ub=10;
        dim=d;
        
    case 'F3'
        fobj = @F3;
        lb=-100;
        ub=100;
        dim=d;
        
    case 'F4'
        fobj = @F4;
        lb=-100;
        ub=100;
        dim=d;
        
    case 'F5'
        fobj = @F5;
        lb=-30;
        ub=30;
        dim=d;
        
    case 'F6'
        fobj = @F6;
        lb=-100;
        ub=100;
        dim=d;
        
    case 'F7'
        fobj = @F7;
        lb=-1.28;
        ub=1.28;
        dim=d;
        
     case 'F8'
        fobj = @F8;
        lb=-10;
        ub=10;
        dim=d;
      
     case 'F9'
        fobj = @F9;
        lb=-10;
        ub=10;
        dim=d;
        
     case 'F10'
        fobj = @F10;
        lb=-100;
        ub=100;
        dim=d;
        
     case 'F11'
        fobj = @F11;
        lb=-100;
        ub=100;
        dim=d;
        
     case 'F12'
        fobj = @F12;
        lb=-10;
        ub=10;
        dim=d;
        
     case 'F13'
        fobj = @F13;
        lb=-1.28;
        ub=1.28;
        dim=d;
        
     case 'F14'
        fobj = @F14;
        lb=-1;
        ub=4;
        dim=d;
        
     case 'F15'
        fobj = @F15;
        lb=-5;
        ub=5;
        dim=d;
end

end

% F1

function o = F1(x)%最小值为0
o=sum(x.^2);
end

% F2

function o = F2(x)%最小值为0
o=sum(abs(x))+prod(abs(x));
end

% F3

function o = F3(x)%最小值为0
dim=size(x,2);
o=0;
for i=1:dim
    o=o+sum(x(1:i))^2;
end
end
   
% F4

function o = F4(x)%最小值为0
o=max(abs(x));
end

% F5

function o = F5(x)%最小值为0
dim=size(x,2);
o=sum(100*(x(2:dim)-(x(1:dim-1).^2)).^2+(x(1:dim-1)-1).^2);
end

% F6

function o = F6(x)%最小值为0
o=sum(abs((x+.5)).^2);
end

% % % function o = F7(x)%0
% % % dim=size(x,2);
% % % o=x(1)^2+10^6*(sum(x(2:dim).^2));
% % % end
function o = F7(x)%最小值为0
f1=0;
dim=size(x,2);
for i = 1:dim
    f1 = f1 + i*x(i)^4;
end
o = f1 +unifrnd(0,1,1,1);
end

function o = F8(x)%
dim=size(x,2);
o=(x(1)-1)^2+sum([2:dim].*(2*(x(2:dim).^2)-x(1:dim-1)).^2);
end

function o = F9(x)%0
dim=size(x,2);
o=sum([1:dim].*(x.^2));
end

function o = F10(x)%0
dim=size(x,2);
sum_1=0;  
for i=1:dim
  sum_1=sum_1+abs(x(i))^(i+1);
end
o=sum_1;
end

function o = F11(x)%0
o=sum(abs(x));
end

function o = F12(x)%0
o=sum(x.^10);
end

function o = F13(x)%0 %F7
dim=size(x,2);
o=sum([1:dim].*(x.^4))+rand;
end

function o = F14(x)%0
dim=size(x,2);
% o=sum(100*(x(2:dim)-(x(1:dim-1).^2)).^2+(x(1:dim-1)-1).^2);
o=sum((x(1:dim-1).^2).^(x(2:dim).^2+1)+(x(2:dim).^2).^(x(1:dim-1).^2+1));
end

function o = F15(x)%0
dim=size(x,2);
o=sum(x.^2)+(1/2*sum([1:dim].*(x.^2))).^2+(1/2*sum([1:dim].*(x.^2))).^4;
end