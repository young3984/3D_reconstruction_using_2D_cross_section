clear; clc; close all;

h=0.1; k=0.5*h^2; alpha=k/(h^2);
x=0:h:1; t=0:k:0.5;

n=size(x',1); m=size(t',1);  

u=zeros(m,n);
Real=zeros(m,n);

u(1,:)=sin(pi*x);    
for ik=2:m
    u(ik,:)=u(ik-1,:);
    for iu=1:10
        for it=2:n-1
            u(ik,it)=(u(ik-1,it)+alpha*(u(ik,it+1)+u(ik,it-1)))/(1+2*alpha);
        end    
    end
end

for ik=1:m
    Real(ik,:)=exp(-pi^2*t(ik))*sin(pi*x);    
end   

for ik=1:m
    plot(x,u(ik,:),'o') 
    hold on
    plot(x,Real(ik,:));
    ylim([0 1])
    drawnow
    hold off
    pause(0.1)
    
end    