# Immediately
* The percent thing for salvage is wonky. Need to cull out lower percentages 
* Uncut gem ranges are wonky. Refactor for sure, mirroring progression from gear
* Waystones need a separate style from fragments
* Waytones ranges are wonky. Maybe mirror structure from gear (?)
* Rare waystones are worth showing until LENIENT cause need some for trash maps
* Flasks need additional progression past the best possible flasks. They drop too much.
* Check weapon mods for highest iLvl needed for best bases
* Change NORMAL to LENIENT (to avoid confusion with normal rarity)
* Add a `#.strict BASE .if Show` for progression drops in case any gear base is outside campaign range
* Change and update all styles
    https://www.poewiki.net/wiki/Guide:Item_filter_guide#Color_Options
    Match the beam colors from the game
        Normal, Magic, Rare and Uniques might need a primer for their font color to match the beams

# Later / Bugs
* The base types for pinnacle keys cannot be used for filtering
* Investigate why there is no `Meta Gems` item class
    * Manually filter through meta-gems (?)
* Filter and tier uniques
* Add mod tiering for items

# After formatting improvements are implemented on the generator
* Indent contents of `.choose` rules
* Merge the primers at the start of the Gems section