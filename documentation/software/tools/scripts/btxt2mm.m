% creates from a hirarchical txt a freemap
% nod11
%     node21
%     node22
% node12
% node13
%     node23
    
clc; 
if 1; [f.file,f.path] = uigetfile('*.txt'); end
fid=fopen([f.path,f.file],'r');
ii=1; h=[]; clear dat;
while ~feof(fid);
    inl=fgetl(fid);
    dat{ii}=inl;
    a=floor(find(inl>65))+1; h(ii)=a(1); %stores the hirachy
    ii=ii+1;
end;
h=h-min(h)+1;

fid=fopen('out.mm','w');
%es muessen immer gleich viele </node> wie  ..ue" TEXT="2 [2-2]"> sein
fprintf(fid,'<map version="1.0.1">\r\n');
fprintf(fid,'<node CREATED="1" TEXT=".">\r\n');
b=2;

for ii=1:length(h)-1
    hjump_nxt=h(ii+1)-h(ii);                                %preview hirarcy next
%    str = regexprep(str,'[^a-zA-Z0-9 ]','');
    
    %kreiere node Abhaengig von nexten h mit oder ohne \
    if hjump_nxt==0  %gleiche ebene
        fprintf(fid,'<node CREATED="%d_%d" TEXT="%s"/>\r\n',ii,h(ii),dat{ii}); b=ii+1;
    end;
    
    if hjump_nxt==1;  %child
        fprintf(fid,'<node CREATED="%d_%d" TEXT="%s">\r\n',ii,h(ii),dat{ii}); b=ii+1;
    end;
    if hjump_nxt<0
        fprintf(fid,'<node CREATED="%d_%d" TEXT="%s"/>\r\n',ii,h(ii),dat{ii}); b=ii+1;
        for jj=-1:-1:hjump_nxt
            fprintf(fid,'</node>\r\n');
        end;
    end;
    if hjump_nxt>1;  %parent
        fprintf(fid,'<node CREATED="%d_%d" TEXT="%s">\r\n',ii,h(ii),dat{ii}); b=ii+1;
        for jj=2:hjump_nxt
            fprintf(fid,'<node CREATED="%d_%d" TEXT="%s">\r\n',ii+1,h(ii)+jj,'-'); %hirarchy hochzaehlen
        end;
    end;
end;
ii=ii+1; fprintf(fid,'<node CREATED="%d-%d" TEXT="%s"/>\r\n',ii,h(ii),dat{ii}); b=ii+1;
for jj=1:h(ii)
    fprintf(fid,'</node>\r\n');
end;

fprintf(fid,'</map>\r\n');
fclose(fid);