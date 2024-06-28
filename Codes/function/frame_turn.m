% this function returns the liste of frame of the backside and frontside
% turns
% Input : Structure studied, index of the first frame of interest, index of
% last turn of interest

function [list_bs, list_fs, list_frame_bs, list_frame_fs] = frame_turn(S, index, nb_turns)
    

    % chech if the number of turn is even or odd
    tester = (-1)^nb_turns;
    if tester == 1
        nb_bsfs = nb_turns/2;
    else
        nb_bsfs = (nb_turns+1)/2;
    end

    % check is the first turn is a backside
    if isequal(contains(S.markers(index).text,'backside'), true)
        frame_bs = [S.markers(index).frame];
        frame_fs = [S.markers(index+1).frame];

        for i = 1 : (nb_bsfs-2)
            frame_bs = [frame_bs, S.markers(index+2*i).frame];
            frame_fs = [frame_fs, S.markers(index+(2*i+1)).frame];
        end

        if tester == 1
            frame_bs = [frame_bs, S.markers(nb_turns+index-2).frame];
            frame_fs = [frame_fs, S.markers(nb_turns+index-1).frame];
        else
            frame_bs = [frame_bs, S.markers(nb_turns+index-1).frame];
        end
    end


    % check is the first turn is a frontside
    if isequal(contains(S.markers(index).text,'frontside'), true)
        frame_fs = [S.markers(index).frame];
        frame_bs = [S.markers(index+1).frame];

        for i = 1 : (nb_bsfs-2)
            frame_fs = [frame_fs, S.markers(index+2*i).frame];
            frame_bs = [frame_bs, S.markers(index+(2*i+1)).frame];
        end

        if tester == 1
            frame_fs = [frame_fs, S.markers(nb_turns+index-2).frame];
            frame_bs = [frame_bs, S.markers(nb_turns+index-1).frame];
        else
            frame_fs = [frame_fs, S.markers(nb_turns+index-1).frame];
        end
    end

    list_frame_bs = frame_bs;
    list_frame_fs = frame_fs;

    % transforming frames into time reference
    for i = 1:length(frame_bs)
        frame_bs(i) = str2num(S.frame(frame_bs(i)).time)/1000;
    end
    for i = 1:length(frame_fs)
        frame_fs(i) = str2num(S.frame(frame_fs(i)).time)/1000;
    end

    list_bs = frame_bs;
    list_fs = frame_fs;



