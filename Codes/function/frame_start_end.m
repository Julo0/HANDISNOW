% start and end frames number of xsens data

function frames = frame_start_end(S)

% check if markers for start and end have been defined on Xsens
if isfield(S, 'markers')==1

    for i = 1:length(S.markers)
        if isequal(S.markers(i).text,'debut')
            frame_debut = S.markers(i).frame;
        end
        if isequal(S.markers(i).text,'fin')
            frame_fin = S.markers(i).frame;
        end
    end
    
% if not take all the frames into account
else
    frame_debut = 1;
    frame_fin = length(S.frame);
end
frames = [frame_debut ,frame_fin];