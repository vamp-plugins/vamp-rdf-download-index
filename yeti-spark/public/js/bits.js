
function togglePlugin(id) {
    var e = document.getElementById('plugs-' + id);
    var b = document.getElementById('plugs-showhide-' + id);
    if (e.style.display == 'block') {
	e.style.display = 'none';
	b.innerHTML = '&#9654; More';
    } else {
	e.style.display = 'block';
	b.innerHTML = '&#9660; Less';
    }
}

