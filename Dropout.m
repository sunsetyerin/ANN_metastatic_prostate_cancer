function y = Dropout(x,ratio)
[m,n]=size(x);
y=zeros(m,n);

num=round(m*n*(1-ratio));
idx=randperm(m*n,num);
y(idx)=1/(1-ratio);
end
