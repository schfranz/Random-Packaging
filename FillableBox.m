%TODO: post question about listener hierarchy on stackoverflow

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
        %nFillShapesExp     %number of FillShapes user expects to place    %default: 10
        %iterDepthMove      %moving other objects when new object can't be placed %default: 10
        %iterDepthSurvGrid  %making grid on observation object finer          %default: 3
        %iterDepthSurvSize  %making an observation object bigger %default: 3
        %gravityOn          %set to true to move all movable objects as close to negative z as possible  %default: false
        %sequentialDrop     %when true, will drop FillShapes sequentially instead of all at once %default: false
        %goAllIn            %set to true to turn on gravity and figure out if object can placed   %default: false
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
        %addShape(obj)              %function that adds a FillShape 
        %deleteShape(obj)           %function that deletes a FillShape
        %placeFillShapesRand(obj)   %function to randomly distribute FillShapes
        
    %%
    %%VARIABLES
    %%PROTECTED%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %%
    %%FUNCTIONS
    %%CONSTRUCTOR%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    methods
        %constructor method
        function obj = FillableBox(varargin) %can call with 0, 3, or 4
            obj = obj@Box(varargin{:}); %call to superclass constructor
            
            if (nargin > 4)
                error(obj.errMessTooManyInputs)
            end
            
            switch nargin
                case num2cell(1:3)
                    obj.freeVolume = obj.volume;
            end
            %listeners
            addlistener(obj, 'volume', 'PostSet', @FillableBox.updateProps);
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
        
        %place an array of FillShapes randomly
        function placeFillShapesRand(obj)
            %initialize random locations
            
        end
    end
    
    methods (Static)
        %update function that responds to data update by user
        function updateProps(~, eventData) %first argument is class info?
            obj = eventData.AffectedObject;
            switch eventData.Source.Name
                case 'volume'
                    obj.freeVolume = obj.freeVolume + (obj.volume - obj.tempVolume);
                    %{
                    %obj.volume = obj.height * obj.width * obj.depth;
                    %obj.diagonal = 2*pdist([obj.center; (obj.center - ...
                    %    [obj.depth/2, obj.width/2, obj.height/2])]);
                    %@Box.updateProps; %ask on stackoverflow
                    obj.height = obj.height;
                    obj.freeVolume = obj.volume; %for now
                case 'width'
                    obj.volume = obj.height * obj.width * obj.depth;
                    obj.diagonal = 2*pdist([obj.center; (obj.center - ...
                        [obj.depth/2, obj.width/2, obj.height/2])]);
                case 'depth'
                    obj.volume = obj.height * obj.width * obj.depth;
                    obj.diagonal = 2*pdist([obj.center; (obj.center - ...
                        [obj.depth/2, obj.width/2, obj.height/2])]);
                    %}
            end
        end
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