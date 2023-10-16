native func LogChannel( channel : CName, text : script_ref< String > );

@addMethod(CraftingSystem)
public final func GetDisassemblyMaterialRecord(quality: gamedataQuality, opt isQuickhack: Bool) -> ref<Item_Record> {
    let record: ref<Item_Record>;
    switch quality {
      case gamedataQuality.Common:
        record = TweakDBInterface.GetItemRecord(t"Items.IntermediateCrafting_Common");
        break;
      case gamedataQuality.Uncommon:
        if isQuickhack {
          record = TweakDBInterface.GetItemRecord(t"Items.QuickHackUncommonMaterial1");
        } else {
          record = TweakDBInterface.GetItemRecord(t"Items.IntermediateCrafting_Uncommon");
        };
        break;
      case gamedataQuality.Rare:
        if isQuickhack {
          record = TweakDBInterface.GetItemRecord(t"Items.QuickHackRareMaterial1");
        } else {
          record = TweakDBInterface.GetItemRecord(t"Items.IntermediateCrafting_Rare");
        };
        break;
      case gamedataQuality.Epic:
        if isQuickhack {
          record = TweakDBInterface.GetItemRecord(t"Items.QuickHackEpicMaterial1");
        } else {
          record = TweakDBInterface.GetItemRecord(t"Items.IntermediateCrafting_Epic");
        };
        break;
      case gamedataQuality.Legendary:
        if isQuickhack {
          record = TweakDBInterface.GetItemRecord(t"Items.QuickHackLegendaryMaterial1");
        } else {
          record = TweakDBInterface.GetItemRecord(t"Items.IntermediateCrafting_Legendary");
        };
        break;
      default:
        return record;
    };
    return record;
  }
  
@addMethod(CraftingSystem)
private final func ReplaceVanillaComponents(ingredientData: IngredientData) -> IngredientData {
  let transactionSystem: ref<TransactionSystem> = GameInstance.GetTransactionSystem(this.GetGameInstance());
  let itemRecord: wref<Item_Record> = ingredientData.id;
	if( Equals(ingredientData.id, TweakDBInterface.GetItemRecord(t"Items.CommonMaterial1"))){
		itemRecord = TweakDBInterface.GetItemRecord(t"IntermediateCrafting_Common");
	}
	else if (Equals(ingredientData.id, TweakDBInterface.GetItemRecord(t"Items.UncommonMaterial1"))){
		itemRecord = TweakDBInterface.GetItemRecord(t"IntermediateCrafting_Uncommon");
	}
	else if (Equals(ingredientData.id, TweakDBInterface.GetItemRecord(t"Items.RareMaterial1"))){
		itemRecord = TweakDBInterface.GetItemRecord(t"IntermediateCrafting_Rare");
	}
	else if (Equals(ingredientData.id, TweakDBInterface.GetItemRecord(t"Items.EpicMaterial1"))){
		itemRecord = TweakDBInterface.GetItemRecord(t"IntermediateCrafting_Epic");
	}
	else if (Equals(ingredientData.id, TweakDBInterface.GetItemRecord(t"Items.LegendaryMaterial1"))){
		itemRecord = TweakDBInterface.GetItemRecord(t"IntermediateCrafting_Legendary");
	}	

	let newIngredientData: IngredientData;
    newIngredientData.quantity = ingredientData.quantity;
    newIngredientData.baseQuantity = ingredientData.baseQuantity;
    newIngredientData.label = itemRecord.FriendlyName();
    newIngredientData.inventoryQuantity = transactionSystem.GetItemQuantityWithDuplicates(this.m_playerCraftBook.GetOwner(), ItemID.CreateQuery(itemRecord.GetID()));
    newIngredientData.id = itemRecord;
    newIngredientData.icon = itemRecord.IconPath();
    newIngredientData.iconGender = this.m_itemIconGender;


	return newIngredientData;
}

