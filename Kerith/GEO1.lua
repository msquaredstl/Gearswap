-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------
 
-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
 
    -- Load and initialize the include file.
    include('Mote-Include.lua')
end
 
-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    indi_timer = ''
    indi_duration = 180
end
 
-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------
 
-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT')
 
    gear.default.weaponskill_waist = "Windbuffet Belt"
 
    select_default_macro_book()
end
 
 
-- Define sets and vars used by this job file.
function init_gear_sets()
 
    --------------------------------------
    -- Precast sets
    --------------------------------------
 
    -- Precast sets to enhance JAs
    sets.precast.JA.Bolster = {body="Bagua Tunic +1"}
    sets.precast.JA['Life Cycle'] = {body="Geomancy Tunic +1"}
 
    -- Fast cast sets for spells
 
    sets.precast.FC = {ammo="Impatiens",
        head="Nahtirah Hat",ear2="Loquacious Earring",
        body="Vanir Cotehardie",ring1="Prolix Ring",hands="Repartie Gloves",
        back="Lifestream Cape",waist="Witful Belt",legs="Geomancy Pants +1",feet="Regal Pumps +1"}
 
    sets.precast.FC.Cure = set_combine(sets.precast.FC, {main="Tefnut Wand",sub="Genbu's Shield",back="Pahtli Cape"})
 
    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {neck="Stoicheion Medal",hands="Bagua Mitaines"})
 
     
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        head="Nahtirah Hat",neck=gear.ElementalGorget,ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Vanir Cotehardie",hands="Yaoyotl Gloves",ring1="Rajas Ring",ring2="K'ayres Ring",
        back="Refraction Cape",waist=gear.ElementalBelt,legs="Hagondes Pants +1",feet="Hagondes Sabots"}
 
    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Flash Nova'] = {ammo="Dosis Tathlum",
        head="Hagondes Hat +1",neck="Eddy Necklace",ear1="Friomisi Earring",ear2="Crematio Earring",
        body="Hagondes Coat +1",hands="Yaoyotl Gloves",ring1="Acumen Ring",ring2="Strendu Ring",
        back="Toro Cape",waist="Snow Belt",legs="Hagondes Pants +1",feet="Hagondes Sabots"}
 
    sets.precast.WS['Starlight'] = {ear2="Moonshade Earring"}
 
    sets.precast.WS['Moonlight'] = {ear2="Moonshade Earring"}
 
 
    --------------------------------------
    -- Midcast sets
    --------------------------------------
 
    -- Base fast recast for spells
    sets.midcast.FastRecast = {
        head="Zelus Tiara",ear2="Loquacious Earring",
        body="Hagondes Coat +1",hands="Bokwus Gloves",ring1="Prolix Ring",
        back="Lifestream Cape",waist="Goading Belt",legs="Hagondes Pants +1",feet="Hagondes Sabots"}
     
     
    sets.midcast['Enfeebling Magic'] = {main="Lehbrailg +2",sub="Mephitis Grip",ammo="Clarus Stone",
        head="Artsieq Hat",neck="Imbodla Necklace",ear1="lifestream Earring",ear2="Psystorm Earring",
        body="Hagondes Coat +1",hands="Hagondes Cuffs +1",ring2="Sangoma Ring",
        cape="Lifestream Cape",waist="Demonry Sash",legs="Artsieq Hose",feet="Bagua Sandals"}
         
    sets.midcast['Elemental Magic'] = {main="Lehbrailg +2",sub="Mephitis Grip",ammo="Clarus Stone",
        head="Hagondes Hat +1",neck="Eddy Necklace",ear1="Friomisi Earring",ear2="Psystorm Earring",
        body="Bagua Tunic +1",hands="Yaoyotl Gloves",ring2="Sangoma Ring",
        cape="Toro Cape",waist="Sekhmet Corset",legs="Hagondes Pants +1",feet="Umbani Boots"}
     
    sets.midcast['Elemental Magic']['Low'] = {main="Lehbrailg +2",sub="Mephitis Grip",ammo="Clarus Stone",
        head="Hagondes Hat +1",neck="Eddy Necklace",ear1="Friomisi Earring",ear2="Psystorm Earring",
        body="Bagua Tunic +1",hands="Yaoyotl Gloves",ring2="Sangoma Ring",
        cape="Toro Cape",waist="Sekhmet Corset",legs="Hagondes Pants +1",feet="Umbani Boots"}
         
    sets.midcast['Dark Magic'] = {main="Lehbrailg +2",sub="Mephitis Grip",ammo="Clarus Stone",
        head="Hagondes Hat +1",neck="Imbodla Necklace",ear1="lifestream Earring",ear2="Psystorm Earring",
        body="Hagondes Coat +1",hands="Yaoyotl Gloves",
        cape="Toro Cape",waist="Demonry Sash",legs="Hagondes Pants +1",feet="Umbani Boots"}
     
    sets.midcast['Dark Magic']['Stun'] = {main="Lehbrailg +2",sub="Mephitis Grip",
        head="Nahtirah Hat",neck="Eddy Necklace",ear1="lifestream Earring",ear2="Loquacious Earring",
        body="Bagua Tunic +1",hands="Hagondes Cuffs +1",ring1="Prolix Ring",Ring2="Sangoma Ring",
        cape="Lifestream Cape",waist="Goading Belt",legs="Geomancy Pants +1",feet="Regal Pumps +1"}
         
    sets.midcast.Geomancy = {range="Dunna",head="Laurel Wreath",legs="Bagua Pants",hands="Geomancy Mitaines",body="Bagua Tunic +1",
        waist="Sekhmet Corset"}
    sets.midcast.Geomancy.Geo = {range="Dunna",head="Laurel Wreath",legs="Theurgist's Slacks",hands="Geomancy Mitaines",body="Bagua Tunic +1",
        waist="Sekhmet Corset"}
 
    sets.midcast.Cure = {main="Tefnut Wand",sub="Genbu's Shield",
        body="Heka's Kalasiris",hands="Bokwus Gloves",ring1="Haoma Ring",ring2="Sirona's Ring",
        back="Oretania's Cape",legs="Nares Trews",feet="Regal Pumps +1"}
     
    sets.midcast.Curaga = sets.midcast.Cure
 
    sets.midcast.Protectra = {ring1="Sheltered Ring"}
 
    sets.midcast.Shellra = {ring1="Sheltered Ring"}
 
 
    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------
 
    -- Resting sets
    sets.resting = {main="Chatoyant Staff",neck="Wiglen Gorget",
        body="Hagondes Coat +1",hands="Bagua Mitaines",ring1="Sheltered Ring",ring2="Paguroidea Ring",
        waist="Austerity Belt",legs="Assiduity Pants",feet="Chelona Boots"}
 
 
    -- Idle sets
 
    sets.idle = {main="Bolelabunga",sub="Genbu's Shield",range="Dunna",
        head="Artsieq Hat",neck="Wiglen Gorget",ear1="Bloodgem Earring",ear2="Loquacious Earring",
        body="Hagondes Coat +1",hands="Bagua Mitaines",ring1="Sheltered Ring",ring2="Paguroidea Ring",
        back="Iximulew Cape",waist="Funcho-no-obi",legs="Assiduity Pants +1",feet="Geomancy Sandals"}
 
    sets.idle.PDT = {main="Earth Staff",range="Dunna",
        head="Hagondes Hat +1",neck="Wiglen Gorget",ear1="Bloodgem Earring",ear2="Loquacious Earring",
        body="Hagondes Coat +1",hands="Bagua Mitaines",ring1="Patricius Ring",ring2="Paguroidea Ring",
        back="Iximulew Cape",waist="Funcho-no-obi",legs="Hagondes Pants +1",feet="Geomancy Sandals"}
 
    -- .Pet sets are for when Luopan is present.
    sets.idle.Pet = {main="Earth Staff",range="Dunna",
        head="Hagondes Hat +1",neck="Twilight Torque",ear1="Bloodgem Earring",ear2="Loquacious Earring",
        body="Hagondes Coat +1",hands="Bagua Mitaines",ring1="Defending Ring",ring2="Paguroidea Ring",
        back="Lifestream Cape",waist="Funcho-no-obi",legs="Assiduity Pants +1",feet="Bagua Sandals"}
 
    sets.idle.PDT.Pet = {main="Earth Staff",range="Dunna",
        head="Hagondes Hat +1",neck="Twilight Torque",ear1="Bloodgem Earring",ear2="Loquacious Earring",
        body="Hagondes Coat +1",hands="Geomancy Mitains",ring1="Patricius Ring",ring2="Paguroidea Ring",
        back="Lifestream Cape",waist="Goading Belt",legs="Assiduity Pants +1",feet="Bagua Sandals"}
 
    -- .Indi sets are for when an Indi-spell is active.
 
    sets.idle.Town = {main="Bolelabunga",sub="Genbu's Shield",range="Dunna",
        head="Artsieq Hat",neck="Wiglen Gorget",ear1="Bloodgem Earring",ear2="Loquacious Earring",
        body="Geomancy Tunic +1",hands="Bagua Mitaines",ring1="Sheltered Ring",ring2="Paguroidea Ring",
        back="Lifestream Cape",waist="Goading Belt",legs="Assiduity Pants +1",feet="Geomancy Sandals"}
 
    sets.idle.Weak = {main="Bolelabunga",sub="Genbu's Shield",range="Dunna",
        head="Nefer Khat +1",neck="Wiglen Gorget",ear1="Bloodgem Earring",ear2="Loquacious Earring",
        body="Hagondes Coat +1",hands="Bagua Mitaines",ring1="Sheltered Ring",ring2="Paguroidea Ring",
        back="Lifestream Cape",waist="Goading Belt",legs="Assiduity Pants +1",feet="Geomancy Sandals"}
 
    -- Defense sets
 
    sets.defense.PDT = {range="Dunna",main="Earth Staff",
        head="Hagondes Hat +1",neck="Wiglen Gorget",ear1="Bloodgem Earring",ear2="Loquacious Earring",
        body="Hagondes Coat +1",hands="Geomancy Mitaines",ring1="Patricius Ring",ring2=gear.DarkRing.physical,
        back="Lifestream Cape",waist="Slipor Sash",legs="Hagondes Pants +1",feet="Bagua Sandals"}
 
    sets.defense.MDT = {range="Dunna",main="Earth Staff",
        head="Hagondes Hat +1",neck="Nuna Gorget",ear1="Bloodgem Earring",ear2="Loquacious Earring",
        body="Hagondes Coat +1",hands="Geomancy Mitaines",ring1="Defending Ring",ring2=gear.DarkRing.physical,
        back="Lifestream Cape",waist="Slipor Sash",legs="Hagondes Pants +1",feet="Bagua Sandals"}
 
    sets.Kiting = {feet="Geomancy Sandals"}
 
    sets.latent_refresh = {waist="Fucho-no-obi"}
 
 
    --------------------------------------
    -- Engaged sets
    --------------------------------------
 
    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
 
    -- Normal melee group
    sets.engaged = {range="Dunna",
        head="Zelus Tiara",neck="Peacock Charm",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Vanir Cotehardie",hands="Bokwus Gloves",ring1="Rajas Ring",ring2="Paguroidea Ring",
        back="Lifestream Cape",waist="Goading Belt",legs="Hagondes Pants +1",feet="Hagondes Sabots"}
 
    --------------------------------------
    -- Custom buff sets
    --------------------------------------
 
