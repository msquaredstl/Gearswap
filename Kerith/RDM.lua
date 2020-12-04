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
    state.Buff.Saboteur = buffactive.saboteur or false
	state.Obi = M(false, 'Obi')
	state.Seidr = M(false, 'Seidr')
	state.MagicBurst = M(false, 'Magic Burst')
	
	include('Mote-TreasureHunter')
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal', 'NormalACC', 'Dual Wield', 'DW Acc') --F9
    state.HybridMode:options('Normal', 'PhysicalDef', 'MagicalDef')
    state.WeaponskillMode:options('Normal', 'Acc', 'Mod')
    state.CastingMode:options('Normal', 'Resistant') --Ctrl + F11
    state.IdleMode:options('Normal', 'CP', 'PDT', 'MDT', 'Staff', 'RR') --Ctrl + F12


	lowTierNukes = S{'Stone', 'Water', 'Aero', 'Fire', 'Blizzard', 'Thunder',
	'Stone II', 'Water II', 'Aero II', 'Fire II', 'Blizzard II', 'Thunder II',
	'Stonega', 'Waterga', 'Aeroga', 'Firaga', 'Blizzaga', 'Thundaga',}

	HighTierNuke = S{'Stone III', 'Stone IV', 'Stone V', 'Stone VI', 'Stonega II', 'Stonega III', 'Stoneja', 'Quake', 'Quake II', 'Water III', 'Water IV', 'Water V', 'Water VI', 'Waterga II', 'Waterga III', 'Waterja', 'Flood', 'Flood II', 'Aero III', 'Aero IV', 'Aero V', 'Aero VI', 'Aeroga II', 'Aeroga III', 'Aeroja', 'Tornado', 'Tornado II', 'Fire III', 'Fire IV', 'Fire V', 'Fire VI', 'Firaga II', 'Firaga III', 'Firaja', 'Flare', 'Flare II', 'Blizzard III', 'Blizzard IV', 'Blizzard V', 'Blizzard VI', 'Blizzaga II', 'Blizzaga III', 'Blizzaja', 'Freeze', 'Freeze II', 'Thunder III', 'Thunder IV', 'Thunder V', 'Thunder VI', 'Thundaga II', 'Thundaga III', 'Thundaja', 'Burst', 'Burst II', 'Meteor', 'Comet'}
	
    gear.default.obi_waist = "Sekhmet Corset"

    -- Additional local binds	
	send_command('bind ^end gs c toggle MagicBurst')
	send_command('bind ^delete gs c toggle Obi')
	send_command('bind ^home gs c toggle Seidr')
   
    select_default_macro_book(5,5)
	
end

