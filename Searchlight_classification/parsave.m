%The analysis code that was used in: Vetter P., Bola L., Reich L., Bennett M., Muckli L., Amedi A. (2020). Decoding natural sounds in early “visual” cortex of congenitally blind individuals. Current Biology.
%The code was originally created by Fraser W. Smith (see Smith & Muckli 2010 PNAS)and was adapted to this project by Petra Vetter and Lukasz Bola.


function parsave(outname, data)

outD=data;

save(outname,'outD');