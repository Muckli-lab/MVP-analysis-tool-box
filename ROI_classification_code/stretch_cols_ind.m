%The analysis code that was used in: Vetter P., Bola L., Reich L., Bennett M., Muckli L., Amedi A. (2020). Decoding natural sounds in early “visual” cortex of congenitally blind individuals. Current Biology.
%The code was originally created by Fraser W. Smith (see Smith & Muckli 2010 PNAS)and was adapted to this project by Petra Vetter and Lukasz Bola.

function [out,pars]=stretch_cols_ind(input,m1,m2)

[nRows, nCols]=size(input);
new=zeros(nRows,nCols); 
pars=zeros(nCols,2);  %% max and min for each rescaling

for i=1:nCols
    [new(:,i), pars(i,:)]=stretch(input(:,i),m1,m2);
end

out=new;