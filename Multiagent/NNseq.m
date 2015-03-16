%Matlab code
clear all;
%% sampling 41 points in the range of [-1,1]
x=-1:0.05:1;
%% generating training data, the desired outputs
y=0.8*x.^3 + 0.3 * x.^2 -0.4 * x;
%% specify the structure and learning algorithm for MLP
net=newff(minmax(x),[3,1],{'tansig','purelin'},'trainlm');
net.trainparam.show=2000;
net.trainparam.lr=0.01;
net.trainparam.epochs=10000;
net.trainparam.goal=1e-4;
%% Train the MLP
[net,tr]=train(net,x,y);
%% Test the MLP, net_output is the output of the MLP, ytest is the desired output.
xtest=-1:0.01:1;
ytest=0.8*xtest.^3 + 0.3 * xtest.^2 -0.4 * xtest;
net_output=sim(net,xtest);
%% Plot out the test results
plot(xtest,ytest,'b+');
hold on;
plot(xtest,net_output,'r-');
hold off
