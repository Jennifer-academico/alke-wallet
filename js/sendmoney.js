$(document).ready(function() {

  var saldo = parseInt(localStorage.getItem('saldo')) || 60000;
  $('#saldo').text(saldo.toLocaleString('es-CL'));
 
  var contactos = JSON.parse(localStorage.getItem('contactos')) || [];

  function renderizarContactos() {
    $('#contactList').empty();
    contactos.forEach(function(c) {
      $('#contactList').append(
        '<li class="list-group-item">' + c.nombre + ' — ' + c.banco + ' (' + c.alias + ')</li>'
      );
    });
  }

  renderizarContactos();

  $('#btnAgregarContacto').click(function() {
    $('#formContacto').show();
  });

  $('#btnCancelar').click(function() {
    $('#formContacto').hide();
    $('#formContacto')[0].reset();
    $('#alert-container').html('');
  });

  $('#formContacto').submit(function(event) {
    event.preventDefault();

    var nombre = $('#nombre').val().trim();
    var cuenta = $('#cta').val().trim();
    var alias = $('#alias').val().trim();
    var banco = $('#banco').val().trim();

    if (!nombre || !cuenta || !alias || !banco) {
      $('#alert-container').html(
        '<div class="alert alert-danger">Todos los campos son obligatorios.</div>'
      );
      return;
    }

    if (cuenta.length < 6 || isNaN(cuenta)) {
      $('#alert-container').html(
        '<div class="alert alert-danger">El número de cuenta debe ser numérico y tener al menos 6 dígitos.</div>'
      );
      return;
    }

    contactos.push({ nombre: nombre, cuenta: cuenta, alias: alias, banco: banco });
    localStorage.setItem('contactos', JSON.stringify(contactos));

    renderizarContactos();

    $('#alert-container').html(
      '<div class="alert alert-success">Contacto agregado correctamente.</div>'
    );

    $('#formContacto').hide();
    $('#formContacto')[0].reset();

  });

  $('#buscar').on('input', function() {
    var texto = $(this).val().toLowerCase();
    $('#contactList li').each(function() {
      var contenido = $(this).text().toLowerCase();
      $(this).toggle(contenido.includes(texto));
    });
  });

  $('#contactList').on('click', 'li', function() {
    $('#contactList li').removeClass('active');
    $(this).addClass('active');
    $('#campoMonto').show();
    $('#btnEnviarDinero').show();
  });

  $('#btnEnviarDinero').click(function() {
    var contacto = $('#contactList li.active').text();
    var monto = parseInt($('#montoEnvio').val());

    if (isNaN(monto) || monto <= 0) {
      $('#alert-container').html(
        '<div class="alert alert-danger">Ingresa un monto válido.</div>'
      );
      return;
    }

    if (monto > saldo) {
      $('#alert-container').html(
        '<div class="alert alert-danger">Saldo insuficiente.</div>'
      );
      return;
    }

    saldo -= monto;
    localStorage.setItem('saldo', saldo);

    var movimientos = JSON.parse(localStorage.getItem('movimientos')) || [];
    movimientos.push({
      tipo: 'transferencia',
      monto: monto,
      descripcion: 'Envío a ' + contacto
    });
    localStorage.setItem('movimientos', JSON.stringify(movimientos));

    $('#alert-container').html(
      '<div class="alert alert-success">Enviaste $' + monto.toLocaleString('es-CL') + ' a ' + contacto + '</div>'
    );

    $('#contactList li').removeClass('active');
    $('#campoMonto').hide();
    $('#btnEnviarDinero').hide();
    $('#montoEnvio').val('');

  });

});