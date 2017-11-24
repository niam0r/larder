let input = document.getElementById('home-input')
let submit = document.getElementById('home-submit')
input.addEventListener('input', () => {
  input.readOnly = true;
  submit.click();
})
