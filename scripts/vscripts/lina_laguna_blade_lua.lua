lina_laguna_blade_lua = class({})
LinkLuaModifier( "modifier_lina_laguna_blade_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------

function lina_laguna_blade_lua:CastFilterResultTarget( hTarget )
	if IsServer() then

		if hTarget ~= nil and hTarget:IsMagicImmune() and ( not self:GetCaster():HasScepter() ) then
			return UF_FAIL_MAGIC_IMMUNE_ENEMY
		end

		local nResult = UnitFilter( hTarget, self:GetAbilityTargetTeam(), self:GetAbilityTargetType(), self:GetAbilityTargetFlags(), self:GetCaster():GetTeamNumber() )
		return nResult
	end

	return UF_SUCCESS
end

--------------------------------------------------------------------------------

require("process_chat")
function lina_laguna_blade_lua:OnSpellStart()
	local hTarget = self:GetCursorTarget()
	StartAnimation(self:GetCaster(), {duration=20, activity=ACT_DOTA_CAST_ABILITY_4, rate=0.5})					
	if hTarget ~= nil then
		EmitSoundOn( "Ability.LagunaBladeImpact", hTarget )
		if not listening then test(self:GetCaster()) else spellbreak(self:GetCaster()) end
				
		local nFXIndex = ParticleManager:CreateParticle( "particles/units/heroes/hero_lina/lina_spell_laguna_blade.vpcf", PATTACH_CUSTOMORIGIN, nil );
		ParticleManager:SetParticleControlEnt( nFXIndex, 0, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_attack1", self:GetCaster():GetOrigin() + Vector( 0, 0, 96 ), true );
		ParticleManager:SetParticleControlEnt( nFXIndex, 1, hTarget, PATTACH_POINT_FOLLOW, "attach_hitloc", hTarget:GetOrigin(), true );
		ParticleManager:ReleaseParticleIndex( nFXIndex );
	end
end

function lina_laguna_blade_lua:OnChannelFinish(bInterrupted)
	check("")
end
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
