clear all; close all; clc;

for A = 1:20
    k = 20;
    
    U = [0 0 1;
        0 1 1;
        1 0 1;
        1 1 1;
        ];
    Y = [0; 1; 1; 0];

 %% random 가중치 미적용 초기값 랜덤 
 %{
W1 = (2*rand(3,k)-1)*0.5;
W2 = (2*rand(k,k)-1)*0.5;
W3 = (2*rand(k,k)-1)*0.5;
W4 = (2*rand(k,k)-1)*0.5;
W5 = (2*rand(k,k)-1)*0.5;
W6 = (2*rand(k,k)-1)*0.5;
W7 = (2*rand(k,k)-1)*0.5;
W8 = (2*rand(k,k)-1)*0.5;
W9 = (2*rand(k,k)-1)*0.5;
W10 = (2*rand(k,k)-1)*0.5;
W11 = (2*rand(k,1)-1)*0.5;
 %}
 
 %% norm 가중치 적용 HE-norm
 %{
 W1 = normrnd(0, sqrt(4/(3*k)),[3,k]);
 W2 = normrnd(0, sqrt(4/(2*k)),[k,k]);
 W3 = normrnd(0, sqrt(4/(2*k)),[k,k]);
 W4 = normrnd(0, sqrt(4/(2*k)),[k,k]);
 W5 = normrnd(0, sqrt(4/(2*k)),[k,k]);
 W6 = normrnd(0, sqrt(4/(2*k)),[k,k]);
 W7 = normrnd(0, sqrt(4/(2*k)),[k,k]);
 W8 = normrnd(0, sqrt(4/(2*k)),[k,k]);
 W9 = normrnd(0, sqrt(4/(2*k)),[k,k]);
 W10 = normrnd(0, sqrt(4/(2*k)),[k,k]);
 W11 = normrnd(0, sqrt(4/(k+1)),[k,1]);
 %}
 
 %{
 W1 = normrnd(0, sqrt(4/16),[3,13]);
 W2 = normrnd(0, sqrt(4/26),[13,13]);
 W3 = normrnd(0, sqrt(4/26),[13,13]);
 W4 = normrnd(0, sqrt(4/26),[13,13]);
 W5 = normrnd(0, sqrt(4/26),[13,13]);
 W6 = normrnd(0, sqrt(4/26),[13,13]);
 W7 = normrnd(0, sqrt(4/26),[13,13]);
 W8 = normrnd(0, sqrt(4/26),[13,13]);
 W9 = normrnd(0, sqrt(4/26),[13,13]);
 W10 = normrnd(0, sqrt(4/26),[13,13]);
 W11 = normrnd(0, sqrt(4/14),[13,1]);
 %}
 
 %% uniform 가중치 적용 uniform
 %{
 W1 = (2*rand(3,20)-1)*sqrt(12/23);
 W2 = (2*rand(20,20)-1)*sqrt(12/40);
 W3 = (2*rand(20,20)-1)*sqrt(12/40);
 W4 = (2*rand(20,20)-1)*sqrt(12/40);
 W5 = (2*rand(20,20)-1)*sqrt(12/40);
 W6 = (2*rand(20,20)-1)*sqrt(12/40);
 W7 = (2*rand(20,20)-1)*sqrt(12/40);
 W8 = (2*rand(20,20)-1)*sqrt(12/40);
 W9 = (2*rand(20,20)-1)*sqrt(12/40);
 W10 = (2*rand(20,20)-1)*sqrt(12/40);
 W11 = (2*rand(20,1)-1)*sqrt(12/21);
 %}
 
 W1 = (2*rand(3,9)-1)*sqrt(12/12);
 W2 = (2*rand(9,9)-1)*sqrt(12/18);
 W3 = (2*rand(9,9)-1)*sqrt(12/18);
 W4 = (2*rand(9,9)-1)*sqrt(12/18);
 W5 = (2*rand(9,9)-1)*sqrt(12/18);
 W6 = (2*rand(9,9)-1)*sqrt(12/18);
 W7 = (2*rand(9,9)-1)*sqrt(12/18);
 W8 = (2*rand(9,9)-1)*sqrt(12/18);
 W9 = (2*rand(9,9)-1)*sqrt(12/18);
 W10 = (2*rand(9,9)-1)*sqrt(12/18);
 W11 = (2*rand(9,1)-1)*sqrt(12/10);
 
 %% logic
 alpha = 0.01;
 
 ERR = zeros(4,1);
 err =0;
 
 for epoch = 1:10000
     
     %% 배열 형태로 변경 % leaky ReLU 적용 % hidden layer 10개
     Z1 = W1' * U';
     X1 = LeakyReLU(Z1);
   %  X1 = X1.*Dropout(X1,0.2);
     
     Z2 = W2' * X1;
     X2 = LeakyReLU(Z2);
   %  X2 = X2.*Dropout(X2,0.2);
   
     Z3 = W3' * X2;
     X3 = LeakyReLU(Z3);
   %  X3 = X3.*Dropout(X3,0.2);
   
     Z4 = W4' * X3;
     X4 = LeakyReLU(Z4);
   %  X4 = X4.*Dropout(X4,0.2);
   
     Z5 = W5' * X4;
     X5 = LeakyReLU(Z5);
   %  X5 = X5.*Dropout(X5,0.2);
   
     Z6 = W6' * X5;
     X6 = LeakyReLU(Z6);
   %  X6 = X6.*Dropout(X6,0.2);
   
     Z7 = W7' * X6;
     X7 = LeakyReLU(Z7);
   %  X7 = X7.*Dropout(X7,0.2);
 
     Z8 = W8' * X7;
     X8 = LeakyReLU(Z8);
   %  X8 = X8.*Dropout(X8,0.2);
 
     Z9 = W9' * X8;
     X9 = LeakyReLU(Z9);
   %  X9 = X9.*Dropout(X9,0.2);
   
     Z10 = W10' * X9;
     X10 = LeakyReLU(Z10);
   %  X10 = X10.*Dropout(X10,0.2);
   
     Z11 = W11' * X10;
   %  X11 = LeakyReLU(Z11);
   
   Yhat = Sigmoid(Z11);
   E = Yhat'-Y;
   
   dZ11 = E;
   dX10 = W11*dZ11';
   
   dZ10 = (X10>0).*dX10;
   dZ10 = dZ10 + 0.1*(X10<0).*dX10;
   dX9 = W10*dZ10;
   
   dZ9 = (X9>0).*dX9;
   dZ9 = dZ9 + 0.1*(X9<0).*dX9;
   dX8 = W9*dZ9;
   
   dZ8 = (X8>0).*dX8;
   dZ8 = dZ8 + 0.1*(X8<0).*dX8;
   dX7 = W8*dZ8;
   
   dZ7 = (X7>0).*dX7;
   dZ7 = dZ7 + 0.1*(X7<0).*dX7;
   dX6 = W7*dZ7;
   
   dZ6 = (X6>0).*dX6;
   dZ6 = dZ6 + 0.1*(X6<0).*dX6;
   dX5 = W6*dZ6;
   
   dZ5 = (X5>0).*dX5;
   dZ5 = dZ5 + 0.1*(X5<0).*dX5;
   dX4 = W5*dZ5;
   
   dZ4 = (X4>0).*dX4;
   dZ4 = dZ4 + 0.1*(X4<0).*dX4;
   dX3 = W4*dZ4;
   
   dZ3 = (X3>0).*dX3;
   dZ3 = dZ3 + 0.1*(X3<0).*dX3;
   dX2 = W3*dZ3;
   
   dZ2 = (X2>0).*dX2;
   dZ2 = dZ2 + 0.1*(X2<0).*dX2;
   dX1 = W2*dZ2;
   
   dZ1 = (X1>0).*dX1;
   dZ1 = dZ1 + 0.1*(X1<0).*dX1;
   
   
   dW11 = alpha * X10 * dZ11;
   dW10 = alpha * X9 * dZ10';
   dW9 = alpha * X8 * dZ9';
   dW8 = alpha * X7 * dZ8';
   dW7 = alpha * X6 * dZ7';
   dW6 = alpha * X5 * dZ6';
   dW5 = alpha * X4 * dZ5';
   dW4 = alpha * X3 * dZ4';
   dW3 = alpha * X2 * dZ3';
   dW2 = alpha * X1 * dZ2';
   dW1 = alpha * U' * dZ1';
   
   W11 = W11 -dW11;
   W10 = W10 -dW10;
   W9 = W9 -dW9;
   W8 = W8 -dW8;
   W7 = W7 -dW7;
   W6 = W6 -dW6;
   W5 = W5 -dW5;
   W4 = W4 -dW4;
   W3 = W3 -dW3;
   W2 = W2 -dW2;
   W1 = W1 -dW1;
   
   err = sum(E.^2);
   
   rms_error(epoch) = sqrt(err/4);
   
 end
 
 %{
 U = [0 0 1;
     0 1 1;
     1 0 1;
     1 1 1;
     ];
 %}
 
 U = [0 0 0.9;
     0 0.7 0.9;
     1 0 1;
     1 0.7 1;
     ];
 Y = [0;1;1;0];
 
    Z1=W1'*U';
    X1=LeakyReLU(Z1);
    
    Z2=W2'*X1;
    X2=LeakyReLU(Z2);
    
    Z3=W3'*X2;
    X3=LeakyReLU(Z3);
    
    Z4=W4'*X3;
    X4=LeakyReLU(Z4);
    
    Z5=W5'*X4;
    X5=LeakyReLU(Z5);
    
    Z6=W6'*X5;
    X6=LeakyReLU(Z6);
    
    Z7=W7'*X6;
    X7=LeakyReLU(Z7);
    
    Z8=W8'*X7;
    X8=LeakyReLU(Z8);
    
    Z9=W9'*X8;
    X9=LeakyReLU(Z9);
    
    Z10=W10'*X9;
    X10=LeakyReLU(Z10);  
    
    Z11=W11'*X10;
    X11=LeakyReLU(Z11);
      
    Yhat=Sigmoid(Z11)
   
    E = Yhat' - Y;
    
    err = sum(E.^2);
    
    Yhatlog(A,:) = Yhat;
    errlog(A,:) = sqrt(err/4);
    
    figure 
    iter = (1:epoch)';
    plot(iter(1:1000),rms_error(1:1000))
    
    %Yhat
    %YhatErr = [Yhat(1),Yhat(2),Yhat(3),Yhat(4),err]
    
    %clear
    
end 

YhatErrlog = [Yhatlog(:,1),Yhatlog(:,2),Yhatlog(:,3),Yhatlog(:,4),errlog(:,1)]
