% C:\Users\wadehnwo\AppData\Local\Pandoc\pandoc Vulcan.docx -f docx -t asciidoc --wrap=none --markdown-headings=atx --extract-media=extracted-media -o output.adoc

% == is sub folder level
% === is file level
%
clc
foldnam='.';
fid_rootcont=fopen('contents_.txt','w');
fidout=fopen('x.adoc','w');
fid_cont=fopen('x.txt','w');
fid=fopen('output.adoc','r');
while ~feof(fid);
    ilin=fgetl(fid);
    if ~isempty(findstr(ilin,'|===')); fprintf(fidout,'%s\n',ilin); end;  %print table limits
    if length(ilin)>5
        if findstr(ilin(1:3),'== ');  %open folder
            foldnam=strrep(ilin(3:end),' ','');
            mkdir(foldnam)
            mkdir([foldnam,'\img'])
            fprintf(fid_rootcont,'[%s]\n',foldnam);
            ii=1;
            fclose(fidout);
            fidout=fopen(['.\',foldnam,'\index.adoc'],'w');
            fprintf(fidout,'%s\n\n',ilin(2:end));
            fclose(fid_cont);
            fid_cont=fopen(['.\',foldnam,'\contents.txt'],'w'); %fprintf('fopen fidcont %s\n',['.\',foldnam,'\contents.txt']);%content file in this sub folder
        elseif findstr(ilin(1:4),'=== ');%open doc in folder
                filenam=strrep(ilin(4:end),' ','');
                filenam=strrep(filenam,'1','');filenam=strrep(filenam,'2','');filenam=strrep(filenam,'3','');filenam=strrep(filenam,'4','');filenam=strrep(filenam,'5','');filenam=strrep(filenam,'6','');filenam=strrep(filenam,'7','');filenam=strrep(filenam,'8','');filenam=strrep(filenam,'9','');filenam=strrep(filenam,'0','');filenam=strrep(filenam,'.','');
                filenam=strrep(filenam,'/','_');filenam=strrep(filenam,':','_');
                fprintf(fid_cont,'%s\n',filenam);
                fclose(fidout);
                fidout=fopen(['.\',foldnam,'\',filenam,'.adoc'],'w'); %fprintf('fopen fidout %s\n',['.\',foldnam,'\',filenam,'.adoc']);
                ilin=ilin(5:end); 
                %a=findstr(ilin,' '); ilin=ilin(a(1)+1:end); %elimiate chapter number if needen !workaround! 
%                 fprintf(fidout,'= %s\n:imagesdir: img\n\n',ilin);
                fprintf(fidout,'= %s\n\n',ilin);
        elseif findstr(ilin(1:5),'==== ');%open subheadline
                fprintf(fidout,'\n%s\n\n',ilin(3:end));
        elseif findstr(ilin(1:5),'=====');%open subheadline
                fprintf(fidout,'\n%s\n\n',ilin(3:end));

            
        elseif findstr(ilin,'image:');   %image
            n=length(findstr(ilin,'image:')); %several images in one line
            for jj=1:n  %copy muliple files
                a=findstr(ilin,'/'); b=findstr(ilin,'.');c=findstr(ilin,'[');
                d=(jj-1)*4+2; %workaround!
                try copyfile(['extracted-media/media/',ilin(a(d)+1:c(jj)-1)],[foldnam,'\img\']);
                   % fprintf(['extracted-media/media/',ilin(a((ii*4)+2)+1:c-1),' ',foldnam,'\img\']);
                catch
                    try fprintf(['copy extracted-media/media/',ilin(a(d)+1:c(jj)-1),' ',foldnam,'\\img\\\n']); end;
                end;
            end
            ilin=strrep(ilin,'extracted-media/media','img');
            fprintf(fidout,'\n%s\n\n',ilin);
        else
            
            if findstr(ilin,'*'); fprintf(fidout,'\n%s\n',ilin); else fprintf(fidout,'%s\n',ilin); end;
        end

   end;
end

fclose(fid);
fclose(fid_cont);fclose(fid_rootcont);
fclose(fidout);

a=dir;
for ii=[3:length(a)];
    if a(ii).isdir==1;
        if exist([a(ii).folder,'\',a(ii).name,'\index.adoc'])
        fid=fopen([a(ii).folder,'\',a(ii).name,'\index.adoc'],'r');
        ilin=fgetl(fid);
        fclose(fid);
        fid=fopen([a(ii).folder,'\',a(ii).name,'\index.adoc'],'w');
        fprintf(fid,'%s\n\n',ilin);
        fprintf(fid,'Note: this is a online snapshot of the version 01/2024 for internal use only. Please get the latest version via your service department. In only contains reference material snippets for repairs.\n');
        fclose(fid);
        end
    end
end
        fid=fopen([a(ii).folder,'\contents.txt'],'r');
        fclose(fid);

copyfile contents_.txt contents.txt  
%Files = searchDocumentsInSubfolders(startingFolder,'.html');

