require('libraries/timers')

function ZeroManaOnSpawn( event ) 
        local hero = event.caster
        Timers:CreateTimer(.01, function()
        -- Set Mana to 0 on created
        -- hero:SetMana(0)
        hero:SetHealth(20000)
    end)
 end

 function ChargeOrbPickup( event )
    local hero = event.caster
    hero:GiveMana(10)
 end