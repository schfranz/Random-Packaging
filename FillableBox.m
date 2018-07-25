classdef FillableBox < Box & FillableShapeInterface %order determines which superclass constructor is used!
    %class that inherits from Box and implements FillableShapeInterface
    %FillableBox is a Box object that can be filled with a shape 
    %   implementing FillShapeInterface
    
    %inherited properties:
        %from class Box:
        %volume     %volume of box       %protected
        %shape      %box                 %protected
        %height     %longest side
        %width      %medium side
        %depth      %shortest side
        %center     %center coordinates     %default: [0,0,0]
        %diagonal   %body diagonal
        %from abstract class FillableShapeInterface:
        %nFillShapesExp %number of FillShapes user expects to place    %default: 10
        %allowedFillShapes = 'sphere';   %FillShapes that can be used (remove default later)
        %mixedShapes = false;        %boolean that is true if FillShapes are different (sizes or shapes)
        %nFillShapes = 0;            %actual number of FillShapes present
        %freeVolume                  %free volume that remains when FillShapes are inside
        %isFilled = false            %boolean that is true if a shape is inside the outer shape
        %shapeLocs                   %list of FillShape IDs, actual center coordinates, and shape types: [ID, x, y, z, shape]
        %shapeLocsOrig               %same as shapeLocs, but with originally intended center coordinates
        %coordListX                  %list of actual x coordinates, shape IDs, and types: [x, ID, shape]
        %coordListY                  %list of actual y coordinates, shape IDs, and types: [y, ID, shape]
        %coordListZ                  %list of actual z coordinates, shape IDs, and types: [z, ID, shape]
        
    %needs to implement:
        %for FillableShapeInterface:
        %canFillHere(obj)
        
    %%
    %%VARIABLES
    %%PROTECTED%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %%
    %%FUNCTIONS
    %%CONSTRUCTOR%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    
    methods
        function addShape(obj)
            
        end
        
        function deleteShape(obj)
            
        end
    end
    
    
    
    
    
end