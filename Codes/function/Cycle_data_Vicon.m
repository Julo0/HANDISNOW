function cycle_data = Cycle_data_Vicon(Struct)
    
    frequence = 200;
    cycle_data_essai = struct();

    % merge and order data from the turn to check validity of the cycle
    fbs = Struct.frame_BS;
    ffs = Struct.frame_FS ;
    merged_data = [fbs, repmat("backside", size(fbs, 1),1); ffs, repmat("frontside", size(ffs, 1),1)];
    frame_turn_sorted = sort(str2double(merged_data(:,1)));
    [~,idx] = sort(str2double(merged_data(:,1)));
    label_turn_sorted = merged_data(idx,2);

    % base de temps
    nb_frame = length(Struct.essai.res_var_angle_t.chevilleD);
    T = zeros(nb_frame, 1);
    for t =1 : nb_frame
        T(t) = t/frequence;
    end

    num_cycle = 1;
    cycle_data = struct();
    index_FS = [];

    for i = 1:(length(frame_turn_sorted)-2)
    
        if (label_turn_sorted(i) =="backside") && (label_turn_sorted(i+1) =="frontside")
            frame1 = frame_turn_sorted(i);
            frame_front = frame_turn_sorted(i+1);
            frame2 = frame_turn_sorted(i+2)-1;
    
            index_FS = [index_FS, frame_front-frame1];

            xdata = T(frame1:frame2);
            pdata = (xdata-min(xdata))/(max(xdata)-min(xdata))*100;
        
            % ankle
            Rdata = Struct.essai.res_var_angle_t.chevilleD(frame1:frame2,3);
            Ldata = Struct.essai.res_var_angle_t.chevilleG(frame1:frame2,3);
        
            cycle_data.ankle(num_cycle).cycle =  num_cycle;
            cycle_data.ankle(num_cycle).Rjoint =  -unwrap(Rdata);
            cycle_data.ankle(num_cycle).Ljoint =  -unwrap(Ldata);
            cycle_data.ankle(num_cycle).size = length(pdata);
            cycle_data.ankle(num_cycle).pdata = pdata;
        
            % knee
            Rdata = Struct.essai.res_var_angle_t.genouD(frame1:frame2,3);
            Ldata = Struct.essai.res_var_angle_t.genouG(frame1:frame2,3);
        
            cycle_data.knee(num_cycle).cycle =  num_cycle;
            cycle_data.knee(num_cycle).Rjoint =  Rdata;
            cycle_data.knee(num_cycle).Ljoint =  Ldata;
            cycle_data.knee(num_cycle).size = length(pdata);
            cycle_data.knee(num_cycle).pdata = pdata;
        
            % hip
            Rdata = Struct.essai.res_var_angle_t.hancheD(frame1:frame2,3);
            Ldata = Struct.essai.res_var_angle_t.hancheG(frame1:frame2,3);
        
            cycle_data.hip(num_cycle).cycle =  num_cycle;
            cycle_data.hip(num_cycle).Rjoint =  -unwrap(Rdata);
            cycle_data.hip(num_cycle).Ljoint =  -unwrap(Ldata);
            cycle_data.hip(num_cycle).size = length(pdata);
            cycle_data.hip(num_cycle).pdata = pdata;

            % pelvis
            Ori_pelvis = Struct.essai.res_var_angle_t.bassin(frame1:frame2,:);
            cycle_data.pelvis(num_cycle).cycle =  num_cycle;
            cycle_data.pelvis(num_cycle).Orientation =  -unwrap(Ori_pelvis);
            cycle_data.pelvis(num_cycle).pdata =  pdata;

            % sternum
            Ori_sternum = Struct.essai.res_var_angle_t.tronc(frame1:frame2,:);
            cycle_data.sternum(num_cycle).cycle =  num_cycle;
            cycle_data.sternum(num_cycle).Orientation =  -unwrap(Ori_sternum);
            cycle_data.sternum(num_cycle).pdata =  pdata;

            num_cycle = num_cycle + 1;
            
        end
    end
    cycle_data.FS_transition = index_FS;

