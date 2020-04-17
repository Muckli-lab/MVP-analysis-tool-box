%The analysis code that was used in: Vetter P., Bola L., Reich L., Bennett M., Muckli L., Amedi A. (2020). Decoding natural sounds in early “visual” cortex of congenitally blind individuals. Current Biology.
%The code was originally created by Fraser W. Smith (see Smith & Muckli 2010 PNAS)and was adapted to this project by Petra Vetter and Lukasz Bola.


function out=rescaleW(x)

%%% rescale entries to see easier in BVQX
%%% as Rainer does (see BV blog - between 0 and 10 here)
a=0;
b=10;

k=sign(x);
x2=abs(x);

m = min(x2(:)); M = max(x2(:));
xR = (b-a) * (x2-m)/(M-m) + a;

max(xR)
min(xR)

out=xR.*k;