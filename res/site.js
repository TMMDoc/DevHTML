function sLoaded () {
  document.querySelectorAll('button.tree').forEach(btn => {
    if (btn.classList.contains ("open") || btn.classList.contains ("closed"))    
      btn.onclick = function(){ sNavToggle(this) };
  }); 
  document.onkeydown = function(evt) {
    evt || window.event;
    node = null;
    if (evt.key == "ArrowRight") node = document.querySelector (".pagination .next");
    if (evt.key == "ArrowLeft") node = document.querySelector (".pagination .prev");
    if (node != null) window.location = node.firstChild.getAttribute ("href");
  }
}

function sNavToggle (btn) {
  ul = btn;
  for (let i = 0; i < 10; i++) {
    ul = ul.nextSibling;
    if (ul.nodeName == "UL") break;
  }
  if (btn.classList.contains ("open")) {
    btn.classList.replace ("open", "closed");
    ul.classList.add ("hide");
  } else {
    btn.classList.replace ("closed", "open");
    ul.classList.remove ("hide");
  }  
}