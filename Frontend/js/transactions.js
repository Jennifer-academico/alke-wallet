$(document).ready(function() {

  var saldo = parseInt(localStorage.getItem('saldo')) || 60000;
  $('#saldo').text(saldo.toLocaleString('es-CL'));

  var movimientos = JSON.parse(localStorage.getItem('movimientos')) || [];

  function getTipoTexto(tipo) {
    if (tipo === 'deposito')      return 'Depósito';
    if (tipo === 'transferencia') return 'Transferencia enviada';
    if (tipo === 'compra')        return 'Compra';
    return tipo;
  }

  function mostrarMovimientos(filtro) {
    $('#lista').empty();

    var encontrados = 0;

    $.each(movimientos, function(i, t) {
      if (filtro === 'todos' || t.tipo === filtro) {
        $('#lista').append(
          '<li class="list-group-item ' + t.tipo + '">' +
            '<strong>' + getTipoTexto(t.tipo) + '</strong> — ' + t.descripcion +
            '<span class="float-end">$' + t.monto.toLocaleString('es-CL') + '</span>' +
          '</li>'
        );
        encontrados++;
      }
    });

    if (encontrados === 0) {
      $('#lista').append(
        '<li class="list-group-item">No hay movimientos de este tipo.</li>'
      );
    }
  }

  mostrarMovimientos('todos');

  $('#filtro').change(function() {
    mostrarMovimientos($(this).val());
  });

});