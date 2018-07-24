classdef cylCanister < Cylinder & CanisterInterface %order determines which superclass constructor is used!
    %class that implements CanisterInterface and inherits from Cylinder
    %cylCanister is a Cylinder object that can be filled with several 
    %   shapes and will attempt to fit them all
    
    %inherited properties:
        %from class Cylinder:
        %volume     %volume of shape        %protected
        %shape      %shape type             %protected
        %width      %width of shape
        %height     %height of shape
        %center     %center coordinates     %default: [0,0,0]
        %from abstract class CanisterInterface:
        %allowedFillShapes   %fill shapes that can be used
        %nFillShapes         %number of fill shapes present
        %freeVolume          %volume that is void if all filling volumes are inside
        %mixed = false;      %boolean that is true if all filling shapes are identical
        %isFilled = false;   %boolean that is true if a shape is inside the canister
        %fillShapes      %type of fill shape; if array, each entry corresponds to geometry
        
    methods
        %constructor method
        function obj = cylCanister(varargin)
            obj = obj@Cylinder(varargin{:}); %call to superclass constructor
            
            if (nargin > 3)
                error(obj.errMessTooManyInputs)
            end
            
            switch nargin
                case num2cell(1:3)
                    obj.freeVolume = obj.volume;
            end
            %listeners
            addlistener(obj, 'allowOverlap', 'PostSet', @cylCanister.letOverlap);
        end
    end
    
    methods
        %add a shape to the canister
        function obj = addShape(obj, fillObj)
            checkIfValidFillShape(obj, fillObj) %compares fillObj to list of allowed shapes
            switch fillObj.shape
                case 'sphere'
                    %check if sphere dimensions are too large
                    if (fillObj.width > obj.width || fillObj.height > obj.height)
                        error(obj.errMessLargeFillShape)
                    end
                    
                    %generate allowed space for center location
                    %for sphere in cylinder, this space will be a cylinder
                    okayCenterLoc = Cylinder(obj.width - fillObj.width, ...
                        obj.height - fillObj.height, obj.center);
                    
                    %check if sphere center falls within this space
                    %MOEP
            end
        end
        
        %delete a shape from the canister
        function deleteShape(obj)
        end
    end
    
    methods (Static)
        %function not implemented; will move objects back to their original
        %location if "allowOverlap" is set to true
        function letOverlap(~, eventData) %first argument is class info?
            obj = eventData.AffectedObject;
            switch eventData.Source.Name
            end
        end
    end
end