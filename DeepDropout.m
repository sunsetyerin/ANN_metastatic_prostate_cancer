function[W1 W2 W3 W4 W5 W6 W7 W8 W9 W10 W11 err]=DeepDropout(W1,W2,W3,W4,W5,W6,W7,W8,W9,W10,W11,U,Y,err)
alpha=0.01;
err=0;

N=4;
for k=1:N
    u=U(k,:)';
    
    z1=W1'*u;
    x1=max(0,z1);
    x1=x1.*Dropout(x1,0.2);
    
    z2=W2'*x1;
    x2=max(0,z2);
    x2=x2.*Dropout(x2,0.2);
    
    z3=W3'*x2;
    x3=max(0,z3);
    x3=x3.*Dropout(x3,0.2);
    
    z4=W4'*x3;
    x4=max(0,z4);
    x4=x4.*Dropout(x4,0.2);
    
    z5=W5'*x4;
    x5=max(0,z5);
    x5=x5.*Dropout(x5,0.2);
    
    z6=W6'*x5;
    x6=max(0,z6);
    x6=x6.*Dropout(x6,0.2);
    
    z7=W7'*x6;
    x7=max(0,z7);
    x7=x7.*Dropout(x7,0.2);
    
    z8=W8'*x7;
    x8=max(0,z8);
    x8=x8.*Dropout(x8,0.2);
    
    z9=W9'*x8;
    x9=max(0,z9);
    x9=x9.*Dropout(x9,0.2);
    
    z10=W10'*x9;
    x10=max(0,z10);
    x10=x10.*Dropout(x10,0.2);
    
    z11=W11'*x10;
    yhat=Sigmoid(z11)
    
    
    y=Y(k);
    e=yhat-y;
    dz11=e; %cross entrophy function
    dx10=W11*dz11;
    dz10=(x10>0).*dx10;
    dx9=W10*dz10;
    dz9=(x9>0).*dx9;
    dx8=W9*dz9;
    dz8=(x8>0).*dx8;
    dx7=W8*dz8;
    dz7=(x7>0).*dx7;
    dx6=W7*dz7;
    dz6=(x6>0).*dx6;
    dx5=W6*dz6;
    dz5=(x5>0).*dx5;
    dx4=W5*dz5;
    dz4=(x4>0).*dx4;
    dx3=W4*dz4;
    dz3=(x3>0).*dx3;
    dx2=W3*dz3;
    dz2=(x2>0).*dx2;
    dx1=W2*dz2;
    dz1=(x1>0).*dx1;
    
    dW1=u*dz1';
    W1=W1-alpha*dW1;
    dW2=x1*dz2';
    W2=W2-alpha*dW2;
    dW3=x2*dz3';
    W3=W3-alpha*dW3;
    dW4=x3*dz4';
    W4=W4-alpha*dW4;
    dW5=x4*dz5';
    W5=W5-alpha*dW5;
    dW6=x5*dz6';
    W6=W6-alpha*dW6;
    dW7=x6*dz7';
    W7=W7-alpha*dW7;
    dW8=x7*dz8';
    W8=W8-alpha*dW8;
    dW9=x8*dz9';
    W9=W9-alpha*dW9;
    dW10=x9*dz10';
    W10=W10-alpha*dW10;
    dW11=x10*dz11';
    W11=W11-alpha*dW11;
    
    err=err+e^2;
    
end
end
