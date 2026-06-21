$(document).ready(function() {

  $('#loginForm').submit(function(event) {
    event.preventDefault();

    var email = $('#email').val();
    var password = $('#password').val();

    if (email === 'admin@wallet.com' && password === '1234') {
      window.location.href = 'menu.html';
    } else {
      $('#alert-container').html(
        '<div class="alert alert-danger">Correo o contraseña incorrectos.</div>'
      );
    }
  });

});