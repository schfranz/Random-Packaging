%TODO: post question about listener hierarchy on stackoverflow

classdef FillableBox < Box & FillableShapeInterface %order determines which superclass constructor is used!
    %class that inherits from Box and implements FillableShapeInterface
    %FillableBox is a Box object that can be filled with a shape 
    %   implementing FillShapeInterface
    
    %inherited properties:
        %from class Box:
        %depth      %shortest side
        %width      %medium side
        %height     %longest side
        %center     %center coordinates     %default: [0,0,0]
        %volume     %volume of box       %protected
        %shape      %box                 %protected
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
            
            %initialize empty variables
            obj.shapeLocs = table('Size', [0,5], ...
                'VariableTypes', {'int16', 'double', 'double', 'double', 'cell'}, ...
                'VariableNames', {'ID', 'X', 'Y', 'Z', 'FillShapeType'});
            obj.shapeLocsOrig = table('Size', [0,5], ...
                'VariableTypes', {'int16', 'double', 'double', 'double', 'cell'}, ...
                'VariableNames', {'ID', 'X', 'Y', 'Z', 'FillShapeType'});
            obj.coordListX = table('Size', [0,3], ...
                'VariableTypes', {'double', 'int16', 'cell'}, ...
                'VariableNames', {'X', 'ID', 'FillShapeType'});
            obj.coordListY = table('Size', [0,3], ...
                'VariableTypes', {'double', 'int16', 'cell'}, ...
                'VariableNames', {'Y', 'ID', 'FillShapeType'});
            obj.coordListZ = table('Size', [0,3], ...
                'VariableTypes', {'double', 'int16', 'cell'}, ...
                'VariableNames', {'Z', 'ID', 'FillShapeType'});
            
            %listeners
            addlistener(obj, 'volume', 'PostSet', @FillableBox.updateProps);
        end
    end
    
    methods
        %add a shape to FillableBox
        function addShape(obj)
            checkValidFillShape(obj, fillObj); %compares fillObj to list of allowed shapes
            switch fillObj.shape
                case 'sphere'
                    %check if sphere dimensions are too large
                    if (fillObj.depth > obj.depth || fillObj.width > obj.width || ...
                            fillObj.height > obj.height)
                        error(obj.errMessLargeFillShape)
                    end
                    
                    %generate allowed space for center location
                    %for sphere in a box, this space will be a box
                    okayCenterLoc = Box(obj.depth - fillObj.depth, ...
                        obj.width - fillObj.width, obj.height - fillObj.height, ...
                        obj.center);
                    
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
        function placeFillShapesRand(obj, FillShapeArray)
            %check how many FillShapes are present and if they match the
            %   expected number of FillShapes
            numElem = numel(FillShapeArray);
            if (numElem > obj.nFillShapesExp)
                warning(obj.warnMessNshapesIncr)
            end
            
            %initialize random locations
            randLoc = zeros(numElem, 3); %initialize random locations; columns are x, y, z
            
            %determine possible center locations and generate random location
            for i = 1:numElem
                checkValidFillShape(obj, FillShapeArray(i)); %compares class of FillShape object to list of allowed shapes
                switch FillShapeArray(i).shape
                    case 'sphere'
                        %check if sphere dimensions are too large
                        if (FillShapeArray(i).depth > obj.depth || ...
                                FillShapeArray(i).width > obj.width || ...
                                FillShapeArray(i).height > obj.height)
                            error(obj.errMessLargeFillShape)
                        end
                        
                        %generate allowed space for center location
                        %for sphere in a Box, this space will be a Box
                        okayCenterLoc = Box(obj.depth - FillShapeArray(i).depth, ...
                            obj.width - FillShapeArray(i).width, ...
                            obj.height - FillShapeArray(i).height, obj.center);
                        
                        %generate random location in Box
                        %formula for N random numbers in interval (a,b) is r = a + (b-a).*rand(N,1)
                        randLoc(i,1) = (okayCenterLoc.center(1) - okayCenterLoc.depth/2) + ...
                            okayCenterLoc.depth .* rand(1,1);
                        randLoc(i,2) = (okayCenterLoc.center(2) - okayCenterLoc.width/2) + ...
                            okayCenterLoc.width .* rand(1,1);
                        randLoc(i,3) = (okayCenterLoc.center(3) - okayCenterLoc.height/2) + ...
                            okayCenterLoc.height .* rand(1,1);
                        
                        %copy new center into FillShape array
                        FillShapeArray(i).center = [randLoc(i,1), ...
                            randLoc(i,2), randLoc(i,3)];
                end
            end
            
            %copy intended original locations to shapeLocsOrig and assign IDs
            %also insert new FillShapes into shapeLocs
            if (isempty(obj.shapeLocsOrig) && isempty(obj.shapeLocs))
                newLocs = table((1:numElem)', randLoc(:,1), randLoc(:,2), ...
                    randLoc(:,3), {FillShapeArray(:).shape}');
                newLocs.Properties.VariableNames = obj.shapeLocsOrig.Properties.VariableNames;
                obj.shapeLocsOrig = [obj.shapeLocsOrig; newLocs];
                obj.shapeLocs = [obj.shapeLocs; obj.shapeLocsOrig];
            else
                %TODO insert handling for additional FillShapes here
            end
            
            %populate x, y, z coordinate tables with sorted values
            if (isempty(obj.coordListX) && isempty(obj.coordListY) && ...
                    isempty(obj.coordListZ))
                %X
                newCoords = table(obj.shapeLocs.X, obj.shapeLocs.ID, ...
                    obj.shapeLocs.FillShapeType);
                newCoords.Properties.VariableNames = obj.coordListX.Properties.VariableNames;
                obj.coordListX = [obj.coordListX; sortrows(newCoords, 'X')];
                %Y
                newCoords = table(obj.shapeLocs.Y, obj.shapeLocs.ID, ...
                    obj.shapeLocs.FillShapeType);
                newCoords.Properties.VariableNames = obj.coordListY.Properties.VariableNames;
                obj.coordListY = [obj.coordListY; sortrows(newCoords, 'Y')];
                %Z
                newCoords = table(obj.shapeLocs.Z, obj.shapeLocs.ID, ...
                    obj.shapeLocs.FillShapeType);
                newCoords.Properties.VariableNames = obj.coordListZ.Properties.VariableNames;
                obj.coordListZ = [obj.coordListZ; sortrows(newCoords, 'Z')];
            else
                %TODO implement handling for additional FillShapes here
            end
            
            %set to filled
            obj.isFilled = true;
            %FillShapeArray = FillShapeArray.setOuterShape(obj);
            %make FillShapes aware of the surrounding object, their own IDs, ...
            %   and their neighbors 
            for i = 1:numElem
                FillShapeArray(i,1) = FillShapeArray(i).setOuterShape(obj);
                FillShapeArray(i,1) = FillShapeArray(i,1).setID(obj.shapeLocsOrig.ID(i));
                FillShapeArray(i,1) = FillShapeArray(i,1).updateNeighbors(obj);
            end
            
            %determine conflicts with other FillShapes and walls
            conflicts = zeros(numElem, 1);
            for i = 1:numElem
                detectConflicts();
            end
            
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