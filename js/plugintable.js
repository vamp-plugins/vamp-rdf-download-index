
$(document).ready(function() {
    
    var rdfStore = N3.Store();

    var parseRdf = function(data) {
	
	var parser = N3.Parser();
	parser.parse(data,
	             function (error, triple, prefixes) {
			 if (triple) {
			     rdfStore.addTriple(triple);
			 }
/*
        		 if (triple) {
			     console.log(triple.subject, triple.predicate, triple.object, '.');
			 }
			 else {
			     console.log("# That's all, folks!", prefixes)
			 }
*/
		     });
    };
    
    var parseIndex = function(data) {
	lines = data.split("\n");
	for (var i = 0; i < lines.length; i++) {
	    var base = lines[i].replace(new RegExp("^.*/"), "");
	    if (base === "" || base === lines[i]) {
	    } else {
		$.get("rdf/plugins/" + base + ".n3", parseRdf, "text");
	    }
	}
    };

    $.get("rdf/plugins/index.txt", parseIndex, "text");
});


