function m = Formater_fichier()

HeadPosition = {'Position X', 'Position Y', 'Position Z', 'Unit', 'Category', 'Collection', 'Time', 'TrackID', 'ID'}; %Nom des variables attendues pour le fichier position
HeadSpeed = {'Value', 'Unit', 'Category', 'Time', 'TrackID', 'ID'}; %Nom des variables attendues pour le fichier speed

[PositionFileName,PositionPathName] = uigetfile('*.xls','Select Position File'); %Récupère le fichier position
while PositionFileName == 0 | strcmp(PositionFileName(end-3:end),'.xls') == 0 | strcmp(PositionFileName(end-4:end),'.xlsx')%Test les erreurs d'ouverture et de format
    % Boîte de dialogue
    choice = questdlg('You have to chose a file in the good extension to continue. Would you like to retry?','File Error','Yes','No','No');
    % Reponse
    switch choice
        case 'Yes'
            [SpeedFileName,SpeedPathName] = uigetfile('*.xls','Select Speed File'); %Repose la question
        case 'No'
            exit
    end
end

[SpeedFileName,SpeedPathName] = uigetfile('*.xls','Select Speed File'); %Récupère le fichier speed
while SpeedFileName == 0 | strcmp(SpeedFileName(end-3:end),'.xls') == 0 | strcmp(SpeedFileName(end-4:end),'.xlsx')%Test les erreurs d'ouverture et de format
    % Boîte de dialogue
    choice = questdlg('You have to chose a file in the good extension to continue. Would you like to retry?','File Error','Yes','No','No');
    % Reponse
    switch choice
        case 'Yes'
            [SpeedFileName,SpeedPathName] = uigetfile('*.xls','Select Speed File'); %Repose la question
        case 'No'
            exit
    end
end

% Importation des données
position = dataset('xlsfile', strcat(PositionPathName,PositionFileName)); 
speed = dataset('xlsfile', strcat(SpeedPathName,SpeedFileName)); 

%Transformation en données de type cell
position=dataset2cell(position); 
speed=dataset2cell(speed); 

if not(isequal(position(2,:),HeadPosition)) || not(isequal(speed(2,:),HeadSpeed)) %Test le nom des variables 
    msgbox('One or both file is not good. Check and retry.');
else
    position(:,6:9) = []; %Enlève les variables Collection, Time, TrackID et ID

    %Concaténation des datasets
    position_speed=[position speed];
    
    position_speed
    %Trie dans les colonnes et lignes
    position_speed(1,:) = [];
    position_speed(:,5) = []; %Enlève Catégory
    position_speed(:,7) = []; %Enlève Catégory
    position_speed(:,9) = []; %Enlève ID
    position_speed(1,9) = {'Centrosomes Names'};
    head = position_speed(1,:); %head des colonnes
    position_speed(1,:) = []; %Enlève le nom des colonnes

    %Sort en fonction des TrackID
    sort_position_speed = sortrows(position_speed,8);
    sort_position_speed = [head;sort_position_speed]; %remet les noms des colonnes en haut

    [FileName,PathName] = uiputfile('*.xls','Save file name','position_speed_combine');

    while FileName == 0
        % Boîte de dialogue
        choice = questdlg('You have to chose a directory and file name to save the File. Would you like to retry?','Error in saving','Yes','No','No');
        % Reponse
        switch choice
            case 'Yes'
                [FileName,PathName] = uiputfile('*.xls','Save file name','position_speed_combine');
            case 'No'
                exit
        end
    end

    filename = strcat(PathName,FileName); 
    xlswrite(filename,sort_position_speed);

    msgbox({'Done.' 'Do not forget to add centrosomes name'});
end





