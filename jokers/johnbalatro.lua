local joker = {
  config = {
    extra = {
      loyalty = 1,
      uses = 1,
    }
  },
  pos = {x = 2, y=9},

  rarity = 3,
  cost = 10,
  unlocked = true,
  discovered = true,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  demicoloncompat = false,
  
  planeswalker = true,
  planeswalker_costs = { 1, -11 },
  
  pronouns = "she_her",
  
  loc_vars = function(self, info_queue, center)
    info_queue[#info_queue+1] = { key = "planeswalker_explainer", set="Other", specific_vars = { 1 } }
  end,
  calculate = function(self, card, context)
    if context.setting_blind and context.cardarea == G.jokers then
      card.ability.extra.uses = 1
      card.ability.extra.scoring = false
    end
  end,

  can_loyalty = function(card, idx)
    if card.ability.extra.uses <= 0 then return false end
    if idx == 1 then
      if #G.hand.highlighted ~= 5 then
        return false
      end
      for _, o_card in pairs(G.hand.highlighted) do
        if o_card.ability.perma_mult ~= 0 then
          return false
        end
      end
      return true
    elseif idx == 2 then
      return true
    end
    return false
  end,

  loyalty = function(card, idx)
    card.ability.extra.uses = card.ability.extra.uses - 1
    if idx == 1 then
      card.ability.extra.loyalty = card.ability.extra.loyalty + 1
      for i = 1, #G.hand.highlighted do
        o_card = G.hand.highlighted[i]
        o_card.ability.perma_mult = (o_card.ability.perma_mult or 0) + 4
        local percent = 0.85 + (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
        G.E_MANAGER:add_event(Event({
          trigger = 'after',
          delay = 0.15,
          func = function()
            play_sound('multhit1', percent, 0.6); G.hand.highlighted[i]
              :juice_up(
                0.3, 0.3); return true
          end
        }))
      end
    elseif idx == 2 then
      card.ability.extra.loyalty = card.ability.extra.loyalty - 11
      card:set_ability(G.P_CENTERS["j_mf_johnbalatrotrue"])
      play_sound("mf_treethree")
      card:juice_up()
      G.jokers:unhighlight_all()
    end
  end
}

return joker
