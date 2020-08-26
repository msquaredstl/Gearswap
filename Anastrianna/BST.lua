-------------------------------------------------------------------------------------------------------------------
-- Last Revised: June 3rd, 2015 (Added comprehensive Ready move system and options notice w/F12
-- You can use "/console gs c Ready one", or "...two", or "...three" macros to use the designated moves,
-- or if you use Windower macros, you can use: i.e. bind ^1 input gs c Ready one)
--
-- alt+F8 cycles through designated Jug Pets
-- ctrl+F8 toggles Monster Correlation between Neutral and Favorable
-- 'Windows Key'+F7 switches between Pet stances for Master/Pet hybrid gearsets
-- alt+= cycles through Pet Food types
-- 'Windows Key'+F8 can swap in the usage of Chaac Belt for Treasure Hunter on common subjob abilities.
-- ctrl+F11 cycles between Magical Defense Modes
--
-- General Gearswap Commands:
-- F9 cycles Accuracy modes
-- ctrl+F9 cycles Hybrid modes
-- 'Windows Key'+F9 cycles Weapon Skill modes
-- F10 equips Physical Defense
-- alt+F10 toggles Kiting on or off
-- ctrl+F10 cycles Physical Defense modes
-- F11 equips Magical Defense
-- alt+F12 turns off Defense modes
-- ctrl+F12 cycles Idle modes
--
-- Keep in mind that any time you Change Jobs/Subjobs, your Pet/Pet Food/etc. reset to default options.
-- F12 will list your current options.
-------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------
-- Initialization function that defines sets and variables to be used.
-------------------------------------------------------------------------------------------------------------------

-- IMPORTANT: Make sure to also get the Mote-Include.lua file (and its supplementary files) to go with this.

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
end

function job_setup()
    state.Buff['Aftermath: Lv.3'] = buffactive['Aftermath: Lv.3'] or false
    state.Buff['Killer Instinct'] = buffactive['Killer Instinct'] or false
    state.Buff.Doomed = buffactive.doomed or false

    get_combat_form()
    get_melee_groups()
end

function user_setup()
    state.OffenseMode:options('Normal', 'HighAcc')
    state.HybridMode:options('Normal', 'Hybrid')
    state.WeaponskillMode:options('Normal', 'WSMedAcc', 'WSHighAcc')
    state.CastingMode:options('Normal')
    state.IdleMode:options('Normal', 'Reraise', 'Regen')
    state.RestingMode:options('Normal')
    state.PhysicalDefenseMode:options('PetPDT', 'PDT', 'Reraise')
    state.MagicalDefenseMode:options('MDTShell', 'MDT')

    -- 'Out of Range' distance; WS will auto-cancel
    target_distance = 5

    -- Set up Jug Pet cycling and keybind Alt+F8
    -- INPUT PREFERRED JUG PETS HERE
state.JugMode = M{['description']='Jug Mode', 'AttentiveIbuki', 'BlackbeardRandy', 'SharpwitHermes',
                'RedolentCandi','DroopyDortwin','ScissorlegXerin','WarlikePatrick','HeraldHenry',
				'AlluringHoney','SwoopingZhivago','BouncingBertha','HeadbreakerKen'}
    send_command('bind !f8 gs c cycle JugMode')

    -- Set up Monster Correlation Modes and keybind Ctrl+F8
    state.CorrelationMode = M{['description']='Correlation Mode', 'Neutral', 'Favorable'}
    send_command('bind ^f8 gs c cycle CorrelationMode')

    -- Set up Pet Modes for Hybrid sets and keybind 'Windows Key'+F7
    state.PetMode = M{['description']='Pet Mode', 'PetOnly', 'PetTank', 'Normal'}
    send_command('bind @f7 gs c cycle PetMode')

    -- Keybind Ctrl+F11 to cycle Magical Defense Modes
    send_command('bind ^f11 gs c cycle MagicalDefenseMode')

    -- Set up Reward Modes and keybind alt+=
    state.RewardMode = M{['description']='Reward Mode', 'Theta', 'Eta', 'Zeta','Robo'}
    send_command('bind != gs c cycle RewardMode')

    -- Set up Treasure Modes and keybind 'Windows Key'+F8
    state.TreasureMode = M{['description']='Treasure Mode', 'Tag', 'Normal'}
    send_command('bind @f8 gs c cycle TreasureMode')

-- Complete list of Ready moves to use with Sic & Ready Recast -5 Desultor Tassets.
physical_ready_moves = S{'Sic','Foot Kick','Whirl Claws','Wild Carrot','Sheep Charge','Lamb Chop','Head Butt',
    'Wild Oats','Leaf Dagger','Claw Cyclone','Razor Fang','Nimble Snap','Cyclotail','Rhino Attack','Power Attack',
    'Mandibular Bite','Big Scissors','Grapple','Spinning Top','Double Claw','Frogkick','Blockhead','Brain Crush',
    'Tail Blow','??? Needles','Needleshot','Scythe Tail','Ripper Fang','Chomp Rush','Recoil Dive','Sudden Lunge',
    'Spiral Spin','Wing Slap','Beak Lunge','Suction','Back Heel','Choke Breath','Fantod','Tortoise Stomp',
    'Harden Shell','Sensilla Blades','Tegmina Buffet','Swooping Frenzy','Pentapeck','Sweeping Gouge',
    'Zealous Snort','Somersault','Tickling Tendrils','Pecking Flurry','Sickle Slash'}

magic_atk_ready_moves = S{'Dust Cloud','Cursed Sphere','Venom','Toxic Spit','Bubble Shower','Drainkiss',
    'Silence Gas','Dark Spore','Fireball','Plague Breath','Snow Cloud','Charged Whisker','Purulent Ooze',
    'Corrosive Ooze','Aqua Breath','Stink Bomb','Nectarous Deluge','Nepenthic Plunge','Pestilent Plume',
    'Foul Waters'}

magic_acc_ready_moves = S{'Sheep Song','Scream','Dream Flower','Roar','Gloeosuccus','Palsy Pollen',
    'Soporific','Geist Wall','Toxic Spit','Numbing Noise','Spoil','Hi-Freq Field','Sandpit','Sandblast',
    'Venom Spray','Filamented Hold','Queasyshroom','Numbshroom','Spore','Shakeshroom','Infrasonics',
    'Chaotic Eye','Blaster','Intimidate','Noisome Powder','Acid Mist','TP Drainkiss','Jettatura',
    'Molting Plumage','Spider Web'}

tp_based_ready_moves = S{'Sic','Somersault','Dust Cloud','Foot Kick','Sheep Song','Sheep Charge','Lamb Chop',
    'Rage','Head Butt','Scream','Dream Flower','Wild Oats','Leaf Dagger','Claw Cyclone','Razor Fang','Roar',
    'Gloeosuccus','Palsy Pollen','Soporific','Cursed Sphere','Geist Wall','Numbing Noise','Frogkick',
    'Nimble Snap','Cyclotail','Spoil','Rhino Guard','Rhino Attack','Hi-Freq Field','Sandpit','Sandblast',
    'Mandibular Bite','Metallic Body','Bubble Shower','Bubble Curtain','Scissor Guard','Grapple','Spinning Top',
    'Double Claw','Filamented Hold','Spore','Blockhead','Secretion','Fireball','Tail Blow','Plague Breath',
    'Brain Crush','Infrasonics','Needleshot','Chaotic Eye','Blaster','Ripper Fang','Intimidate','Recoil Dive',
    'Water Wall','Snow Cloud','Wild Carrot','Sudden Lunge','Noisome Powder','Wing Slap','Beak Lunge','Suction',
    'Drainkiss','Acid Mist','TP Drainkiss','Back Heel','Jettatura','Choke Breath','Fantod','Charged Whisker',
    'Purulent Ooze','Corrosive Ooze','Tortoise Stomp','Harden Shell','Aqua Breath','Sensilla Blades',
    'Tegmina Buffet','Sweeping Gouge','Zealous Snort','Tickling Tendrils','Pecking Flurry',
    'Pestilent Plume','Foul Waters','Spider Web'}

-- List of abilities to reference for applying Treasure Hunter +1 via Chaac Belt.
abilities_to_check = S{'Feral Howl','Quickstep','Box Step','Stutter Step','Desperate Flourish','Violent Flourish',
    'Animated Flourish','Provoke','Dia','Dia II','Flash','Bio','Bio II','Sleep','Sleep II',
    'Drain','Aspir','Dispel','Steal','Mug'}
end

function file_unload()
    if binds_on_unload then
        binds_on_unload()
    end

    -- Unbinds the Reward, Correlation, PetMode and Treasure hotkeys.
    send_command('unbind ^=')
    send_command('unbind f8')
    send_command('unbind !f8')
    send_command('unbind ^f8')
    send_command('unbind ^f11')
end

