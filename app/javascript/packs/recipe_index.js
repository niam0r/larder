console.log('hello from pack index recipe')

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
       $('.cards').addClass('container-after-scroll')
    }
    else {
       $('nav').removeClass('fixed-header');
       $('.cards').removeClass('container-after-scroll')
    }
});

/* scrollTop() >= 240
   Should be equal the the height of the header
 */

