% Heat Equation by implict

clear; clc; close all;

h=0.1; k=0.5*h^2; alpha=k/h^2; beta=1+2*alpha;     
x=0:h:1; t=0:k:0.5;


n=size(x',1); m=size(t',1);                     

u=zeros(m,n);
Real=zeros(m,n);

u(1,:)=sin(pi*x);               
A=zeros(n-2,n-2);
B=zeros(n-2,1);

A(1,1)=beta; A(1,2)=-alpha; A(n-2,n-3)=-alpha; A(n-2,n-2)=beta;

for ik=2:n-3
    A(ik,ik-1)=-alpha;
    A(ik,ik)=beta;
    A(ik,ik+1)=-alpha;
end

for ik=2:m
    B=u(ik-1,2:n-1)';
    B(1)=u(ik-1,2)+alpha*u(ik,1);
    B(n-2)=u(ik-1,n-1)+alpha*u(ik,n);
    u(ik,2:n-1)=A\B;    
end  

for ik=1:m
    Real(ik,:)=exp(-pi^2*t(ik))*sin(pi*x);    
end    

filename='heat.gif';

for ik=1:m
    plot(x,u(ik,:),'o');
    hold on
    plot(x,Real(ik,:));
    ylim([0 1])
    drawnow 
    hold off
    
    frame=getframe(1);
    img=frame2im(frame);
    [imind cm]=rgb2ind(img,256);
    
    if ik == 1
        imwrite(imind,cm,filename,'gif','Loopcount',10);
    else
        imwrite(imind,cm,filename,'gif','Writemode','append');
    end
    pause(0.1);
        
    

end    
