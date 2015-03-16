%Matlab code
clear all;
%% sampling 41 points in the range of [-1,1]
x=-1:0.05:1;
%% generating training data, the desired outputs
%y=0.8*x.^3 + 0.3 * x.^2 -0.4 * x;
y= 1.2*sin(3.14*x)-cos(2.4*3.14*x);
%% specify the structure and learning algorithm for MLP
net=newff(minmax(x),[5,1],{'tansig','purelin'},'trainbr');
net.trainparam.show=2000;
net.trainparam.lr=0.01;
net.trainparam.epochs=10000;
net.trainparam.goal=1e-4;
%% Train the MLP
[net,tr]=train(net,x,y);
%% Test the MLP, net_output is the output of the MLP, ytest is the desired output.
xtest=-1:0.01:1;
ytest= 1.2*sin(3.14*xtest)-cos(2.4*3.14*xtest);
%ytest=0.8*xtest.^3 + 0.3 * xtest.^2 -0.4 * xtest;
net_output=sim(net,xtest);
%% Plot out the test results
plot(xtest,ytest,'b+');
hold on;
plot(xtest,net_output,'r-');
hold off
%x2=[-1.5 1.5]
%y2=sim(net,x2)
W=net.IW
B=net.b