-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^end gs c toggle MagicBurst')
	send_command('unbind ^delete gs c toggle Obi')
	send_command('unbind ^home gs c toggle Seidr')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
 
    sets.TreasureHunter = {waist="Chaac Belt"}

    -- JSE
    AF = {}         -- leave this empty
    RELIC = {}      -- leave this empty
    EMPY = {}       -- leave this empty
	
	-- Fill this with your own JSE. 
    --
    AF.Head		=	"Atrophy Chapeau +1"
    AF.Body		=	"Atrophy Tabard +2"
    AF.Hands	=	"Atrophy Gloves +2"
    AF.Legs		=	"Atrophy Tights +2"
    AF.Feet		=	"Atrophy Boots +1"

    --Vitiation
    RELIC.Head		=	"Viti. Chapeau +3"
    RELIC.Body		=	"Viti. Tabard +3"
    RELIC.Hands 	=	"Vitiation Gloves +1"
    RELIC.Legs		=	"Vitiation Tights +1"
    RELIC.Feet		=	"Vitiation Boots +2"
	RELIC.Neck		=	"Duelist's Torque +1"

    --Lethargy
    EMPY.Head		=	"Leth. Chappel +1"
    EMPY.Body		=	"Lethargy Sayon +1"
    EMPY.Hands		=	"Leth. Gantherots +1"
    EMPY.Legs		=	"Leth. Fuseau +1"
    EMPY.Feet		=	"Leth. Houseaux +1"

	Salvage = {}
	Salvage.Head	=	"Jhakri Coronal +1"
	Salvage.Body	=	"Jhakri Robe +2"
	Salvage.Hands	=	"Jhakri Cuffs +2"
	Salvage.Legs 	=	"Jhakri Slops +2"
	Salvage.Feet	=	"Jhakri Pigaches +1"

	Limbus = {}
	Limbus.Head		=	"Ayanmo Zucchetto +1"
	Limbus.Body		=	"Ayanmo Corazza +2"
	Limbus.Hands	=	"Ayanmo Manopolas +2"
	Limbus.Legs 	=	"Ayanmo Cosciales +1"
	Limbus.Feet		=	"Ayanmo Gambieras +1"
	
    -- Capes:
    -- Sucellos's And such, add your own.
    RDMCape = {}
    RDMCape.MND		=	{ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10','Damage taken-2%',}
 }
    RDMCape.STR		=	{ name="Sucellos's Cape", augments={'STR+20','Accuracy+20 Attack+20','Attack+10','"Dual Wield"+10','Damage taken-5%',}
 }
	RDMCape.INT		=   RDMCape.MND
	
	-- Other augmented gear
	MB_feet={ name="Merlinic Crackows", augments={'"Mag.Atk.Bns."+30','Magic burst dmg.+10%','Mag. Acc.+3',}}
	MAB_feet={ name="Merlinic Crackows", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','Phys. dmg. taken -1%','AGI+6','Mag. Acc.+10','"Mag.Atk.Bns."+12',}}

	
 --------------------------------------
    -- Start defining the sets
    --------------------------------------
    
	MainWeapon = {}
		MainWeapon.Sword = {name="Kaja Sword"}
		MainWeapon.Excal = {name="Excalibur"}
		
	SubWeapon = {}
		SubWeapon.Dagger = {name="Tauret"}
		SubWeapon.Shield = {name="Sacro Bulwark"}
	
	sets.engaged.DW = {main=MainWeapon.Sword, sub=SubWeapon.Dagger}
	
	Staff = {}
		Staff.FC = {name="Grioavolr"}
		Staff.Nuke = Staff.FC
	
	--sets.OffenseMode.{'Normal'} = {main=MainWeapon.Sword, sub="Culminus"}
	--sets.OffenseMode.{'Dual Wield'} = {main=MainWeapon.Sword, sub="Odium"}
	
    -- Precast Sets
    
    -- Precast sets to enhance JAs
    sets.precast.JA['Chainspell'] = {body=RELIC.Body}
    

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
        head=AF.Head,
        body=AF.Body,
		hands="Carmine Fin. Ga. +1",
		legs=AF.Legs,
		feet=RELIC.Feet}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

    -- Fast cast sets for spells
    
    -- 80% Fast Cast (including trait) for all spells, plus 5% quick cast
    -- No other FC sets necessary.
    sets.precast.FC = {main=Staff.FC,sub="Niobid Strap",ammo="Impatiens",
        head=AF.Head,neck="Orunmila's Torque",ear1="Enchanter Earring +1",ear2="Loquacious Earring",
        body=RELIC.Body,hands="Leyline Gloves",ring1="Prolix Ring",ring2="Kishar Ring",
        back="Swith Cape",waist="Witful Belt",legs="Psycloth Lappas",feet="Carmine Greaves +1"}

    sets.precast.FC.Impact = set_combine(sets.precast.FC, {head=empty,body="Twilight Cloak"})
    
	sets.precast.Trust = sets.precast.FC


    -- Midcast Sets
    
    sets.midcast.FastRecast = {
        head=AF.Head,
		ear2="Loquacious Earring",
        body=RELIC.Body,
		hands="Leyline Gloves",
		ring1="Prolix Ring",
        back="Swith Cape",
		waist="Witful Belt",
		legs="Psycloth Lappas",
		feet="Carmine Greaves +1"}

    sets.midcast.Cure = {
		main="Tamaxchi",
		sub="Sors Shield",
        head="Kaykaus Mitra",
		neck="Incanter's Torque",
		ear1="Mendicant's Earring",
		ear2="Loquacious Earring",
        body="Kaykaus Bliaut",
		hands="Telchine Gloves",
		ring1="Haoma's Ring",
		ring2="Sirona's Ring",
        back="Swith Cape",
		waist="Witful Belt",
		legs=AF.Legs,
		feet="Vanya clogs"}
        
    sets.midcast.Curaga = sets.midcast.Cure
    sets.midcast.CureSelf = {
		waist="Gishdubar Sash"}

    sets.midcast['Enhancing Magic'] = {
        head=AF.Head,
		neck=RELIC.Neck,
        body=RELIC.Body,
		hands=AF.Hands,
		ring1="Prolix Ring",
		ring2="Kishar Ring",
        back=RDMCape.MND,
		waist="Embla Sash",
		legs=AF.Legs,
		feet="Lethargy Houseaux +1"}

    sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'],{body=AF.Body,legs="Lethargy Fuseau +1"})
	-- sets.midcast['Refresh II'] = sets.midcast['Refresh']
	-- sets.midcast['Refresh III'] = sets.midcast['Refresh']
	sets.midcast.RefreshSelf = {
		waist="Gishdubar Sash"}

    sets.midcast.Stoneskin = {ear2="Earthcry Earring", waist="Siegel Sash"}
    
    sets.midcast['Enfeebling Magic'] = {
		main="Grioavolr",
		sub="Mephitis Grip",
		ammo="Pemphredo Tathlum",
        head=RELIC.Head,
		neck=RELIC.Neck,
		ear1="Gwati Earring",
		ear2="Snotra Earring",
        body="Vanya Robe",
		hands="Helios Gloves",
		ring1="Stikini Ring",
		ring2="Kishar Ring",
        back=RDMCape.MND,
		waist="Eschan Stone",
		legs="Psycloth Lappas",
		feet="Medium's Sabots"}

    sets.midcast['Dia III'] = set_combine(sets.midcast['Enfeebling Magic'], {head=RELIC.Head,ring2="Stikini Ring"})

    sets.midcast['Slow II'] = set_combine(sets.midcast['Enfeebling Magic'], {head=RELIC.Head,ring2="Stikini Ring"})

    sets.midcast['Paralyze II'] = set_combine(sets.midcast['Enfeebling Magic'], {head=RELIC.Head,ring2="Stikini Ring"})
	
	sets.midcast['Enfeebling Magic'].Resistant = set_combine(sets.midcast['Enfeebling Magic'],{ring2="Stikini Ring"})
    
    -- Elemental Magic sets
    
    -- Elemental Magic sets are default for handling low-tier nukes.
    sets.midcast['Elemental Magic'] = {
		main=Staff.Nuke,
		sub="Zuuxowu Grip",
		ammo="Pemphredo Tathlum",
        head="Merlinic Hood",
		neck="Sanctity Necklace",
		ear1="Barkarole Earring",
		ear2="Friomisi Earring",
        body="Merlinic Jubbah",
		hands="Amalric Gages",
		ring1="Shiva Ring +1",
		ring2="Fenrir Ring +1",
        back="Izdubar Mantle",
		waist="Refoccilation Stone",
		legs="Amalric Slops",
		feet=MAB_feet}

	sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'], {
		sub="Niobid Strap", 
		neck="Saevus Pendant +1",
		ear2="Gwati Earring",
		back=RDMCape.INT,
		waist="Refoccilation Stone",
		legs="Psycloth Lappas"})

    -- Custom refinements for certain nuke tiers
    sets.midcast['Elemental Magic'].HighTierNuke = set_combine(sets.midcast['Elemental Magic'], {
		main=Staff.Nuke,
		sub="Alber Strap",
		ring2="Shiva Ring +1",
		back="Izdubar Mantle"})

    sets.midcast['Elemental Magic'].HighTierNuke.Resistant = set_combine(sets.midcast['Elemental Magic'].HighTierNuke, {
		sub="Niobid Strap",
		ring2="Adoulin Ring +1"})

        
    sets.midcast.Impact = set_combine(sets.midcast['Elemental Magic'], {head=empty,body="Twilight Cloak"})

    sets.midcast['Dark Magic'] = {main="Grioavolr",sub="Mephitis Grip",ammo="Pemphredo Tathlum",
        head=AF.Head,neck="Incanter's Torque",ear1="Gwati Earring",ear2="Enchanter Earring +1",
        body="Shango Robe",hands="Leyline Gloves",ring1="Prolix Ring",ring2="Sangoma Ring",
        back=RDMCape.INT,waist="Eschan Stone",legs="Psycloth Lappas",feet=MAB_feet}

    sets.midcast.Stun = {main="Marin Staff +1",sub="Mephitis Grip",ammo="Pemphredo Tathlum",
        head=AF.Head,neck="Incanter's Torque",ear1="Gwati Earring",ear2="Enchanter Earring +1",
        body=RELIC.Body,hands="Leyline Gloves",ring1="Prolix Ring",ring2="Sangoma Ring",
        back=RDMCape.INT,waist="Witful Belt",legs="Psycloth Lappas",feet="Carmine Greaves +1"}

    sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {ring1="Excelsis Ring", waist="Fucho-no-Obi"})

    sets.midcast.Aspir = sets.midcast.Drain


    -- Sets for special buff conditions on spells.

    sets.midcast.EnhancingDuration = {neck=RELIC.Neck,hands=AF.Hands,back="Ghostfyre Cape",feet="Lethargy Houseaux +1"}
        
    sets.buff.ComposureOther = {
		head=EMPY.Head,
        body=EMPY.Body,
		hands=EMPY.Hands,
        legs=EMPY.Legs,
		feet=EMPY.Feet}

    sets.buff.Saboteur = {hands=EMPY.Hands}
    

    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {
		main="Boonwell Staff",
		sub="Niobid Strap",
		neck="Jeweled Collar", 
		ear1="Relaxing Earring",
		ear2="Loquacious Earring", 
		waist="Hierarch Belt"}

    -- Idle sets
    sets.idle = {main="Bolelabunga",sub=SubWeapon.Shield,ammo="Homiliary",
        head=RELIC.Head,neck="Wiglen Gorget",ear1="Thureous Earring",ear2="Loquacious Earring",
        body=Salvage.Body,hands=RELIC.Hands,ring1="Stikini Ring",ring2="Stikini Ring",
        back=RDMCape.MND,waist="Flume Belt",legs="Carmine Cuisses",feet=AF.Feet}

    sets.idle.Town = {main="Excalibur",sub=SubWeapon.Shield,ammo="Homiliary",
        head=RELIC.Head,neck="Asperity necklace",ear1="Steelflash Earring",ear2="Bladeborn Earring",
        body=AF.Body,hands=RELIC.Hands,ring1="Adoulin Ring +1",ring2="Rajas Ring",
        back="Ghostfyre Cape",waist="Cetl Belt",legs="Carmine Cuisses",feet=AF.Feet}
    
    sets.idle.Weak = {main="Bolelabunga",sub=SubWeapon.Shield,ammo="Homiliary",
        head=RELIC.Head,neck="Wiglen Gorget",ear1="Thureous Earring",ear2="Genmei Earring",
        body=AF.Body,hands="Malignance Gloves",ring1="Sheltered Ring",ring2="Paguroidea Ring",
        back=RDMCape.MND,waist="Flume Belt",legs="Carmine Cuisses",feet="Battlecast Gaiters"}

    sets.idle.PDT = {main="Bolelabunga",sub=SubWeapon.Shield,ammo="Staunch Tathlum +1",
        head="Lithelimb Cap",neck="Loricate Torque +1",ear1="Thureous Earring",ear2="Genmei Earring",
        body="Hagondes Coat +1",hands="Malignance Gloves",ring1="Defending Ring",
        back=RDMCape.STR,waist="Flume Belt",legs="Amalric Slops",feet="Battlecast Gaiters"}

    sets.idle.MDT = {main="Bolelabunga",sub="Beatific Shield +1" ,ammo="Staunch Tathlum +1",
        head="Kaykaus Mitra",neck="Loricate Torque +1",ear1="Thureous Earring",ear2="Genmei Earring",
        body="Hagondes Coat +1",hands="Malignance Gloves",ring1="Defending Ring",ring2="Archon Ring",
        back=RDMCape.STR,waist="Flume Belt",legs=RELIC.Legs,feet="Battlecast Gaiters"}

	sets.idle.Staff = {main="Grioavolr",sub="Mephitis Grip",ammo="Impatiens",
		head=RELIC.Head,neck="Loricate Torque +1",ear1="Thureous Earring",ear2="Genmei Earring",
		body=AF.Body,hands=AF.Hands,ring1="Defending Ring",ring2="Archon Ring",
		back=RDMCape.STR,waist="Flume Belt",legs="Carmine Cuisses",feet=AF.Feet}
    
	sets.idle.Weak = set_combine(sets.idle.PDT, {feet="Herald's Gaiters"})

	sets.idle.CP = set_combine(sets.idle,{back="Mecistopins Mantle"})
	sets.idle.RR = set_combine(sets.idle.PDT,{body="Annointed Kalasiris"})
	
	sets.idle['Dual Wield'] = {main=MainWeapon.Sword, sub=SubWeapon.Dagger}
    
    -- Defense sets
    sets.defense.PDT = {
        head=AF.Head,
		neck="Loricate Torque +1",
		ear2="Genmei Earring",
        body="Hagondes Coat +1",
		hands="Malignance Gloves",
		ring1="Defending Ring",
        back=RDMCape.STR,
		waist="Flume Belt",
		feet="Battlecast Gaiters"}

    sets.defense.MDT = {ammo="Staunch Tathlum +1",
        head=AF.Head,
		neck="Loricate Torque +1",
		ear2="Genmei Earring",
        body="Hagondes Coat +1",
		hands="Malignance Gloves",
		ring1="Defending Ring",
		ring2="Archon Ring",
        back=RDMCape.STR,
		waist="Flume Belt",
		feet="Battlecast Gaiters"}

    sets.Kiting = {legs="Carmine Cuisses"}

    sets.latent_refresh = {waist="Fucho-no-obi",ammo="Impatiens"}

    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
    
    sets.magic_burst = {
		neck="Mizu. Kubikazari", 
		ring2="Locus ring", 
		ear2="Static Earring", 
		back=RDMCape.INT, 
		ring1="mujin band", 
		feet=MB_feet}
	sets.Seidr = {body="Seidr Cotehardie"}
	sets.Obi = {waist="Hachirin-no-Obi"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = { 
		ammo="Ginsen",
        head=RELIC.Head,
		neck="Anu Torque",
		ear1="Sherida Earring",
		ear2="Dedition Earring",
        body=Limbus.Body,
		hands=Limbus.Hands,
		ring1="Chirich Ring",
		ring2="Chirich Ring +1",
        back=RDMCape.STR,
		waist="Windbuffet Belt +1",
		legs="Taeon Tights",
		feet="Carmine Greaves +1"}
	
	sets.engaged['NormalACC'] = set_combine(sets.engaged, { 
		head="Carmine Mask",
		neck="Lissome Necklace",
		body=Salvage.Body,
		neck="Combatant's Torque",
		ear2="Eabani Earring", 
		hands="Taeon Gloves", 
		waist="Eschan Stone",
		legs="Carmine Cuisses"	})

	sets.engaged['Dual Wield'] = set_combine(sets.engaged, { 
		ear1="Eabani Earring",
		waist="Windbuffet Belt +1",
		legs="Carmine Cuisses" })

	sets.engaged['DW Acc'] = set_combine(sets.engaged['Dual Wield'], { 
		body=Salvage.Body,
		neck="Combatant's Torque",
		ear1="Zennaroi Earring",
		ear2="Suppanomimi", 
		hands="Taeon Gloves", 
		waist="Eschan Stone" })
	
    sets.engaged.Defense = {ammo="Staunch Tathlum +1",
        head=AF.Head,neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body=AF.Body,hands=AF.Hands,ring1="Adoulin Ring +1",ring2="Rajas Ring",
        back=RDMCape.STR,waist="Flume Belt",legs=RELIC.Legs,feet=AF.Feet}
	
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        head=AF.Head,
		neck="Asperity Necklace",
		ear2="Moonshade Earring",
		ear1="Ishvara Earring",
        body=AF.Body,
		hands=Salvage.Hands,
		ring1="Rufescent Ring",
		ring2="Rajas Ring",
        back=RDMCape.STR,
		waist="Prosilio Belt +1",
		legs=Salvage.Legs,
		feet=Salvage.Feet}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {
		head="Carmine Mask", 
		neck="Fotia Gorget",
		ear1="Brutal Earring",
		ring1="Leviathan Ring +1",
		ring2="Globidonta Ring",
		waist="Fotia Belt"})

    sets.precast.WS['Sanguine Blade'] = set_combine(sets.precast.WS, {
		ammo="Pemphredo Tathlum",
		head="Pixie Hairpin +1",
		neck="Sanctity Necklace",
		ear1="Friomisi Earring",
        body="Hagondes Coat +1",
		ring1="Archon Ring",
		ring2="Adoulin Ring +1",
        back=RDMCape.MND,
		legs="Amalric Slops",
		feet=MAB_feet})

    sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, { 
		ear1="Sherida Earring",
		body=Salvage.Body,
		hands=AF.Hands,
		waist="Prosilio Belt +1",
		feet="Carmine Greaves +1" })		

    sets.precast.WS['Chant du Cygne'] = set_combine(sets.precast.WS, { 
		head=Limbus.Body,
		neck="Fotia Gorget" })		
	sets.precast.WS['Evisceration'] = sets.precast.WS['Chant du Cygne']
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function job_midcast(spell, action, spellMap, eventArgs)

