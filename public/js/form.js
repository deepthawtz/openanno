function addAVP(atID) {
	var currentAT = parseInt(atID.substr(11),10);
	var avpIDlength = 10 + parseInt(currentAT.toString().length,10);
	var currentAVP = $('#' + atID + ' .nvpair:last').attr('id');
	var nextAVP = parseInt(currentAVP.substr(avpIDlength),10) + 1;	
	var AVPmarkup = '<tr id="t-' + currentAT + '-nvpair-' + nextAVP + '" class="nvpair"><td class="index">#' + nextAVP + '</td><td class="attribute"><input type="text" name="type[' + currentAT + '][names][]" class="obj_attribute" /></td><td class="value"><input type="text" name="type[' + currentAT + '][values][]" class="obj_value" /></td></tr>';
	$('#' + atID + ' .nvpair:last').after(AVPmarkup);
}
function addAT(atID) {
	var nextID = parseInt(atID.substr(11),10) + 1;
	var ATmarkup = '<fieldset id="annotation-' + nextID + '" class="annotation"><legend>Type &#035;' + nextID + '</legend><section><label for="type[' + nextID + '][id]">Type</label> <input type="text" name="type[' + nextID + '][id]" class="obj_type" /></section><fieldset><legend>Attribute-Value Pairs</legend><table><thead><tr><th class="index">Index</th><th class="attribute">Attribute</th><th class="value">Value</th></tr></thead><tfoot><tr><td colspan="3"><p class="buttonContain"><a href="#" class="addAVP button">Add New Attribute-Value Pair</a></p></td></tr></tfoot><tbody><tr id="t-' + nextID + '-nvpair-0" class="nvpair"><td class="index">#0</td><td class="attribute"><input type="text" name="type[' + nextID + '][names][]" class="obj_attribute" /></td><td class="value"><input type="text" name="type[' + nextID + '][values][]" class="obj_value" /></td></tr></tbody></table></fieldset></fieldset>';
	
	
	
	$('#' + atID).after(ATmarkup);
}

$(document).ready(function() {
	$('a.addAVP').live('click',function(){
		addAVP($(this).parents('.annotation').attr('id'));
		return false;
	});
	$('a.addAT').live('click',function(){
		addAT($('.annotation:last').attr('id'));
		return false;
	});
});