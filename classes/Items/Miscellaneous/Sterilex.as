﻿package classes.Items.Miscellaneous
{
	import classes.Engine.Interfaces.*;
	import classes.Engine.Utility.indefiniteArticle;
	import classes.Engine.Utility.rand;
	import classes.Engine.Utility.num2Ordinal;
	import classes.ItemSlotClass;
	import classes.GLOBAL;
	import classes.Creature;
	import classes.kGAMECLASS;	
	import classes.Characters.PlayerCharacter;
	import classes.GameData.TooltipManager;
	import classes.StringUtil;
	
	public class Sterilex extends ItemSlotClass
	{
		//constructor
		public function Sterilex()
		{
			_latestVersion = 1;
			
			quantity = 1;
			stackSize = 10;
			type = GLOBAL.PILL;
			shortName = "Sterilex";
			longName = "Sterilex pill";
			
			TooltipManager.addFullName(shortName, StringUtil.toTitleCase(longName));
			
			description = "a pill labeled ‘Sterilex’";
			tooltip = "This is a colorfully-packaged box featuring some holovid sales girl.";
			if(!kGAMECLASS.silly) tooltip += " Equally colorful lettering informs you that this is a powerful one-use contraceptive which is guaranteed to prevent pregnancy without impacting sexual performance.";
			else tooltip += "\n\n<i>“Hi, Milly Bayes here with new Sterilex! Getting ready for an orgy? Making sure your night on the town doesn’t turn sour? Just not ready to start a family with that special someone? Well now J’ejune Pharmaceutical is there for you with Sterilex! Sterilex’s powerful fast-acting agents provide you with twenty-four full hours of protection for any and all of your sexual organs, with no long-term hazards to your fertility! Don’t rely on condoms or other pills! Get protection you can trust, with Sterilex!”</i>";
			tooltip += "\n\nBelow this, in much smaller text, is a warning informing you <b>not to take Sterilex more than once within twenty-four hours</b>. It also lists off a long string of minor potential side effects. Within the colorful packaging is a dull gray pill.";
			
			TooltipManager.addTooltip(shortName, tooltip);
			
			attackVerb = "";
			
			basePrice = 200;
			
			version = _latestVersion;
		}
		private function useDudEffect():void
		{
			kGAMECLASS.output("You gulp down the pill, feeling a throbbing sensation in your [pc.crotch]...");
			kGAMECLASS.output("\n\n... and nothing happens.");
			kGAMECLASS.output("\n\nWell that was a waste, now wasn't it?");
		}
		private function useAddDose(target:Creature):void
		{
			target.addStatusValue("Infertile", 1, 1);
			target.addStatusMinutes("Infertile", 1440);
		}
		private function sterilizeMale(target:Creature):void
		{
			target.createPerk("Firing Blanks", 0,0,0,0,"There’s no way you could get anyone or anything pregnant.");
		}
		private function sterilizeFemale(target:Creature):void
		{
			target.createPerk("Sterile", 0,0,0,0,"There’s no way anyone or anything could get you pregnant.");
		}
		//METHOD ACTING!
		override public function useFunction(target:Creature, usingCreature:Creature = null):Boolean
		{
			kGAMECLASS.clearOutput();
			author("Couch");
			kGAMECLASS.showName("\nSTERILEX");
			
			if(target is PlayerCharacter)
			{
				// Sexless get duds:
				if(!target.hasCock() && !target.hasVagina())
				{
					useDudEffect();
					return false;
				}
				
				// Pregnant get duds:
				else if(target.isPregnant())
				{
					kGAMECLASS.output("You gulp down the pill, feeling an uneasy sensation in your [pc.crotch]...");
					kGAMECLASS.output("\n\n... and then your [pc.belly]...");
					kGAMECLASS.output("\n\nAn extremely nauseating feeling suddenly hits you like a ton of steel bricks! You");
					if(target.RQ() <= 25) kGAMECLASS.output(" slowly");
					else if(target.RQ() <= 75) kGAMECLASS.output(" gradually");
					else kGAMECLASS.output(" quickly");
					kGAMECLASS.output(" manage to recover and fight the urge to gag and hurl");
					if(!kGAMECLASS.silly && target.bellyRating() >= 5) kGAMECLASS.output(" your innards");
					else if(kGAMECLASS.silly) kGAMECLASS.output(" a parabolic curve of stars and rainbows");
					kGAMECLASS.output("... You shake your head and wipe the sweat from your [pc.face]. Your microsurgeons work in overtime to fight the foreign substance as you take on a light fever momentarily.");
					
					target.HP(-5);
					target.energy(-20);
					
					kGAMECLASS.output("\n\nAfter your stomach settles and your fever subsides, your codex gives a few affirming beeps. You tap the screen and find that your body has rejected the drug due to your pending motherhood. Maybe it isn't such a good idea to take this stuff when you're already pregnant...");
					
					return false;
				}
				
				// Use as directed:
				else if(!target.hasStatusEffect("Infertile"))
				{
					kGAMECLASS.output("You gulp down the pill, feeling a humming sensation in");
					if(target.hasCock())kGAMECLASS.output(" your [pc.balls]");
					if(target.isHerm()) kGAMECLASS.output(" and");
					if(target.hasVagina()) kGAMECLASS.output(" your womb");
					kGAMECLASS.output(" as your body’s fertility is shut down completely.");
					if(target.hasTailCock()) kGAMECLASS.output(" Even your tailcock feels like it’s now shooting blanks.");
					else if(target.hasTailCunt()) kGAMECLASS.output(" Even your tailcunt feels like it’s gilded in protection.");
					
					target.createStatusEffect("Infertile",1,0,0,0, false, "Icon_DrugPill", "You are unable to make any pregnancies happen.", false, 1440);
					
					kGAMECLASS.output(" <b>You won’t be making any pregnancies happen for the rest of the day.</b>");
				}
				
				// Get a warning:
				else if(target.statusEffectv1("Infertile") <= 1)
				{
					// First use, but already Infertile somehow:
					if(target.statusEffectv1("Infertile") < 1) kGAMECLASS.output("Even though you are already infertile, you swallow the pill of Sterilex out of curiousity. You have a slight discomfort in your gut, but nothing really changes. Was that something worth taking at all?");
					// Second use:
					else kGAMECLASS.output("You ignore the directions and pop " + indefiniteArticle(num2Ordinal(target.statusEffectv1("Infertile") + 1)) + " Sterilex. The protection you feel restores itself, but you feel an odd discomfort in your gut. <b>Taking any more is probably a bad idea.</b>");
					
					useAddDose(target);
				}
				
				// Sterilize:
				else if(!target.hasPerk("Sterile") || !target.hasPerk("Firing Blanks"))
				{
					kGAMECLASS.output("You take your " + num2Ordinal(target.statusEffectv1("Infertile") + 1) + " Sterilex without waiting for the first to end, and immediately feel an unplugged sensation inside you. Even after the Sterilex wears off, you’re not going to");
					
					if(target.hasVagina())
					{
						if(target.hasCock() && rand(2) == 0) sterilizeMale(target);
						else sterilizeFemale(target);
					}
					else sterilizeMale(target);
					
					useAddDose(target);
					
					if(target.hasPerk("Sterile") && !target.hasPerk("Firing Blanks")) kGAMECLASS.output(" get");
					else kGAMECLASS.output(" be making anyone");
					kGAMECLASS.output(" pregnant any time soon. Thankfully, removing your genitals and then regrowing them should reset this... you think.");
					kGAMECLASS.output(" <b>You");
					
					if(target.hasPerk("Sterile") && target.hasPerk("Firing Blanks")) kGAMECLASS.output("’re now completely");
					else if(target.hasPerk("Sterile"))
					{
						kGAMECLASS.output("r womb");
						if(target.totalVaginas() > 1) kGAMECLASS.output("s are");
						else kGAMECLASS.output(" is");
						kGAMECLASS.output(" now");
					}
					else
					{
						kGAMECLASS.output("r [pc.balls]");
						if(target.balls > 1) kGAMECLASS.output(" are");
						else kGAMECLASS.output(" is");
						kGAMECLASS.output(" now");
					}
					
					kGAMECLASS.output(" sterile.</b>");
				}
				
				// Already too infertile:
				else
				{
					useDudEffect();
					return false;
				}
			}
			else
			{
				kGAMECLASS.output(target.capitalA + target.short + " takes the drug to no effect.");
			}
			return false;
		}
	}
}

