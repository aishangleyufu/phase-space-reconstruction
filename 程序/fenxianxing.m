clc;
clear all;
data_raw=load('C:\Users\c\Desktop\plss.txt');
data=data_raw(1:661,100);

N=length(data);
max_d=12;
sigma=std(data);

for t=1:max_d
    t
    s_t=0;
    delt_s_s=0;
    for m=2:5
        s_t1=0;
        for j=1:4
            r=sigma*j/2;
            data_d=disjoint(data,N,t);
            [ll,N_d]=size(data_d);
            s_t3=0;
            for i=1:t
                i
                Y=data_d(i,:);
                C_1(i)=correlation_integral(Y,N_d,r);
                X=reconstitution(Y,N_d,m,t);
                N_r=N_d-(m-1)*t;
                C_I(i)=correlation_integral(X,N_r,r);
                s_t3=s_t3+(C_I(i)-C_1(i)^m);
            end
            s_t2(j)=s_t3/t;
            s_t1=s_t1+s_t2(j);
        end
        delt_s_m(m)=max(s_t2)-min(s_t2);
        delt_s_s=delt_s_s+delt_s_m(m);
        s_t0(m)=s_t1;
        s_t=s_t+s_t0(m);
    end
    s(t)=s_t/16;
    delt_s(t)=delt_s_s/4;
    s_cor(t)=delt_s(t)+abs(s(t));
   
end

t=1:max_d;
plot(t,s,t,delt_s,'--*r',t,s_cor,'--*g')
