%cost function: cross entrophy function
function[W1,W2]=BackpropCE(W1,W2,U,Y) 
alpha=0.9;

N=4;
for k=1:N
    u=U(k,:)';
    y=Y(k);
    
    z1=W1'*u;
    x1=Sigmoid(z1);
    z2=W2'*x1;
    yhat=Sigmoid(z2);
    
    e=yhat-y;
    dz2=e; %cross entrophy function
    dx1=W2*dz2;
    dz1=x1.*(1-x1).*dx1;
    
    dW1=alpha*u*dz1';
    W1=W1-dW1;
    dW2=alpha*x1*dz2';
    W2=W2-dW2;
end
end