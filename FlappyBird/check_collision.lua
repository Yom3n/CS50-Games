-- Checks if objects collide with each other
function Collides(x1, y1, w1, h1, x2, y2, w2, h2)
    -- Check if there is no overlap in the x or y direction
    if x1 + w1 < x2 or x2 + w2 < x1 then
        return false
    end
    if y1 + h1 < y2 or y2 + h2 < y1 then
        return false
    end
    -- If there is overlap in both x and y directions, return true
    return true
end