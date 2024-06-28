% function that take 2 structures and merges them into one single strucure

function merged_struct = Merge_structure(Struct1, Struct2)

% vérifier que les structures sont compatibles et ont les memes fieldnames

filednames1 = fieldnames(Struct1);
filednames2 = fieldnames(Struct2);

if isequal(filednames1,filednames2)==0
    error('The structures are not identical : different fieldnames');
end


% merge la seconde struct sur la première
merged_struct = Struct1;

for i = 1: length(filednames1)
    names_var = filednames1{i};
    merged_struct.(names_var) = horzcat(Struct1.(names_var) ,Struct2.(names_var));
end
