clc
clear
close all
path='F:\pattern-2P\hw5\jaffe';
dirData = dir(path);
dirData=dirData(3:172);
filenames = {dirData.name};
path='F:\pattern-2P\hw5\jaffe\';
for i=1:size(dirData)
    m=imread(strcat(path,dirData(i).name));
    m=imresize(m, 0.25);
    m=m(:);
    x(i,:)=m';
end
mu=mean(x);
clss=['AN';'DI';'FE';'HA';'NE';'SA';'SU'];
for i=1:size(dirData)
    for j=1:7
        s=strfind(filenames(i),clss(j,:));
       if s{1}>1
           L(i)=j;
       end
    end
end
Classes=unique(L)';
k=numel(Classes);
Sw=0;
Sb=0;
x=double(x);
M=mean(x);
for j=1:k
     Xj=x(L==Classes(j),:);% samples of one class
     n=size(Xj,1);%% number of sample of one class
     C=mean(Xj);% avg Features of samples
     S=0;
    for i=1:n
       S=S+(Xj(i,:)-C)'*(Xj(i,:)-C);
    end
    Sw=Sw+S;%The within-class scatter matrix SW is computed
%     co(j)=1/(n-1)*Sw;
   Sb=Sb+n*(C-M)'*(C-M);
end

[W, LAMBDA]=eig(Sb,Sw);
    lambda=diag(LAMBDA);
    [lambda, SortOrder]=sort(lambda,'descend');
    W=W(:,SortOrder);
    k=1;
    w=W(1:k,:);
    y=x*w';
    for i=1:170
        ms=0;
        for j=1:k
            ms=ms+(x(i,j)-y(i,j))^2;
        end
        mse(i)=ms/k;
    end
    plot(1:170,ms)
%     h=(x(:,1:k)-y).^2;
%     sm=sum(h);
% % u=zeros(4096,k);
% weight=zeros(170,k);
% cu=1;
% for i=k:-1:1
%     u(cu,:)=W(i,:)
%     cu=cu+1;
% end
% for i=1:170
%     g=
% end
% 