-- BST gearsets
function init_gear_sets()
    -- AUGMENTED GEAR
    Pet_PDT_AxeMain = { name="Kumbhakarna", augments={'Pet: Accuracy +15 Pet: Rng. Acc.+15','Pet: TP Bonus +80','Pet: Phys. dmg. taken -4%',}}
    Pet_PDT_AxeSub = "Izizoeksi"
	
	RegenAxeMain = "Hunaphu"
    RegenAxeSub = "Izizoeksi"

    Pet_PDT_head = "Anwig Salade"
    Pet_PDT_body = { name="Acro Surcoat", augments={'Pet: Accuracy+18 Pet: Rng. Acc.+18','Pet: "Dbl. Atk."+4','Pet: Damage taken -2%',}}
    Pet_PDT_hands = { name="Acro Gauntlets", augments={'Pet: Accuracy+22 Pet: Rng. Acc.+22','Pet: "Dbl. Atk."+3','Pet: Damage taken -2%',}}
    Pet_PDT_legs =  { name="Acro Breeches", augments={'Pet: Accuracy+22 Pet: Rng. Acc.+22','Pet: "Dbl. Atk."+5','Pet: Damage taken -3%',}}
    Pet_PDT_feet = { name="Acro Leggings", augments={'Pet: Accuracy+25 Pet: Rng. Acc.+25','Pet: "Dbl. Atk."+3','Pet: Damage taken -2%',}}
    Pet_PDT_back = "Pastoralist's Mantle"

    Ready_Atk_head ={ name="Acro Helm", augments={'Pet: Accuracy+13 Pet: Rng. Acc.+13','Pet: "Dbl. Atk."+5',}}
    Ready_Atk_body ={ name="Acro Surcoat", augments={'Pet: Accuracy+18 Pet: Rng. Acc.+18','Pet: "Dbl. Atk."+4','Pet: Damage taken -2%',}}
    Ready_Atk_hands = { name="Acro Gauntlets", augments={'Pet: Accuracy+22 Pet: Rng. Acc.+22','Pet: "Dbl. Atk."+3','Pet: Damage taken -2%',}}
    Ready_Atk_legs = { name="Acro Breeches", augments={'Pet: Accuracy+22 Pet: Rng. Acc.+22','Pet: "Dbl. Atk."+5','Pet: Damage taken -3%',}}
    Ready_Atk_feet = { name="Acro Leggings", augments={'Pet: Accuracy+25 Pet: Rng. Acc.+25','Pet: "Dbl. Atk."+3','Pet: Damage taken -2%',}}
    Ready_Atk_back = "Pastoralist's Mantle"

    Ready_Acc_head = Ready_Atk_head
    Ready_Acc_body = Ready_Atk_body
    Ready_Acc_hands = Ready_Atk_hands
    Ready_Acc_legs = Ready_Atk_legs
    Ready_Acc_feet = Ready_Atk_feet
    Ready_Acc_back = Ready_Atk_back

    Ready_MAB_head = { name="Acro Helm", augments={'Pet: Mag. Acc.+12','"Call Beast" ability delay -3'}}
    Ready_MAB_body = { name="Acro Surcoat", augments={'Pet: Mag. Acc.+21',}}
    Ready_MAB_hands = { name="Acro Gauntlets", augments={'Pet: "Mag.Atk.Bns."+17',}}
    Ready_MAB_legs = { name="Acro Breeches", augments={'Pet: Mag. Acc.+14','"Call Beast" ability delay -2'}}
    Ready_MAB_feet = { name="Acro Leggings", augments={'Pet: Mag. Acc.+14','"Call Beast" ability delay -5'}}

    Ready_MAcc_head = Ready_MAB_head
    Ready_MAcc_body = Ready_MAB_body
    Ready_MAcc_hands = Ready_MAB_hands
    Ready_MAcc_legs = Ready_MAB_legs
    Ready_MAcc_feet = Ready_MAB_feet

    Ready_Atk_Axe1 = { name="Kumbhakarna", augments={'Pet: Accuracy +15 Pet: Rng. Acc.+15','Pet: TP Bonus +80','Pet: Phys. dmg. taken -4%',}}
    Ready_Acc_Axe1 = Ready_Atk_Axe1
	Ready_Atk_Axe2 = { name="Kumbhakarna", augments={'Pet: "Mag.Atk.Bns."+15','Pet: TP Bonus +200',}}
    Ready_Acc_Axe2 = Ready_Atk_Axe2
    Ready_MAB_Axe1 = { name="Kumbhakarna", augments={'Pet: TP Bonus +160','Pet: "Mag.Atk.Bns."+12',}}
    Ready_MAcc_Axe1 = Ready_MAB_Axe1
	Ready_MAB_Axe2 = { name="Kumbhakarna", augments={'Pet: "Mag.Atk.Bns."+15','Pet: TP Bonus +200',}}
    Ready_MAcc_Axe2 = Ready_MAB_Axe2
	
    Pet_Melee_head = "Anwig Salade"
    Pet_Melee_body = Pet_PDT_body
    Pet_Melee_hands = Pet_PDT_hands
    Pet_Melee_legs = Pet_PDT_legs
    Pet_Melee_feet = Pet_PDT_feet

    Hybrid_head = "Anwig Salade"
    Hybrid_body = Pet_PDT_body
    Hybrid_hands = Pet_PDT_hands
    Hybrid_legs = Pet_PDT_legs
    Hybrid_feet = Pet_PDT_feet

    DW_head = Hybrid_head
    DW_body = Hybrid_body
    DW_hands = Hybrid_hands
    DW_legs = Hybrid_legs
    DW_feet = Hybrid_feet

    MAB_head = Hybrid_head
    MAB_body = Hybrid_body
    MAB_hands = Hybrid_hands
    MAB_legs = Hybrid_legs
    MAB_feet = Hybrid_feet

    FC_head = MAB_head
    FC_body = MAB_body
    FC_hands = MAB_hands
    FC_legs = MAB_legs
    FC_feet = MAB_feet

    MAcc_head = MAB_head
    MAcc_body = MAB_body
    MAcc_hands = MAB_hands
    MAcc_legs = MAB_legs
    MAcc_feet = MAB_feet

    CB_head = Ready_MAB_head
    CB_body = Ready_MAB_body
    CB_hands = "Ankusa Gloves +1"
    CB_legs = Ready_MAB_legs
    CB_feet = Ready_MAB_feet

    -- PRECAST SETS
    sets.precast.JA['Killer Instinct'] = {head="Ankusa Helm +1"}
    sets.precast.JA['Bestial Loyalty'] = {head=CB_head,
        body=CB_body,
        hands=CB_hands,
        legs=CB_legs,
        feet=CB_feet}
    sets.precast.JA['Call Beast'] = sets.precast.JA['Bestial Loyalty']
    sets.precast.JA.Familiar = {legs="Ankusa Trousers +1"}
    sets.precast.JA.Tame = {head="Totemic Helm +1",ear1="Tamer's Earring",legs="Stout Kecks"}
    sets.precast.JA.Spur = {feet="Nukumi Ocreae"}

    sets.precast.JA['Feral Howl'] = {ammo="Ombre Tathlum +1",
        head=MAcc_head,
        neck="Stoicheion Medal",ear1="Lifestorm Earring",ear2="Psystorm Earring",
        body=MAcc_body,
        hands=MAcc_hands,
        ring1="Perception Ring",ring2="Sangoma Ring",
        back="Aput Mantle +1",
        waist="Salire Belt",
        legs=MAcc_legs,
        feet=MAcc_feet}

    sets.precast.JA.Reward ={
    head="Khimaira Bonnet",
    body="Tot. Jackcoat +1",
    hands="Ankusa Gloves +1",
    legs="Ankusa Trousers +1",
    feet="Ankusa Gaiters +1",
    neck="Aife's Medal",
    waist="Engraved Belt",
    left_ear="Neptune's Pearl",
    right_ear="Lifestorm Earring",
    left_ring="Levia. Ring +1",
    right_ring="Levia. Ring +1",
    back="Pastoralist's Mantle"
}

    sets.precast.JA.Reward.Theta = set_combine(sets.precast.JA.Reward, {ammo="Pet Food Theta"})
    sets.precast.JA.Reward.Zeta = set_combine(sets.precast.JA.Reward, {ammo="Pet Food Zeta"})
    sets.precast.JA.Reward.Eta = set_combine(sets.precast.JA.Reward, {ammo="Pet Food Eta"})
	sets.precast.JA.Reward.Robo = set_combine(sets.precast.JA.Reward, {ammo="Pet Roborant"})

    sets.precast.JA.Charm = {ammo="Tsar's Egg",
        head="Ighwa Cap",neck="Dualism Collar +1",ear1="Enchanter's Earring",ear2="Enchanter Earring +1",
        body="Totemic Jackcoat +1",hands="Ankusa Gloves +1",ring1="Dawnsoul Ring",ring2="Dawnsoul Ring",
        back="Aisance Mantle +1",waist="Aristo Belt",legs="Ankusa Trousers +1",feet="Ankusa Gaiters +1"}

    -- CURING WALTZ
    sets.precast.Waltz = {ammo="Sonia's Plectrum",
        head="Ighwa Cap",neck="Dualism Collar +1",ear1="Enchanter's Earring",ear2="Enchanter Earring +1",
        body="Totemic Jackcoat +1",hands="Regimen Mittens",ring1="Valseur's Ring",ring2="Asklepian Ring",
        back="Aisance Mantle +1",waist="Aristo Belt",legs="Desultor Tassets",feet="Totemic Gaiters +1"}

    -- HEALING WALTZ
    sets.precast.Waltz['Healing Waltz'] = {}

    -- STEPS
	sets.precast.Step = {ammo="Hasty Pinion +1",
        head="Yaoyotl Helm",neck="Subtlety Spectacles",ear1="Steelflash Earring",ear2="Heartseeker Earring",
        body=Hybrid_body,
        hands=DW_hands,
        ring1="Mars's Ring",ring2="Oneiros Annulet",
        back="Grounded Mantle +1",waist="Hurch'lan Sash",
        legs=DW_legs,
        feet=DW_feet}

    -- VIOLENT FLOURISH
    sets.precast.Flourish1 = {}
    sets.precast.Flourish1['Violent Flourish'] = {ammo="Hasty Pinion +1",
        head=MAcc_head,
        neck="Stoicheion Medal",ear1="Lifestorm Earring",ear2="Psystorm Earring",
        body=Hybrid_body,
        hands=MAcc_hands,
        ring1="Sangoma Ring",ring2="Fenrir Ring +1",
        back="Grounded Mantle +1",waist="Salire Belt",
        legs=MAcc_legs,
        feet=MAcc_feet}

    sets.precast.FC = {neck="Voltsurge Torque",body="Taeon Tabard",ear1="Loquacious Earring",
                ear2="Enchanter Earring +1",hands="Buremte Gloves",ring1="Prolix Ring",legs="Limbo Trousers"}

        sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})

    -- MIDCAST SETS
    sets.midcast.FastRecast = {
                head=Hybrid_head,neck="Twilight Torque",ear1="Loquacious Earring",ear2="Enchanter Earring +1",
                body="Taeon Tabard",hands="Buremte Gloves",ring1="Lebeche Ring",ring2="Defending Ring",
                back="Shadow Mantle",waist="Nierenschutz",legs=Hybrid_legs,feet=Hybrid_feet}
 
    sets.midcast.Utsusemi = sets.midcast.FastRecast

    sets.midcast.Cure = {ammo="Quartz Tathlum +1",
        head="Yaoyotl Helm",neck="Phalaina Locket",ear1="Lifestorm Earring",ear2="Neptune's Pearl",
        body="Savas Jawshan",hands="Buremte Gloves",ring1="Leviathan Ring +1",ring2="Asklepian Ring",
        back=Pet_PDT_back,
        waist="Chuq'aba Belt",legs="Ankusa Trousers +1",feet="Ankusa Gaiters +1"}

    sets.midcast.Curaga = sets.midcast.Cure

    sets.midcast.Stoneskin = {ammo="Quartz Tathlum +1",
        head="Ighwa Cap",neck="Stone Gorget",ear1="Earthcry Earring",ear2="Lifestorm Earring",
        body="Totemic Jackcoat +1",hands="Stone Mufflers",ring1="Leviathan Ring +1",ring2="Leviathan Ring +1",
        back=Pet_PDT_back,
        waist="Salire Belt",legs="Haven Hose",feet="Whirlpool Greaves"}

    sets.midcast.Cursna = set_combine(sets.midcast.FastRecast, {neck="Malison Medallion",
        ring1="Eshmun's Ring",ring2="Haoma's Ring"})

    sets.midcast.Protect = {ring2="Sheltered Ring"}
    sets.midcast.Protectra = sets.midcast.Protect

    sets.midcast.Shell = {ring2="Sheltered Ring"}
    sets.midcast.Shellra = sets.midcast.Shell

    sets.midcast['Enfeebling Magic'] = {ammo="Quartz Tathlum +1",
        head=FC_head,
        neck="Stoicheion Medal",ear1="Lifestorm Earring",ear2="Psystorm Earring",
        body=FC_body,
        hands=FC_hands,
        ring1="Sangoma Ring",ring2="Fenrir Ring +1",
        back="Aput Mantle +1",waist="Salire Belt",
        legs=FC_legs,
        feet=FC_feet}

    sets.midcast['Elemental Magic'] = sets.midcast['Enfeebling Magic']

    -- WEAPONSKILLS
    -- Default weaponskill sets.
    sets.precast.WS = {
		ammo="Flame Sachet",head=Hybrid_head,neck="Snow Gorget",ear1="Heartseeker Earring",
		ear2="Brutal Earring",body=Hybrid_body,hands=Hybrid_hands,ring1="Ifrit Ring",
		ring2="Ifrit Ring",back="Annealed Mantle",waist="Metalslinger Belt",legs=Hybrid_legs,
		feet="Nukumi Ocrea"}

    sets.precast.WS.WSMedAcc = {
		ammo="Hasty Pinion +1",head=Hybrid_head,neck="Snow Gorget",ear1="Heartseeker Earring",
		ear2="Brutal Earring",body=Hybrid_body,hands=Hybrid_hands,ring1="Ifrit Ring",
		ring2="Ifrit Ring",back="Annealed Mantle",waist="Metalslinger Belt",legs=Hybrid_legs,
		feet="Nukumi Ocrea"}

    sets.precast.WS.WSHighAcc = {
		ammo="Hasty Pinion +1",head=Hybrid_head,neck="Snow Gorget",ear1="Heartseeker Earring",
		ear2="Brutal Earring",body=Hybrid_body,hands=Hybrid_hands,ring1="Mars's Ring",
		ring2="Enlivened Ring",back="Pastoralist's Mantle",waist="Anguinus Belt",legs=Hybrid_legs,
		feet="Nukumi Ocrea"}

    -- Specific weaponskill sets.
    sets.precast.WS['Ruinator'] = set_combine(sets.precast.WS, {neck="Fotia Gorget",hands="Boor Bracelets",
        back="Buquwik Cape",waist="Fotia Belt"})
    sets.precast.WS['Ruinator'].Mekira = set_combine(sets.precast.WS['Ruinator'], {head="Mekira-oto +1"})
    sets.precast.WS['Ruinator'].WSMedAcc = set_combine(sets.precast.WS.WSMedAcc, {neck="Fotia Gorget",
        ear1="Kokou's Earring",ear2="Brutal Earring",
        back="Buquwik Cape",waist="Fotia Belt"})
    sets.precast.WS['Ruinator'].WSHighAcc = set_combine(sets.precast.WS.WSHighAcc, {neck="Fotia Gorget",
        ear1="Kokou's Earring",ear2="Brutal Earring",
        waist="Fotia Belt"})

    sets.precast.WS['Onslaught'] = set_combine(sets.precast.WS, {neck="Justiciar's Torque",
        ear1="Steelflash Earring",ear2="Bladeborn Earring",
        ring1="Rajas Ring",back="Vespid Mantle"})
    sets.precast.WS['Onslaught'].WSMedAcc = set_combine(sets.precast.WSMedAcc, {ring1="Rajas Ring",back="Vespid Mantle"})
    sets.precast.WS['Onslaught'].WSHighAcc = set_combine(sets.precast.WSHighAcc, {back="Vespid Mantle"})

    sets.precast.WS['Primal Rend'] = {ammo="Erlene's Notebook",
        head=MAB_head,
        neck="Atzintli Necklace",ear1="Novio Earring",ear2="Friomisi Earring",
        body=MAB_body,
        hands=MAB_hands,
        ring1="Acumen Ring",ring2="Ifrit Ring",
        back="Argocham. Mantle",waist="Light Belt",
        legs=MAB_legs,
        feet=MAB_feet}
    sets.precast.WS['Primal Rend'].WSMedAcc = set_combine(sets.precast.WS['Primal Rend'], {neck="Fotia Gorget",waist="Fotia Belt"})
    sets.precast.WS['Primal Rend'].WShighAcc = sets.precast.WS['Primal Rend'].WSMedAcc
    sets.precast.WS['Cloudsplitter'] = set_combine(sets.precast.WS['Primal Rend'], {neck="Light Gorget",
        ring2="Fenrir Ring",waist="Light Belt"})

    sets.midcast.NightEarrings = {ear1="Lugra Earring",ear2="Lugra Earring +1"}
    sets.midcast.ExtraMAB = {ear1="Hecate's Earring"}

    -- PET SIC & READY MOVES
    sets.midcast.Pet.WS = {ammo="Demonry Core",
        neck="Empath Necklace",ear2="Hija Earring",ear1="Sabong Earring",
		head=Ready_Atk_head,
        body=Ready_Atk_body,
        hands=Ready_Atk_hands,
        ring1="Thurandaut Ring",
        back=Ready_Atk_back,
        waist="Hurch'lan Sash",
        legs=Ready_Atk_legs,
        feet=Ready_Atk_feet}

    sets.midcast.Pet.MagicAtkReady = set_combine(sets.midcast.Pet.WS, {
        head=Ready_MAB_head,
        body=Ready_MAB_body,
        hands=Ready_MAB_hands,
        legs=Ready_MAB_legs,
        feet=Ready_MAB_feet,
		ring1="Thurandaut Ring",
		back="Argocham. Mantle"})

    sets.midcast.Pet.MagicAccReady = set_combine(sets.midcast.Pet.WS, {
        head=Ready_MAcc_head,
        body=Ready_MAcc_body,
        hands=Ready_MAcc_hands,
        legs=Ready_MAcc_legs,
        feet=Ready_MAcc_feet,
		ring1="Thurandaut Ring",
		back="Argocham. Mantle"})
		
    sets.midcast.Pet.ReadyRecast = {legs="Desultor Tassets"}

    sets.midcast.Pet.Neutral = {head="Despair Helm"}
    sets.midcast.Pet.Favorable = {head="Nukumi Cabasset +1"}

    sets.midcast.Pet.HighAcc = set_combine(sets.midcast.Pet.WS, {
        body=Ready_Acc_body,
        hands=Ready_Acc_hands,
        legs=Ready_Acc_legs,
        feet=Ready_Acc_feet})
		
    sets.midcast.Pet.TPBonus = {hands="Nukumi Manoplas"}

    -- PET-ONLY SETS
    sets.midcast.Pet.ReadyRecastNE = {sub="Charmer's Merlin",legs="Desultor Tassets"}

    sets.midcast.Pet.ReadyNE = set_combine(sets.midcast.Pet.WS, {main=Ready_Atk_Axe1,
        sub=Ready_Atk_Axe2})

		
    sets.midcast.Pet.ReadyNE.HighAcc = set_combine(sets.midcast.Pet.WS, {Ready_Acc_Axe1,
        sub=Ready_Acc_Axe2,
        body=Ready_Acc_body,
        hands=Ready_Acc_hands,
        legs=Ready_Acc_legs,
		 ring1="Thurandaut Ring",
        feet=Ready_Acc_feet})

    sets.midcast.Pet.MagicAtkReadyNE = set_combine(sets.midcast.Pet.MagicAtkReady, {main=Ready_MAB_Axe1,
        sub=Ready_MAB_Axe2})

    sets.midcast.Pet.MagicAtkReadyNE.HighAcc = set_combine(sets.midcast.Pet.MagicAtkReady, {main=Ready_MAcc_Axe1,
        sub=Ready_MAB_Axe2,
        head=Ready_MAcc_head,
        body=Ready_MAcc_body,
        hands=Ready_MAcc_hands,
        legs=Ready_MAcc_legs,
		 ring1="Thurandaut Ring",
        feet=Ready_MAcc_feet})

    sets.midcast.Pet.MagicAccReadyNE = set_combine(sets.midcast.Pet.MagicAccReady, {main=Ready_MAcc_Axe1,
        sub=Ready_MAB_Axe2})

    sets.DTAxes = {main=Pet_PDT_AxeMain,
        sub=Pet_PDT_AxeSub}
		
	sets.DTAxes2 = {main=Pet_PDT_AxeMain,
        sub=Ready_Atk_Axe1}
	

    -- RESTING
    sets.resting = {}

    -- IDLE SETS
    sets.ExtraRegen = {waist="Muscle Belt +1"}
	sets.RegenAxes = {main="Hatxiik",sub="Hunahpu"}

    sets.idle = {ammo="Demonry Core",head="Oce. Headpiece +1",neck="Bathy Choker +1",
		ear1="Dawn Earring",ear2="Infused Earring",body="Kumarbi's Akar",hands="Acro Gauntlets",
		ring1="Defending Ring",ring2="Patricius Ring",waist="Muscle Belt +1",legs="Desultor Tassets",feet="Acro Leggings"}
		
	sets.idle.Town ={ legs="Desultor Tassets" }	

    sets.idle.Regen ={ammo="Demonry Core",head="Oce. Headpiece +1",neck="Bathy Choker +1",
		ear1="Dawn Earring",ear2="Infused Earring",body="Kumarbi's Akar",hands="Buremte Gloves",
		ring1="Sheltered Ring",ring2="Paguroidea Ring",waist="Muscle Belt +1",legs=Hybrid_legs,feet="Acro Leggings"}

    sets.idle.Refresh = set_combine(sets.idle, {head="Wivre Hairpin",body="Twilight Mail",legs="Stearc Subligar"})
    sets.idle.Reraise = set_combine(sets.idle, {head="Twilight Helm",body="Twilight Mail"})

    sets.idle.Pet = {ammo="Sihirik",head="Oce. Headpiece +1",neck="Bathy Choker +1",ear1="Dawn Earring",
		ear2="Infused Earring",body="Kumarbi's Akar",hands=Pet_PDT_hands,back="Pastoralist's Mantle",
		waist="Muscle Belt +1", ring1="Thurandaut Ring",ring2="Defending Ring",
		legs=Hybrid_legs,
		feet={ name="Acro Leggings",augments={'Pet: Accuracy+22 Pet: Rng. Acc.+22','Pet: "Dbl. Atk."+5','Pet: Damage taken -4%',}}}
		
		sets.idle.Pet.HighAcc = {
		ammo="Sihirik",head="Oce. Headpiece +1",neck="Bathy Choker +1",ear1="Dawn Earring",
		ear2="Infused Earring",body="Kumarbi's Akar",hands=Pet_PDT_hands,back="Pastoralist's Mantle",
		waist="Muscle Belt +1", ring1="Thurandaut Ring",ring2="Paguroidea Ring",
		legs=Hybrid_legs,
		feet={ name="Acro Leggings",augments={'Pet: Accuracy+22 Pet: Rng. Acc.+22','Pet: "Dbl. Atk."+5','Pet: Damage taken -4%',}}}

    sets.idle.Pet.Engaged = {
		ammo="Demonry Core",
		head="Anwig Salade",
		neck="Shepherd's Chain",
		ear1="Handler's Earring",
		ear2="Handler's Earring +1",
		body=Pet_Melee_body,
		hands=Pet_PDT_hands,
		ring1="Thurandaut Ring",ring2="Defending Ring",
		back="Pastoralist's Mantle",
		waist="Isa Belt",
		legs=Pet_Melee_legs,
		feet=Pet_Melee_feet
		}
		
		sets.idle.Pet.Engaged.HighAcc = {main =Pet_PDT_AxeMain,sub=Pet_PDT_AxeSub,
		ammo="Demonry Core",head="Anwig Salade",neck="Empath Necklace",ear1="Handler's Earring",
		ear2="Handler's Earring +1",
		body=Pet_PDT_body,
		hands=Pet_PDT_hands,
		ring1="Thurandaut Ring",ring2="Paguroidea Ring",
		back="Pastoralist's Mantle",waist="Isa Belt",legs=Pet_PDT_legs,
		feet=Pet_PDT_feet}
		

    -- DEFENSE SETS
    sets.defense.PDT = {ammo="Hasty Pinion +1",
        head="Ighwa Cap",neck="Agitator's Collar",
        body="Emet Harness +1",hands=Pet_PDT_hands,ring1="Patricius Ring",ring2="Defending Ring",
        back="Repulse Mantle",waist="Flume Belt +1",legs="Iuitl Tights +1",feet="Gorney Sollerets +1"}

    sets.defense.Killer = set_combine(sets.defense.PDT, {ammo="Bibiki Seashell",head="Ankusa Helm +1",
        hands=DW_hands,
        ring1="Patricius Ring",ring2="Oneiros Annulet",
        waist="Hurch'lan Sash",
        legs=DW_legs,
        feet=DW_feet})

    sets.defense.Reraise = set_combine(sets.defense.PDT, {head="Twilight Helm",body="Twilight Mail"})

    sets.defense.PetPDT = {ammo="Demonry Core",
        head="Anwig Salade",neck="Shepherd's Chain",ear1="Handler's Earring",ear2="Handler's Earring +1",
        body=Pet_PDT_body,
        hands=Pet_PDT_hands,
        ring1="Thurandaut Ring",ring2="Defending Ring",
        back=Pet_PDT_back,
        waist="Isa Belt",
        legs=Pet_PDT_legs,
        feet=Pet_PDT_feet}

    sets.defense.MDT = set_combine(sets.defense.PDT, {ammo="Sihirik",
        head="Iuitl Headgear +1",neck="Twilight Torque",ear1="Merman's Earring",ear2="Merman's Earring",
        body="Savas Jawshan",
        back="Engulfer Cape +1",waist="Nierenschutz"})

    sets.defense.MDTShell = set_combine(sets.defense.MDT, {ammo="Vanir Battery",
        neck="Inquisitor Bead Necklace",ear1="Sanare Earring",
        ring1="Shadow Ring",back="Engulfer Cape +1",waist="Resolute Belt"})

    sets.Kiting =  {sub="Mafic Cudgel",neck="Twilight Torque",ammo="Sihirik",head="Ighwa Cap",body="Emet Harness +1",
		hands="Buremte Gloves",legs="Osmium Cuisses",ring1={ name="Dark Ring", augments={'Phys. dmg. taken -6%','Breath dmg. taken -4%',}},ring2="Defending Ring",feet="Diama. Sollerets",back="Shadow Mantle",
		waist="Nierenschutz",ear1="Infused Earring", ear2="Sanare Earring"}

    -- MELEE (SINGLE-WIELD) SETS
    sets.engaged = { main=Pet_PDT_AxeMain,
    ammo="Hasty Pinion +1",head=Hybrid_head,neck="Shepherd's Chain",ear1="Dudgeon Earring",
	ear2="Heartseeker Earring"
	,body=Hybrid_body,hands=Hybrid_hands,ring1="Rajas Ring",
	ring2="Epona's Ring",back="Pastoralist's Mantle",waist="Isa Belt",legs=Hybrid_legs,
	feet=Hybrid_feet}
	
    sets.engaged.LowAccHaste = sets.engaged
	
    sets.engaged.HighAcc = {ammo="Hasty Pinion +1",
        head=Hybrid_head,
        neck="Subtlety Spectacles",ear1="Steelflash Earring",ear2="Bladeborn Earring",
        body=Hybrid_body,
        hands=Hybrid_hands,
        ring1="Mars's Ring",ring2="Oneiros Annulet",
        back="Grounded Mantle +1",waist="Isa Belt",
        legs=Hybrid_legs,
        feet=Hybrid_feet}
    sets.engaged.HighAccHaste = sets.engaged.HighAcc
    sets.engaged.Aftermath = set_combine(sets.engaged, {hands="Aetosaur Gloves +1"})
    sets.engaged.LowAccHaste.Aftermath = sets.engaged.Aftermath

    sets.engaged.HighAcc.Aftermath = set_combine(sets.engaged.HighAcc)
    sets.engaged.HighAccHaste.Aftermath = sets.engaged.HighAcc.Aftermath

    -- MELEE (SINGLE-WIELD) HYBRID SETS
    sets.engaged.Hybrid = set_combine(sets.engaged, {head="Iuitl Headgear +1",
        back="Mollusca Mantle",hands=Pet_PDT_hands,legs="Iuitl Tights +1",feet="Gorney Sollerets +1"})
    sets.engaged.LowAccHaste.Hybrid = sets.engaged.Hybrid

    sets.engaged.HighAcc.Hybrid = set_combine(sets.engaged.HighAcc, {head="Iuitl Headgear +1",
        legs="Iuitl Tights +1",feet="Gorney Sollerets +1"})
    sets.engaged.HighAccHaste.Hybrid = sets.engaged.HighAcc.Hybrid

    -- MELEE (DUAL-WIELD) SETS FOR DNC AND NIN SUBJOB
    sets.engaged.DW = { main=Pet_PDT_AxeMain,
    sub=Pet_PDT_AxeSub,ammo="Hasty Pinion +1",head=Hybrid_head,neck="Shepherd's Chain",ear1="Dudgeon Earring",
	ear2="Heartseeker Earring"
	,body=Hybrid_body,hands=Hybrid_hands,ring1="Rajas Ring",
	ring2="Epona's Ring",back="Pastoralist's Mantle",waist="Isa Belt",legs=Hybrid_legs,
	feet=Hybrid_feet}
	
    sets.engaged.DW.LowAccHaste = { main=Pet_PDT_AxeMain,
    sub=Pet_PDT_AxeSub,ammo="Hasty Pinion +1",head=Hybrid_head,neck="Shepherd's Chain",ear1="Dudgeon Earring",
	ear2="Heartseeker Earring"
	,body=Hybrid_body,hands=Hybrid_hands,ring1="Rajas Ring",
	ring2="Epona's Ring",back="Pastoralist's Mantle",waist="Isa Belt",legs=Hybrid_legs,
	feet=Hybrid_feet}
	
	
    sets.engaged.DW.HighAcc = { main=Pet_PDT_AxeMain,
    sub=Pet_PDT_AxeSub,ammo="Hasty Pinion +1",head=Hybrid_head,neck="Shepherd's Chain",ear1="Dudgeon Earring",
	ear2="Heartseeker Earring"
	,body=Hybrid_body,hands=Hybrid_hands,ring1="Rajas Ring",
	ring2="Epona's Ring",back="Pastoralist's Mantle",waist="Isa Belt",legs=Hybrid_legs,
	feet=Hybrid_feet}
	
    sets.engaged.DW.HighAccHaste = {ammo="Hasty Pinion +1",
        head=Hybrid_head,
        neck="Shepherd's Chain",ear1="Heartseeker Earring",ear2="Dudgeon Earring",
        body=Hybrid_body,
        hands=DW_hands,
        ring1="Mars's Ring",ring2="Oneiros Annulet",
        back="Grounded Mantle +1",waist="Isa Belt",
        legs=Hybrid_legs,
        feet=Hybrid_feet}
		
    sets.engaged.DW.Aftermath = sets.engaged.DW
    sets.engaged.DW.LowAccHaste.Aftermath = sets.engaged.DW.Aftermath

    sets.engaged.DW.HighAcc.Aftermath = sets.engaged.DW.HighAcc
    sets.engaged.DW.HighAccHaste.Aftermath = sets.engaged.DW.HighAcc.Aftermath
	
    -- MELEE (DUAL-WIELD) HYBRID SETS
    sets.engaged.DW.Hybrid = set_combine(sets.engaged.DW, {head="Iuitl Headgear +1",
        back="Mollusca Mantle",hands=Pet_PDT_hands,legs="Iuitl Tights +1",feet="Gorney Sollerets +1"})
    sets.engaged.DW.LowAccHaste.Hybrid = sets.engaged.DW.Hybrid

    sets.engaged.DW.HighAcc.Hybrid = set_combine(sets.engaged.DW.HighAcc, {head="Iuitl Headgear +1",
        legs="Iuitl Tights +1",feet="Gorney Sollerets +1"})
    sets.engaged.DW.HighAccHaste.Hybrid = sets.engaged.DW.HighAcc.Hybrid

    -- GEARSETS FOR MASTER ENGAGED (SINGLE-WIELD) & PET TANKING
    sets.engaged.PetTank = set_combine(sets.engaged, {
        head=Pet_PDT_head,
        neck="Shepherd's Chain",ear1="Handler's Earring",ear2="Handler's Earring +1",
        body=Pet_PDT_body,
        hands=Pet_PDT_hands,
        ring1="Thurandaut Ring",
		ring2="Enlivened Ring",
        back=Pet_PDT_back,
        waist="Isa Belt",
        legs=Pet_PDT_legs,
        feet=Pet_PDT_feet})
    sets.engaged.PetTank.LowAccHaste = sets.engaged.PetTank

    sets.engaged.PetTank.HighAcc = sets.engaged.PetTank
    sets.engaged.PetTank.HighAccHaste = sets.engaged.PetTank

    -- GEARSETS FOR MASTER ENGAGED (DUAL-WIELD) & PET TANKING
    sets.engaged.DW.PetTank = set_combine(sets.engaged.DW, {
        head=Pet_PDT_head,
        neck="Shepherd's Chain",ear1="Handler's Earring",ear2="Handler's Earring +1",
        body=Pet_PDT_body,
        hands=Pet_PDT_hands,
        back=Pet_PDT_back,
		ring1="Thurandaut Ring",
        waist="Isa Belt",
        legs=Pet_PDT_legs,
        feet=Pet_PDT_feet})
		
    sets.engaged.DW.PetTank.LowAccHaste = sets.engaged.DW.PetTank
	
	
    sets.engaged.DW.PetTank.HighAcc = set_combine(sets.engaged.DW.HighAcc, {
        head=Pet_PDT_head,
        neck="Shepherd's Chain",ear1="Handler's Earring",ear2="Handler's Earring +1",
        body=Pet_PDT_body,
        hands=Pet_PDT_hands,
        ring1="Thurandaut Ring",
		ring2="Mars's Ring",
		waist="Isa Belt",
        legs=Pet_PDT_legs,
        feet=Pet_PDT_feet})
		
    sets.engaged.DW.PetTank.HighAccHaste = sets.engaged.DW.PetTank.HighAcc

    sets.buff['Killer Instinct'] = {body=Hybrid_body}
    sets.buff.Doomed = {ring1="Eshmun's Ring"}
    sets.THBelt = {waist="Chaac Belt"}
    sets.DaytimeAmmo = {ammo="Tengu-no-Hane"}

