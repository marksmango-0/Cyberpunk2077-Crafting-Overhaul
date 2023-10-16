# Cyberpunk2077 Crafting Overhaul
An attempt to build an in-depth crafting system post 2.0



This adds intermediate crafting components and prevents some junk from being disassembled when it logically wouldn't be useful (looking at you, bloody bandages and vinyl records).


At its core, this mod replaces parts from disassembly with alternate intermediate parts. T1 weapons break down into Spare Common Components, hardware, and mechanical parts. Junk (that should break down) turns into mechanical (or electrical) and hardware.
The idea is to discourage hoarding/mass disassembling of every weapon you come across. With proper weight rebalancing, the idea of carrying around 100 useless components is less and less appealing. 
The next stage is to actually implement some other alternative crafting recipes - ammo disassembly will produce ammo parts that can be crafted, clothing _may_ produce fabric if I can find a use for that (I'm super tempted to re-add some form of light clothing mods).
It may expand from there, may not, kind of depends on how it actually feels to play.


5 (balance is likely to change) common parts + 1 mech part + 1 hardware turns into a single T1 component. Electrical components don't have a use for now-I may convert quickhacks like this, but I don't typically see enough quickhack components for it to matter.
This is the same ratio for each tier for now. 
Since there doesn't seem to be a way for one item to have two separate recipes, these overwrite the 5->1 tier upgrades. The solution is that the recipe is now 25->5, but a bundle is produced instead. Disassembling the bundle then returns the 5 components. 
I expect to expand the bundling to ammo when that time comes, so you'll be effectively disassembling 100 rounds at a time instead of trying to balance materials for each individual round. 


Current notes, TODO, issues:
* Clothing isn't really handled yet. The function overwrite I've done does automatically replace vanilla components with intermediate ones (so clothes will break down into spare components), but I'd like to either remove that entirely or find a proper use for them. I also just flat out forgot about those.
* Jewelry can be disassembled. Also just an oversight at the moment, but with their value (especially once my pricing rebalance is done), it probably isn't worth breaking them down into parts. 
* Hardware and mech parts are always awarded at the moment. I want to put some RNG on weapon disassembly to give more or less of them. Junk will always break down into exact parts.
* Hardware, mech/electrical parts, and maybe intermediate components will be sold at some vendors. Not hard to do, I just need to do it.
* Junk, etc. added by other mods won't have controlled disassembly. They will still produce intermediate parts, but until this is a bit more of a proper framework, those will need to likely be handled on my end unless the other mod developer removes those itemactions or adds the proper tagging. 




