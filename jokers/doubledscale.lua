
local joker = {
  name = "Doubled Scale",
  config = { 
  },
  pos = {x = 6, y = 9},
  rarity = 3,
  cost = 10,
  unlocked = true,
  discovered = true,
  blueprint_compat = false,
  eternal_compat = true,
  perishable_compat = true,
  loc_vars = function(self, info_queue, center)
    return {}
  end,
  calculate = function(self, card, context)
  end,
  calc_scaling = function(self, _self, card, initial, scalar_value, args)
    if args.operation == 'X' then
      return {
        override_scalar_value = { value = scalar_value * scalar_value }
      }
    else
      return {
        override_scalar_value = { value = scalar_value * 2 }
      }
    end
  end
}

return joker