-------------------------------------------------------------------------------------------------------------------
-- Complete Lvl 76-99 Jug Pet Precast List +Funguar +Courier +Amigo
-------------------------------------------------------------------------------------------------------------------

    sets.precast.JA['Bestial Loyalty'].FunguarFamiliar = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Seedbed Soil"})
    sets.precast.JA['Bestial Loyalty'].CourierCarrie = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Fish Oil Broth"})
    sets.precast.JA['Bestial Loyalty'].AmigoSabotender = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Sun Water"})
    sets.precast.JA['Bestial Loyalty'].NurseryNazuna = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="D. Herbal Broth"})
    sets.precast.JA['Bestial Loyalty'].CraftyClyvonne = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Cng. Brain Broth"})
    sets.precast.JA['Bestial Loyalty'].PrestoJulio = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="C. Grass. Broth"})
    sets.precast.JA['Bestial Loyalty'].SwiftSieghard = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Mlw. Bird Broth"})
    sets.precast.JA['Bestial Loyalty'].MailbusterCetas = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Gob. Bug Broth"})
    sets.precast.JA['Bestial Loyalty'].AudaciousAnna = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="B. Carrion Broth"})
    sets.precast.JA['Bestial Loyalty'].TurbidToloi = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Auroral Broth"})
    sets.precast.JA['Bestial Loyalty'].LuckyLulush = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="L. Carrot Broth"})
    sets.precast.JA['Bestial Loyalty'].DipperYuly = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Wool Grease"})
    sets.precast.JA['Bestial Loyalty'].FlowerpotMerle = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Vermihumus"})
    sets.precast.JA['Bestial Loyalty'].DapperMac = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Briny Broth"})
    sets.precast.JA['Bestial Loyalty'].DiscreetLouise = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Deepbed Soil"})
    sets.precast.JA['Bestial Loyalty'].FatsoFargann = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="C. Plasma Broth"})
    sets.precast.JA['Bestial Loyalty'].FaithfulFalcorr = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Lucky Broth"})
    sets.precast.JA['Bestial Loyalty'].BugeyedBroncha = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Svg. Mole Broth"})
    sets.precast.JA['Bestial Loyalty'].BloodclawShasra = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Rzr. Brain Broth"})
    sets.precast.JA['Bestial Loyalty'].GorefangHobs = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="B. Carrion Broth"})
    sets.precast.JA['Bestial Loyalty'].GooeyGerard = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Cl. Wheat Broth"})
    sets.precast.JA['Bestial Loyalty'].CrudeRaphie = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Shadowy Broth"})