@addMethod(CraftingSystem)
public final func RollDisassemblyExtras(ingredientData: IngredientData) -> array<IngredientData> {
	
	let outputIngredients: array<IngredientData>;
	let transactionSystem: ref<TransactionSystem> = GameInstance.GetTransactionSystem(this.GetGameInstance());
	let originalItemRecord: wref<Item_Record> = ingredientData.id;
	let itemRecord: wref<Item_Record>; 
	let mechRolls: Int32 = 0;
	let mechTotals: Int32 = 0;
	let elecRolls: Int32 = 0;
	let elecTotals: Int32 = 0;
	let hardwareRolls: Int32 = 0;
	let hardwareTotals: Int32 = 0;
	if( Equals(ingredientData.id, TweakDBInterface.GetItemRecord(t"Items.IntermediateCrafting_Common"))){
		mechRolls+=1;
		hardwareRolls+=1;
	}
	else if (Equals(ingredientData.id, TweakDBInterface.GetItemRecord(t"Items.IntermediateCrafting_Uncommon"))){
		mechRolls += 2;
		hardwareRolls +=2;
	}
	else if (Equals(ingredientData.id, TweakDBInterface.GetItemRecord(t"Items.IntermediateCrafting_Rare"))){
		mechRolls += 2;
		hardwareRolls +=2;
	}
	else if (Equals(ingredientData.id, TweakDBInterface.GetItemRecord(t"Items.IntermediateCrafting_Epic"))){
		mechRolls += 3;
		hardwareRolls +=3;
	}
	else if (Equals(ingredientData.id, TweakDBInterface.GetItemRecord(t"Items.LegendaryMaterial1"))){
		mechRolls += 5;
		hardwareRolls +=5;
	}	
	
	while (mechRolls >0){
		if(RandRangeF(0.0,1.0) >= 0.5){
			mechTotals+=1;
		}
		mechRolls-=1;
	}
	if(mechTotals >0){
		itemRecord = TweakDBInterface.GetItemRecord(t"Items.IntermediateCrafting_Mechanical");
		let newIngredientData: IngredientData;
		newIngredientData.quantity = mechTotals;
		newIngredientData.baseQuantity = mechTotals;
		newIngredientData.label = itemRecord.FriendlyName();
		newIngredientData.inventoryQuantity = transactionSystem.GetItemQuantityWithDuplicates(this.m_playerCraftBook.GetOwner(), ItemID.CreateQuery(itemRecord.GetID()));
		newIngredientData.id = itemRecord;
		newIngredientData.icon = itemRecord.IconPath();
		newIngredientData.iconGender = this.m_itemIconGender;
		ArrayPush(outputIngredients, newIngredientData);
	}
	
	while (elecRolls >0){
		if(RandRangeF(0.0,1.0) >= 0.5){
			elecTotals+=1;
		}
		elecRolls-=1;
	}
	if(elecTotals >0){
		itemRecord = TweakDBInterface.GetItemRecord(t"Items.IntermediateCrafting_Electronic");
		let newIngredientData: IngredientData;
		newIngredientData.quantity = elecTotals;
		newIngredientData.baseQuantity = elecTotals;
		newIngredientData.label = itemRecord.FriendlyName();
		newIngredientData.inventoryQuantity = transactionSystem.GetItemQuantityWithDuplicates(this.m_playerCraftBook.GetOwner(), ItemID.CreateQuery(itemRecord.GetID()));
		newIngredientData.id = itemRecord;
		newIngredientData.icon = itemRecord.IconPath();
		newIngredientData.iconGender = this.m_itemIconGender;
		ArrayPush(outputIngredients, newIngredientData);
	}
   
	while (hardwareRolls >0){
		if(RandRangeF(0.0,1.0) >= 0.5){
			hardwareTotals+=1;
		}
		hardwareRolls-=1;
	}
	if(hardwareTotals >0){
		itemRecord = TweakDBInterface.GetItemRecord(t"Items.IntermediateCrafting_Hardware");
		let newIngredientData: IngredientData;
		newIngredientData.quantity = hardwareTotals;
		newIngredientData.baseQuantity = hardwareTotals;
		newIngredientData.label = itemRecord.FriendlyName();
		newIngredientData.inventoryQuantity = transactionSystem.GetItemQuantityWithDuplicates(this.m_playerCraftBook.GetOwner(), ItemID.CreateQuery(itemRecord.GetID()));
		newIngredientData.id = itemRecord;
		newIngredientData.icon = itemRecord.IconPath();
		newIngredientData.iconGender = this.m_itemIconGender;
		ArrayPush(outputIngredients, newIngredientData);
	}
	LogChannel(n"DEBUG", "bonus rolls -  mech: " + ToString(mechTotals) + " elec: " + ToString(elecTotals+ " hardware: " + ToString(hardwareTotals)));
	
	return outputIngredients;

}

