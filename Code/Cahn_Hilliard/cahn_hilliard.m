clear; clc; close all;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Set Initial Value
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

h=0.05; m=2.5; eps=h*m/(2*2^(1/2)*atanh(0.9)); dt=0.1*h; alpha=0.1;
x=-0.5*h:h:1+0.5*h; y=x; z=-0.5*h:h:10.5*h;   

n_xy=size(x',1);
n_z=size(z',1);

%%% mu 초기값 설정 %%%
mu=zeros(n_xy,n_xy,n_z);

%%% phi 초기값 설정 %%%
phi=mu;
c=sin(atan(5*(n_z-1)/h));

for ix=1:n_xy
    for iy=1:n_xy
        phi(ix,iy,1)=tanh((0.2-sqrt(c*(x(ix)-0.5)^2+(y(iy)-0.5)^2))/(sqrt(2)*eps));       
    end    
end

for ix=1:n_xy
    for iy=1:n_xy
        phi(ix,iy,n_z)=tanh((0.2-sqrt((x(ix)-0.6)^2+c*(y(iy)-0.5)^2))/(sqrt(2)*eps));
    end
end

for ik=2:n_z-1
    phi(:,:,ik)=1/(n_z-1)*(ik-1)*phi(:,:,n_z)+(1-(ik-1)/(n_z-1))*phi(:,:,1);              % 중간 층 초기 값 설정 
end 

temp=phi; temp(:,:,1)=-1; temp(:,:,end)=-1;
isosurface(x,y,z,temp,0);
hold on
axis image;
axis([min(x) max(x) min(y) max(y) min(z)-0.1 max(z)+0.1]);
box on;
saveas(gcf,'image.jpg')
return

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Gauss-Seidel Iteration
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

phi_i=phi;
phi_pr=phi;             % t=n일때 사용될 값
phi_f=phi;
mu_pr=mu;
figure(2)
for it=1:50                     % 일단 n=1일 때만 해보고 교수님께 질문
    phi_pr=phi;                 
    for ik=1:50                 % 가우스 세이델 50번 반복
        for iz=2:n_z-1
            for ix=2:n_xy-1
                for iy=2:n_xy-1
                    
                    A=[1/dt 6/(h^2)
                        -3*(2*eps^2/(h^2)+phi(ix,iy,iz)^2) 1];     % 역행렬 계산을 위한 행렬
                    
                    mu_c=(mu(ix+1,iy,iz)+mu(ix-1,iy,iz)...
                        +mu(ix,iy+1,iz)+mu(ix,iy-1,iz)...
                        +mu(ix,iy,iz+1)+mu(ix,iy,iz-1))/(h^2);           % 역행렬 계산을 위한 뮤의 중앙 차분
                    
                    phi_c=(phi(ix+1,iy,iz)+phi(ix-1,iy,iz)...
                        +phi(ix,iy+1,iz)+phi(ix,iy-1,iz)...
                        +phi(ix,iy,iz+1)+phi(ix,iy,iz-1))/(h^2);         % 역행렬 계산을 위한 뮤의 중앙 차분
                    
                    B=[phi_pr(ix,iy,iz)/dt+mu_c
                        -phi_pr(ix,iy,iz)-2*phi(ix,iy,iz)^3-eps^2*phi_c];     % 역행렬 계산을 위한 행렬
                    
                    C=A\B;     % 역행렬 계산
                    phi(ix,iy,iz)=C(1); mu(ix,iy,iz)=C(2);
                    mu(1,:,:)=mu(2,:,:); mu(:,1,:)=mu(:,2,:);
                    mu(n_xy,:,:)=mu(n_xy-1,:,:); mu(:,n_xy,:)=mu(:,n_xy-1,:);
                end                
            end 
        end    
        phi(:,:,1)=alpha*phi_f(:,:,1)+(1-alpha)*(2*phi(:,:,2)-phi(:,:,3));
        phi(:,:,n_z)=alpha*phi_f(:,:,n_z)+(1-alpha)*(2*phi(:,:,n_z-1)-phi(:,:,n_z-2));          %업데이트 해주는 값
    end
    
    % 출력하고픈 횟수에 따라서 1 바꾸기
    if mod(it,1) == 0
        clf;
        temp=phi; temp(:,:,1)=-1; temp(:,:,end)=-1;
        isosurface(x,y,z,temp,0);
        axis image;
        axis([min(x) max(x) min(y) max(y) min(z)-0.1 max(z)+0.1]);
        box on;
        drawnow;
    end
end