-------------------------------------------------------------------------------------------------------------------
-- Complete iLvl Jug Pet Precast List
-------------------------------------------------------------------------------------------------------------------

    sets.precast.JA['Bestial Loyalty'].DroopyDortwin = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Swirling Broth"})
    sets.precast.JA['Bestial Loyalty'].PonderingPeter = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Vis. Broth"})
    sets.precast.JA['Bestial Loyalty'].SunburstMalfik = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Shimmering Broth"})
    sets.precast.JA['Bestial Loyalty'].AgedAngus = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Ferm. Broth"})
    sets.precast.JA['Bestial Loyalty'].WarlikePatrick = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Livid Broth"})
    sets.precast.JA['Bestial Loyalty'].ScissorlegXerin = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Spicy Broth"})
    sets.precast.JA['Bestial Loyalty'].BouncingBertha = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Bubbly Broth"})
    sets.precast.JA['Bestial Loyalty'].RhymingShizuna = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Lyrical Broth"})
    sets.precast.JA['Bestial Loyalty'].AttentiveIbuki = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Salubrious Broth"})
    sets.precast.JA['Bestial Loyalty'].SwoopingZhivago = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Windy Greens"})
    sets.precast.JA['Bestial Loyalty'].AmiableRoche = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Airy Broth"})
    sets.precast.JA['Bestial Loyalty'].HeraldHenry = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Trans. Broth"})
    sets.precast.JA['Bestial Loyalty'].BrainyWaluis = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Crumbly Soil"})
    sets.precast.JA['Bestial Loyalty'].HeadbreakerKen = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Blackwater Broth"})
    sets.precast.JA['Bestial Loyalty'].RedolentCandi = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Electrified Broth"})
    sets.precast.JA['Bestial Loyalty'].AlluringHoney = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Bug-Ridden Broth"})
    sets.precast.JA['Bestial Loyalty'].CaringKiyomaro = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Fizzy Broth"})
    sets.precast.JA['Bestial Loyalty'].VivaciousVickie = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Tant. Broth"})
    sets.precast.JA['Bestial Loyalty'].HurlerPercival = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Pale Sap"})
    sets.precast.JA['Bestial Loyalty'].BlackbeardRandy = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Meaty Broth"})
    sets.precast.JA['Bestial Loyalty'].GenerousArthur = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Dire Broth"})
    sets.precast.JA['Bestial Loyalty'].ThreestarLynn = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Muddy Broth"})
    sets.precast.JA['Bestial Loyalty'].BraveHeroGlenn = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Wispy Broth"})
    sets.precast.JA['Bestial Loyalty'].SharpwitHermes = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Saline Broth"})
    sets.precast.JA['Bestial Loyalty'].ColibriFamiliar = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Sugary Broth"})
    sets.precast.JA['Bestial Loyalty'].ChoralLeera = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Glazed Broth"})
    sets.precast.JA['Bestial Loyalty'].SpiderFamiliar = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Sticky Webbing"})
    sets.precast.JA['Bestial Loyalty'].GussyHachirobe = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Slimy Webbing"})
    sets.precast.JA['Bestial Loyalty'].AcuexFamiliar = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Poisonous Broth"})
    sets.precast.JA['Bestial Loyalty'].FluffyBredo = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Venomous Broth"})
