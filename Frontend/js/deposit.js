$(document).ready(function() {

  var saldo = parseInt(localStorage.getItem('saldo')) || 60000;
  $('#saldo').text(saldo.toLocaleString('es-CL'));

  $('#depositForm').submit(function(event) {
    event.preventDefault();

    var monto = parseInt($('#monto').val());

    if (isNaN(monto) || monto <= 0) {
      $('#alert-container').html(
        '<div class="alert alert-danger">Ingresa un monto válido.</div>'
      );
      return;
    }

    saldo += monto;
    localStorage.setItem('saldo', saldo);
  
    var movimientos = JSON.parse(localStorage.getItem('movimientos')) || [];
    movimientos.push({
      tipo: 'deposito',
      monto: monto,
      descripcion: 'Depósito realizado'
    });
    localStorage.setItem('movimientos', JSON.stringify(movimientos));

    $('#alert-container').html(
      '<div class="alert alert-success">Depósito de $' + monto.toLocaleString('es-CL') + ' realizado con éxito.</div>'
    );

    setTimeout(function() {
      window.location.href = 'menu.html';
    }, 2000);

  });

});