FileName=['Tabla_Errores.txt'];
Dirsave = '';
Fileout = ['Tabla_Errores.tex'];
caption = ['Error table'];

Data = readmatrix(FileName);
VecTimes = unique(Data(:,2));
VecTimes = VecTimes(end:-1:1);
VecNodos = unique(Data(:,1));

Ntime = length(VecTimes);
ErroresNinfty = reshape(Data(:,3),Ntime,[])';
ErroresNL2 = reshape(Data(:,4),Ntime,[])';

LatexTables = zeros(size([ErroresNinfty,ErroresNL2]));

for i=1:length(VecNodos)
LatexTables(i,:) = reshape([ErroresNinfty(i,:);ErroresNL2(i,:)],1,[]);
end


fileID = fopen(Fileout,'w');
% fprintf(fileID,'\\begin{table} \n \\begin{centering} \n ');
% fprintf(fileID,'\\begin{tabular}{%s',repmat('l',1,size(LatexTables,2)+2));
fprintf(fileID,'\\begin{tabular}{l|');
fprintf(fileID,'%s',repmat('ll|',1,Ntime));
fprintf(fileID,'l} \n');
fprintf(fileID,'$N\\backslash\\Delta t$');
fprintf(fileID,' & \\multicolumn{2}{c}{%.2e}',VecTimes);
fprintf(fileID,' \\tabularnewline \n');
labels = '& $||e_{y}||_{\infty}$ & $||e_{y}||_{2}$ ';
fprintf(fileID,'%s',repmat(labels,1,Ntime));
fprintf(fileID,' \\tabularnewline \n');

for i=1:length(VecNodos)
fprintf(fileID,' %d ',VecNodos(i));
fprintf(fileID,' & %.2e',LatexTables(i,:));
fprintf(fileID,' \\tabularnewline \n');
end
fprintf(fileID,'\\end{tabular} \n');
% fprintf(fileID,'\\par\\end{centering} \n');
% fprintf(fileID,'\\caption{%s} \n',caption);
% fprintf(fileID,'\\end{table}');

fclose(fileID);