% print the trajectory of the center of mass
% input : S = structure mvnx
%         bool = int
% return the position of the com, if bool = 1 plot the position

function Pos_com = traj_com(S, bool)

    for i = 1:length(S.markers)
        if isequal(S.markers(i).text,'debut')
            frame_debut = S.markers(i).frame;
        end
        if isequal(S.markers(i).text,'fin')
            frame_fin = S.markers(i).frame;
        end
    end


    Pos_com = zeros(length(S.frame) ,3);
    for i = 1 : length(S.frame)
        Pos_com(i,:) = S.frame(i).centerOfMass(1:3)';
    end

    if bool == 1
        figure();
        plot3(Pos_com(frame_debut:frame_fin,1),Pos_com(frame_debut:frame_fin,2),Pos_com(frame_debut:frame_fin,3));
        hold on
        plot3(Pos_com(frame_debut,1),Pos_com(frame_debut,2),Pos_com(frame_debut,3), '.g')
        plot3(Pos_com(frame_fin,1),Pos_com(frame_fin,2),Pos_com(frame_fin,3), '.r')
        xlabel('X');
        ylabel('Y');
        zlabel('Z');
        title('Trajectoire du centre de masse')
    end




