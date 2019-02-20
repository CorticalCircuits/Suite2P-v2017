
190208

buildops3, line 199
- pasted in options for filenames for sci vs prairie

master_file_SPD_190201, line 107
- pasted in function 

master_file_SPD_190201, line 58
- set ops0.dobidi = 0; otherwise you get this error 
- missing BiDiPhaseOffsets function

Undefined function or variable 'BiDiPhaseOffsets'.

Error in reg2P (line 58)
        ops.BiDiPhase = BiDiPhaseOffsets(IMG);

Error in run_pipeline (line 39)
    ops1 = reg2P(ops0);  % do registration

Error in master_file_SPD_190201 (line 111)
    run_pipeline(db, ops0);
    
190214

buildops3, line 13
- all of this added for sci vs prairie

    for k = 1:length(db.expts)
        if strcmp(db.which2p,'prairie')
            dashes = strfind(db.fb,'-');
            ops.SubDirs{k}    = [db.fb(1:dashes(end)),sprintf('%03d',db.expts(k))];
        elseif strcmp(db.which2p,'sci')
            ops.SubDirs{k}    = num2str(db.expts(k));
%         ops.SubDirs{k}    = num2str(db.expts(k));
        end
    end
    
buildops3, line 27
- removed ops.mousename from RootDir because its already in RootStorage

%         ops.RootDir = fullfile(ops.RootStorage, ops.mouse_name, ops.date);
        ops.RootDir = fullfile(ops.RootStorage, ops.date); %SPD removed mousename 
        
        
        
write_reg_to_tiff.m, line 53
%             partname = sprintf('%s_%s_%s_2P_plane%d_%d.tif', ops.date, ops.SubDirs{k}, ...
%             ops.mouse_name, iplane, ix);
        partname = sprintf('%s_%s_2P_plane%d_%d.tif', ops.SubDirs{k}, ...
            ops.mouse_name, iplane, ix);
        
reg2P, line 358
% save(sprintf('%s/regops_%s_%s.mat', ops.ResultsSavePath, ...
%     ops.mouse_name, ops.date),  'ops1')
save(sprintf('%s/regops_%s.mat', ops.ResultsSavePath),  'ops1')

master_file_SPD_190201, line 69
ops0.nSVDforROI             = 100; % how many SVD components for cell clustering
%(change to 100 from 1000