end

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
	if spell.skill == 'Elemental Magic' and state.Obi.value then equip(sets.Obi)
	end

    if spell.skill == 'Elemental Magic' and state.MagicBurst.value then equip(sets.magic_burst)
    end

	if spell.skill == 'Elemental Magic' and state.Seidr.value then equip(sets.Seidr)
	end
	
    if spell.skill == 'Enfeebling Magic' and state.Buff.Saboteur then
        equip(sets.buff.Saboteur)
    elseif spell.skill == 'Enhancing Magic' then
        equip(sets.midcast.EnhancingDuration)
		if spellMap == 'Refresh' and spell.target.type == 'SELF' then
			equip(sets.midcast.RefreshSelf)
		end
        if buffactive.composure and spell.target.type == 'PLAYER' then
            equip(sets.buff.ComposureOther)
        end
    elseif spellMap == 'Cure' and spell.target.type == 'SELF' then
        equip(sets.midcast.CureSelf)
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Offense Mode' then
        if newValue == 'None' then
            enable('main','sub','range')
        elseif newValue == 'Dual Wield' or newValue == 'DW Acc' then
			equip(sets.engaged.DW)
            disable('main','sub','range')        
		else
            disable('main','sub','range')
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

 -- Called any time we attempt to handle automatic gear equips (ie: engaged or idle gear).
