<?php 
require_once("lib/Libraries.php");
$output = array();
if(isset($_POST['tbl'])){
	switch($_POST['tbl']){
		case "land_acquistion_category":
			$land_acquistion_category = new landAcquisitionCategory();
			$output['data'] = $land_acquistion_category->findAll();
		break;
		case "land_acquistion_category_unit":
			$land_acquistion_category_unit = new landAcquisitionCategoryUnit();
			$output['data'] = $land_acquistion_category_unit->findAll();
		break;
		case "treecroptypes":
			$treecroptypes = new TreeCropTypes();
			$output['data'] = $treecroptypes->findAll();
		break;
		case "comments":
			$comments = new Comments();
			$output['data'] = $comments->findAll();
		break;
		case "districts":
			$districts = new Districts();
			$output['data'] = $districts->findAll();
		break;
		case "counties":
			$counties = new Counties();
			$output['data'] = $counties->findCounties();
		break;
		case "subcounties":
			$subcounties = new SubCounties();
			$output['data'] = $subcounties->findSubCounties();
		break;
		case "parishes":
			$parish = new Parish();
			$output['data'] = $parish->findParishes();
		break;case "villages":
			$villages = new Village();
			$output['data'] = $villages->findVillages();
		break;
		break;
		case "propertytypes":
			$propertytypes = new PropertyTypes();
			$output['data'] = $propertytypes->findAll();
		break;
		case "cropdescription":
			$cropdescription = new CropDescription();
			$output['data'] = $cropdescription->findAll();
		break;
		case "propertydescription":
			$propertydescription = new PropertyDescription();
			$output['data'] = $propertydescription->findAll();
		break;
		case "districtcroprate":
			$districtcroprate = new DistrictCropRate();
			$output['data'] = $districtcroprate->findDistrictCropRates();
		break;
		case "districtpropertyrate":
			$districtpropertyrate = new DistrictPropertyRate();
			$output['data'] = $districtpropertyrate->findDistrictPropertyRates();
		break;
		case "expense_type":
			$expense_type = new ExpenseTypes();
			$output['data'] = $expense_type->findAll();
		break;
		
		case "person_type":
			$person_type = new PersonType();
			$output['data'] = $person_type->findAll();
		break;
		case "account_type":
			$account_type = new AccountType();
			$output['data'] = $account_type->findAll();
		break;
		case "branch":
			$branch = new Branch();
			$output['data'] = $branch->findAll();
		break;
		case "access_level":
			$access_level = new AccessLevel();
			$output['data'] = $access_level->findAll();
		break;
		case "income_sources":
			$income_source = new IncomeSource();
			$output['data'] = $income_source->findAll();
		break;
		case "individual_types":
			$individual_type = new IndividualType();
			$output['data'] = $individual_type->findAll();
		break;
		case "loan_types":
			$loan_type = new LoanType();
			$output['data'] = $loan_type->findAll();
		break;
		case "penalty_calculations":
			$penalty_calculation = new PenaltyCalculationMethod();
			$output['data'] = $penalty_calculation->findAll();
		break;
		case "loan_product_penalties":
			$loan_product_penalties = new LoanProductsPenalties();
			$output['data'] = $loan_product_penalties->findLoanProductPenalties();
		break;
		case "relationship_types":
			$relation_type = new RelationshipType();
			$output['data'] = $relation_type->findAll();
		break;
		case "loan_repayment_durations":
			$loan_repayment_duration = new LoanRepaymentDuration();
			$output['data'] = $loan_repayment_duration->findAll();
		break;
		case "positions":
			$positions = new Position();
			$output['data'] = $positions->findPositionDetails();
		break;
		case "id_card_types":
			$id_card_type = new IdCardType();
			$output['data'] = $id_card_type->findAll();
		break;
		case "loan_product_types":
			$loan_product_type = new LoanProductType();
			$output['data'] = $loan_product_type->findAll();
		break;
		case "loan_product":
			$loan_product = new LoanProduct();
			$output['data'] = $loan_product->getDtData();
		break;
		case "deposit_product":
			$deposit_product = new DepositProduct();
			$output['data'] = $deposit_product->getDtData();
		break;
		case "security_types":
			$security_type = new SecurityType();
			$output['data'] = $security_type->findAll();
		break;
		default:
			echo "No data found!"; 
		break;
	}
	echo json_encode($output);
}
?>