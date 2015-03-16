P =-1:0.2:1;

T = [0 1 2 3 4 3 2 1 2 3 4];
i=1;
while i<11
i
    net = newff(minmax(P),[i 1],{'tansig' 'purelin'},'trainlm');
i=i+1;
Y = sim(net,P);
plot(P,T,P,Y,'o')
net.trainParam.epochs = 50;
net = train(net,P,T);
Y = sim(net,P);
plot(P,T,P,Y,'o')
pause
end