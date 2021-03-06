-- Initialization function for this job file.
function get_sets()
	mote_include_version = 2
	
-- Load and initialize the include file.
	include('Mote-Include.lua')
end

-- Setup vars that are user-independent.
function job_setup()
    indi_timer = ''
    indi_duration = 180
	state.Buff['Theurgic Focus'] = buffactive['Theurgic Focus'] or false
	state.Buff['Bolster'] = buffactive['Bolster'] or false
	state.Obi = M(false, 'Obi')
	state.Seidr = M(false, 'Seidr')
	state.MagicBurst = M(false, 'Magic Burst')
end

	function job_post_midcast(spell, action, spellMap, eventArgs)
if spell.skill == 'Elemental Magic' and state.Obi.value then
equip(sets.Obi)

end

if spell.skill == 'Elemental Magic' and state.MagicBurst.value then
        equip(sets.magic_burst)
    end

if spell.skill == 'Elemental Magic' and state.Seidr.value then
equip(sets.Seidr)
end
end

-- //gs debugmode
-- //gs showswaps


-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal')
    state.CastingMode:options('Normal')
    state.IdleMode:options('Normal', 'PDT')
	
	

	
	send_command('bind ^delete gs c toggle Obi')
	send_command('bind ^home gs c toggle Seidr')
	send_command('bind ^end gs c toggle MagicBurst')
	
	
    gear.default.weaponskill_waist = "Windbuffet Belt +1"

	LowTierNuke = S{
		'Stone', 'Water', 'Aero', 'Fire', 'Blizzard', 'Thunder',
		'Stone II', 'Water II', 'Aero II', 'Fire II', 'Blizzard II', 'Thunder II',
		'Stone III', 'Water III', 'Aero III', 'Fire III', 'Blizzard III', 'Thunder III',
		'Stonega', 'Waterga', 'Aeroga', 'Firaga', 'Blizzaga', 'Thundaga',
		'Stonega II', 'Waterga II', 'Aeroga II', 'Firaga II', 'Blizzaga II', 'Thundaga II'}
	
    select_default_macro_book(1, 3)
end

-- Define sets and vars used by this job file.
function init_gear_sets()
-- Precast Sets
	sets.precast.JA['Bolster'] = {body="Bagua Tunic +1"}
	sets.precast.JA['Radial Arcana'] = {feet="Bagua Sandals"}
	sets.precast.JA['Life Cycle'] = {body="Geomancy Tunic +1",head="Azimuth Hood +1"}
	sets.precast.JA['Theurgic Focus'] = {head="bagua galero +1 +1"}
	
	-- Fast cast sets for spells
	sets.precast.FC = {
		main="solstice", sub="genbu's shield",
		head="Nahtirah Hat", 
		body="dalmatica +1",
		back="Lifestream Cape", neck="Orunmila's Torque",
		hands="repartie gloves", waist="Witful Belt",
		legs="geomancy pants +1", feet="Regal Pumps +1",
		ring1="weatherspoon ring", ring2="veneficium ring",
		ear1="Enchanter Earring +1", ear2="Loquacious Earring"}

	sets.precast.FC.Cure = set_combine(sets.precast.FC,{
		body="Heka's Kalasiris",
		back="Pahtli Cape"})
	
	sets.precast.FC.Curaga = sets.precast.FC.Cure
	
	sets.precast.FC.Stoneskin = set_combine(sets.precast.FC, {
		head="Umuthi Hat",	
		waist="Siegel Sash"})
		
	sets.precast.FC.Impact = set_combine(sets.precast.FC, {
		head=empty, body="Twilight Cloak"})
  
	sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {
		waist="Siegel Sash"})

