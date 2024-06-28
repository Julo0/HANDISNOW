% create a list with the frame number of all turns during the boarde cross
% the frame are then transform as a time variable

function virage = boardercross_frame(S)

    for i = 1:length(S.markers)
            if isequal(S.markers(i).text,'virage 1')
                v1 = S.markers(i).frame;
            end

            if isequal(S.markers(i).text,'virage 2')
                v2 = S.markers(i).frame;
            end

            if isequal(S.markers(i).text,'virage 3')
                v3 = S.markers(i).frame;
            end

            if isequal(S.markers(i).text,'virage 4')
                v4 = S.markers(i).frame;
            end

            if isequal(S.markers(i).text,'virage 5')
                v5 = S.markers(i).frame;
            end

            if isequal(S.markers(i).text,'virage 6')
                v6 = S.markers(i).frame;
            end

            if isequal(S.markers(i).text,'virage 7')
                v7 = S.markers(i).frame;
            end

            if isequal(S.markers(i).text,'virage 8')
                v8 = S.markers(i).frame;
            end

            if isequal(S.markers(i).text,'virage 9')
                v9 = S.markers(i).frame;
            end

            if isequal(S.markers(i).text,'virage 10')
                v10 = S.markers(i).frame;
            end

    end

    framelist = [v1,v2,v3,v4,v5,v6,v7,v8,v9,v10];

    virage = [];
    for i = 1:10
        virage = [virage, str2num(S.frame(framelist(i)).time)/1000];
    end



