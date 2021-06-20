function [outputArg1,outputArg2] = boundarywrapper(i,j,L,D,struct)

    function obj  = boundary_wrapper(obj)
        
        %create east boundary
        
        i_vector    = 1                                 ;
        j_vector 	= 2 : obj.wrapper.geo.dimY-1        ;
        
        obj = boundary_switcher(obj,i_vector,j_vector,obj.wrapper.boundary.east);
        
        %create west boundary
        i_vector    = obj.wrapper.geo.dimX      ;
        j_vector 	= 2 : obj.wrapper.geo.dimY-1 ;
        
        obj = boundary_switcher(obj,i_vector,j_vector,obj.wrapper.boundary.west);
        
        %create north boundary
        i_vector    = 1: obj.wrapper.geo.dimX       ;
        j_vector 	= obj.wrapper.geo.dimY          ;
        
        obj = boundary_switcher(obj,i_vector,j_vector,obj.wrapper.boundary.north);
        
        %create south boundary
        i_vector    = 1 : obj.wrapper.geo.dimX ;
        j_vector 	= 1 ;
        
        obj  = boundary_switcher(obj,i_vector,j_vector,obj.wrapper.boundary.south);
        
    end

    function obj = boundary_switcher(obj,i_vector,j_vector,boundary_info)
        
        switch lower(boundary_info.type(1))
            
            case 'd'
                obj  = dirichlet(obj,i_vector,j_vector,boundary_info);
                
            case 'n'
                obj  = neumann(obj,i_vector,j_vector,boundary_info);
                
            case 'r'
                obj  = robin(obj,i_vector,j_vector,boundary_info);
        end
    end

end

