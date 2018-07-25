classdef (Abstract) FillableShapeInterface < ShapeInterface
    %abstract class that describes a 3-D shape that is filled with another
    %   3-D shape
    %inherited properties:
        %volume     %volume of shape        %protected
        %shape      %shape type             %protected
        %width      %width of shape
        %height     %height of shape
        %center     %center coordinates     %default: [0,0,0]
    
    %%
    %%VARIABLES
    %%PROTECTED%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    properties (SetAccess = protected)
        freeVolume          %free volume that remains when filling shape is inside
        isFilled = false    %boolean that is true if a shape is inside the outer shape
    end
    
    %%
    %%FUNCTIONS
    %%ABSTRACT%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    methods (Abstract)
        canFillHere(obj)
    end    
end