@replaceMethod(CraftingSystem)
  public final const func GetDisassemblyResultItems(target: wref<GameObject>, itemID: ItemID, amount: Int32, restoredAttachments: script_ref<array<ItemAttachments>>, opt calledFromUI: Bool) -> array<IngredientData> {
    let i: Int32;
    let ingredients: array<wref<RecipeElement_Record>>;
    let itemBroken: Bool;
    let itemData: wref<gameItemData>;
    let itemPlus: Float;
    let itemQual: gamedataQuality;
    let newIngrData: IngredientData;
	let itemRecord = TweakDBInterface.GetItemRecord(ItemID.GetTDBID(itemID));
    let outResult: array<IngredientData>;
    let itemType: gamedataItemType = itemRecord.ItemType().Type();
    let itemCategory: gamedataItemCategory = TweakDBInterface.GetItemRecord(ItemID.GetTDBID(itemID)).ItemCategory().Type();
    let dissResult: wref<DisassemblingResult_Record> = TweakDBInterface.GetDisassemblingResultRecord(t"Crafting." + TDBID.Create(EnumValueToString("gamedataItemType", Cast<Int64>(EnumInt(itemType)))));
    let rollExtras: Bool = true;

	let itemTags: array<CName> = itemRecord.Tags();
	LogChannel(n"DEBUG", "tags count: " + ToString(ArraySize(itemTags)));
	LogChannel(n"DEBUG", "is dissresult real? : " + ToString(IsDefined(dissResult)));
	if (Equals(itemType, gamedataItemType.Gen_Junk) && (ArraySize(itemTags) >0)){
		LogChannel(n"DEBUG", s"has tags");
		if(ArrayContains(itemTags, n"MechanicalDisassembly")){
			dissResult = TweakDBInterface.GetDisassemblingResultRecord(t"Crafting.DisassemblingResult_Mechanical");
			LogChannel(n"DEBUG", s"mechanical disassembly");
		}
		else if(ArrayContains(itemTags, n"ElectronicDisassembly")){
			dissResult = TweakDBInterface.GetDisassemblingResultRecord(t"Crafting.DisassemblingResult_Electronic");
			LogChannel(n"DEBUG", s"electronic disassembly");
		}
		else if(ArrayContains(itemTags, n"HardwareDisassembly")){
			dissResult = TweakDBInterface.GetDisassemblingResultRecord(t"Crafting.DisassemblingResult_Hardware");
			LogChannel(n"DEBUG", s"hardware disassembly");
		}
		else if(ArrayContains(itemTags, n"UncommonComponentsBundle")){
			dissResult = TweakDBInterface.GetDisassemblingResultRecord(t"Crafting.DisassemblingResult_UncommonComponents");
		}
		else if(ArrayContains(itemTags, n"RareComponentsBundle")){
			dissResult = TweakDBInterface.GetDisassemblingResultRecord(t"Crafting.DisassemblingResult_RareComponents");
		}
		else if(ArrayContains(itemTags, n"EpicComponentsBundle")){
			dissResult = TweakDBInterface.GetDisassemblingResultRecord(t"Crafting.DisassemblingResult_EpicComponents");
		}
		else if(ArrayContains(itemTags, n"LegendaryComponentsBundle")){
			dissResult = TweakDBInterface.GetDisassemblingResultRecord(t"Crafting.DisassemblingResult_LegendaryComponents");
		}

		rollExtras = false;
	}

    if !IsDefined(dissResult) {
			dissResult = TweakDBInterface.GetDisassemblingResultRecord(t"Crafting.DisassemblingResult_Default");
    }
    dissResult.Ingredients(ingredients);
	LogChannel(n"DEBUG", "ingredients count: " + ToString(ArraySize(ingredients)));
    itemData = GameInstance.GetTransactionSystem(this.GetGameInstance()).GetItemData(target, itemID);
    itemQual = RPGManager.GetItemQuality(itemData);
    itemBroken = RPGManager.IsItemBroken(itemData);
    itemPlus = RPGManager.GetItemPlus(itemData);
	LogChannel(n"DEBUG", "ingredients count: " + ToString(ArraySize(ingredients)));
    if amount > 0 {
		LogChannel(n"DEBUG", "amount: " + ToString(amount));
      i = 0;
      while i < ArraySize(ingredients) {
		newIngrData = this.ReplaceVanillaComponents(this.CreateIngredientData(ingredients[i]));
        this.AddIngredientToResult(newIngrData, amount, outResult);
		if(rollExtras){
			for ingDat in this.RollDisassemblyExtras(newIngrData){
				this.AddIngredientToResult(ingDat, ingDat.quantity, outResult);
			}
		}
        i += 1;
      };
      itemQual = RPGManager.GetItemQuality(itemData);
	  
	  //these all seem to be bonuses based on quality and item type
	  //basic weapon
      if Equals(itemCategory, gamedataItemCategory.Weapon) && !itemBroken && itemPlus == 0.00 {
        if Equals(itemQual, gamedataQuality.Common) {
          newIngrData = this.CreateIngredientData(this.GetDisassemblyMaterialRecord(gamedataQuality.Common), 5);
          this.AddIngredientToResult(newIngrData, amount, outResult);
		  for ingDat in this.RollDisassemblyExtras(newIngrData){
			this.AddIngredientToResult(ingDat, ingDat.quantity, outResult);
			}
        };
        if Equals(itemQual, gamedataQuality.Uncommon) {
          newIngrData = this.CreateIngredientData(this.GetDisassemblyMaterialRecord(gamedataQuality.Uncommon), 5);
          this.AddIngredientToResult(newIngrData, amount, outResult);
		  for ingDat in this.RollDisassemblyExtras(newIngrData){
			this.AddIngredientToResult(ingDat, ingDat.quantity, outResult);
			}
        };
        if Equals(itemQual, gamedataQuality.Rare) {
          newIngrData = this.CreateIngredientData(this.GetDisassemblyMaterialRecord(gamedataQuality.Rare), 5);
          this.AddIngredientToResult(newIngrData, amount, outResult);
		  for ingDat in this.RollDisassemblyExtras(newIngrData){
			this.AddIngredientToResult(ingDat, ingDat.quantity, outResult);
			}
        };
        if Equals(itemQual, gamedataQuality.Epic) {
          newIngrData = this.CreateIngredientData(this.GetDisassemblyMaterialRecord(gamedataQuality.Epic), 5);
          this.AddIngredientToResult(newIngrData, amount, outResult);
		  for ingDat in this.RollDisassemblyExtras(newIngrData){
			this.AddIngredientToResult(ingDat, ingDat.quantity, outResult);
			}
        };
        if Equals(itemQual, gamedataQuality.Legendary) {
          newIngrData = this.CreateIngredientData(this.GetDisassemblyMaterialRecord(gamedataQuality.Legendary), 5);
          this.AddIngredientToResult(newIngrData, amount, outResult);
		  for ingDat in this.RollDisassemblyExtras(newIngrData){
			this.AddIngredientToResult(ingDat, ingDat.quantity, outResult);
			}
        };
      };
	  //not a program, not broken, idk what itemplus is, upgraded?
      if NotEquals(itemType, gamedataItemType.Prt_Program) && !itemBroken && itemPlus == 1.00 {
        if Equals(itemQual, gamedataQuality.Common) {
          newIngrData = this.CreateIngredientData(this.GetDisassemblyMaterialRecord(gamedataQuality.Common), 7);
          this.AddIngredientToResult(newIngrData, amount, outResult);
		  for ingDat in this.RollDisassemblyExtras(newIngrData){
			this.AddIngredientToResult(ingDat, ingDat.quantity, outResult);
			}
        };
        if Equals(itemQual, gamedataQuality.Uncommon) {
          newIngrData = this.CreateIngredientData(this.GetDisassemblyMaterialRecord(gamedataQuality.Uncommon), 7);
          this.AddIngredientToResult(newIngrData, amount, outResult);
		  for ingDat in this.RollDisassemblyExtras(newIngrData){
			this.AddIngredientToResult(ingDat, ingDat.quantity, outResult);
		}
        };
        if Equals(itemQual, gamedataQuality.Rare) {
          newIngrData = this.CreateIngredientData(this.GetDisassemblyMaterialRecord(gamedataQuality.Rare), 7);
          this.AddIngredientToResult(newIngrData, amount, outResult);
		  for ingDat in this.RollDisassemblyExtras(newIngrData){
			this.AddIngredientToResult(ingDat, ingDat.quantity, outResult);
		}
        };
        if Equals(itemQual, gamedataQuality.Epic) {
          newIngrData = this.CreateIngredientData(this.GetDisassemblyMaterialRecord(gamedataQuality.Epic), 7);
          this.AddIngredientToResult(newIngrData, amount, outResult);
		  for ingDat in this.RollDisassemblyExtras(newIngrData){
			this.AddIngredientToResult(ingDat, ingDat.quantity, outResult);
		}
        };
        if Equals(itemQual, gamedataQuality.Legendary) {
          newIngrData = this.CreateIngredientData(this.GetDisassemblyMaterialRecord(gamedataQuality.Legendary), 7);
          this.AddIngredientToResult(newIngrData, amount, outResult);
		  for ingDat in this.RollDisassemblyExtras(newIngrData){
			this.AddIngredientToResult(ingDat, ingDat.quantity, outResult);
		}
        };
      };
	  //not a program, 2++
      if NotEquals(itemType, gamedataItemType.Prt_Program) && !itemBroken && itemPlus == 2.00 {
        if Equals(itemQual, gamedataQuality.Legendary) {
          newIngrData = this.CreateIngredientData(this.GetDisassemblyMaterialRecord(gamedataQuality.Legendary), 15);
          this.AddIngredientToResult(newIngrData, amount, outResult);
		  for ingDat in this.RollDisassemblyExtras(newIngrData){
			this.AddIngredientToResult(ingDat, ingDat.quantity, outResult);
		}
        };
      };
	  //broken item
      if itemBroken {
        if Equals(itemQual, gamedataQuality.Common) {
          newIngrData = this.CreateIngredientData(this.GetDisassemblyMaterialRecord(gamedataQuality.Common), 1);
          this.AddIngredientToResult(newIngrData, amount, outResult);
		  for ingDat in this.RollDisassemblyExtras(newIngrData){
			this.AddIngredientToResult(ingDat, ingDat.quantity, outResult);
		}
        };
      };

	  //not a weapon or program or junk(attachments I guess?)
      if NotEquals(itemCategory, gamedataItemCategory.Weapon) && NotEquals(itemType, gamedataItemType.Prt_Program) && NotEquals(itemType, gamedataItemType.Gen_Junk) {
        if Equals(itemQual, gamedataQuality.Common) {
          newIngrData = this.CreateIngredientData(this.GetDisassemblyMaterialRecord(gamedataQuality.Common), 1);
          this.AddIngredientToResult(newIngrData, amount, outResult);
		  for ingDat in this.RollDisassemblyExtras(newIngrData){
			this.AddIngredientToResult(ingDat, ingDat.quantity, outResult);
		}
        };
        if Equals(itemQual, gamedataQuality.Uncommon) {
          newIngrData = this.CreateIngredientData(this.GetDisassemblyMaterialRecord(gamedataQuality.Uncommon), 1);
          this.AddIngredientToResult(newIngrData, amount, outResult);
		  for ingDat in this.RollDisassemblyExtras(newIngrData){
			this.AddIngredientToResult(ingDat, ingDat.quantity, outResult);
		}
        };
        if Equals(itemQual, gamedataQuality.Rare) {
          newIngrData = this.CreateIngredientData(this.GetDisassemblyMaterialRecord(gamedataQuality.Rare), 1);
          this.AddIngredientToResult(newIngrData, amount, outResult);
		  for ingDat in this.RollDisassemblyExtras(newIngrData){
			this.AddIngredientToResult(ingDat, ingDat.quantity, outResult);
		}
        };
        if Equals(itemQual, gamedataQuality.Epic) {
          newIngrData = this.CreateIngredientData(this.GetDisassemblyMaterialRecord(gamedataQuality.Epic), 1);
          this.AddIngredientToResult(newIngrData, amount, outResult);
		  for ingDat in this.RollDisassemblyExtras(newIngrData){
			this.AddIngredientToResult(ingDat, ingDat.quantity, outResult);
		}
        };
        if Equals(itemQual, gamedataQuality.Legendary) {
          newIngrData = this.CreateIngredientData(this.GetDisassemblyMaterialRecord(gamedataQuality.Legendary), 1);
          this.AddIngredientToResult(newIngrData, amount, outResult);
		  for ingDat in this.RollDisassemblyExtras(newIngrData){
			this.AddIngredientToResult(ingDat, ingDat.quantity, outResult);
		}
        };
      };
	  //is a program
      if Equals(itemType, gamedataItemType.Prt_Program) && itemPlus == 0.00 {
        if Equals(itemQual, gamedataQuality.Common) {
          newIngrData = this.CreateIngredientData(this.GetDisassemblyMaterialRecord(gamedataQuality.Uncommon, true), 1);
          this.AddIngredientToResult(newIngrData, amount, outResult);
		  for ingDat in this.RollDisassemblyExtras(newIngrData){
			this.AddIngredientToResult(ingDat, ingDat.quantity, outResult);
		}
        };
        if Equals(itemQual, gamedataQuality.Uncommon) {
          newIngrData = this.CreateIngredientData(this.GetDisassemblyMaterialRecord(gamedataQuality.Uncommon, true), 7);
          this.AddIngredientToResult(newIngrData, amount, outResult);
		  for ingDat in this.RollDisassemblyExtras(newIngrData){
			this.AddIngredientToResult(ingDat, ingDat.quantity, outResult);
		}
        };
        if Equals(itemQual, gamedataQuality.Rare) {
          newIngrData = this.CreateIngredientData(this.GetDisassemblyMaterialRecord(gamedataQuality.Rare, true), 6);
          this.AddIngredientToResult(newIngrData, amount, outResult);
		  for ingDat in this.RollDisassemblyExtras(newIngrData){
			this.AddIngredientToResult(ingDat, ingDat.quantity, outResult);
		}
        };
        if Equals(itemQual, gamedataQuality.Epic) {
          newIngrData = this.CreateIngredientData(this.GetDisassemblyMaterialRecord(gamedataQuality.Epic, true), 5);
          this.AddIngredientToResult(newIngrData, amount, outResult);
		  for ingDat in this.RollDisassemblyExtras(newIngrData){
			this.AddIngredientToResult(ingDat, ingDat.quantity, outResult);
		}
        };
        if Equals(itemQual, gamedataQuality.Legendary) {
          newIngrData = this.CreateIngredientData(this.GetDisassemblyMaterialRecord(gamedataQuality.Legendary, true), 3);
          this.AddIngredientToResult(newIngrData, amount, outResult);
		  for ingDat in this.RollDisassemblyExtras(newIngrData){
			this.AddIngredientToResult(ingDat, ingDat.quantity, outResult);
		}
        };
      };
      if Equals(itemType, gamedataItemType.Prt_Program) && itemPlus == 2.00 {
        if Equals(itemQual, gamedataQuality.Legendary) {
          newIngrData = this.CreateIngredientData(this.GetDisassemblyMaterialRecord(gamedataQuality.Legendary, true), 20);
          this.AddIngredientToResult(newIngrData, amount, outResult);
		  for ingDat in this.RollDisassemblyExtras(newIngrData){
			this.AddIngredientToResult(ingDat, ingDat.quantity, outResult);
		}
        };
      };
	  if Equals(itemType, gamedataItemType.Gen_Junk) {

		
	  }
      this.ProcessDisassemblingPerks(amount, outResult, itemData, restoredAttachments, calledFromUI);
    };
	  
    return outResult;
  }