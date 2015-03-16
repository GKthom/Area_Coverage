clear all
clc
% s=1:0.1:10;
% x1=sin(s)+2.1;
% x2=cos(s+pi/2);

% plot(sin(s)+2.1)
% plot(cos(s+pi/2))
ep=0;
w=[1 1 1];
n=0.001;
x=[1 0.4 0.4;1 0 1;1 1 0;1 1 1;1 -1 -1;1 -0.2 -0.2;1 3 0.3; 1 -.3 -.4];
d=[-1;1;1;1;-1;-1;1;-1];

for i=1:length(d)
    v(i)=w*x(i,:)';
    if v(i)>0
        y(i)=1;
    else y(i)=-1;
    end
    e(i)=d(i)-y(i);
end
sq_er=e.^2;

count=0;
sv=sign(v);
sum_x=0;
sum_y=0;
converge=0;
while converge==0%sv(1)~=d(1)||sv(2)~=d(2)||sv(3)~=d(3)||sv(4)~=d(4)||sv(5)~=d(5)||sv(6)~=d(6)||sv(7)~=d(7)||sv(8)~=d(8)

    for i=1:length(d)
        count=count+1;
        if count>8
            count=1;
            x_hist={};
            sum_x=0;
            sum_y=0;
        end
       i=randi(8);
        
        
        if count>2
            for j=1:length(x_hist)
               sum_x=sum_x+x_hist{j}(2);
               sum_y=sum_y+x_hist{j}(3);
            end
            
            xc=sum_x/length(x_hist);
            yc=sum_y/length(x_hist);
            sum_tor_x=0;
            sum_tor_y=0;
            for j=1:length(x_hist)
                net_tor_x=sq_er(x_hist{j}(4))*(x_hist{j}(2)-xc);
                sum_tor_x=sum_tor_x+net_tor_x;
                net_tor_y=sq_er(x_hist{j}(4))*(x_hist{j}(3)-yc);
                sum_tor_y=sum_tor_y+net_tor_y;
            end
            x_balance=sum_tor_x/length(x_hist)
            y_balance=sum_tor_y/length(x_hist)
            
            for ii=1:length(d)
                dist(ii)=norm([x_balance,y_balance]-[x(ii,2),x(ii,3)]);
            end
            i=find(dist==min(dist));
            if length(i)>1
                i=i(1);
            end
            sum_x=0;
            sum_y=0;
        else i=randi(length(d));
            
        end
        
x_hist{count}=[x(i,:) i];
        
        if v(i)>0
            y(i)=1;
            e(i)=d(i)-y(i);
            w=w+n*e(i)*x(i,:);
            v(i)=w*x(i,:)';
        else y(i)=-1;
            e(i)=d(i)-y(i);
            w=w+n*e(i)*x(i,:);
            v(i)=w*x(i,:)';
        end

    end
    for i=1:length(d)
        v(i)=w*x(i,:)';
        if v(i)>0
            y(i)=1;
        else y(i)=-1;
        end
        e(i)=d(i)-y(i);
    end
    sq_er=e.^2
    ep=ep+1;
    sv=sign(v);
    conv=sv'-d;
    if conv==zeros(length(d),1)
        converge=1; 
    else converge=0;
    end
end
%     
%     if v1>0
% y1=1;
% e1=d1-y1;
% w=w+n*e1*x1;
% v1=w'*x1;
% end 
% w1=w;
% w1
% v2=w'*x2;
% if v2<0 
% y2=0;
% e2=d2-y2;
% w=w+n*e2*x2;
% v2=w'*x2;
% end 
% w2=w;
% w2
% v3=w'*x3;
% 
% if v3<0 
% y3=0;
% e3=d3-y3;
% w=w+n*e3*x3;
% v3=w'*x3;
% end 
% w3=w;
% w3
% v4=w'*x4;
% if v4<0 
% y4=0;
% e4=d4-y4;
% w=w+n*e4*x4;
% v4=w'*x4;
% end 
% w4=w;
% w4
% 
% v1=w'*x1;
% v2=w'*x2;
% v3=w'*x3;
% v4=w'*x4;
% 
% ep=ep+1;
% 
% end
wf=w;
wf
ep


xx=0:0.1:1;

plot(xx, (-wf(1)-wf(2)*xx)/wf(3),'k')
hold on
for i=1:length(d)
    if d(i)==1
        h=scatter(x(i,2),x(i,3),'r','filled');
    else h=scatter(x(i,2),x(i,3),'b','filled');
    end
hold on
end
% axis([-2 2 -2 2])