-- Midcast Sets
	sets.midcast.FastRecast = {
		main="solstice", sub="genbu's shield",
		head="nahtirah hat", body="helios jacket",
		back="Lifestream Cape", neck="orunmila's torque",
		hands="geomancy mitaines +1", waist="ninurta's sash",
		legs="geomancy pants +1", feet="regal pumps +1",
		ring1="Defending Ring", ring2="weatherspoon ring",
		ear1="novia earring", ear2="Loquacious Earring"}

	sets.midcast.Geomancy = {
		main="solstice", sub="genbu's shield",
		range="Dunna", head="Azimuth Hood +1", neck="reti pendant",
		body="Bagua Tunic +1",
		back="Lifestream Cape",
		hands="Geomancy Mitaines +1",
		ear1="gwati earring", ear1="Gwati Earring",
		legs="Bagua Pants +1", feet="Medium's Sabots"}
		
	sets.midcast.Geomancy.Indi = {
	main="solstice", sub="genbu's shield",
		head="Azimuth Hood +1", neck="Reti pendant",
		range="Dunna", 
		body="Bagua Tunic +1",
		back="Lifestream Cape",
		hands="Geomancy Mitaines +1",
		legs="Bagua Pants +1", feet="Medium's Sabots"}

	sets.midcast.Cure = {
		main="tamaxchi",sub="genbu's shield",
		head="nahtirah hat", neck="Lasaia Pendant",
		body="Heka Kalasiris",
		hands="Telchine Gloves", waist="pythia sash +1",
		legs="artsieq hose", feet="regal pumps +1",
		ring1="haoma's ring", ring2="haoma's ring",
		ear1="novia earring", ear2="Gwati Earring"}
		
	sets.midcast.Refresh = {
		head="Nahtirah Hat", body="helios jacket",
		back="Lifestream Cape", neck="orunmila's Torque",
		hands="geomancy mitaines +1", waist="Witful Belt",
		legs="geomancy pants +1", feet="regal pumps +1",
		ring1="weatherspoon ring", ring2="prolix Ring",
		ear1="gwati earring", ear2="Loquacious Earring"}
		
	sets.midcast.Curaga = sets.midcast.Cure
	
	sets.midcast.CureSelf = set_combine(sets.midcast.Cure, {})

	sets.midcast['Enhancing Magic'] = {
		head="Umuthi Hat", body="Anhur Robe",
		back="Refraction Cape", neck="orunmila's torque",
		hands="telchine gloves", waist="Olympus Sash",
		legs="artsieq hose", feet="Geomancy Sandals",
		ear1="gwati earring",ear2="Loquacious Earring",
		ring1="Defending Ring", ring2="Levia. Ring +1"}
		
	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {
		waist="Siegel Sash",
		neck="stone gorget",
		ear2="Earthcry Earring"})
		
	sets.midcast['Aquaveil'] = sets.midcast['Enhancing Magic']

	sets.midcast['Enfeebling Magic'] = {
		    main="lehbrailg +2",
    sub="mephitis grip",
		range="Aureole", 
		head="befouled crown", body="helios jacket",
		back="Lifestream Cape", neck="Imbodla Necklace",
		hands="yaoyotl gloves", waist="rumination sash",
		legs="artsieq hose", feet="artsieq boots",
		ring1="weatherspoon ring", ring2="sangoma ring",
		ear1="barkarole earring", ear2="Gwati Earring"}
		
	sets.midcast['Enfeebling Magic'].Resistant = set_combine(sets.midcast['Enfeebling Magic'])
	
	sets.midcast.ElementalEnfeeble = sets.midcast['Enfeebling Magic']
	
	
	sets.midcast.Impact = set_combine(sets.midcast['Enfeebling Magic'], {
		head=empty, body="Twilight Cloak"})

	sets.midcast.Impact.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {
		head=empty, body="Twilight Cloak"})
		
	sets.midcast['Dark Magic'] = {
		    main="lehbrailg +2",
    sub="mephitis grip",
		range="Aureole",
		head="befouled crown", body="Geomancy Tunic +1",
		back="Refraction Cape", neck="imbodla necklace",
		hands="yaoyotl gloves", waist="eschan stone",
		legs="Artsieq Hose", feet="artsieq boots",
		ring1="weatherspoon Ring", ring2="Sangoma Ring",
		ear1="barkarole earring", ear2="Gwati Earring"}

	sets.midcast['Dark Magic'].Resistant = set_combine(sets.midcast['Dark Magic'])
	--24haste+47FC+MACC -- Ionis 2haste, 3FC.
	sets.midcast.Stun = set_combine(sets.midcast['Dark Magic'], {
		waist="Ninurta's Sash", head="nahtirah hat",})
		
	sets.midcast.Stun.Resistant = set_combine(sets.midcast['Dark Magic'].Resistant, {
		waist="Ninurta's Sash", head="nahtirah hat"})
		
	sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {main="Rubicundity", sub="Genbu's Shield",
		head="bagua galero +1",
		waist="Fucho-no-Obi"})
	
	sets.midcast.Drain.Resistant = set_combine(sets.midcast['Dark Magic'].Resistant, {main="Rubicundity", sub="Genbu's Shield",
		head="bagua galero +1",
		waist="Fucho-no-Obi"})

	sets.midcast.Aspir = sets.midcast.Drain
	
	sets.midcast['Aspir III'] = sets.midcast.Drain

	sets.midcast.Aspir.Resistant = sets.midcast.Drain.Resistant

	sets.midcast.Protectra = {ring1="Sheltered Ring"}

	sets.midcast.Shellra = {ring1="Sheltered Ring"}

-- Elemental Magic sets are default for handling low-tier nukes.
	sets.midcast.LowTierNuke = {    main="Lehbrailg +2",
    sub="Zuuxowu Grip", Ammo="Dosis Tathlum",
		head="hagondes hat +1", body="amalric doublet",
		back="Toro Cape", neck="Eddy Necklace",
		hands="amalric gages", waist="Sekhmet Corset",
		legs="hagondes pants +1",feet="Amalric Nails",
		ring1="Shiva Ring +1", ring2="Shiva Ring +1",
		ear2="Friomisi Earring", ear1="Barkarole Earring"}


