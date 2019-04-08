function ret=Cross(FitnV,lenchrom,chrom,sizepop,bound)
%交叉操作
%FitnV：种群适应度值
%lenchrom:染色体长度
%chrom：染色体群
%sizepop：种群规模
%ret：交叉后的染色体
%pcross:交叉概率

for i=1:sizepop   %是否进行交叉则由交叉概率决定（continue控制）
    %随机选择两个染色体进行交叉
    pick=rand(1,2);
    while prod(pick)==0
        pick=rand(1,2);
    end
    index=ceil(pick.*sizepop);
    FitnVavg=mean(FitnV);
    if max(FitnV(max(index))<=FitnVavg)
        pcross=1-0.5/(1+exp(acos(pi*(FitnVavg-FitnV(max(index)))/(FitnVavg-FitnV(max(index))))));
    else
        pcross=1.0;
    end
    
    %交叉概率决定是否进行交叉
    pick=rand;
    while pick==0
        pick=rand;
    end
    if pick>pcross
        continue;
    end
    flag=0;
    while flag==0
        %随机选择交叉位置
        pick=rand;
        while pick==0;
            pick=rand;
        end
        pos=ceil(pick.*sum(lenchrom));%随机选择进行交叉的位置
        pick=rand;%交叉开始
        v1=chrom(index(1),pos);
        v2=chrom(index(2),pos);
        chrom(index(1),pos)=pick*v2+(1-pick)*v1;
        chrom(index(2),pos)=pick*v1+(1-pick)*v2; %交叉结束
        flag1=test(lenchrom,bound,chrom(index(1),:),fcode);
        flag2=test(lenchrom,bound,chrom(index(2),:),fcode);
        if flag1*flag2==0
            flag=0;          %如果两个染色体都不是可行的，则重新交叉
        else
            flag=1;       
        end
    end
end
ret=chrom;