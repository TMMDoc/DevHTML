%% creates Mindmapstructure from Bento_folder
clc;
if 0; f.path = uigetdir; end
F = searchInSubfolders('.','.txt');

fid2=fopen('bentostruc.txt','w');
for ii=length(F):-1:1
    if findstr(F{ii},'contents.txt');
    a=length(findstr(F{ii},'\'));
    for jj=1:a; fprintf(fid2,' '); end;
    fprintf(fid2,'%s\n',F{ii});
    
    a=findstr(F{ii},'\');
    for jj=1:a+1; fprintf(fid2,' '); end; fprintf(fid2,'%sindex.adoc\n',F{ii}(1:a(end)));
    
    fid3=fopen(F{ii},'r');
    while ~feof(fid3)
        ilin=fgetl(fid3);
        if length(ilin)>2; for jj=1:a+1; fprintf(fid2,' '); end; 
            fprintf(fid2,'%s%s.adoc\n',F{ii}(1:a(end)),ilin); 
        end;
    end;
    fclose(fid3)
    end
end
fclose(fid2);