end
 
 
LowNukes                                    = S{'Stone'}
-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------
 
function job_aftercast(spell, action, spellMap, eventArgs)
    if not spell.interrupted then
        if spell.english:startswith('Indi') then
            if not classes.CustomIdleGroups:contains('Indi') then
                classes.CustomIdleGroups:append('Indi')
            end
            send_command('@timers d "'..indi_timer..'"')
            indi_timer = spell.english
            send_command('@timers c "'..indi_timer..'" '..indi_duration..' down spells/00136.png')
        elseif spell.english == 'Sleep' or spell.english == 'Sleepga' then
            send_command('@timers c "'..spell.english..' ['..spell.target.name..']" 60 down spells/00220.png')
        elseif spell.english == 'Sleep II' or spell.english == 'Sleepga II' then
            send_command('@timers c "'..spell.english..' ['..spell.target.name..']" 90 down spells/00220.png')
        end
    elseif not player.indi then
        classes.CustomIdleGroups:clear()
    end
end
 
 
-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------
 
-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if player.indi and not classes.CustomIdleGroups:contains('Indi')then
        classes.CustomIdleGroups:append('Indi')
        handle_equipping_gear(player.status)
    elseif classes.CustomIdleGroups:contains('Indi') and not player.indi then
        classes.CustomIdleGroups:clear()
        handle_equipping_gear(player.status)
    end
