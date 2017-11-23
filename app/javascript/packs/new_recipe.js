import $ from 'jquery';
import 'select2';

$('.ingredient-dropdown').select2({
  tags: true
});

// DOES NOT WORK - DOES IF YOU ATTACH MANUALLY
// $('#cocoon-container').on('cocoon:after-insert', function(e, insertedItem) {
//   console.log('COCOON EVENT TRIGGERED')
//   console.log(insertedItem)
//   $('.ingredient-dropdown').select2({});
// })

// $('#new_recipe').on('cocoon:after-insert', function(e, insertedItem) {
//   console.log('COCOON EVENT TRIGGERED')
//   console.log(insertedItem)
// })

// $('.new_recipe').on('cocoon:before-insert', function(e, insertedItem) {
//   console.log('COCOON EVENT TRIGGERED')
//   console.log(insertedItem)
// })

var count = $('.nested-fields').length
setInterval(function() {
  if (count !== $('.nested-fields').length) {
    $('.ingredient-dropdown').select2({
      tags: true
    });
    count = $('.nested-fields').length
  }
}, 300)