function job_handle_equipping_gear(playerStatus, eventArgs)    	
    if player.equipment.back == 'Mecisto. Mantle' or player.equipment.back == 'Aptitude Mantle' or player.equipment.back == 'Aptitude Mantle +1' or player.equipment.back == 'Nexus Cape' then
        disable('back')
    else
        enable('back')
    end
        if player.equipment.ring1 == 'Warp Ring' or player.equipment.ring1 == 'Vocation Ring' or player.equipment.ring1 == 'Capacity Ring' or player.equipment.ring1 == 'Trizek Ring' or player.equipment.ring1 == 'Eschad Ring' then
        disable('ring1')
    else
        enable('ring1')
    end
    if player.equipment.ring2 == 'Warp Ring' or player.equipment.ring2 == 'Vocation Ring' or player.equipment.ring2 == 'Capacity Ring' or player.equipment.ring2 == 'Trizek Ring' or player.equipment.ring2 == 'Eschad Ring' then
        disable('ring2')
    else
        enable('ring2')
    end
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    
    return idleSet
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
    display_current_caster_state()
    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(5,5)
    elseif player.sub_job == 'NIN' then
        set_macro_page(4, 5)
    elseif player.sub_job == 'THF' then
        set_macro_page(5,5)
    else
        set_macro_page(5, 5)
    end
end

