console.log('hello from pack index recipe')

const submitButton = document.getElementById('submitSeachButton')
const inputSeach = document.getElementById('inputSeach')

inputSeach.setSelectionRange(1000,1000)

inputSeach.addEventListener('input', () => {
  submitButton.click();
  window.history.replaceState({}, null, "recipes?query=" + inputSeach.value);
})


