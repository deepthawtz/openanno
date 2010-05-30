function addAVP(atID) {
	var currentAT = parseInt(atID.substr(11),10);
	var avpIDlength = 10 + parseInt(currentAT.toString().length,10);
	var currentAVP = $('#' + atID + ' .nvpair:last').attr('id');
	var nextAVP = parseInt(currentAVP.substr(avpIDlength),10) + 1;
	var AVPmarkup = '<tr id="t-' + currentAT + '-nvpair-' + nextAVP + '" class="nvpair"><td>#' + nextAVP + '</td><td><input type="text" name="t-' + currentAT + '-attribute-' + nextAVP + '" class="tweet_attribute" /></td><td><input type="text" name="t-' + currentAT + '-value-' + nextAVP + '" class="tweet_value" /></td></tr>';
	$('#' + atID + ' .nvpair:last').after(AVPmarkup);
}
function addAT(atID) {
	var nextID = parseInt(atID.substr(11),10) + 1;
	var ATmarkup = '<fieldset id="annotation-' + nextID + '" class="annotation"><legend>Type &#035;' + nextID + '</legend><input type="text" name="t-' + nextID + '-type" class="tweet_type" /><table><thead><tr><th>Index</th><th>Attribute</th><th>Value</th></tr></thead><tfoot><tr><td colspan="3"><p><a href="#" class="addAVP">Add New Attribute-Value Pair</a></p></td></tr></tfoot><tbody><tr id="t-' + nextID + '-nvpair-1" class="nvpair"><td>#1</td><td><input type="text" name="t-' + nextID + '-attribute-1" class="tweet_attribute" /></td><td><input type="text" name="t-' + nextID + '-value-1" class="tweet_value" /></td></tr></tbody></table></fieldset>';
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