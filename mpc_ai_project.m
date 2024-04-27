%% training data
% 학습 패턴이 다양해질 수록 구별하는 능력이 더 다양해진다
% test dataset을 더 만들어서 학습시키면 더 잘 분류해내는 것을 확인할 수 있다

clear all;
rng(3);

%one hot encoding 
Y= [1 0 0 0 0 ; %1;gleason score 6
    0 1 0 0 0 ; %2;gleason score 7
    0 0 1 0 0 ; %3;gleason score 8
    0 0 0 1 0 ; %4;gleason score 9
    0 0 0 0 1 ];%5;gleason score 10

yIndex=[1,1,1,1,1,
        1,1,1,1,1,
        1,1,1,1,1,
        2,2,2,2,2,
        2,2,2,2,2,
        2,2,2,2,2,
        3,3,3,3,3,
        3,3,3,3,3,
        3,3,3,3,3,
        4,4,4,4,4,
        4,4,4,4,4,
        4,4,4,4,4,
        5,5,5,5,5,
        5,5,5,5,5,
        5,5,5,5,5,];
    
%correct answer for each image
%index to find Y value in MultiClass

U = zeros(1,3,75);%1~5를 각각 1x3로 나타냄 

%gleason score 6
U(:,:,1)=[1 -1 0];
U(:,:,2)=[2 0 -1];     
U(:,:,3)=[2 -1 -1];      
U(:,:,4)=[0 -2 -1];     
U(:,:,5)=[1 0 1];     
U(:,:,6)=[2 -1 -1];
U(:,:,7)=[2 -1 -1];
U(:,:,8)=[2 -2 -1];
U(:,:,9)=[2 -1 -1];    
U(:,:,10)=[0 -1 0];      
U(:,:,11)=[2 -1 -1];
U(:,:,12)=[2 -1 -1];
U(:,:,13)=[1 1 -1];
U(:,:,14)=[2 -1 1];   
U(:,:,15)=[2 -1 -2];

%gleason score 7
U(:,:,16)=[1 0 0];
U(:,:,17)=[2 -1 0];
U(:,:,18)=[0 -2 -2];
U(:,:,19)=[0 0 0];
U(:,:,20)=[0 0 0];
U(:,:,21)=[2 -1 0];
U(:,:,22)=[2 0 0];
U(:,:,23)=[2 -2 0];
U(:,:,24)=[1 0 0];
U(:,:,25)=[0 0 -1];
U(:,:,26)=[2 0 0];
U(:,:,27)=[2 -1 -1];
U(:,:,28)=[2 -1 0];
U(:,:,29)=[2 0 0];
U(:,:,30)=[0 0 -1];

%gleason score 8
U(:,:,31)=[2 0 0];
U(:,:,32)=[0 -1 0];
U(:,:,33)=[2 -2 -1];
U(:,:,34)=[2 -1 -1];
U(:,:,35)=[1 -1 -1];
U(:,:,36)=[2 -1 -1];
U(:,:,37)=[0 -1 -1];
U(:,:,38)=[0 0 0];
U(:,:,39)=[0 -1 -1];
U(:,:,40)=[2 -1 -1];
U(:,:,41)=[1 0 0];
U(:,:,42)=[1 0 -1];
U(:,:,43)=[2 -1 -1];
U(:,:,44)=[0 0 0];
U(:,:,45)=[1 -2 -1];

%gleason score 9
U(:,:,46)=[2 -1 -1];
U(:,:,47)=[2 1 -1];
U(:,:,48)=[2 -1 -1];
U(:,:,49)=[2 -1 -1];
U(:,:,50)=[1 1 1];
U(:,:,51)=[0 -1 0];
U(:,:,52)=[0 -1 -1];
U(:,:,53)=[2 -1 -1];
U(:,:,54)=[2 -2 -1];
U(:,:,55)=[0 -1 -1];
U(:,:,56)=[0 -1 -1];
U(:,:,57)=[1 0 -1];
U(:,:,58)=[0 -1 -1];
U(:,:,59)=[2 -1 -1];
U(:,:,60)=[2 -1 -1];

%gleason score 10
U(:,:,61)=[1 0 0];
U(:,:,62)=[2 0 -1];
U(:,:,63)=[2 -1 0];
U(:,:,64)=[1 1 -1];
U(:,:,65)=[2 -1 -2];
U(:,:,66)=[2 -1 -1];
U(:,:,67)=[2 1 -1];
U(:,:,68)=[0 1 -1];
U(:,:,69)=[0 0 0];
U(:,:,70)=[0 0 0];
U(:,:,71)=[0 0 -1];
U(:,:,72)=[1 0 0];
U(:,:,73)=[2 1 -1];
U(:,:,74)=[0 -1 -1];
U(:,:,75)=[1 0 -1];

%% training

W1 = 2*rand(3,50)-1;
W2 = 2*rand(50,5)-1;
B1 = rand(50,1)-1;
B2 = rand(5,1)-1;

% increased node number from 50 to 100
%W1 = 2*rand(25,100)-1;
%W2 = 2*rand(100,5)-1;
%B1 = rand(100,1)-1;
%B2 = rand(5,1)-1;

N=size(U,3);
iteration=10000;
e_hist=zeros(5,N);
y_hist=zeros(5,N);

ee=zeros(N,1);
for epoch = 1:iteration
    [W1,W2,B1,B2,eHist] = MultiClass_mpc(W1,W2,B1,B2,U,Y,N,yIndex);
    for j=1:N
        ee(j,epoch)=sum(abs(eHist(1:5,j)))';
    end