end

-------------------------------------------------------------------------------------------------------------------
-- General hooks for other game events.
-------------------------------------------------------------------------------------------------------------------

function job_buff_change(buff, gain)
    if buff == 'Aftermath: Lv.3' and gain then
        job_update(cmdParams, eventArgs)
                handle_equipping_gear(player.status)
    else
        job_update(cmdParams, eventArgs)
        handle_equipping_gear(player.status)
    end
	if buff == 'Reive Mark' then
		if gain then
			equip({neck="Adoulin's Refuge +1"})
			send_command('@wait .5;gs disable neck')
		else
			send_command('gs enable neck')
		end
	end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks that are called to process player actions at specific points in time.
-------------------------------------------------------------------------------------------------------------------

function job_precast(spell, action, spellMap, eventArgs)
--	cancel_conflicting_buffs(spell, action, spellMap, eventArgs)

        if player.equipment.main == 'Aymur' then
                custom_aftermath_timers_precast(spell)
        end

        if spell.type == "WeaponSkill" and spell.name ~= 'Mistral Axe' and spell.name ~= 'Bora Axe' and spell.target.distance > target_distance then
                cancel_spell()
                add_to_chat(123, spell.name..' Canceled: [Out of Range]')
                handle_equipping_gear(player.status)
                return
        end

    if spell.english == 'Reward' then
        if state.RewardMode.value == 'Theta' then
            equip(sets.precast.JA.Reward.Theta)
        elseif state.RewardMode.value == 'Zeta' then
            equip(sets.precast.JA.Reward.Zeta)
        elseif state.RewardMode.value == 'Eta' then
            equip(sets.precast.JA.Reward.Eta)
		elseif state.RewardMode.value == 'Robo' then
            equip(sets.precast.JA.Reward.Robo)
        end
    end

	if spell.english == 'Bestial Loyalty' or spell.english == 'Call Beast' then
        if state.JugMode.value == 'FunguarFamiliar' then
            equip(sets.precast.JA['Bestial Loyalty'].FunguarFamiliar)
        elseif state.JugMode.value == 'CourierCarrie' then
            equip(sets.precast.JA['Bestial Loyalty'].CourierCarrie)
        elseif state.JugMode.value == 'AmigoSabotender' then
            equip(sets.precast.JA['Bestial Loyalty'].AmigoSabotender)
        elseif state.JugMode.value == 'NurseryNazuna' then
            equip(sets.precast.JA['Bestial Loyalty'].NurseryNazuna)
        elseif state.JugMode.value == 'CraftyClyvonne' then
            equip(sets.precast.JA['Bestial Loyalty'].CraftyClyvonne)
        elseif state.JugMode.value == 'PrestoJulio' then
            equip(sets.precast.JA['Bestial Loyalty'].PrestoJulio)
        elseif state.JugMode.value == 'SwiftSieghard' then
            equip(sets.precast.JA['Bestial Loyalty'].SwiftSieghard)
        elseif state.JugMode.value == 'MailbusterCetas' then
            equip(sets.precast.JA['Bestial Loyalty'].MailbusterCetas)
        elseif state.JugMode.value == 'AudaciousAnna' then
            equip(sets.precast.JA['Bestial Loyalty'].AudaciousAnna)
        elseif state.JugMode.value == 'TurbidToloi' then
            equip(sets.precast.JA['Bestial Loyalty'].TurbidToloi)
        elseif state.JugMode.value == 'SlipperySilas' then
            equip(sets.precast.JA['Bestial Loyalty'].SlipperySilas)
        elseif state.JugMode.value == 'LuckyLulush' then
            equip(sets.precast.JA['Bestial Loyalty'].LuckyLulush)
        elseif state.JugMode.value == 'DipperYuly' then
            equip(sets.precast.JA['Bestial Loyalty'].DipperYuly)
        elseif state.JugMode.value == 'FlowerpotMerle' then
            equip(sets.precast.JA['Bestial Loyalty'].FlowerpotMerle)
        elseif state.JugMode.value == 'DapperMac' then
            equip(sets.precast.JA['Bestial Loyalty'].DapperMac)
        elseif state.JugMode.value == 'DiscreetLouise' then
            equip(sets.precast.JA['Bestial Loyalty'].DiscreetLouise)
        elseif state.JugMode.value == 'FatsoFargann' then
            equip(sets.precast.JA['Bestial Loyalty'].FatsoFargann)
        elseif state.JugMode.value == 'FaithfulFalcorr' then
            equip(sets.precast.JA['Bestial Loyalty'].FaithfulFalcorr)
        elseif state.JugMode.value == 'BugeyedBroncha' then
            equip(sets.precast.JA['Bestial Loyalty'].BugeyedBroncha)
        elseif state.JugMode.value == 'BloodclawShasra' then
            equip(sets.precast.JA['Bestial Loyalty'].BloodclawShasra)
        elseif state.JugMode.value == 'GorefangHobs' then
            equip(sets.precast.JA['Bestial Loyalty'].GorefangHobs)
        elseif state.JugMode.value == 'GooeyGerard' then
            equip(sets.precast.JA['Bestial Loyalty'].GooeyGerard)
        elseif state.JugMode.value == 'CrudeRaphie' then
            equip(sets.precast.JA['Bestial Loyalty'].CrudeRaphie)
        elseif state.JugMode.value == 'DroopyDortwin' then
            equip(sets.precast.JA['Bestial Loyalty'].DroopyDortwin)
        elseif state.JugMode.value == 'PonderingPeter' then
            equip(sets.precast.JA['Bestial Loyalty'].PonderingPeter)
        elseif state.JugMode.value == 'SunburstMalfik' then
            equip(sets.precast.JA['Bestial Loyalty'].SunburstMalfik)
        elseif state.JugMode.value == 'AgedAngus' then
            equip(sets.precast.JA['Bestial Loyalty'].AgedAngus)
        elseif state.JugMode.value == 'WarlikePatrick' then
            equip(sets.precast.JA['Bestial Loyalty'].WarlikePatrick)
        elseif state.JugMode.value == 'ScissorlegXerin' then
            equip(sets.precast.JA['Bestial Loyalty'].ScissorlegXerin)
        elseif state.JugMode.value == 'BouncingBertha' then
            equip(sets.precast.JA['Bestial Loyalty'].BouncingBertha)
        elseif state.JugMode.value == 'RhymingShizuna' then
            equip(sets.precast.JA['Bestial Loyalty'].RhymingShizuna)
        elseif state.JugMode.value == 'AttentiveIbuki' then
            equip(sets.precast.JA['Bestial Loyalty'].AttentiveIbuki)
        elseif state.JugMode.value == 'SwoopingZhivago' then
            equip(sets.precast.JA['Bestial Loyalty'].SwoopingZhivago)
        elseif state.JugMode.value == 'AmiableRoche' then
            equip(sets.precast.JA['Bestial Loyalty'].AmiableRoche)
        elseif state.JugMode.value == 'HeraldHenry' then
            equip(sets.precast.JA['Bestial Loyalty'].HeraldHenry)
        elseif state.JugMode.value == 'BrainyWaluis' then
            equip(sets.precast.JA['Bestial Loyalty'].BrainyWaluis)
        elseif state.JugMode.value == 'HeadbreakerKen' then
            equip(sets.precast.JA['Bestial Loyalty'].HeadbreakerKen)
        elseif state.JugMode.value == 'RedolentCandi' then
            equip(sets.precast.JA['Bestial Loyalty'].RedolentCandi)
        elseif state.JugMode.value == 'AlluringHoney' then
            equip(sets.precast.JA['Bestial Loyalty'].AlluringHoney)
        elseif state.JugMode.value == 'CaringKiyomaro' then
            equip(sets.precast.JA['Bestial Loyalty'].CaringKiyomaro)
        elseif state.JugMode.value == 'VivaciousVickie' then
            equip(sets.precast.JA['Bestial Loyalty'].VivaciousVickie)
        elseif state.JugMode.value == 'HurlerPercival' then
            equip(sets.precast.JA['Bestial Loyalty'].HurlerPercival)
        elseif state.JugMode.value == 'BlackbeardRandy' then
            equip(sets.precast.JA['Bestial Loyalty'].BlackbeardRandy)
        elseif state.JugMode.value == 'GenerousArthur' then
            equip(sets.precast.JA['Bestial Loyalty'].GenerousArthur)
        elseif state.JugMode.value == 'ThreestarLynn' then
            equip(sets.precast.JA['Bestial Loyalty'].ThreestarLynn)
        elseif state.JugMode.value == 'BraveHeroGlenn' then
            equip(sets.precast.JA['Bestial Loyalty'].BraveHeroGlenn)
        elseif state.JugMode.value == 'SharpwitHermes' then
            equip(sets.precast.JA['Bestial Loyalty'].SharpwitHermes)
        elseif state.JugMode.value == 'ColibriFamiliar' then
            equip(sets.precast.JA['Bestial Loyalty'].ColibriFamiliar)
        elseif state.JugMode.value == 'ChoralLeera' then
            equip(sets.precast.JA['Bestial Loyalty'].ChoralLeera)
        elseif state.JugMode.value == 'SpiderFamiliar' then
            equip(sets.precast.JA['Bestial Loyalty'].SpiderFamiliar)
        elseif state.JugMode.value == 'GussyHachirobe' then
            equip(sets.precast.JA['Bestial Loyalty'].GussyHachirobe)
        elseif state.JugMode.value == 'AcuexFamiliar' then
            equip(sets.precast.JA['Bestial Loyalty'].AcuexFamiliar)
        elseif state.JugMode.value == 'FluffyBredo' then
            equip(sets.precast.JA['Bestial Loyalty'].FluffyBredo)
		end
	end