-- Custom classes for high-tier nukes.
	sets.midcast.HighTierNuke = {    main="Lehbrailg +2",
    sub="willpower grip", Ammo="Dosis Tathlum",
		head="hagondes hat +1", body="amalric doublet",
		back="Toro Cape", neck="Eddy Necklace",
		hands="amalric gages", waist="Eschan Stone",
		legs="hagondes pants +1",feet="Amalric Nails",
		ring1="Shiva Ring +1", ring2="Shiva Ring +1",
		ear2="Friomisi Earring", ear1="Barkarole Earring"}

		
	sets.magic_burst = {head="helios band", neck="Mizu. Kubikazari", ring2="Locus ring", feet="Helios Boots", ear2="Static Earring", back="Seshaw Cape", ring1="mujin band"}	
	sets.Obi = {back="Twilight Cape", waist="Hachirin-no-Obi"}
	sets.Seidr = {body="Seidr Cotehardie"}

-- Resting sets
	sets.resting = {

		range="Dunna",
		head="Azimuth Hood +1", body="Geomancy Tunic +1",
		back="Mecisto. Mantle", neck="Twilight Torque",
		hands="Geomancy Mitaines +1", waist="Yamabuki-no-obi",
		legs="Assiduity Pants", feet="Geomancy Sandals",
		ring1="Sheltered Ring", ring2="Paguroidea Ring",
		ear1="Ethereal Earring", ear2={ name="Moonshade Earring", augments={'Mag. Acc.+4','Latent effect: "Refresh"+1',}}}
		
-- Idle sets back="Mecistopins Mantle",
	sets.idle = {
		main="Bolelabunga", sub="Genbu's Shield",
		range="Dunna",
		head="Spurrina Coif", body="Geomancy Tunic +1",
		back="umbra cape", neck="Twilight Torque",
		hands="Serpentes Cuffs", waist="slipor sash",
		legs="Assiduity Pants +1", feet="Serpentes Sabots",
		ring2="Dark ring", ring1="defending ring",
		ear1="Novia Earring", ear2="Moonshade Earring"}
	--back="Kumbira Cape",
	sets.idle.PDT = {
		main="terra's staff", sub="willpower grip",
		range="Dunna",
		head="hagondes hat +1", body="Helios Jacket",
		back="umbra cape", neck="Twilight Torque",
		hands="amalric gages", waist="slipor sash",
		legs="Assiduity Pants +1", feet="Regal Pumps +1",
		ring1="Defending Ring", ring2="Dark Ring",
		ear1="Ethereal Earring", ear2="Sanare Earring"}
	--back="Repulse Mantle",
	sets.idle.Town = {
		main="Bolelabunga", sub="Genbu's Shield",
		range="Dunna",
		head="Spurrina Coif",body="amalric doublet",
		back="Ogapepo Cape +1", neck="Twilight Torque",
		hands="Amalric Gages", waist="Ninurta's Sash",
		legs="Bagua Pants +1", feet="Amalric Nails",
		ring1="Defending Ring", ring2="Weatherspoon Ring",
		ear1="Novia Earring", ear2="Moonshade Earring"}
		
	-- .Pet sets are for when Luopan is present.
    sets.idle.Pet = set_combine(sets.idle,{hands="Geomancy Mitaines +1", feet="Bagua Sandals", back="Lifestream Cape", head="Azimuth Hood +1"})
    

    sets.idle.PDT.Pet = sets.idle.Pet

	sets.idle.Indi = set_combine(sets.idle, {})
	
    sets.idle.Pet.Indi = set_combine(sets.idle.Pet, {})
	
    sets.idle.PDT.Indi = set_combine(sets.idle.PDT, {})
	
    sets.idle.PDT.Pet.Indi = set_combine(sets.idle.PDT.Pet, {})
-- Defense sets

	sets.defense.PDT = sets.idle.PDT

	sets.defense.MDT = {
		main="Terra's Staff", "Vivid Strap",
		range="Dunna",
		head="Befouled Crown", body="Geomancy Tunic +1",
		back="Umbra Cape", neck="Twilight Torque",
		hands="Yaoyotl Gloves", waist="Slipor Sash",
		legs="Assiduity Pants +1", feet="Regal Pumps +1",
		ring1="Defending Ring", ring2="Dark Ring",
		ear1="Ethereal Earring", ear2="Sanare Earring"}

	sets.Kiting = {feet="Geomancy Sandals"}
	
	sets.latent_refresh = {waist="Fucho-no-obi"}
	
-- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
	sets.buff['Theurgic Focus'] = {head="bagua galero +1"}
	sets.buff['Bolster'] = {body="Bagua Tunic +1"}
	
-- Engaged sets
    sets.engaged = {}
end
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
            end
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

-- Custom spell mapping.
function job_get_spell_map(spell, default_spell_map)
	if spell.skill == 'Elemental Magic' and default_spell_map ~= 'ElementalEnfeeble' then
		if LowTierNuke:contains(spell.english) then
			return 'LowTierNuke'
		else
			return 'HighTierNuke'
		end
	end
end
-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(1, 6)
end