end

for k=1:N
    u=reshape(U(:,:,k),3,1); %reshape 5x5 matrix into 25x1 matrix
    z1=W1'*u+B1;
    x1=Sigmoid(z1);
    z=W2'*x1+B2;
    yhat=Softmax(z) %5x1 classification result
    y_hist(:,k)=yhat;
end

disp('-------------------------training')

%%
%{
function[W1,W2,B1,B2,eHist]=MultiClass_answer(W1,W2,B1,B2,U,Y,N,yIndex) 
alpha=0.1;
%N=5;
eHist=zeros(5,N);
for k=1:N
    u=reshape(U(:,:,k),25,1);%25x1 form으로 변형 
    k2=yIndex(k);%use numbers in yIndex as an index to find correct answer in Y
    y=Y(k2,:)';%transpose 해서 5x1
    
    z1=W1'*u+B1;
    x1=Sigmoid(z1);
    z=W2'*x1+B2;
    yhat=Softmax(z);
    
    e=yhat-y;
    dz=e; %cross entrophy function
    dx1=W2*dz;
    dz1=x1.*(1-x1).*dx1;
    
    dW1=alpha*u*dz1';
    dB1=alpha*dz1;
    dW2=alpha*x1*dz';
    dB2=alpha*dz;
    
    W1=W1-dW1;
    B1=B1-dB1;
    W2=W2-dW2;
    B2=B2-dB2;
    
    eHist(1:5,k)=e;
end
end
%}

%% plot

figure()
set(0,'DefaultAxesColorOrder',hsv(N));%colorful
endplot=iteration;
plot(1:endplot,ee(1,1:endplot))
hold on
plot(1:endplot,ee(2,1:endplot))
plot(1:endplot,ee(3,1:endplot))
plot(1:endplot,ee(4,1:endplot))
plot(1:endplot,ee(5,1:endplot))
plot(1:endplot,ee(6,1:endplot))
plot(1:endplot,ee(7,1:endplot))
plot(1:endplot,ee(8,1:endplot))
plot(1:endplot,ee(9,1:endplot))
plot(1:endplot,ee(10,1:endplot))
plot(1:endplot,ee(11,1:endplot))
plot(1:endplot,ee(12,1:endplot))
plot(1:endplot,ee(13,1:endplot))
plot(1:endplot,ee(14,1:endplot))
plot(1:endplot,ee(15,1:endplot))
plot(1:endplot,ee(75,1:endplot))

xlim([0,10000])
ylim([0,2]);

legend('1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','75')
title(['Error of Each Number:iteration',num2str(iteration)])

%% plot save 
%num=2;
%saveas(gcf,['errorgraph_',num2str(num),'png');

%% testing 

T = zeros(1,3,45); %1~5를 각각 5x5로 나타냄 

%gleason score 6
T(:,:,1)=[1 -1 -1];    
T(:,:,2)=[1	-1 -1];  
T(:,:,3)=[2	0 -1];      
T(:,:,4)=[0	-1 -1];   
T(:,:,5)=[1	-1 -1];
T(:,:,6)=[0	-2 -1];
T(:,:,7)=[2	0 -1];
T(:,:,8)=[2 0 0];
T(:,:,9)=[2 -1 0];
%gleason score 7
T(:,:,10)=[1 -1 0];
T(:,:,11)=[0 0 -1];
T(:,:,12)=[2 -1 -1];
T(:,:,13)=[2 0 0];
T(:,:,14)=[2 -1 0];  
T(:,:,15)=[2 -1	-1];
T(:,:,16)=[0 0 0];
T(:,:,17)=[1 0 -1];
T(:,:,18)=[0 0 0];
%gleason score 8
T(:,:,19)=[2 -2	-1];
T(:,:,20)=[2 -1	-1];
T(:,:,21)=[1 -1	0];
T(:,:,22)=[0 -2 -1];
T(:,:,23)=[2 -1 -1];
T(:,:,24)=[2 -1 -1];
T(:,:,25)=[1 -1 -1];
T(:,:,26)=[0 0 -1];
T(:,:,27)=[0 -1 0];
%gleason score 9
T(:,:,28)=[2 -1 0];
T(:,:,29)=[2 -1 -1];
T(:,:,30)=[2 -1 -1];
T(:,:,31)=[1 1 -1];
T(:,:,32)=[2 -1	0];
T(:,:,33)=[2 -1 0];
T(:,:,34)=[2 0 -2];
T(:,:,35)=[2 0 0];
T(:,:,36)=[2 -1 -1];
%gleason score 10
T(:,:,37)=[2 -1 -1];
T(:,:,38)=[2 1 -2];
T(:,:,39)=[0 -2 -1];
T(:,:,40)=[2 -1 -1];
T(:,:,41)=[2 0 0];
T(:,:,42)=[0 0 -1];
T(:,:,43)=[2 -1 -1];
T(:,:,44)=[1 -1 0];
T(:,:,45)=[0 -1 -1];

N=size(T,3);
test=zeros(5,N);
for k=1:N
    t=reshape(T(:,:,k),3,1);
    z1=W1'*t+B1;
    x1=Sigmoid(z1);
    z=W2'*x1+B2;
    yhat=Softmax(z)
    test(:,k)=yhat;
end
disp('-------------------------testing')

%{
function y = Softmax(x)
ex=exp(x);
y=ex/sum(ex);
end
%}

%{
function x = Sigmoid(z)
x=1./(1+exp(-z));
end
%}
