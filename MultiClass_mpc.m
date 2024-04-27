function[W1,W2,B1,B2,eHist]=MultiClass(W1,W2,B1,B2,U,Y,N,yIndex) 
alpha=0.1;
%N=5;
eHist=zeros(5,N);
for k=1:N
    u=reshape(U(:,:,k),3,1);%25x1 form으로 변형 
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