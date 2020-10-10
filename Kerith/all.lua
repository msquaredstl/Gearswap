-- Initialization function for this job file.
 
local jobs = T{ "BLM", "RDM", "THF", "WHM", "NIN", "GEO", "SCH", "THF", "SMN" }
 
mysets = {}
 
for k,v in pairs(jobs) do
    include(v .. '.lua')
    get_sets()
    mysets[v] = sets
    sets = {}
 end
 
 
function get_sets()
    for k,v in pairs(mysets) do sets[k] = v end
end