% Authors: Louis Breton <louis.breton@ciencias.unam.mx>,
% Authors: Cristhian Montoya <cdmontoy@mat.uc.cl>,
%
% This program is free software: you can redistribute it and/or modify it
% under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
%
% This program is distributed in the hopeC that it will be useful, but
% WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with this program.  If not, see
% <https://www.gnu.org/licenses/>.
%
%
%funcion que escribe la solution de ks y la fuente en un archivo de freefem

function Ks_source = Wrtitefreem_robust_stack(u,Uobjtivo)
syms x t y;
%%%Definiendo la fuente de Ks%%%

%%%%%%%%%%%Escribiendo el archivo de freefem%%%%%%%
ks_ini = ['func Uini = 0.0*x + ' ,char(simplify(subs(u,t,0))),';'];
ks_ini_xx = ['func Uinixx = 0.0*x +' ,char(simplify(subs(diff(u,'x',2),t,0))),';'];
Ks_obj = ['func Uobjtivo= 0.0*x +' ,char(simplify(subs(Uobjtivo,t,y))),';'];
Ks_obj_xx = ['func Uobjtivoxx = 0.0*x +' ,char(simplify(subs(diff(Uobjtivo,'x',2),t,0))),';'];

Filename = ['Ks_stackelberg/','Condiciones_Robust.edp'];
%creando el archivo que contiene la informacion para freefem
fid = fopen(Filename,'wt');
fprintf(fid, '%s\n%s\n%s\n%s', ks_ini, ks_ini_xx, Ks_obj,Ks_obj_xx);
fclose(fid);
