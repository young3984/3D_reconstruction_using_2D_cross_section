clear; clc; close all; 

h=0.1; k=0.5*h^2; alpha=k/(h^2);
x=0:h:pi; y=0:h:pi; t=0:k:1.5;

n=size(x',1); m=size(t',1);

u=zeros(n);
us=zeros(n);

for ik=2:n-1
    for it=2:n-1
        u(ik,it)=8*sin(x(ik))*cos(x(ik))*sin(y(it))*cos(y(it));
    end
end

mesh(x,y,u)
filename='heat_2D.gif';
figure
for ik=1:m
    us=u;
    for it=1:5
        for ii=2:n-1
            for ij=2:n-1
                us(ii,ij)=(u(ii,ij)+alpha*(us(ii+1,ij)+us(ii-1,ij)+us(ii,ij+1)+us(ii,ij-1)))/(1+4*alpha);               
            end
        end       
    end
    u=us;
    mesh(x,y,us)
	zlim([-2 2])
%     pause(0.1);  
    frame=getframe(2);
    img=frame2im(frame);
    [imind cm]=rgb2ind(img,256);
    
    if ik == 1
        imwrite(imind,cm,filename,'gif','Loopcount',10);
    else
        imwrite(imind,cm,filename,'gif','Writemode','append');
    end
%     pause(0.01)    
end
