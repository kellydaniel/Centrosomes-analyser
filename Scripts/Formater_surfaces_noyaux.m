warning('off','MATLAB:xlswrite:AddSheet');

Path = uigetdir ; 
ext = '*.obj';

cas = 0;
while cas == 0
    if Path == 0
    % Boîte de dialogue
        choice = questdlg('You have to chose a directory to continue. Would you like to retry?','Directory Error','Yes','No','No'); %Pas de dossier sélectionné
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
            % Boîte de dialogue
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
 
h = waitbar(0,'Job is running...'); %Ouverture de la fenêtre d'avancement
i=1;

while i <= Fin(1) %pour tous les fichiers
    [pathstr,name,ext] = fileparts([Path '\' ListFile(i).name]); %Sépare le path du nom et de l'extension
    copyfile([pathstr '\' name ext],[pathstr '\' name '.txt']); % copie dans un nouveau fichier au format txt
    OpenFile = fopen([pathstr '\' name '.txt'],'rt'); %ouvre le fichier
    v = fscanf(OpenFile,'%s',1); %lit la première lettre
    points = {'X', 'Y', 'Z' }; %Créer la cell
    while strcmp(v,'v') == 1 %tant que la ligne correspond aux vertices
        points = [points;{fscanf(OpenFile,'%s',1),fscanf(OpenFile,'%s',1),fscanf(OpenFile,'%s',1)}]; %Ajoute les coordonnées du point
        v= fscanf(OpenFile,'%s',1); %Regarde la première lettre de la ligne d'après
    end
    fclose(OpenFile); %ferme le fichier
    name = strsplit(name,'_'); %Sépare quand '_'
    temps = cellstr(name{3}')'; %Split toutes les lettre et chiffre du 3éme élement de l'array
    temps(1)= []; %enlève de 't'
    temps = int2str(str2double(cell2mat(temps)) + 1);%transforme le char en int, ajoute 1 et le retransforme en char
    ID = name{4};
    xlswrite([PathName '\' ID],points,temps); %Ecrit les coordonnées dans un excel dans le sheet donné ayant le temps comme nom

    waitbar(i / Fin(1)) %Mise à jour de la barre d'avancement
    
    i = i + 1;
 end

close(h) %Fermeture de la fenêtre d'avancement
msgbox({'Done.' 'Do not forget to rename the files with true cell name'}); %Message de fin 