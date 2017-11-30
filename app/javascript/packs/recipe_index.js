const submitButton = document.getElementById('submitSeachButton')
const inputSeach = document.getElementById('inputSeach')

inputSeach.setSelectionRange(1000,1000)

inputSeach.addEventListener('input', () => {
  submitButton.click();
  window.history.replaceState({}, null, "recipes?query=" + inputSeach.value);
})

$(window).scroll(function(){
  if ($(window).scrollTop() >= 426) {
     $('nav').addClass('fixed-header');
     $('.cards').addClass('container-after-scroll');
  }
  else {
     $('nav').removeClass('fixed-header');
     $('.cards').removeClass('container-after-scroll');
  }
});

// Hide Header on on scroll down
let didScroll;
let lastScrollTop = 0;
const delta = 5;
const footerHeight = $('footer').outerHeight();

$(window).scroll(function(event){
    didScroll = true;
});

setInterval(function() {
    if (didScroll) {
        hasScrolled();
        didScroll = false;
    }
}, 250);

function hasScrolled() {
    let st = $(this).scrollTop();

    // Make sure they scroll more than delta
    if(Math.abs(lastScrollTop - st) <= delta)
        return;

    // If they scrolled down and are past the navbar, add class .nav-up.
    // This is necessary so you never see what is "behind" the navbar.
    if (st > lastScrollTop && st > footerHeight){
        // Scroll Down
        $('#foot').addClass('hidden');
    } else {
        // Scroll Up
        if(st + $(window).height() < $(document).height()) {
            $('#foot').removeClass('hidden');
        }
    }

    lastScrollTop = st;
}


