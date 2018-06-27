package classes.Items.Apparel 
{
	import classes.ItemSlotClass;
	import classes.GLOBAL;
	import classes.StringUtil;
	import classes.GameData.TooltipManager;
	
	/*
	 * @author Fenoxo
	 */
	public class Slavesuit extends ItemSlotClass
	{
		//Level 9 (Common). Balance 2.0
		public function Slavesuit() 
		{
			this._latestVersion = 1;
			
			this.quantity = 1;
			this.stackSize = 1;
			this.type = GLOBAL.CLOTHING;
			
			this.shortName = "Slave U.";
			
			this.longName = "slave uniform";
			
			TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
			
			this.description = "a slave uniform";
			
			this.tooltip = "This set of fantasy style armor seems to leave a lot of areas exposed. While it completely covers one’s arms and legs in fanciful fetish armor, it barely covers anywhere else. You recognize it is the heroine’s outfit from the ‘Perky Paladin’ series.\n\nThe chest piece - if it can be called that - resembles a metallic bra that pushes the breasts up and together, resulting in impressive cleavage. Sheer, see-through fabric hangs down from the bra and flares out in a rather stylish ‘negligee’ fashion.\n\nFurther down the nethers are protected only by a snug pair of armored underwear that barely covers the buttocks. Even more sheer fabric hangs from both the front and rear in an incredibly ornamental fashion, yet it fails to hide or protect anything at all.";
			
			TooltipManager.addTooltip(this.shortName, this.tooltip);
			
			this.attackVerb = "";
			
			this.basePrice = 7000;
			this.attack = 0;
			this.defense = 2;
			this.shieldDefense = 0;
			this.sexiness = 3;
			this.critBonus = 0;
			this.evasion = 10;
			this.fortification = 15;

			resistances.burning.resistanceValue = 20.0;
			resistances.corrosive.resistanceValue = 15.0;
			resistances.electric.resistanceValue = 30.0;
			resistances.freezing.resistanceValue = -30.0;
			resistances.tease.resistanceValue = -10.0;
			
			this.version = this._latestVersion;
		}
		
	}

}
