-- Variable to track time elapsed
local timeElapsed = 0
-- Interval for printing camera location (in seconds)
local printInterval = 5

function onUpdate(elapsed)
    -- Increment time elapsed
    timeElapsed = timeElapsed + elapsed

    -- Check if it's time to print camera location
    if timeElapsed >= printInterval then
        -- Call the function to print camera locations
        printCameraLocation()
        -- Reset time elapsed
        timeElapsed = 0
    end
end

-- Function to safely print the camera location of characters
function printCameraLocation()
    -- Check if the required functions exist
    if getObjectCamera and print then
        -- Get the camera location of Boyfriend
        local bfCameraX, bfCameraY = getObjectCamera('bf')
        print("Boyfriend Camera Location: X = " .. bfCameraX .. ", Y = " .. bfCameraY)

        -- Get the camera location of Girlfriend
        local gfCameraX, gfCameraY = getObjectCamera('gf')
        print("Girlfriend Camera Location: X = " .. gfCameraX .. ", Y = " .. gfCameraY)

        -- Get the camera location of Dad
        local dadCameraX, dadCameraY = getObjectCamera('dad')
        print("Dad Camera Location: X = " .. dadCameraX .. ", Y = " .. dadCameraY)
    else
        -- Print an error message if required functions are missing
        print("Error: Required functions are missing.")
    end
end