-- Define class for Sic and Ready moves.
    if spell.type == "Monster" then
            classes.CustomClass = "WS"
        if state.PetMode.Value == 'PetOnly' then
            equip(sets.midcast.Pet.ReadyRecastNE)
        else
            equip(sets.midcast.Pet.ReadyRecast)
        end
    end
end

function job_post_precast(spell, action, spellMap, eventArgs)
-- If Killer Instinct is active during WS, equip Nukumi Gausape.
    if spell.type:lower() == 'weaponskill' and buffactive['Killer Instinct'] then
        equip(sets.buff['Killer Instinct'])
    end

    if world.time >= 17*60 or world.time < 7*60 then
        if spell.english == "Ruinator" or spell.english == "Rampage" or spell.english == "Calamity" then
            equip(sets.midcast.NightEarrings)
        end
    end

    if spell.english == "Primal Rend" and player.tp > 2750 then
        equip(sets.midcast.ExtraMAB)
    end

-- Equip Chaac Belt for TH+1 on common Subjob Abilities or Spells.
    if abilities_to_check:contains(spell.english) and state.TreasureMode.value == 'Tag' then
        equip(sets.THBelt)
    end
end

function job_pet_midcast(spell, action, spellMap, eventArgs)
    if physical_ready_moves:contains(spell.name) then
        if state.PetMode.value == 'PetOnly' then
            if state.OffenseMode.value == 'HighAcc' or state.OffenseMode.value == 'HighAccHaste' then
                equip(sets.midcast.Pet.ReadyNE.HighAcc, sets.midcast.Pet[state.CorrelationMode.value])
          
            else
                equip(set_combine(sets.midcast.Pet.ReadyNE, sets.midcast.Pet[state.CorrelationMode.value]))
            end
        else
            if state.OffenseMode.value == 'HighAcc' or state.OffenseMode.value == 'HighAccHaste' then
                equip(sets.midcast.Pet.HighAcc, sets.midcast.Pet[state.CorrelationMode.value])
          
            else
                equip(set_combine(sets.midcast.Pet.WS, sets.midcast.Pet[state.CorrelationMode.value]))
            end
        end
    end

    if magic_atk_ready_moves:contains(spell.name) then
        if state.PetMode.value == 'PetOnly' then
            if state.OffenseMode.value == 'HighAcc' or state.OffenseMode.value == 'HighAccHaste' then
                equip(sets.midcast.Pet.MagicAtkReadyNE,HighAcc)
           
            else
                equip(sets.midcast.Pet.MagicAtkReadyNE)
            end
        else
            equip(sets.midcast.Pet.MagicAtkReady)
        end
    end

    if magic_acc_ready_moves:contains(spell.name) then
        if state.PetMode.value == 'PetOnly' then
            equip(sets.midcast.Pet.MagicAccReadyNE)
        else
            equip(sets.midcast.Pet.MagicAccReady)
        end
    end

    -- If Pet TP, before bonuses, is less than a certain value then equip Nukumi Manoplas +1
    --if state.OffenseMode.value ~= 'HighAcc' and state.OffenseMode.value ~= 'HighAccHaste' then
    --   if tp_based_ready_moves:contains(spell.name) and PetJob == 'Warrior' and pet.tp < 190 then
    --        equip(sets.midcast.Pet.TPBonus)
    --    elseif tp_based_ready_moves:contains(spell.name) and PetJob ~= 'Warrior' and pet.tp < 240 then
    --        equip(sets.midcast.Pet.TPBonus)
    --    end
    --end
end

function job_pet_aftercast(spell, action, spellMap, eventArgs)
    if state.PetMode.value == 'PetOnly' and state.OffenseMode.value == 'Normal' then
        equip(sets.DTAxes)
	elseif state.PetMode.value == 'PetOnly' and state.OffenseMode.value == 'HighAcc' then
		equip(sets.DTAxes2)
    end
end

-- Return true if we handled the aftercast work.  Otherwise it will fall back
-- to the general aftercast() code in Mote-Include.
function job_aftercast(spell, action, spellMap, eventArgs)
    if player.equipment.main == 'Aymur' then
        custom_aftermath_timers_aftercast(spell)
    end

    if world.time >= 360 and world.time < 1080 then
        if state.OffenseMode.value == 'HighAcc' or state.OffenseMode.value == 'HighAccHaste' then
            if player.status == 'Engaged' then
                equip(sets.DaytimeAmmo)
            end
        end
    end

    if state.PetMode.value == 'PetOnly' and state.OffenseMode.value == 'Normal' then
        equip(sets.DTAxes)
	elseif state.PetMode.value == 'PetOnly' and state.OffenseMode.value == 'HighAcc' then
		equip(sets.DTAxes2)	
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Customization hook for idle sets.
-------------------------------------------------------------------------------------------------------------------


-------------------------------------------------------------------------------------------------------------------
-- Hooks for Reward, Correlation, Treasure Hunter, and Pet Mode handling.
-------------------------------------------------------------------------------------------------------------------

function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Correlation Mode' then
        state.CorrelationMode:set(newValue)
    elseif stateField == 'Reward Mode' then
        state.RewardMode:set(newValue)
    elseif stateField == 'Treasure Mode' then
        state.TreasureMode:set(newValue)
    elseif stateField == 'Pet Mode' then
        state.CombatWeapon:set(newValue)
    end

    if world.time >= 360 and world.time < 1080 then
        if state.OffenseMode.value == 'HighAcc' or state.OffenseMode.value == 'HighAccHaste' then
            if player.status == 'Engaged' then
                equip(sets.DaytimeAmmo)
            end
        end
    end
end

function get_custom_wsmode(spell, spellMap, default_wsmode)
    if default_wsmode == 'Normal' then
        if spell.english == "Ruinator" and (world.day_element == 'Water' or world.day_element == 'Wind' or world.day_element == 'Ice') then
            return 'Mekira'
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called any time we attempt to handle automatic gear equips (ie: engaged or idle gear).
function job_handle_equipping_gear(playerStatus, eventArgs)    	
    if player.equipment.back == 'Mecisto. Mantle' or player.equipment.back == 'Aptitude Mantle' or player.equipment.back == 'Aptitude Mantle +1' or player.equipment.back == 'Nexus Cape' then
        disable('back')
    else
        enable('back')
    end
    if player.equipment.ring1 == 'Warp Ring' or player.equipment.ring1 == 'Vocation Ring' or player.equipment.ring1 == 'Capacity Ring' or player.equipment.ring1 == 'Trizek Ring'then
        disable('ring1')
    else
        enable('ring1')
    end
    if player.equipment.ring2 == 'Warp Ring' or player.equipment.ring2 == 'Vocation Ring' or player.equipment.ring2 == 'Capacity Ring' or player.equipment.ring2 == 'Trizek Ring'then
        disable('ring2')
    else
        enable('ring2')
    end
