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
state.Obi = M(false, 'Obi')
state.Seidr = M(false, 'Seidr')
state.MagicBurst = M(false, 'Magic Burst')

    no_swap_gear = S{"Warp Ring", "Dim. Ring (Dem)", "Dim. Ring (Holla)", "Dim. Ring (Mea)",
              "Trizek Ring", "Echad Ring", "Facility Ring", "Capacity Ring"}

    degrade_array = {
        ['Aspirs'] = {'Aspir','Aspir II','Aspir III'}
        }

    lockstyleset = 100
	
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal') --F9
    state.CastingMode:options('Normal', 'Resistant') -- F11
    state.IdleMode:options('Normal', 'PDT','HighMP','RR') --Ctrl + F12
    state.MagicBurst = M(false, 'Magic Burst')
    state.DeathMode = M(false, 'Death Mode')
    state.CP = M(false, "Capacity Points Mode")
	state.VorsealMode = M('Normal', 'Vorseal')
	state.ManawallMode = M('Swaps', 'No_Swaps')
	state.Enfeebling = M('None', 'Effect')		--Ctrl + F11
	--Vorseal mode is handled simply when zoning into an escha zone--
    state.Moving  = M(false, "moving")
    
	element_table = L{'Earth','Wind','Ice','Fire','Water','Lightning'}

    lowTierNukes = S{'Stone', 'Water', 'Aero', 'Fire', 'Blizzard', 'Thunder',
        'Stone II', 'Water II', 'Aero II', 'Fire II', 'Blizzard II', 'Thunder II',
        'Stone III', 'Water III', 'Aero III', 'Fire III', 'Blizzard III', 'Thunder III',
        'Stonega', 'Waterga', 'Aeroga', 'Firaga', 'Blizzaga', 'Thundaga',
        'Stonega II', 'Waterga II', 'Aeroga II', 'Firaga II', 'Blizzaga II', 'Thundaga II'}

	--	HighTierNuke = S{'Stone IV', 'Stone V', 'Stone VI','Stonega III', 'Stoneja', 'Quake', 'Quake II', 'Water IV', 'Water V', 'Water VI', 'Waterga III', 'Waterja', 'Flood', 'Flood II', 'Aero IV', 'Aero V', 'Aero VI', 'Aeroga III', 'Aeroja', 'Tornado', 'Tornado II', 'Fire IV', 'Fire V', 'Fire VI', 'Firaga III', 'Firaja', 'Flare', 'Flare II', 'Blizzard IV', 'Blizzard V', 'Blizzard VI', 'Blizzaga III', 'Blizzaja', 'Freeze', 'Freeze II', 'Thunder IV', 'Thunder V', 'Thunder VI', 'Thundaga III', 'Thundaja', 'Burst', 'Burst II', 'Meteor', 'Comet'}
   
   degrade_array = {
		['Fire'] = {'Fire','Fire II','Fire III','Fire IV','Fire V','Fire VI'},
		['Firega'] = {'Firaga','Firaga II','Firaga III','Firaja'},
		['Ice'] = {'Blizzard','Blizzard II','Blizzard III','Blizzard IV','Blizzard V','Blizzard VI'},
		['Icega'] = {'Blizzaga','Blizzaga II','Blizzaga III','Blizzaja'},
		['Wind'] = {'Aero','Aero II','Aero III','Aero IV','Aero V','Aero VI'},
		['Windga'] = {'Aeroga','Aeroga II','Aeroga III','Aeroja'},
		['Earth'] = {'Stone','Stone II','Stone III','Stone IV','Stone V','Stone VI'},
		['Earthga'] = {'Stonega','Stonega II','Stonega III','Stoneja'},
		['Lightning'] = {'Thunder','Thunder II','Thunder III','Thunder IV','Thunder V','Thunder VI'},
		['Lightningga'] = {'Thundaga','Thundaga II','Thundaga III','Thundaja'},
		['Water'] = {'Water', 'Water II','Water III', 'Water IV','Water V','Water VI'},
		['Waterga'] = {'Waterga','Waterga II','Waterga III','Waterja'},
		['Aspirs'] = {'Aspir','Aspir II','Aspir III'},
		['Sleepgas'] = {'Sleepga','Sleepga II'}
	}
   
    -- Additional local binds
	send_command('bind f10 gs c cycle IdleMode')	--F10
	send_command('bind f11 gs c cycle CastingMode')	--F11
	send_command('bind ^f11 gs c cycle Enfeebling')	--Ctrl + F11
	send_command('bind f12 gs c cycle ManawallMode') --F12
    send_command('bind ^` input /ma Stun <t>')
    send_command('bind ^end gs c toggle MagicBurst') --Ctrl + End
	send_command('bind ^delete gs c toggle DeathMode')	--Ctrl + End
	send_command('bind ^home gs c toggle Seidr')	--Ctrl + Home
		
    select_default_macro_book()
	
    state.Auto_Kite = M(false, 'Auto_Kite')
    moving = false
