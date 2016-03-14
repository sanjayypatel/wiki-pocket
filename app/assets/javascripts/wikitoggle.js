$( function () {
	// Each toggle button needs click listener
	$('.wiki-toggle').on('click', function() {
		if($(this).next().hasClass('hidden')) {
			isHidden = false;
			$(this).next().removeClass('hidden');
			$(this).html('Hide');
		} else {
			isHidden = true;
			$(this).next().addClass('hidden');
			$(this).html('Show');
		}

	});
});