end

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    get_combat_form()
    get_melee_groups()

        if state.JugMode.value == 'FunguarFamiliar' then
                PetInfo = "Funguar, Plantoid"
                PetJob = 'Warrior'
                ReadyMoveOne = 'Frogkick'
                ReadyMoveTwo = 'Spore'
                ReadyMoveThree = 'Silence Gas'
        elseif state.JugMode.value == 'CourierCarrie' then
                PetInfo = "Crab, Aquan"
                PetJob = 'Paladin'
                ReadyMoveOne = 'Big Scissors'
                ReadyMoveTwo = 'Scissor Guard'
                ReadyMoveThree = 'Bubble Curtain'
        elseif state.JugMode.value == 'AmigoSabotender' then
                PetInfo = "Cactuar, Plantoid"
                PetJob = 'Warrior'
                ReadyMoveOne = 'Needle Shot'
                ReadyMoveTwo = '??? Needles'
                ReadyMoveThree = '??? Needles'
        elseif state.JugMode.value == 'NurseryNazuna' then
                PetInfo = "Sheep, Beast"
                PetJob = 'Warrior'
                ReadyMoveOne = 'Lamb Chop'
                ReadyMoveTwo = 'Rage'
                ReadyMoveThree = 'Sheep Song'
        elseif state.JugMode.value == 'CraftyClyvonne' then
                PetInfo = "Coeurl, Beast"
                PetJob = 'Warrior'
                ReadyMoveOne = 'Blaster'
                ReadyMoveTwo = 'Chaotic Eye'
                ReadyMoveThree = 'None'
        elseif state.JugMode.value == 'PrestoJulio' then
                PetInfo = "Flytrap, Plantoid"
                PetJob = 'Warrior'
                ReadyMoveOne = 'Frogkick'
                ReadyMoveTwo = 'Spore'
                ReadyMoveThree = 'Silence Gas'
        elseif state.JugMode.value == 'SwiftSieghard' then
                PetInfo = "Raptor, Lizard"
                PetJob = 'Warrior'
                ReadyMoveOne = 'Scythe Tail'
                ReadyMoveTwo = 'Ripper Fang'
                ReadyMoveThree = 'Chomp Rush'
        elseif state.JugMode.value == 'MailbusterCetas' then
                PetInfo = "Fly, Vermin"
                PetJob = 'Warrior'
                ReadyMoveOne = 'Somersault'
                ReadyMoveTwo = 'Cursed Sphere'
                ReadyMoveThree = 'Venom'
        elseif state.JugMode.value == 'AudaciousAnna' then
                PetInfo = "Lizard, Lizard"
                PetJob = 'Warrior'
                ReadyMoveOne = 'Tail Blow'
                ReadyMoveTwo = 'Brain Crush'
                ReadyMoveThree = 'Fireball'
        elseif state.JugMode.value == 'TurbidToloi' then
                PetInfo = "Pugil, Aquan"
                PetJob = 'Warrior'
                ReadyMoveOne = 'Recoil Dive'
                ReadyMoveTwo = 'Water Wall'
                ReadyMoveThree = 'Intimidate'
        elseif state.JugMode.value == 'SlipperySilas' then
                PetInfo = "Toad, Aquan"
                PetJob = 'Warrior'
                ReadyMoveOne = 'None'
                ReadyMoveTwo = 'None'
                ReadyMoveThree = 'None'
        elseif state.JugMode.value == 'LuckyLulush' then
                PetInfo = "Rabbit, Beast"
                PetJob = 'Warrior'
                ReadyMoveOne = 'Foot Kick'
                ReadyMoveTwo = 'Whirl Claws'
                ReadyMoveThree = 'Wild Carrot'
        elseif state.JugMode.value == 'DipperYuly' then
                PetInfo = "Ladybug, Vermin"
                PetJob = 'Thief'
                ReadyMoveOne = 'Spiral Spin'
                ReadyMoveTwo = 'Sudden Lunge'
                ReadyMoveThree = 'Noisome Powder'
        elseif state.JugMode.value == 'FlowerpotMerle' then
                PetInfo = "Mandragora, Plantoid"
                PetJob = 'Monk'
                ReadyMoveOne = 'Head Butt'
                ReadyMoveTwo = 'Leaf Dagger'
                ReadyMoveThree = 'Wild Oats'
        elseif state.JugMode.value == 'DapperMac' then
                PetInfo = "Apkallu, Bird"
                PetJob = 'Monk'
                ReadyMoveOne = 'Beak Lunge'
                ReadyMoveTwo = 'Wing Slap'
                ReadyMoveThree = 'None'
        elseif state.JugMode.value == 'DiscreetLouise' then
                PetInfo = "Funguar, Plantoid"
                PetJob = 'Warrior'
                ReadyMoveOne = 'Frogkick'
                ReadyMoveTwo = 'Spore'
                ReadyMoveThree = 'Silence Gas'
        elseif state.JugMode.value == 'FatsoFargann' then
                PetInfo = "Leech, Amorph"
                PetJob = 'Warrior'
                ReadyMoveOne = 'Suction'
                ReadyMoveTwo = 'Acid Mist'
                ReadyMoveThree = 'Drain Kiss'
        elseif state.JugMode.value == 'FaithfulFalcorr' then
                PetInfo = "Hippogryph, Bird"
                PetJob = 'Thief'
                ReadyMoveOne = 'Back Heel'
                ReadyMoveTwo = 'Choke Breath'
                ReadyMoveThree = 'Fantod'
        elseif state.JugMode.value == 'BugeyedBroncha' then
                PetInfo = "Eft, Lizard"
                PetJob = 'Warrior'
                ReadyMoveOne = 'Nimble Snap'
                ReadyMoveTwo = 'Cyclotail'
                ReadyMoveThree = 'Geist Wall'
        elseif state.JugMode.value == 'BloodclawShasra' then
                PetInfo = "Lynx, Beast"
                PetJob = 'Warrior'
                ReadyMoveOne = 'Blaster'
                ReadyMoveTwo = 'Chaotic Eye'
                ReadyMoveThree = 'Charged Whisker'
        elseif state.JugMode.value == 'GorefangHobs' then
                PetInfo = "Tiger, Beast"
                PetJob = 'Warrior'
                ReadyMoveOne = 'Razor Fang'
                ReadyMoveTwo = 'Claw Cyclone'
                ReadyMoveThree = 'Roar'
        elseif state.JugMode.value == 'GooeyGerard' then
                PetInfo = "Slug, Amorph"
                PetJob = 'Warrior'
                ReadyMoveOne = 'Purulent Ooze'
                ReadyMoveTwo = 'Corrosive Ooze'
                ReadyMoveThree = 'Corrosive Ooze'
        elseif state.JugMode.value == 'CrudeRaphie' then
                PetInfo = "Adamantoise, Lizard"
                PetJob = 'Paladin'
                ReadyMoveOne = 'Tortoise Stomp'
                ReadyMoveTwo = 'Harden Shell'
                ReadyMoveThree = 'Aqua Breath'
        elseif state.JugMode.value == 'DroopyDortwin' then
                PetInfo = "Rabbit, Beast"
                PetJob = 'Warrior'
                ReadyMoveOne = 'Foot Kick'
                ReadyMoveTwo = 'Whirl Claws'
                ReadyMoveThree = 'Wild Carrot'
        elseif state.JugMode.value == 'PonderingPeter' then
                PetInfo = "HQ Rabbit, Beast"
                PetJob = 'Warrior'
                ReadyMoveOne = 'Foot Kick'
                ReadyMoveTwo = 'Whirl Claws'
                ReadyMoveThree = 'Wild Carrot'
        elseif state.JugMode.value == 'SunburstMalfik' then
                PetInfo = "Crab, Aquan"
                PetJob = 'Paladin'
                ReadyMoveOne = 'Big Scissors'
                ReadyMoveTwo = 'Scissor Guard'
                ReadyMoveThree = 'Bubble Curtain'
        elseif state.JugMode.value == 'AgedAngus' then
                PetInfo = "HQ Crab, Aquan"
                PetJob = 'Paladin'
                ReadyMoveOne = 'Big Scissors'
                ReadyMoveTwo = 'Scissor Guard'
                ReadyMoveThree = 'Bubble Curtain'
        elseif state.JugMode.value == 'WarlikePatrick' then
                PetInfo = "Lizard, Lizard"
                PetJob = 'Warrior'
                ReadyMoveOne = 'Tail Blow'
                ReadyMoveTwo = 'Brain Crush'
                ReadyMoveThree = 'Fireball'
        elseif state.JugMode.value == 'ScissorlegXerin' then
                PetInfo = "Chapuli, Vermin"
                PetJob = 'Warrior'
                ReadyMoveOne = 'Sensilla Blades'
                ReadyMoveTwo = 'Tegmina Buffet'
                ReadyMoveThree = 'Tegmina Buffet'
        elseif state.JugMode.value == 'BouncingBertha' then
                PetInfo = "HQ Chapuli, Vermin"
                PetJob = 'Warrior'
                ReadyMoveOne = 'Sensilla Blades'
                ReadyMoveTwo = 'Tegmina Buffet'
                ReadyMoveThree = 'Tegmina Buffet'
        elseif state.JugMode.value == 'RhymingShizuna' then
                PetInfo = "Sheep, Beast"
                PetJob = 'Warrior'
                ReadyMoveOne = 'Lamb Chop'
                ReadyMoveTwo = 'Rage'
                ReadyMoveThree = 'Sheep Song'
        elseif state.JugMode.value == 'AttentiveIbuki' then
                PetInfo = "Tulfaire, Bird"
                PetJob = 'Warrior'
                ReadyMoveOne = 'Swooping Frenzy'
                ReadyMoveTwo = 'Pentapeck'
                ReadyMoveThree = 'Molting Plumage'
        elseif state.JugMode.value == 'SwoopingZhivago' then
                PetInfo = "HQ Tulfaire, Bird"
                PetJob = 'Warrior'
                ReadyMoveOne = 'Swooping Frenzy'
                ReadyMoveTwo = 'Pentapeck'
                ReadyMoveThree = 'Molting Plumage'
        elseif state.JugMode.value == 'AmiableRoche' then
                PetInfo = "Pugil, Aquan"
                PetJob = 'Warrior'
                ReadyMoveOne = 'Recoil Dive'
                ReadyMoveTwo = 'Water Wall'
                ReadyMoveThree = 'Intimidate'
        elseif state.JugMode.value == 'HeraldHenry' then
                PetInfo = "Crab, Aquan"
                PetJob = 'Paladin'
                ReadyMoveOne = 'Big Scissors'
                ReadyMoveTwo = 'Scissor Guard'
                ReadyMoveThree = 'Bubble Curtain'
        elseif state.JugMode.value == 'BrainyWaluis' then
                PetInfo = "Funguar, Plantoid"
                PetJob = 'Warrior'
                ReadyMoveOne = 'Frogkick'
                ReadyMoveTwo = 'Spore'
                ReadyMoveThree = 'Silence Gas'
        elseif state.JugMode.value == 'HeadbreakerKen' then
                PetInfo = "Fly, Vermin"
                PetJob = 'Warrior'
                ReadyMoveOne = 'Somersault'
                ReadyMoveTwo = 'Cursed Sphere'
                ReadyMoveThree = 'Venom'
        elseif state.JugMode.value == 'RedolentCandi' then
                PetInfo = "Snapweed, Plantoid"
                PetJob = 'Warrior'
                ReadyMoveOne = 'Tickling Tendrils'
                ReadyMoveTwo = 'Stink Bomb'
                ReadyMoveThree = 'Nepenthic Plunge'
        elseif state.JugMode.value == 'AlluringHoney' then
                PetInfo = "HQ Snapweed, Plantoid"
                PetJob = 'Warrior'
                ReadyMoveOne = 'Tickling Tendrils'
                ReadyMoveTwo = 'Stink Bomb'
                ReadyMoveThree = 'Nectarous Deluge'
        elseif state.JugMode.value == 'CaringKiyomaro' then
                PetInfo = "Raaz, Beast"
                PetJob = 'Monk'
                ReadyMoveOne = 'Sweeping Gouge'
                ReadyMoveTwo = 'Zealous Snort'
                ReadyMoveThree = 'Zealous Snort'
        elseif state.JugMode.value == 'VivaciousVickie' then
                PetInfo = "HQ Raaz, Beast"
                PetJob = 'Monk'
                ReadyMoveOne = 'Sweeping Gouge'
                ReadyMoveTwo = 'Zealous Snort'
                ReadyMoveThree = 'Zealous Snort'
        elseif state.JugMode.value == 'HurlerPercival' then
                PetInfo = "Beetle, Vermin"
                PetJob = 'Paladin'
                ReadyMoveOne = 'Power Attack'
                ReadyMoveTwo = 'Rhino Attack'
                ReadyMoveThree = 'Hi-Freq Field'
        elseif state.JugMode.value == 'BlackbeardRandy' then
                PetInfo = "Tiger, Beast"
                PetJob = 'Warrior'
                ReadyMoveOne = 'Razor Fang'
                ReadyMoveTwo = 'Claw Cyclone'
                ReadyMoveThree = 'Roar'
        elseif state.JugMode.value == 'GenerousArthur' then
                PetInfo = "Slug, Amorph"
                PetJob = 'Warrior'
                ReadyMoveOne = 'Purulent Ooze'
                ReadyMoveTwo = 'Corrosive Ooze'
                ReadyMoveThree = 'Corrosive Ooze'
        elseif state.JugMode.value == 'ThreestarLynn' then
                PetInfo = "Ladybug, Vermin"
                PetJob = 'Thief'
                ReadyMoveOne = 'Spiral Spin'
                ReadyMoveTwo = 'Sudden Lunge'
                ReadyMoveThree = 'Noisome Powder'
        elseif state.JugMode.value == 'BraveHeroGlenn' then
                PetInfo = "Frog, Aquan"
                PetJob = 'Warrior'
                ReadyMoveOne = 'None'
                ReadyMoveTwo = 'None'
                ReadyMoveThree = 'None'
        elseif state.JugMode.value == 'SharpwitHermes' then
                PetInfo = "Mandragora, Plantoid"
                PetJob = 'Monk'
                ReadyMoveOne = 'Head Butt'
                ReadyMoveTwo = 'Leaf Dagger'
                ReadyMoveThree = 'Wild Oats'
        elseif state.JugMode.value == 'ColibriFamiliar' then
                PetInfo = "Colibri, Bird"
                PetJob = 'Red Mage'
                ReadyMoveOne = 'Pecking Flurry'
                ReadyMoveTwo = 'Pecking Flurry'
                ReadyMoveThree = 'Pecking Flurry'
        elseif state.JugMode.value == 'ChoralLeera' then
                PetInfo = "HQ Colibri, Bird"
                PetJob = 'Red Mage'
                ReadyMoveOne = 'Pecking Flurry'
                ReadyMoveTwo = 'Pecking Flurry'
                ReadyMoveThree = 'Pecking Flurry'
        elseif state.JugMode.value == 'SpiderFamiliar' then
                PetInfo = "Spider, Vermin"
                PetJob = 'Warrior'
                ReadyMoveOne = 'Sickle Slash'
                ReadyMoveTwo = 'Acid Spray'
                ReadyMoveThree = 'Spider Web'
        elseif state.JugMode.value == 'GussyHachirobe' then
                PetInfo = "HQ Spider, Vermin"
                PetJob = 'Warrior'
                ReadyMoveOne = 'Sickle Slash'
                ReadyMoveTwo = 'Acid Spray'
                ReadyMoveThree = 'Spider Web'
        elseif state.JugMode.value == 'AcuexFamiliar' then
                PetInfo = "Acuex, Amorph"
                PetJob = 'Black Mage'
                ReadyMoveOne = 'Foul Waters'
                ReadyMoveTwo = 'Pestilent Plume'
                ReadyMoveThree = 'Pestilent Plume'
        elseif state.JugMode.value == 'FluffyBredo' then
                PetInfo = "HQ Acuex, Amorph"
                PetJob = 'Black Mage'
                ReadyMoveOne = 'Foul Waters'
                ReadyMoveTwo = 'Pestilent Plume'
                ReadyMoveThree = 'Pestilent Plume'
        end

end

-------------------------------------------------------------------------------------------------------------------
-- Ready Move Presets - Credit to Bomberto
-------------------------------------------------------------------------------------------------------------------

function job_self_command(cmdParams, eventArgs)
    if cmdParams[1]:lower() == 'ready' then
        ready_move(cmdParams)
        eventArgs.handled = true
    end
end
 
