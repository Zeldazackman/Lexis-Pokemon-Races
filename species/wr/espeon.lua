-- these are just the names of the variables internally and how they're used on the creation screen, do whatever you want with them here!
-- but probably put name species and gender as the ones supplied, thats probably a good idea
-- I've supplied the bare minimum as a template here, do with it what you will
local function wrap(index, length, secondary, secondaryLength)
	if not index then
		index = math.floor(wrap(secondary, secondaryLength * length) / secondaryLength)
	end
	return math.abs(index) % length
end
function create(name, species, genderIndex, primaryColor, hairStyle, secondaryColor, facialHairStyle, markingsColor, markingsPattern, eyeColorChoice, _8, personality, bellyColor, hairColor, eyeColor, gemColor, ...)
	 -- these values are zero indexed!

	local speciesConfig = root.speciesConfig(species)
	local humanoidConfig = sb.jsonMerge(root.assetJson(speciesConfig.humanoidConfig or "/humanoid.config"), speciesConfig.humanoidOverrides or {})


	genderIndex = wrap(genderIndex, #speciesConfig.genders)
	local gender = speciesConfig.genders[genderIndex + 1]

	local hairGroup = gender.hairGroup or speciesConfig.hairGroup or "hair"
	local hairOptions = gender[hairGroup.."Style"] or speciesConfig[hairGroup.."Style"]

	local facialHairGroup = gender.facialHairGroup or speciesConfig.facialHairGroup or "mane"
	local facialHairOptions = gender[facialHairGroup.."Style"] or speciesConfig[facialHairGroup.."Style"]


	primaryColor = wrap(primaryColor, #speciesConfig.primaryColor)
	secondaryColor = wrap(secondaryColor, #speciesConfig.secondaryColor)
	eyeColor = wrap(eyeColor or eyeColorChoice, #speciesConfig.eyeColor)
	gemColor = wrap(gemColor, #speciesConfig.gemColor, eyeColorChoice, #speciesConfig.eyeColor)
	markingsColor = wrap(markingsColor, #speciesConfig.markingsColor)


	hairStyle = wrap(hairStyle, #hairOptions)
	facialHairStyle = wrap(facialHairStyle, #facialHairOptions)
	bellyColor = wrap(bellyColor or markingsPattern, #speciesConfig.bellyColor)
	hairColor = wrap(hairColor, #speciesConfig.hairColor, markingsPattern, #speciesConfig.bellyColor)


	personality = wrap(personality, #humanoidConfig.personalities)

	local directives = ""

	directives = directives .. (speciesConfig.bellyColor[bellyColor + 1])
	directives = directives .. (speciesConfig.hairColor[hairColor + 1])
	directives = directives .. (speciesConfig.markingsColor[markingsColor + 1])
	directives = directives .. (speciesConfig.primaryColor[primaryColor + 1])
	directives = directives .. (speciesConfig.secondaryColor[secondaryColor + 1])
	directives = directives .. (speciesConfig.eyeColor[eyeColor + 1])
	directives = directives .. (speciesConfig.gemColor[gemColor + 1])


	local personalityIdle, personalityArmIdle, personalityHeadOffset, personalityArmOffset = table.unpack(humanoidConfig.personalities[personality+1])

	local identity = {
		name = name,
		species = species,
		gender = gender.name,
		hairGroup = hairGroup,
		hairType = hairOptions[hairStyle+1],
		hairDirectives = directives,
		bodyDirectives = directives,
		emoteDirectives = directives,
		facialHairGroup = facialHairGroup,
		facialHairType = facialHairOptions[facialHairStyle+1],
		facialHairDirectives = directives,
		facialMaskGroup = "",
		facialMaskType = "",
		facialMaskDirectives = directives,
		personalityIdle = personalityIdle,
		personalityArmIdle = personalityArmIdle,
		personalityHeadOffset = personalityHeadOffset,
		personalityArmOffset = personalityArmOffset,
		color = {51, 117, 237, 255},
	}
	local parameters = {
		choices = { genderIndex, primaryColor, hairStyle, secondaryColor, facialHairStyle, markingsColor, markingsPattern, eyeColorChoice, _8, personality, ... },
		--this you can do a lot with, see the humanoid build script
	}
	local armor = {
		head = nil,
		chest = nil,
		legs = nil,
		back = nil,
		headCosmetic = nil,
		chestCosmetic = nil,
		legsCosmetic = nil,
		backCosmetic = nil,
		cosmetic1 = nil,
		cosmetic2 = nil,
		cosmetic3 = nil,
		cosmetic4 = nil,
		cosmetic5 = nil,
		cosmetic6 = nil,
		cosmetic7 = nil,
		cosmetic8 = nil,
		cosmetic9 = nil,
		cosmetic10 = nil,
		cosmetic11 = nil,
		cosmetic12 = nil,
	}
	return identity, parameters, armor
end
