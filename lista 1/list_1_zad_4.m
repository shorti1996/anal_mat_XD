# "force script not function m-file" trick
0;

function  y = gen1(x,N)
m=8191;
a=101;
c=1731;
y=zeros(N,1);
for i=1:N
x=mod(a.*x+c,m);
y(i)=x/m;
endfor
endfunction

function  y = gen2(x,N)
a=517;
m=32767;
c=6923;
y=zeros(N,1);
for i=1:N
x=mod(a.*x+c,m);
y(i)=x/m;
endfor
endfunction

function y = gen3(x,N)
c=65536;
y=zeros(N,1);
for i=1:N
x=x*25;
x=mod(x,c);
x=x*125;
x=mod(x,c);
y(i)=x/c;
endfor
endfunction


subplot(221)
x0 = rand(20,1)
hist(x0)
subplot(222)
x1 = gen1(1,20)
hist(x1)
subplot(223)
x2 = gen2(1,20)
hist(x2)
subplot(224)
x3 = gen3(1,20)
hist(x3)