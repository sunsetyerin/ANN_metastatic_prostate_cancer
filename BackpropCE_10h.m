function[W1 W2 W3 W4 W5 W6 W7 W8 W9 W10 W11]=BackpropCE_10h(W1,W2,W3,W4,W5,W6,W7,W8,W9,W10,W11,U,Y)
alpha=0.01;

N=4;
for k=1:N
    u=U(k,:)';
    y=Y(k);
    
    z1=W1'*u;
    x1=Sigmoid(z1);
    z2=W2'*x1;
    x2=Sigmoid(z2);
    z3=W3'*x2;
    x3=Sigmoid(z3);
    z4=W4'*x3;
    x4=Sigmoid(z4);
    z5=W5'*x4;
    x5=Sigmoid(z5);
    z6=W6'*x5;
    x6=Sigmoid(z6);
    z7=W7'*x6;
    x7=Sigmoid(z7);
    z8=W8'*x7;
    x8=Sigmoid(z8);
    z9=W9'*x8;
    x9=Sigmoid(z9);
    z10=W10'*x9;
    x10=Sigmoid(z10);
    z=W11'*x10;
    yhat=Sigmoid(z)
    
    e=yhat-y;
    dz=e; %cross entrophy function
    dx10=W11*dz;
    dz10=x10.*(1-x10).*dx10;
    dx9=W10*dz10;
    dz9=x9.*(1-x9).*dx9;
    dx8=W9*dz9;
    dz8=x8.*(1-x8).*dx8;
    dx7=W8*dz8;
    dz7=x7.*(1-x7).*dx7;
    dx6=W7*dz7;
    dz6=x6.*(1-x6).*dx6;
    dx5=W6*dz6;
    dz5=x5.*(1-x5).*dx5;
    dx4=W5*dz5;
    dz4=x4.*(1-x4).*dx4;
    dx3=W4*dz4;
    dz3=x3.*(1-x3).*dx3;
    dx2=W3*dz3;
    dz2=x2.*(1-x2).*dx2;
    dx1=W2*dz2;
    dz1=x1.*(1-x1).*dx1;
    
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
    dW11=x10*dz';
    W11=W11-alpha*dW11;
end
end