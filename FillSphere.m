classdef FillSphere < Sphere & FillShapeInterface %order determines which superclass constructor is used!
    %class that inherits from Sphere and implements FillShapeInterface
    %FillSphere is a Sphere object that can be used to fill a shape 
    %   implementing FillableShapeInterface 
    
    %inherited properties:
        %from class Sphere:
        %depth      %diameter
        %width      %diameter
        %height     %diameter
        %center     %center coordinates     %default: [0,0,0]
        %volume     %volume of sphere       %protected
        %shape      %sphere                 %protected
        %radius     %radius of sphere
        %diameter   %diameter of sphere
        %from abstract class FillShapeInterface:
        %movable = true;        %true if a FillShape can be moved
        %transpShape = false;   %true if a FillShape is transparent to other FillShapes, i.e. it is allowed to overlap
        %transpWall = false;    %true if a FillShape is transparent to the wall of the surrounding Fillable object, i.e. it can stick out
        %nRelevantNeighbors = 6;%integer; minimum number of neighbors a FillShape keeps track of
        %ID                     %FillShapes' own ID within Fillable object
        %neighbors              %list of neighbors FillShape needs to be aware of
        %outerShape             %an object that implements FillableShapeInterface and contains the FillShape
        
    %needs to implement:
        %for FillShapeInterface:
        %setID(obj) %update object's ID (only once in FillShapes' lifetime)
        %updateNeighbors(obj) %update list of neighbors as more objects are added
        %setOuterShape(obj) %updates information about surrounding shape
        %checkSurroundings(obj) %drops cones in all directions to see if there is more space elsewhere
        
    %%
    %%VARIABLES
    %%PROTECTED%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %%
    %%FUNCTIONS
    %%CONSTRUCTOR%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    methods
        %constructor method
        function obj = FillSphere(varargin) %can call with 0, 1, or 2
            obj = obj@Sphere(varargin{:}); %call to superclass constructor
            
            if (nargin > 2)
                error(obj.errMessTooManyInputs)
            end
            
            %{
            switch nargin
                case num2cell(1:3)
                    obj.freeVolume = obj.volume; %check 
            end
            %}
            
            %listeners
            addlistener(obj, 'movable', 'PostSet', @FillSphere.updateMobility);
        end
    end
    
    methods
        %set ID (only once in lifetime)
        function obj = setID(obj, ID)
            obj.ID = ID;
        end
        
        %update list of neighbors
        function obj = updateNeighbors(obj, outerShape)
            %nearest two neighbors in X
            %{
            locInList = outerShape.coordListX(outerShape.coordListX.ID == obj.ID);
            outerShape.coordListX((outerShape.coordListX.X < ...
                (outerShape.coordListX.X(outerShape.coordListX.ID == obj.ID) + ...
                obj.radius)) & (outerShape.coordListX.X > ...
                (outerShape.coordListX.X(outerShape.coordListX.ID == obj.ID) - ...
                obj.radius)),:)
            %}
            
            %nearest two neighbors in Y
            
            %nearest two neighbors in Z
            
        end
        
        %update information about surrounding shape
        function obj = setOuterShape(obj, outerShape)
            switch outerShape.shape
                case 'box'
                    obj.outerShape = Box(outerShape.depth, outerShape.width, ...
                        outerShape.height, outerShape.center);
            end
        end
        
        %check surroundings of FillSphere
        function checkSurroundings(obj)
            
            
        end
    end
end