function ready_move(cmdParams)
     local move = cmdParams[2]:lower()
 
        if pet.name == 'DroopyDortwin' or pet.name == 'PonderingPeter' or pet.name == 'HareFamiliar' or pet.name == 'KeenearedSteffi' or pet.name == 'LuckyLulush' then
            if move == 'one' then
                send_command('input /ja "Foot Kick" <me>')
            elseif move == 'two' then
                send_command('input /ja "Whirl Claws" <me>')
            elseif move == 'three' then
                send_command('input /ja "Wild Carrot" <me>') end
        elseif pet.name == 'SunburstMalfik' or pet.name == 'AgedAngus' or pet.name == 'HeraldHenry' or pet.name == 'CrabFamiliar' or pet.name == 'CourierCarrie' then
            if move == 'one' then
                send_command('input /ja "Big Scissors" <me>')
            elseif move == 'two' then
                send_command('input /ja "Scissor Guard" <me>')
            elseif move == 'three' then
                send_command('input /ja "Bubble Curtain" <me>') end
        elseif pet.name == 'WarlikePatrick' or pet.name == 'LizardFamiliar' or pet.name == 'ColdbloodedComo' or pet.name == 'AudaciousAnna' then
            if move == 'one' then
                send_command('input /ja "Tail Blow" <me>')
            elseif move == 'two' then
                send_command('input /ja "Brain Crush" <me>')
            elseif move == 'three' then
                send_command('input /ja "Fireball" <me>') end
        elseif pet.name == 'ScissorlegXerin' or pet.name == 'BouncingBertha' then
            if move == 'one' then
                send_command('input /ja "Sensilla Blades" <me>')
            elseif move == 'two' or move == 'three' then
                send_command('input /ja "Tegmina Buffet" <me>') end
        elseif pet.name == 'RhymingShizuna' or pet.name == 'SheepFamiliar' or pet.name == 'LullabyMelodia' or pet.name == 'NurseryNazuna' then
            if move == 'one' then
                send_command('input /ja "Lamp Chop" <me>')
            elseif move == 'two' then
                send_command('input /ja "Rage" <me>')
            elseif move == 'three' then
                send_command('input /ja "Sheep Song" <me>') end
        elseif pet.name == 'AttentiveIbuki' or pet.name == 'SwoopingZhivago' then
            if move == 'one' then
                send_command('input /ja "Swooping Frenzy" <me>')
            elseif move == 'two' then
                send_command('input /ja "Pentapeck" <me>')
            elseif move == 'three' then
                send_command('input /ja "Molting Plumage" <me>') end
        elseif pet.name == 'AmiableRoche' or pet.name == 'TurbidToloi' then
            if move == 'one' then
                send_command('input /ja "Recoil Dive" <me>')
            elseif move == 'two' then
                send_command('input /ja "Water Wall" <me>')
            elseif move == 'three' then
                send_command('input /ja "Intimidate" <me>') end
        elseif pet.name == 'BrainyWaluis' or pet.name == 'FunguarFamiliar' or pet.name == 'DiscreetLouise' then
            if move == 'one' then
                send_command('input /ja "Frogkick" <me>')
            elseif move == 'two' then
                send_command('input /ja "Spore" <me>')
            elseif move == 'three' then
                send_command('input /ja "Silence Gas" <me>') end               
        elseif pet.name == 'HeadbreakerKen' or pet.name == 'MayflyFamiliar' or pet.name == 'ShellbusterOrob' or pet.name == 'MailbusterCetas' then
            if move == 'one' then
                send_command('input /ja "Somersault" <me>')   
            elseif move == 'two' then
                send_command('input /ja "Cursed Sphere" <me>')
            elseif move == 'three' then
                send_command('input /ja "Venom" <me>') end                
        elseif pet.name == 'RedolentCandi' or pet.name == 'AlluringHoney' then
            if move == 'one' then
                send_command('input /ja "Tickling Tendrils" <me>')
            elseif move == 'two' then
                send_command('input /ja "Stink Bomb" <me>')
            elseif move == 'three' then
                send_command('input /ja "Nectarous Deluge" <me>') end
        elseif pet.name == 'CaringKiyomaro' or pet.name == 'VivaciousVickie' then
            if move == 'one' then
                send_command('input /ja "Sweeping Gouge" <me>')
            elseif move == 'two' or move == 'three' then
                send_command('input /ja "Zealous Snort" <me>') end
        elseif pet.name == 'HurlerPercival' or pet.name == 'BeetleFamiliar' or pet.name == 'PanzerGalahad' then
            if move == 'one' then
                send_command('input /ja "Power Attack" <me>')
            elseif move == 'two' then
                send_command('input /ja "Rhino Attack" <me>')
            elseif move == 'three' then
                send_command('input /ja "Hi-Freq Field" <me>') end
        elseif pet.name == 'BlackbeardRandy' or pet.name == 'TigerFamiliar' or pet.name == 'SaberSiravarde' or pet.name == 'GorefangHobs' then
            if move == 'one' then
                send_command('input /ja "Razor Fang" <me>')
            elseif move == 'two' then
                send_command('input /ja "Claw Cyclone" <me>')
            elseif move == 'three' then
                send_command('input /ja "Roar" <me>') end
        elseif pet.name == 'ColibriFamiliar' or pet.name == 'ChoralLeera' then
            if move == 'one' or move == 'two' or move == 'three' then
                send_command('input /ja "Pecking Flurry" <me>') end
        elseif pet.name == 'SpiderFamiliar' or pet.name == 'GussyHachirobe' then
            if move == 'one' then
                send_command('input /ja "Sickle Slash" <me>')
            elseif move == 'two' then
                send_command('input /ja "Acid Spray" <me>')
            elseif move == 'three' then
                send_command('input /ja "Spider Web" <me>') end
        elseif pet.name == 'GenerousArthur' or pet.name == 'GooeyGerard' then
            if move == 'one' then
                send_command('input /ja "Purulent Ooze" <me>')
            elseif move == 'two' or move == 'three' then
                send_command('input /ja "Corrosive Ooze" <me>') end
        elseif pet.name == 'ThreestarLynn' or pet.name == 'DipperYuly' then
            if move == 'one' then
                send_command('input /ja "Spiral Spin" <me>')
            elseif move == 'two' then
                send_command('input /ja "Sudden Lunge" <me>')
            elseif move == 'three' then
                send_command('input /ja "Noisome Powder" <me>') end
        elseif pet.name == 'SharpwitHermes' or pet.name == 'FlowerpotBill' or pet.name == 'FlowerpotBen' or pet.name == 'Homonculus' or pet.name == 'FlowerpotMerle' then
            if move == 'one' then
                send_command('input /ja "Head Butt" <me>')
            elseif move == 'two' then
                send_command('input /ja "Leaf Dagger" <me>')
            elseif move == 'three' then
                send_command('input /ja "Wild Oats" <me>') end
        elseif pet.name == 'AcuexFamiliar' or pet.name == 'FluffyBredo' then
            if move == 'one' then
                send_command('input /ja "Foul Waters" <me>')
            elseif move == 'two' or move == 'three' then
                send_command('input /ja "Pestilent Plume" <me>') end
        elseif pet.name == 'FlytrapFamiliar' or pet.name == 'VoraciousAudrey' or pet.name == 'PrestoJulio' then
            if move == 'one' then
                send_command('input /ja "Soporific" <me>')
            elseif move == 'two' then
                send_command('input /ja "Palsy Pollen" <me>')
            elseif move == 'three' then
                send_command('input /ja "Gloeosuccus" <me>') end
        elseif pet.name == 'EftFamiliar' or pet.name == 'AmbusherAllie' or pet.name == 'BugeyedBroncha' then
            if move == 'one' then
                send_command('input /ja "Nimble Snap" <me>')
            elseif move == 'two' then
                send_command('input /ja "Cyclotail" <me>')
            elseif move == 'three' then
                send_command('input /ja "Geist Wall" <me>') end
        elseif pet.name == 'AntlionFamiliar' or pet.name == 'ChopsueyChucky' then
            if move == 'one' then
                send_command('input /ja "Mandibular Bite" <me>')
            elseif move == 'two' then
                send_command('input /ja "Venom Spray" <me>')
            elseif move == 'three' then
                send_command('input /ja "Sandpit" <me>') end
        elseif pet.name == 'MiteFamiliar' or pet.name == 'LifedrinkerLars' then
            if move == 'one' then 
                send_command('input /ja "Double Claw" <me>')
            elseif move == 'two' then
                send_command('input /ja "Spinning Top" <me>')
            elseif move == 'three' then
                send_command('input /ja "Filamented Hold" <me>') end
        elseif pet.name == 'AmigoSabotender' then
            if move == 'one' then
                send_command('input /ja "Needleshot" <me>')
            elseif move == 'two' or move == 'three' then
                send_command('input /ja "??? Needles" <me>') end
        elseif pet.name == 'CraftyClyvonne' or pet.name == 'BloodclawShashra' then
            if move == 'one' then
                send_command('input /ja "Chaotic Eye" <me>')
            elseif move == 'two' then
                send_command('input /ja "Blaster" <me>')
            elseif move == 'three' then
                send_command('input /ja "Charged Whisker" <me>') end
        elseif pet.name == 'SwiftSieghard' then
            if move == 'one' then
                send_command('input /ja "Scythe Tail" <me>')
            elseif move == 'two' then
                send_command('input /ja "Ripper Fang" <me>')
            elseif move == 'three' then
                send_command('input /ja "Chomp Rush" <me>') end
        elseif pet.name == 'DapperMac' then
            if move == 'one' then
                send_command('input /ja "Beak Lunge" <me>')
            elseif move == 'two' or move == 'three' then
                send_command('input /ja "Wing Slap" <me>') end
        elseif pet.name == 'FatsoFargann' then
            if move == 'one' then
                send_command('input /ja "Suction" <me>')
            elseif move == 'two' then
                send_command('input /ja "Acid Mist" <me>')
            elseif move == 'three' then
                send_command('input /ja "Drain Kiss" <me>') end
        elseif pet.name == 'FaithfulFalcorr' then
            if move == 'one' then
                send_command('input /ja "Back Heel" <me>')
            elseif move == 'two' then
                send_command('input /ja "Choke Breath" <me>')
            elseif move == 'three' then
                send_command('input /ja "Fantod" <me>') end
        elseif pet.name == 'CrudeRaphie' then
            if move == 'one' then
                send_command('input /ja "Tortoise Stomp" <me>')   
            elseif move == 'two' then
                send_command('input /ja "Harden Shell" <me>')
            elseif move == 'three' then
                send_command('input /ja "Aqua Breath" <me>') end
    end 
end

-- Updates gear based on pet status changes.
function job_pet_status_change(newStatus, oldStatus, eventArgs)
        if newStatus == 'Idle' or newStatus == 'Engaged' then
                handle_equipping_gear(player.status)
        end
end 

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
    local msg = 'Melee'
    
    if state.CombatForm.has_value then
        msg = msg .. ' (' .. state.CombatForm.value .. ')'
    end
    
    msg = msg .. ': '
    
    msg = msg .. state.OffenseMode.value
    if state.HybridMode.value ~= 'Normal' then
        msg = msg .. '/' .. state.HybridMode.value
    end
    msg = msg .. ', WS: ' .. state.WeaponskillMode.value
    
    if state.DefenseMode.value ~= 'None' then
        msg = msg .. ', ' .. 'Defense: ' .. state.DefenseMode.value .. ' (' .. state[state.DefenseMode.value .. 'DefenseMode'].value .. ')'
    end
    
    if state.Kiting.value then
        msg = msg .. ', Kiting'
    end

    msg = msg .. ', Reward: '..state.RewardMode.value..', Corr.: '..state.CorrelationMode.value

    if state.JugMode.value ~= 'None' then
        add_to_chat(8,'--- Jug Pet: '.. state.JugMode.value ..' --- ('.. PetInfo ..', '.. PetJob ..')')
    end

    add_to_chat(28,'Ready Moves: 1.'.. ReadyMoveOne ..'  2.'.. ReadyMoveTwo ..'  3.'.. ReadyMoveThree ..'')
    add_to_chat(122, msg)

    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function get_combat_form()
    if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
                state.CombatForm:set('DW')
    else
        state.CombatForm:reset()
    end
end

function get_melee_groups()
        classes.CustomMeleeGroups:clear()

        if buffactive['Aftermath: Lv.3'] then
                classes.CustomMeleeGroups:append('Aftermath')
        end
end