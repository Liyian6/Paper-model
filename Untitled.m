figure(1);
fplot('v.*sin(10*pi*v)+2.0',[-1,2]);
NIND=40;
MAXGEN=30;
PRECI=20;
GGAP=0.9;
trace=zeros(2,MAXGEN);
FieldD=[20;-1;2;1;0;1;1];
Chrom=crtbp(NIND,PRECI);
gen=0;
v=bs2rv(Chrom,FieldD);
ObjV=v.*sin(10*pi*v)+2.0;
while gen<MAXGEN,
    FitnV=ranking(-ObjV);
    SelCh=select('sus',Chrom,FitnV,GGAP);
    FitnVmax=max(FitnV);
    FitnVave=sum(FitnV)/NIND;
    if(FitnV>= FitnVave)
         Index1=find(FitnV>= FitnVave);
         Index2=find(FitnV< FitnVave);
         Pc1=0.5*(FitnVmax- FitnV(Index,1))/(FitnVmax- FitnVave);
         Pm1=0.02*(FitnVmax- FitnV(Index,1))/(FitnVmax- FitnVave);
    else    
         Pc2=0.85;
         Pm2=0.05;
    end  
    SelCh=recombin('xovsp',SelCh(Index1,1),Pc1);
    SelCh=recombin('xovsp',SelCh(Index2,1),Pc2);
    SelCh=mut(SelCh(Index1,1),Pm1);
    SelCh=mut(SelCh(Index2,1),Pm2);
    v=bs2rv(SelCh,FieldD);
    ObjVSel=v.*sin(10*pi*v)+2.0;
    [Chrom ObjV]=reins(Chrom,SelCh,1,1,ObjV,ObjVSel);
    gen=gen+1;
    variable=bs2rv(Chrom, FieldD)
    [Y,I]=max(ObjV),hold on;
    plot(I,Y,'bo');
    trace(1,gen)=max(ObjV);
    trace(2,gen)=sum(ObjV)/length(ObjV);
    if (gen==20)
        figure(2);
        plot(ObjV);hold on;
        plot(ObjV,'b*');grid;
    end
end
figure(3);
plot(trace(1,:)','Pr');
hold on;
plot(trace(2,:)','-.');grid;
legend('解的变化','种群均值的变化')