end

-- Called when this job file is unloaded (eg: job change)
function user_unload()
	send_command('unbind f10')
	send_command('unbind f11')
	send_command('unbind ^`f11')
	send_command('unbind f12')
    send_command('unbind ^`')
    send_command('unbind ^end gs c toggle MagicBurst')
	send_command('unbind ^delete gs c toggle Obi')
	send_command('unbind ^home gs c toggle Seidr')
end



-- Define sets and vars used by this job file.
function init_gear_sets()

    -- JSE
    AF = {}         -- leave this empty
    RELIC = {}      -- leave this empty
    EMPY = {}       -- leave this empty


	-- Fill this with your own JSE. 
    --
    AF.Head		=	""
    AF.Body		=	"Spaekona's Coat +2"
    AF.Hands	=	"Spaekona's Gloves +2"
    AF.Legs		=	""
    AF.Feet		=	""

    --Vitiation
    RELIC.Head		=	"Archmage's Petasos +3"
    RELIC.Body		=	"Archmage's Coat +3"
    RELIC.Hands 	=	"Archmage's Gloves +3"
    RELIC.Legs		=	"Archmage's Tonban +3"
    RELIC.Feet		=	"Archmage's Sabots +3"

    --Lethargy
    EMPY.Head		=	"Wicce Petasos +1"
    EMPY.Body		=	"Wicce Coat +1"
    EMPY.Hands		=	"Wicce Gloves +1"
    EMPY.Legs		=	"Wicce Tonban +1"
    EMPY.Feet		=	"Wicce Sabots +1"

	Salvage = {}
	Salvage.Head	=	"Jhakri Coronal +1"
	Salvage.Body	=	"Jhakri Robe +2"
	Salvage.Hands	=	"Jhakri Cuffs +2"
	Salvage.Legs 	=	"Jhakri Slops +2"
	Salvage.Feet	=	"Jhakri Pigaches +2"

	Limbus = {}
	Limbus.Head		=	"Mallquis Chapeau +1"
	Limbus.Body		=	"Mallquis Saio +1"
	Limbus.Hands	=	"Mallquis Cuffs +1"
	Limbus.Legs 	=	"Mallquis Trews +1"
	Limbus.Feet		=	"Mallquis Clogs +2"

	AMBU ={}
	AMBU.Grip		=	"Kaja Grip"
	
    -- Capes:
    -- Sucellos's And such, add your own.
    BLMCape = {}
    BLMCape.FreeNuke	=	{ name="Taranus's Cape" }


	Weapons = {}

		Weapons.FreeNuke = {name="Lathi"}
		Weapons.MACC = {}
		Weapons.MB = {}

	Subweapons = {}
		
		Subweapons.FreeNuke = {name="Alber Strap"}
		Subweapons.MACC = {name="Niobid Strap"}
		Subweapons.MB = {}

	Necklace = {}
	
		Necklace.FreeNuke = {name="Saevus Pendant +1"}
		Necklace.MACC = {name="Sanctity Necklace"}
		Necklace.MB = {name="Mizukage-no-kubikazari"}
		
	Earrings = {}
		Earrings.FreeNuke = {name="Barkarole Earring"}
		Earrings.FreeNuke2 = {name="Friomisi Earring"}
		Earrings.TP = {name="Moonshade Earring"}

	Mb_feet={ name="Merlinic Crackows", augments={'"Mag.Atk.Bns."+30','Magic burst dmg.+10%','Mag. Acc.+3',}}
	Mab_feet={ name="Merlinic Crackows", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','Phys. dmg. taken -1%','AGI+6','Mag. Acc.+10','"Mag.Atk.Bns."+12',} }
	
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    ---- Precast Sets ----
    
    -- Precast sets to enhance JAs
    sets.precast.JA['Mana Wall'] = {back=BLMCape.FreeNuke,feet=EMPY.Feet}

    sets.precast.JA.Manafont = {body=RELIC.Body}
    
	sets.precast.JA['Elemental Seal'] = {main="Laevateinn"}
	
    -- equip to maximize HP (for Tarus) and minimize MP loss before using convert
    sets.precast.JA.Convert = {}


    -- Fast cast sets for spells

    sets.precast.FC = {
		main="Grioavolr",
		sub="Niobid Strap",
		ammo="Sapience Orb",
        head={name="Merlinic Hood", priority=2},
		neck="Orunmila's Torque",
		ear1="Enchanter Earring +1",
		ear2="Loquacious Earring",
        body="Shango Robe",
		hands="Helios Gloves",
		ring1="Prolix Ring",
		ring2="Lebeche Ring",
        back="Perimede Cape",
		waist="Witful Belt",
		legs={name="psycloth lappas", priority=1}, 
		feet="Regal Pumps +1"
		}

	sets.precast.FC.DeathMB = set_combine(sets.precast.FC, {
		ammo="Psilomene", 
		ear1={Earrings.FreeNuke, priority=4},
		body="Merlinic Jubbah", 
		ring1="Sangoma ring",
		ring2={name="Mephitas's ring +1", priority=9}, 
		back={name=BLMCape.MACC, priority=6},
		legs="Psycloth Lappas", 
		feet={name=Mab_feet, priority=8}})

	sets.precast.FC.Death = {}
	
	sets.precast.FC.Aspir = sets.precast.FC.Death	

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})

    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {feet="Tutyr Sabots"})

    sets.precast.FC.Impact = set_combine(sets.precast.FC['Elemental Magic'], {head=empty,body="Twilight Cloak"})

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {
		head="Vanya Hood",
		ear1="Mendicant's earring",
		back="Pahtli Cape",
		feet="Vanya Clogs"})

    sets.precast.FC.Curaga = sets.precast.FC.Cure
	
	sets.precast.Trust = sets.precast.FC

    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        head="Merlinic Hood",neck="Fotia Gorget",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Amalric Doublet",hands="Amalric Gages",ring1="Shiva Ring +1",ring2="Rajas Ring",
        back=BLMCape.FreeNuke,waist="Fotia Belt",legs="Assiduity Pants +1",feet="Battlecast Gaiters"}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Vidohunir'] = {ammo="Dosis Tathlum",
        head="Merlinic Hood",neck="Sanctity Necklace",ear1=Earrings.FreeNuke,ear2=Earrings.FreeNuke2,
        body="Amalric Doublet",hands="Amalric Gages",ring1="Shiva Ring +1",ring2="Adoulin Ring +1",
        back=BLMCape.FreeNuke,legs="Assiduity Pants +1",feet="Battlecast Gaiters"}
		-- Increase Max MP
     sets.precast.WS['Myrkr'] = {
        head="Nahtirah Hat",neck="Orunmila's Torque",ear1=Earrings.FreeNuke,ear2=Earrings.TP,
        body="Amalric Doublet",hands="Helios Gloves",ring1="Sangoma Ring",ring2="Mephitas's ring +1",
        back=BLMCape.FreeNuke,waist="Fucho-no-obi",legs="Psycloth Lappas",feet="Medium's Sabots"}
   
    
    ---- Midcast Sets ----

    sets.midcast.FastRecast = {
        head="Nahtirah Hat",ear2="Loquacious Earring",neck="Orunmila's Torque",
        body="Shango Robe",ring1="Prolix Ring",
        back="Swith Cape",waist="Witful Belt",legs="Psycloth Lappas"}

    sets.midcast.Cure = {
		main="Tamaxchi",
		sub="Sors Shield",
        head="Vanya Hood",
		neck="Incanter's Torque",
		ear1="Mendicant's earring",
		ear2="Loquacious Earring",
        body="Annointed Kalasiris",
		hands="Telchine Gloves",
		ring1="Menelaus's Ring",
		ring2="Sirona's Ring",
        back="Oretania's Cape +1",
		waist="Hachirin-no-Obi",
		legs="Psycloth Lappas",
		feet="Vanya Clogs"}

    sets.midcast.Curaga = sets.midcast.Cure
    sets.midcast.CureSelf = {
		waist="Gishdubar Sash"}

    sets.midcast['Enhancing Magic'] = {
		main="Gada",
		sub="Ammurapi Shield",	
		head="Befouled Crown", 
		neck="Incanter's Torque",
		body="Vanya Robe",
		waist="Embla Sash",
		feet="Regal Pumps +1" }
    
    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {ear1="Earthcry Earring", waist="Siegel Sash"})
	
	sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {})
	sets.midcast.RefreshSelf = {waist="Gishdubar Sash", feet="Inspirited Boots"}

    sets.midcast['Enfeebling Magic'] = {
		main=Weapons.FreeNuke,
		sub="Mephitis Grip",
		ammo="Quartz Tathlum +1",
        head="Befouled Crown",
		neck="Incanter's Torque",
		ear1=Earrings.FreeNuke,
		ear2="Gwati Earring",
        body="Vanya Robe",
		hands="Helios Gloves",
		ring1="Stikini Ring",
		ring2="Stikini Ring",
        back=BLMCape.FreeNuke,
		waist="Rumination Sash",
		legs="Psycloth Lappas",
		feet="Medium's Sabots"}
        
    sets.midcast.ElementalEnfeeble = sets.midcast['Enfeebling Magic']

    sets.midcast['Dark Magic'] = {main=Weapons.FreeNuke,sub="Mephitis Grip",ammo="Pemphredo Tathlum",
        head="Befouled Crown",neck="Sanctity Necklace",ear1=Earrings.FreeNuke,ear2="Gwati Earring",
        body="Shango Robe",hands="Helios Gloves",ring1="Archon Ring",ring2="Sangoma Ring",
        back=BLMCape.FreeNuke,waist="Eschan Stone",legs="Psycloth Lappas",feet=EMPY.Feet}

	sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {
		head="Pixie Hairpin +1", 
		neck="Incanter's Torque", 
		hands="Helios Gloves", 
		ring1="Archon Ring", 
		ring2="Excelsis Ring",
		back=BLMCape.FreeNuke, 
		waist="Fucho-no-obi", 
		legs="Amalric Slops",
		feet=RELIC.Feet
	})
    
    sets.midcast.Aspir = sets.midcast.Drain
	sets.midcast['Aspir III'] = sets.midcast.Drain

	sets.midcast.Stun = {
		main=Weapons.FreeNuke,
		sub="Mephitis Grip",
		ammo="Impatiens",
		head="Nahtirah Hat",
		neck="Orunmila's Torque",
		ear1="Barkarole Earring",
		ear2="Gwati Earring",
		body="Merlinic Jubbah",
		hands=AF.Hands,
		ring1="Stikini Ring",
		ring2="Stikini Ring",
		back=BLMCape.FreeNuke,
		waist="Witful Belt",
		legs="Psycloth Lappas",
		feet="regal pumps +1"}


    -- Elemental Magic sets
    
    sets.midcast['Elemental Magic'] = {
		main=Weapons.FreeNuke,
		sub="Niobid Strap",
		ammo="Pemphredo Tathlum",
        head=RELIC.Head,
		neck=Necklace.FreeNuke,
		ear1="Barkarole Earring",
		ear2="Friomisi Earring",
        body=RELIC.Body,
		hands=RELIC.Hands,
		ring1="Shiva Ring +1",
		ring2="Fenrir Ring +1",
        back=BLMCape.FreeNuke,
		waist="Refoccilation Stone",
		legs=RELIC.Legs,
		feet=RELIC.Feet}

    sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'], {
		sub="Niobid Strap", 
		neck=Necklace.MACC,
		ear2="Gwati Earring",
		legs="Psycloth Lappas"
	})
	
	sets.midcast['Elemental Magic'].MBurst = set_combine(sets.midcast['Elemental Magic'], {
		ring2="Mujin Band",
		feet=Mb_feet
	})


    sets.midcast['Elemental Magic'].HighTierNuke = set_combine(sets.midcast['Elemental Magic'], {
		sub="Alber Strap",
		ring2="Shiva Ring +1"})
    
	sets.midcast['Elemental Magic'].HighTierNuke.Resistant = set_combine(sets.midcast['Elemental Magic'].HighTierNuke, {
		ring2="Adoulin Ring +1"})

	sets.midcast.Death = {
		main="Lathi",
		sub="Niobid Strap",
		ammo="Ghastly Tathlum +1", 
		head="Pixie Hairpin +1", 
		neck="Saevus Pendant +1", 
		ear1="Barkarole Earring", 
		ear2="Loquacious Earring",
		body="Merlinic Jubbah",
		hands="Amalric Gages", 
		ring2="Mephitas's Ring +1", 
		ring1="Archon Ring",
		back=BLMCape.FreeNuke, 
		waist="Yamabuki-no-Obi", 
		legs="Amalric Slops", 
		feet=Mab_feet}
	
	sets.midcast.Death.HighMP = set_combine(sets.midcast.Death,{
		head=RELIC.Head,
		body=RELIC.Body,
		hands=RELIC.Hands,
		legs=RELIC.Legs,
		feet=RELIC.Feet,
		ring2="Metamorph Ring +1"
		})
	
	sets.midcast.Comet = set_combine(sets.midcast.Death,{
						 Ammo="Pemphredo Tathlum", ring1="Mujin Band"})

    -- Minimal damage gear for procs.
    sets.midcast['Elemental Magic'].Proc = {main="Boonwell Staff", sub="Mephitis Grip",ammo="Impatiens",
        head="Nahtirah Hat",neck="Loricate Torque +1",ear1="Enchanter Earring +1",ear2="Loquacious Earring",
        body="Seidr Cotehardie",hands="Hagondes Cuffs +1",ring1="Prolix Ring",ring2="Leviathan Ring +1",
        back="Swith Cape",waist="Witful Belt",legs="Psycloth Lappas",feet="Regal Pumps +1"}


    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {
		main="Boonwell Staff",
		sub="Niobid Strap",
		neck="Jeweled Collar", 
		ear1="Barkarole Earring", 
		ear2="Relaxing Earring",
        waist="Hierarch Belt",
		legs="Assiduity Pants +1"}
    

    -- Idle sets
    
    -- Normal refresh idle set
    sets.idle = {main="Lathi", sub="Zuuxowu Grip",
        head="Befouled Crown",neck="Sorcerer's Stole +1",ear1="Barkarole Earring",ear2="Friomisi Earring",
        body=Salvage.Body,hands="Amalric Gages",ring1="Shiva Ring +1",ring2="Fenrir Ring +1",
        back=BLMCape.FreeNuke,
		waist="Fucho-no-obi",legs="Assiduity Pants +1",feet="Herald's Gaiters"}

    -- Idle mode that keeps PDT gear on, but doesn't prevent normal gear swaps for precast/etc.
    sets.idle.PDT = {main="Bolelabunga",sub="Genmei Shield",
        head="Nahtirah Hat",neck="Loricate Torque +1",ear1="Barkarole Earring",ear2="Genmei Earring",
        body="Hagondes Coat +1",hands="Amalric Gages",ring1="Defending Ring",
        back="Moonbeam Cape",waist="Fucho-no-obi",legs=RELIC.Legs,feet=Limbus.Feet}

    -- Idle mode scopes:
    -- Idle mode when weak.
    sets.idle.Weak = {main="Bolelabunga",sub="Genmei Shield",
        head="Hagondes Hat +1",neck="Loricate Torque +1",ear1="Barkarole Earring",ear2="Genmei Earring",
        body="Hagondes Coat +1",hands="Amalric Gages",ring1="Defending Ring",ring2="Adoulin Ring +1",
        back="Moonbeam Cape",waist="Fucho-no-obi",legs="Assiduity Pants +1",feet="Battlecast Gaiters"}
    
    -- Town gear.
    sets.idle.Town = set_combine(sets.idle,{
	main="Laevateinn",
		head=RELIC.Head,
		body=RELIC.Body,
		hands=AF.Hands,
		legs=RELIC.Legs
		})
        
	sets.idle.HighMP = set_combine(sets.idle,{
		head=RELIC.Head,
		body=RELIC.Body,
		hands=RELIC.Hands,
		legs=RELIC.Legs,
		feet=RELIC.Feet,
		ring2="Metamorph Ring +1"
		})
	sets.CP = {back="Mecistopins Mantle"}
	sets.idle.RR = set_combine(sets.idle,{body="Annointed Kalasiris"})
	
    -- Defense sets

    sets.defense.PDT = {ammo="Staunch Tathlum +1", head="Hagondes Hat +1",neck="Loricate Torque +1",ear2="Genmei Earring",
        body="Hagondes Coat +1",hands="Helios Gloves",ring1="Defending Ring",
        back="Moonbeam Cape",waist="Hierarch Belt",legs="Amalric Slops", feet=Limbus.Feet}
    
    sets.defense.MDT = {ammo="Staunch Tathlum +1",
        head="Hagondes hat +1",neck="Loricate Torque +1",ear2="Genmei Earring",
        body="Hagondes Coat +1",hands="Helios Gloves",ring1="Defending Ring",ring2="Archon Ring",
        back="Moonbeam Cape",waist="Hierarch Belt",legs="Psycloth Lappas",feet=Limbus.Feet}

    sets.Kiting = {feet="Herald's Gaiters"}

    sets.latent_refresh = {waist="Fucho-no-obi"}

    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
    
    sets.buff['Mana Wall'] = {feet=EMPY.Feet}

    sets.magic_burst = {
		neck=Necklace.MB,
		ear2="Static Earring", 
		hands=AF.Hands,
		ring1="Locus ring", 
		ring2="mujin band", 
		legs=RELIC.Legs,
		feet=Mb_feet
	}
	
	--sets.Seidr = {body=AF.Body}
	sets.DarkAffinity = {head="Pixie Hairpin +1",ring2="Archon Ring"}
	sets.Seidr = {body=AF.Body, hands=AF.Hands}
	sets.Obi = {waist="Hachirin-no-Obi"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {
		ammo="Hasty Pinion +1",
        head=RELIC.Head,
		neck="Asperity Necklace",
		ear1="Telos Earring",
		ear2="Cessance Earring",
        body=Salvage.Body,
		hands=Salvage.Hands,
		ring1="Chirich Ring +1",
		ring2="Rajas Ring",
        back="Argochampsa Mantle",
		waist="Cetl Belt",
		legs=Salvage.Legs,
		feet=Salvage.Feet
	}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if spellMap == 'Cure' or spellMap == 'Curaga' then
        gear.default.obi_waist = "Witful Belt"
    elseif spell.skill == 'Elemental Magic' then
        gear.default.obi_waist = "Sekhmet Corset"
        if state.CastingMode.value == 'Proc' then
            classes.CustomClass = 'Proc'
        end
    end
	
	if spell.action_type == 'Magic' and state.DeathMode.value then
        eventArgs.handled = true
        equip(sets.precast.FC.DeathMode)
        if spell.english == "Impact" then
            equip(sets.precast.FC.Impact.DeathMode)
        end
    end
	
    if spell.name:startswith('Aspir') then
        refine_various_spells(spell, action, spellMap, eventArgs)
    end
	
    if buffactive['Mana Wall'] then
        equip(sets.precast.JA['Mana Wall'])
    end
end

function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.name == 'Impact' then
        equip(sets.precast.FC.Impact)
    end

	if player.mp > 2000 and state.VorsealMode.value == 'Vorseal' then
	equip(sets.precast.FC.HighMP)
	elseif player.mp < 2000 and state.VorsealMode.value == 'Vorseal' then
	equip(sets.precast.FC)
	elseif player.mp > 1650 and state.VorsealMode.value == 'Normal' then
	equip(sets.precast.FC.HighMP)
	elseif player.mp < 1650 and state.VorsealMode.value == 'Normal' then
	equip(sets.precast.FC)
    end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
    if spell.action_type == 'Magic' and state.DeathMode.value then
        eventArgs.handled = true
        if spell.skill == 'Elemental Magic' then
            equip(sets.midcast['Elemental Magic'].DeathMode)
        else
            if state.CastingMode.value == "Resistant" then
                equip(sets.midcast.Death.Resistant)
            else
                equip(sets.midcast.Death)
            end
        end
    end

    if buffactive['Mana Wall'] then
        equip(sets.precast.JA['Mana Wall'])
    end
end

function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.skill == 'Enhancing Magic' and classes.NoSkillSpells:contains(spell.english) and not state.DeathMode.value then
        equip(sets.midcast.EnhancingDuration)
        if spellMap == 'Refresh' then
            equip(sets.midcast.Refresh)
        end
    end
    if spell.skill == 'Elemental Magic' and spell.english == "Comet" then
        equip(sets.DarkAffinity)
    end
    if spell.skill == 'Elemental Magic' then
        if state.MagicBurst.value and spell.english ~= 'Death' then
            --if state.CastingMode.value == "Resistant" then
                --equip(sets.magic_burst.Resistant)
            --else
                equip(sets.magic_burst)
            --end
            if spell.english == "Impact" then
                equip(sets.midcast.Impact)
            end
        end
        if (spell.element == world.day_element or spell.element == world.weather_element) then
            equip(sets.Obi)
        end
    end
    if buffactive['Mana Wall'] then
        equip(sets.precast.JA['Mana Wall'])
    end

    if spell.skill == 'Elemental Magic' and state.MagicBurst.value then equip(sets.magic_burst)
    end

	if spell.skill == 'Elemental Magic' and state.Seidr.value then equip(sets.Seidr)
	end
	
	if spell.skill == 'Enhancing Magic' then
		if spellMap == 'Refresh' and spell.target.type == 'SELF' then
			equip(sets.midcast.RefreshSelf)
		end
    elseif spellMap == 'Cure' and spell.target.type == 'SELF' then
        equip(sets.midcast.CureSelf)
    end
end

function job_aftercast(spell, action, spellMap, eventArgs)
    -- Lock feet after using Mana Wall.
    if buffactive['Mana Wall'] then
        enable('feet','back')
        equip(sets.buff['Mana Wall'])
        disable('feet','back')
    end
	if not spell.interrupted then
        if spell.english == "Sleep II" or spell.english == "Sleepga II" then
            send_command('@timers c "Sleep II ['..spell.target.name..']" 90 down spells/00259.png')
        elseif spell.english == "Sleep" or spell.english == "Sleepga" then -- Sleep & Sleepga Countdown --
            send_command('@timers c "Sleep ['..spell.target.name..']" 60 down spells/00253.png')
        elseif spell.english == "Break" or spell.english == "Breakga" then
            send_command('@timers c "Break ['..spell.target.name..']" 30 down spells/00255.png')
        end
    end
    --if not spell.interrupted then
    --    if spell.english == "Sleep II" or spell.english == "Sleepga II" then -- Sleep II Countdown --
    --        send_command('wait 60;input /echo Sleep Effect: [WEARING OFF IN 30 SEC.];wait 15;input /echo Sleep Effect: [WEARING OFF IN 15 SEC.];wait 10;input /echo Sleep Effect: [WEARING OFF IN 5 SEC.]')
    --    elseif spell.english == "Sleep" or spell.english == "Sleepga" then -- Sleep & Sleepga Countdown --
    --        send_command('wait 30;input /echo Sleep Effect: [WEARING OFF IN 30 SEC.];wait 15;input /echo Sleep Effect: [WEARING OFF IN 15 SEC.];wait 10;input /echo Sleep Effect: [WEARING OFF IN 5 SEC.]')
    --    elseif spell.english == "Break" or spell.english == "Breakga" then -- Break Countdown --
    --        send_command('wait 25;input /echo Break Effect: [WEARING OFF IN 5 SEC.]')
    --    elseif spell.english == "Paralyze" then -- Paralyze Countdown --
    --         send_command('wait 115;input /echo Paralyze Effect: [WEARING OFF IN 5 SEC.]')
    --    elseif spell.english == "Slow" then -- Slow Countdown --
    --        send_command('wait 115;input /echo Slow Effect: [WEARING OFF IN 5 SEC.]')        
    --    end
    --end
	--if buffactive['poison'] then
	--send_command('input /item "antidote" <me>')
	--end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
	--if buff == "poison" and gain then
	--send_command('input /item "antidote" <me>')
	--end

    -- Unlock feet when Mana Wall buff is lost.
	 if buff== "Mana Wall" then
			if gain then
				--send_command('gs enable all')
				equip(sets.precast.JA['Mana Wall'])
				--send_command('gs disable all')
			else
				--send_command('gs enable all')
				handle_equipping_gear(player.status)
			end
		end

    --if buff == "Commitment" and not gain then
    --    equip({ring2="Capacity Ring"})
    --    if player.equipment.right_ring == "Capacity Ring" then
    --        disable("ring2")
    --    else
    --        enable("ring2")
    --    end
    --end

end

-- Handle notifications of general user state change.
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

 -- Called any time we attempt to handle automatic gear equips (ie: engaged or idle gear).
function job_handle_equipping_gear(playerStatus, eventArgs)  
    check_gear()
    check_moving()  	
end

function job_update(cmdParams, eventArgs)
    handle_equipping_gear(player.status)
end

-- Custom spell mapping.
function job_get_spell_map(spell, default_spell_map)
    if spell.action_type == 'Magic' then
        if spell.skill == "Enfeebling Magic" then
            if spell.type == "WhiteMagic" then
                return "MndEnfeebles"
            else
                return "IntEnfeebles"
            end
        end
    end
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if state.DeathMode.value then
        idleSet = sets.idle.DeathMode
    end
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    if player.hpp <= 25 then
        idleSet = set_combine(idleSet, sets.latent_dt)
    end
    -- if state.CP.current == 'on' then
    --     equip(sets.CP)
    --     disable('back')
    -- else
    --     enable('back')
    -- end
    if buffactive['Mana Wall'] then
        idleSet = set_combine(idleSet, sets.precast.JA['Mana Wall'])
    end
    if state.Auto_Kite.value == true then
       idleSet = set_combine(idleSet, sets.Kiting)
    end

    return idleSet
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
    if buffactive['Mana Wall'] then
        meleeSet = set_combine(meleeSet, sets.precast.JA['Mana Wall'])
    end

    return meleeSet
end

function customize_defense_set(defenseSet)
    if buffactive['Mana Wall'] then
        defenseSet = set_combine(defenseSet, sets.precast.JA['Mana Wall'])
    end

    return defenseSet
end

-- Function to display the current relevant user state when doing an update.
function display_current_job_state(eventArgs)
    --display_current_caster_state()
	
    local c_msg = state.CastingMode.value

    local d_msg = 'None'
    if state.DefenseMode.value ~= 'None' then
        d_msg = state.DefenseMode.value .. state[state.DefenseMode.value .. 'DefenseMode'].value
    end

    local i_msg = state.IdleMode.value

    local msg = ''
    if state.MagicBurst.value then
        msg = ' Burst: On |'
    end
    if state.DeathMode.value then
        msg = msg .. ' Death: On |'
    end
    if state.Kiting.value then
        msg = msg .. ' Kiting: On |'
    end

    add_to_chat(060, '| Magic: ' ..string.char(31,001)..c_msg.. string.char(31,002)..  ' |'
        ..string.char(31,004).. ' Defense: ' ..string.char(31,001)..d_msg.. string.char(31,002)..  ' |'
        ..string.char(31,008).. ' Idle: ' ..string.char(31,001)..i_msg.. string.char(31,002)..  ' |'
        ..string.char(31,002)..msg)

    eventArgs.handled = true
end

function refine_various_spells(spell, action, spellMap, eventArgs)
    local aspirs = S{'Aspir','Aspir II','Aspir III'}

    local newSpell = spell.english
    local spell_recasts = windower.ffxi.get_spell_recasts()
    local cancelling = 'All '..spell.english..' are on cooldown. Cancelling.'

    local spell_index

    if spell_recasts[spell.recast_id] > 0 then
        if aspirs:contains(spell.name) then
            spell_index = table.find(degrade_array['Aspirs'],spell.name)
            if spell_index > 1 then
                newSpell = degrade_array['Aspirs'][spell_index - 1]
                send_command('@input /ma '..newSpell..' '..tostring(spell.target.raw))
                eventArgs.cancel = true
            end
        end
    end
end
-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function job_self_command(cmdParams, eventArgs)
    gearinfo(cmdParams, eventArgs)
end

function gearinfo(cmdParams, eventArgs)
    if cmdParams[1] == 'gearinfo' then
        if type(cmdParams[4]) == 'string' then
            if cmdParams[4] == 'true' then
                moving = true
            elseif cmdParams[4] == 'false' then
                moving = false
            end
        end
        if not midaction() then
            job_update()
        end
    end
end

function check_moving()
    if state.DefenseMode.value == 'None'  and state.Kiting.value == false then
        if state.Auto_Kite.value == false and moving then
            state.Auto_Kite:set(true)
        elseif state.Auto_Kite.value == true and moving == false then
            state.Auto_Kite:set(false)
        end
    end
end

function check_gear()
    if no_swap_gear:contains(player.equipment.left_ring) then
        disable("ring1")
    else
        enable("ring1")
    end
    if no_swap_gear:contains(player.equipment.right_ring) then
        disable("ring2")
    else
        enable("ring2")
    end
end

windower.register_event('zone change',
    function()
        if no_swap_gear:contains(player.equipment.left_ring) then
            enable("ring1")
            equip(sets.idle)
        end
        if no_swap_gear:contains(player.equipment.right_ring) then
            enable("ring2")
            equip(sets.idle)
        end
    end
)

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(3, 20)
end

function set_lockstyle()
    send_command('wait 2; input /lockstyleset ' .. lockstyleset)
end