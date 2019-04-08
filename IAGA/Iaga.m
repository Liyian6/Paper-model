%IAGA?
function best=ga
clear
MAX_gen=200;%最大迭代步数
best.max_f=0;%当前最大的适应度?STOP_f=14.5;????????????%停止循环的适应度?
RANGE=[0 255];%初始取值范围[0?255]?SPEEDUP_INTER=5;???????%进入加速迭代的间隔
advance_k=0;%优化的次数?
popus=init;%初始化?for?gen=1:MAX_gen
for gen=1:MAX_gen
    fitness=fit(popus,RANGE);%求适应度????
    f=fitness.f;
    picked=choose(popus,fitness);%选择
    popus=intercross(popus,picked);%杂交?????
    popus=aberrance(popus,picked);%变异
    if max(f)>best.max_f
        advance_k=advance_k+1;
        x_better(advance_k)=fitness.x;
        best.max_f=max(f);
        best.popus=popus;
        best.x=fitness.x;
    end
    if mod(advance_k,SPEEDUP_INTER==0)
        RANGE=minmax(x_better);
        RANGE
        advance=0;
    end
end
return;
function popus=init;
M=50;
N=30;
popus=round(rand(M,N));
return;