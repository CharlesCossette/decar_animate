directories = {'./lib/'};
output_filename = './API.md';

% Open the output API markdown file. Print basic title and table of
% contents in markdown
file_out = fopen(output_filename,'w');
fprintf(file_out, '# API Documentation \n [TOC] \n');


% Get all .m files in the directory.
file_list =  what(directories{1});
file_list = file_list.m;

% Go through each .m file.
for lv1 = 1:numel(file_list)
    % Get the .m file name string
    m_file = file_list{lv1};
    % Get the .m file name string without the ".m" file extension
    m_file_name = erase(m_file,'.m');
    
    % Get class description help documentation.
    desc_help_string = help(m_file);
    cut_location = strfind(desc_help_string, 'Documentation for');
    desc_help_string = desc_help_string(1:cut_location-1);
    
    header = ['## ', m_file_name, '\n'];
    
    fprintf(file_out, header);
    fprintf(file_out, [desc_help_string, '\n']);
    
    % Get Property discriptions
    fprintf(file_out,['#### **',m_file_name,' Properties**:\n\n']);
    props = properties(m_file_name);
    for lv2 = 1:numel(props)
        prop_help_string = help([m_file_name,'.',props{lv2}]);
        prop_help_exists = (numel(strfind(prop_help_string,'is a property.')) == 0);
        if prop_help_exists
            fprintf(file_out, [prop_help_string,'\n']);
        end
    end

    
    % CUSTOM FOR decar_animate
    % Get a picture of the object
    try
        ani_obj = eval(m_file_name);
        figure(1);
        clf;
        ani_obj.plot([0;0;0],eye(3));
        axis vis3d
        axis equal
        drawnow;
        saveas(gcf,['./doc/', m_file_name],'png');
        fprintf(file_out,['![Picture of ',m_file_name,'](./doc/',m_file_name,'.png)\n']);
    catch
    end

end
    
fclose(file_out);


