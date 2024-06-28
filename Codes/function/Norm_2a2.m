%%% calculate the norm of the values for same index of two lists 

function norm_2a2 = Norm_2a2(L1, L2, varargin)


if length(L1) ~= length(L2)
    error('Input have different size');
end

norm_2a2=[];


if ~isempty(varargin)
    L3 = varargin{1, 1};
    if length(L1) ~= length(L3)
        error('Input have different size');
    end
    if length(L3) ~= length(L2)
        error('Input have different size');
    end
    for i =1: length(L1)
        norm_2a2 = [norm_2a2; sqrt(L1(i)^2+L2(i)^2+L3(i)^2)];
    end
else
    for i =1: length(L1)
        norm_2a2 = [norm_2a2; sqrt(L1(i)^2+L2(i)^2)];
    end
end