end
 
function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Offense Mode' then
        if newValue == 'Normal' then
            disable('main','sub','range')
        else
            enable('main','sub','range')
        end
    end
end
 
-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------
 
function job_get_spell_map(spell, default_spell_map)
    if spell.action_type == 'Magic' then
        if spell.skill == 'Enfeebling Magic' then
            if spell.type == 'WhiteMagic' then
                return 'MndEnfeebles'
            else
                return 'IntEnfeebles'
            end
        elseif spell.skill == 'Geomancy' then
            if spell.english:startswith('Indi') then
                return 'Indi'
            elseif spell.english:startswith('Geo') then
                return 'Geo'
            end
        elseif spell.skill == 'Elemantal Magic' then
            if LowNukes:contains(spell.name) then
                return 'Low'
            else
                return
            end
        elseif spell.skill == 'Dark Magic' then
            if spell.english:startswith('Stu') then
                return 'Stun'
            else
                return
            end
            return
        end
    end
end
 
function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    return idleSet
end
 
-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    classes.CustomIdleGroups:clear()
    if player.indi then
        classes.CustomIdleGroups:append('Indi')
    end
end
 
-- Function to display the current relevant user state when doing an update.
function display_current_job_state(eventArgs)
    display_current_caster_state()
    eventArgs.handled = true
end
 
-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
 
-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(1, 7)
end