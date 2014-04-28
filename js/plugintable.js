
$(document).ready(function() {

    var ready = false;
    var received = 0;
    var expecting = 0;
    
    var rdfStore = N3.Store();

    var parseRdf = function(data) {
	
	var parser = N3.Parser();
	parser.parse(data,
	             function (error, triple, prefixes) {
			 if (triple) {
			     rdfStore.addTriple(triple);
//			     $("#plugintable").append("<tr><td>" + triple.subject + "</td><td>" + triple.predicate + "</td><td>" + triple.object + "</td></tr>");
			 }
        		 if (triple) {
			     console.log(triple.subject, triple.predicate, triple.object, '.');
			 }
			 else {
			     console.log("# That's all, folks!", prefixes)
			 }
		     });
	received = received + 1;
	console.log("Received ", received, " of ", expecting);
    };
    
    var parseIndex = function(data) {
	lines = data.split("\n");
	expecting = lines.length;
	for (var i = 0; i < lines.length; i++) {
	    var base = lines[i].replace(new RegExp("^.*/"), "");
	    if (base === "" || base === lines[i]) {
		expecting = expecting - 1;
	    } else {
		$.get("rdf/plugins/" + base + ".n3", parseRdf, "text");
	    }
	}
    };

    $.get("rdf/plugins/index.txt", parseIndex, "text");
});


