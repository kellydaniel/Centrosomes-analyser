warning('off','MATLAB:xlswrite:AddSheet');

Path = uigetdir ; 
ext = '*.obj';

cas = 0;
while cas == 0
    if Path == 0
    % Bo�te de dialogue
        choice = questdlg('You have to chose a directory to continue. Would you like to retry?','Directory Error','Yes','No','No'); %Pas de dossier s�lectionn�
    % Reponse
        switch choice
            case 'Yes'
                Path = uigetdir ; %Repose la question
                cas = 0; 
            case 'No'
                exit
        end
    else 
        Chemin = fullfile(Path,ext); %Cherche tous les fichiers ayant l'extension .obj
        ListFile = dir(Chemin); %liste des fichiers
        Fin = size(ListFile); %nombre de fichiers
        if Fin(1) == 0
            % Bo�te de dialogue
            choice = questdlg('There is no .obj files in the directory. Would you like to retry?','Directory Error','Yes','No','No'); %Pas de fichier object dans le dossier
        % Reponse
            switch choice
                case 'Yes'
                    Path = uigetdir ; %Repose la question
                    cas = 0;
                case 'No'
                    exit
            end
        else 
            cas = 1; %Tout est bon
        end
    end
end

[PathName] = uigetdir('','Save directory name'); % Choisis le nom du fichier excel et son emplacement
 
h = waitbar(0,'Job is running...'); %Ouverture de la fen�tre d'avancement
i=1;

while i <= Fin(1) %pour tous les fichiers
    [pathstr,name,ext] = fileparts([Path '\' ListFile(i).name]); %S�pare le path du nom et de l'extension
    copyfile([pathstr '\' name ext],[pathstr '\' name '.txt']); % copie dans un nouveau fichier au format txt
    OpenFile = fopen([pathstr '\' name '.txt'],'rt'); %ouvre le fichier
    v = fscanf(OpenFile,'%s',1); %lit la premi�re lettre
    points = {'X', 'Y', 'Z' }; %Cr�er la cell
    while strcmp(v,'v') == 1 %tant que la ligne correspond aux vertices
        points = [points;{fscanf(OpenFile,'%s',1),fscanf(OpenFile,'%s',1),fscanf(OpenFile,'%s',1)}]; %Ajoute les coordonn�es du point
        v= fscanf(OpenFile,'%s',1); %Regarde la premi�re lettre de la ligne d'apr�s
    end
    fclose(OpenFile); %ferme le fichier
    name = strsplit(name,'_'); %S�pare quand '_'
    temps = cellstr(name{3}')'; %Split toutes les lettre et chiffre du 3�me �lement de l'array
    temps(1)= []; %enl�ve de 't'
    temps = int2str(str2double(cell2mat(temps)) + 1);%transforme le char en int, ajoute 1 et le retransforme en char
    ID = name{4};
    xlswrite([PathName '\' ID],points,temps); %Ecrit les coordonn�es dans un excel dans le sheet donn� ayant le temps comme nom

    waitbar(i / Fin(1)) %Mise � jour de la barre d'avancement
    
    i = i + 1;
 end

close(h) %Fermeture de la fen�tre d'avancement
msgbox({'Done.' 'Do not forget to rename the files with true cell name'}); %Message de fin 