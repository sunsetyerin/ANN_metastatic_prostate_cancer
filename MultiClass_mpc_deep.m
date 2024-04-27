function[W1,W2,W3,W4,W5,W6,W7,W8,W9,W10,W11,eHist]=MultiClass(W1,W2,W3,W4,W5,W6,W7,W8,W9,W10,W11,U,Y,N,yIndex) 
alpha=0.01;
%N=5;
eHist=zeros(5,N);

for k=1:N
    u=reshape(U(:,:,k),3,1);%25x1 form으로 변형 
    k2=yIndex(k);%use numbers in yIndex as an index to find correct answer in Y
    y=Y(k2,:)';%transpose 해서 5x1
    
    z1=W1'*u;
    x1=LeakyReLU(z1);
   % x1 = x1.*Dropout(x1,0.2);
    
    z2=W2'*x1;
    x2=LeakyReLU(z2);
   % x2 = x2.*Dropout(x2,0.2);
   
    z3=W3'*x2;
    x3=LeakyReLU(z3);
   % x3 = x3.*Dropout(x3,0.2);
   
    z4=W4'*x3;
    x4=LeakyReLU(z4);
   % x4 = x4.*Dropout(x4,0.2);
   
    z5=W5'*x4;
    x5=LeakyReLU(z5);
   % x5 = x5.*Dropout(x5,0.2);
   
    z6=W6'*x5;
    x6=LeakyReLU(z6);
   % x6 = x6.*Dropout(x6,0.2);
   
    z7=W7'*x6;
    x7=LeakyReLU(z7);
   % x7 = x7.*Dropout(x7,0.2);
   
    z8=W8'*x7;
    x8=LeakyReLU(z8);
   % x8 = x8.*Dropout(x8,0.2);
   
     z9=W9'*x8;
     x9=LeakyReLU(z9);
   % x9 = x9.*Dropout(x9,0.2);
   
     z10=W10'*x9;
     x10=LeakyReLU(z10);
   % x10 = x10.*Dropout(x10,0.2);
   
    z11=W11'*x10;
    % x11 = LeakyReLU(z11);
    
    yhat=Softmax(z11);
    e=yhat-y;
    
   dz11=e; %cross entrophy function
   dx10=W11*dz11;
    
   dz10 = (x10>0).*dx10;
   dz10 = dz10 + 0.1*(x10<0).*dx10;
   dx9 = W10*dz10;
   
   dz9 = (x9>0).*dx9;
   dz9 = dz9 + 0.1*(x9<0).*dx9;
   dx8 = W9*dz9;
   
   dz8 = (x8>0).*dx8;
   dz8 = dz8 + 0.1*(x8<0).*dx8;
   dx7 = W8*dz8;
   
   dz7 = (x7>0).*dx7;
   dz7 = dz7 + 0.1*(x7<0).*dx7;
   dx6 = W7*dz7;
   
   dz6 = (x6>0).*dx6;
   dz6 = dz6 + 0.1*(x6<0).*dx6;
   dx5 = W6*dz6;
   
   dz5 = (x5>0).*dx5;
   dz5 = dz5 + 0.1*(x5<0).*dx5;
   dx4 = W5*dz5;
   
   dz4 = (x4>0).*dx4;
   dz4 = dz4 + 0.1*(x4<0).*dx4;
   dx3 = W4*dz4;
   
   dz3 = (x3>0).*dx3;
   dz3 = dz3 + 0.1*(x3<0).*dx3;
   dx2 = W3*dz3;
   
   dz2 = (x2>0).*dx2;
   dz2 = dz2 + 0.1*(x2<0).*dx2;
   dx1 = W2*dz2;
   
   dz1 = (x1>0).*dx1;
   dz1 = dz1 + 0.1*(x1<0).*dx1;
   
   
   dW11 = alpha * x10 * dz11';
   dW10 = alpha * x9 * dz10';
   dW9 = alpha * x8 * dz9';
   dW8 = alpha * x7 * dz8';
   dW7 = alpha * x6 * dz7';
   dW6 = alpha * x5 * dz6';
   dW5 = alpha * x4 * dz5';
   dW4 = alpha * x3 * dz4';
   dW3 = alpha * x2 * dz3';
   dW2 = alpha * x1 * dz2';
   dW1 = alpha * u * dz1';
   
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
    
    eHist(1:5,k)=e;
    
end
end