//= require_tree .

// Make Shift+D toggle debug grid
document.onkeydown = function(e) {
    e = e || window.event
    var k = KeyCode;
    var handled = false;
    if(k.hot_key(k.translate_event(e)) === "Shift+D") {
        handled = true;
        document.querySelector('body').classList.toggle('debug');
    }
    if(handled && e.preventDefault) {
        e.preventDefault();
        return false;
    }
};
