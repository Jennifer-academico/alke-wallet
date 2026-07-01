$(document).ready(function() {

  var saldo = localStorage.getItem('saldo') || 60000;
  $('#saldo').text(parseInt(saldo).toLocaleString('es-CL'));

  $('#btnDepositar').click(function() {
    $('#alert-container').html(
      '<div class="alert alert-info">Redirigiendo a Depositar...</div>'
    );
    setTimeout(function() {
      window.location.href = 'deposit.html';
    }, 1500);
  });

  $('#btnEnviar').click(function() {
    $('#alert-container').html(
      '<div class="alert alert-info">Redirigiendo a Enviar dinero...</div>'
    );
    setTimeout(function() {
      window.location.href = 'sendmoney.html';
    }, 1500);
  });

  $('#btnMovimientos').click(function() {
    $('#alert-container').html(
      '<div class="alert alert-info">Redirigiendo a Últimos movimientos...</div>'
    );
    setTimeout(function() {
      window.location.href = 'transactions.html';
    }, 1500);
  });

});