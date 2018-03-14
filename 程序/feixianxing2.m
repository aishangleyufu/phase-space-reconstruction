clc;
clear all;
data_raw=load('C:\Users\c\Desktop\plss.txt');
data=data_raw(1:30,80);
N=30;
tau=2
min_m=2;
max_m=10;
ss=5;
for m=min_m:max_m
    Y=reconstitution(data,N,m,tau);
    M=N-(m-1)*tau;
    for i=1:M-1
        for j=i+1:M
            d(i,j)=max(abs(Y(:,i)-Y(:,j)))         
        end                                
    end
    max_d=max(max(d));
    d(1,1)=max_d;
    min_d=min(min(d));
    delt=(max_d-min_d)/ss;
    for k=1:ss
        r=min_d+k*delt;
        C(k)=correlation_integral(Y,M,r);
        ln_C(m,k)=log(C(k));%lnC(r)
        ln_r(m,k)=log(r);%lnr
%         fprintf('%d/%d/%d/%d\n',k,ss,m,max_m);
    end
    plot(ln_r(m,:),ln_C(m,:));
%     hold on;
end
% fid=fopen('lnr.txt','w');
% fprintf(fid,'%6.2f %6.2f\n',ln_r);
% fclose(fid);
% fid = fopen('lnC.txt','w');
% fprintf(fid,'%6.2f %6.2f\n',ln_C);
% fclose(fid);