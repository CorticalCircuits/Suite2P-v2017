function TiffWriter(image,fname,bitspersamp)
size(image)
% written by Adam Packer (I think).
disp('TiffWriter')
t = Tiff(fname,'w');
tagstruct.ImageLength = size(image,1);
tagstruct.ImageWidth = size(image,2);
tagstruct.Photometric = Tiff.Photometric.MinIsBlack;
if bitspersamp==16
    tagstruct.BitsPerSample = 16;
end
if bitspersamp==32
    tagstruct.BitsPerSample = 32;
end
tagstruct.SampleFormat = Tiff.SampleFormat.Int;
tagstruct.SamplesPerPixel = 1;
tagstruct.RowsPerStrip = 256;
tagstruct.PlanarConfiguration = Tiff.PlanarConfiguration.Chunky;
tagstruct.Software = 'MATLAB';
t.setTag(tagstruct);
t.write(image(:,:,1));
for i=2:size(image,3)
    t.writeDirectory();
    t.setTag(tagstruct);
    try
        t.write(image(:,:,i));
    catch
        i
        size(image)
        figure
        imagesc(image(:,:,i))
        max(max(image(:,:,i)))
        min(min(image(:,:,i)))
    end
end
t.close();