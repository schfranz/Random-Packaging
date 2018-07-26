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
        %constructor method
        function obj = FillableBox(varargin)
            obj = obj@Box(varargin{:}); %call to superclass constructor
            
            if (nargin > 3) %check 3
                error(obj.errMessTooManyInputs)
            end
            
            switch nargin
                case num2cell(1:3)
                    obj.freeVolume = obj.volume; %check 
            end
            %listeners
            addlistener(obj, 'allowOverlap', 'PostSet', @cylCanister.letOverlap); %check
        end
        
    end
    
    methods
        %add a shape to FillableBox
        function addShape(obj)
            checkIfValidFillShape(obj, fillObj) %compares fillObj to list of allowed shapes
            switch fillObj.shape
                case 'sphere'
                    %check if sphere dimensions are too large
                    if (fillObj.width > obj.width || fillObj.height > obj.height)
                        error(obj.errMessLargeFillShape)
                    end
                    
                    %generate allowed space for center location
                    %for sphere in a box, this space will be a box
                    okayCenterLoc = Box(obj.width - fillObj.width, ...
                        obj.height - fillObj.height, obj.center);
                    
                    %check if sphere center falls within this space
                    %MOEP
                    %if there is a conflict, determine magnitude of force
                    
                    %if the FillShape is in a valid location, update list
                    %of neighbors
                        %check number of existing FillShapes
                        %if less than 18, make sure FillShape is okay with
                        %   there not being enough
                        %add whatever neighbors are around (3 up, 3 down on
                        %   x, y, z)
                    %check distances to all neighbors
                        %if distances are large enough for all nearest
                        %   neighors, Fillshape has been placed
                        %   successfully
                            %update neighborlists for all surrounding Shapes
                            %   (recursively if other Shapes have to knock
                            %   Shapes off their lists)
                            %return
                        %if there is a conflict, determine magnitude of
                        %   force
                    %if there is a nonzero force (wall plus other
                    %   FillShapes), determine magnitude and direction
                        %if force points further into the wall, drop cones
                        %   to check for more space further into the shape
                        %if force points inwards, check target location
                            %if more space, move there and go back to
                            %   checking distances
                            %if less space, drop cones and look elsewhere
                    %if moving, and cone-dropping doesn't help, return to
                    %   original location and move away from wall if there
                    %   is a wall force and move neighbors if they are
                    %   movable and can find better space
                    %if neighbor moving is unsuccessful, declare sphere
                    %unplaceable
            end
        end
        
        function deleteShape(obj)
            %check that object exists
            %remove object from x, y, z lists
            %remove object from neighbor lists of its own neighbors
        end
    end
    
    methods (Static)
        %function not implemented; will move objects back to their original
        %location if "allowOverlap" is set to true
        %MOEP do i need this?
        function letOverlap(~, eventData) %first argument is class info?
            obj = eventData.AffectedObject;
            switch eventData.Source.Name
            end
        end
    end
    
    
    
end