
using Application.Interfaces.IServices.almacen;
using Application.Utils;
using Domain.Models.Data;
using Domain.Models;
using Domain.Models.almacen;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System.Security.Claims;

namespace WebApi.Controllers.almacen
{
    [Route("api/[controller]")]
    //[Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme)]
    [ApiController]
    public class ClientesController : ControllerBase
    {
        private readonly IClientesService _clientesService;

        public ClientesController(IClientesService clientesService)
        {
            _clientesService = clientesService;
        }

        // GET: api/Clientes
        [HttpGet]
        //[Authorize(Roles = Roles.Administrador)]
        public async Task<ActionResult> Get(string? valor, string? parametro, int numeroPagina, int cantidadMostrar)
        {
            var respuestaListado = await _clientesService.BuscarListado(valor, parametro, numeroPagina, cantidadMostrar);
            return Ok(respuestaListado);
        }

        // GET api/Clientes/5
        [HttpGet("{codigo}")]
        //[Authorize(Roles = Roles.Administrador)]
        public async Task<ActionResult> Get(long codigo)
        {
            var datos = await _clientesService.BuscarPorNumSec(codigo);
            var respuesta = new RespuestaCore()
            {
                status = Status.Success,
                response = datos
            };
            return Ok(respuesta);
        }

        // POST api/Clientes
        [HttpPost]
        //[Authorize(Roles = Roles.Administrador)]
        public async Task<ActionResult> Post([FromBody] Clientes clientes)
        {
            // string nsecUsuario = User!.FindFirst(ClaimTypes.Sid)!.Value;
            // clientes.nsec_usuario_registro = long.Parse(nsecUsuario);
            var respuestaBD = await _clientesService.Guardar(clientes);
            if (respuestaBD.status == Status.Error)
            {
                var respuestaError = new RespuestaError()
                {
                    error = respuestaBD.status,
                    message = respuestaBD.response
                };
                return BadRequest(respuestaError);
            }
            return Ok(respuestaBD);
        }

        // PUT api/Clientes
        [HttpPut]
        //[Authorize(Roles = Roles.Administrador)]
        public async Task<ActionResult> Put([FromBody] Clientes clientes)
        {
            // string nsecUsuario = User!.FindFirst(ClaimTypes.Sid)!.Value;
            // clientes.nsec_usuario_registro = long.Parse(nsecUsuario);
            var respuestaBD = await _clientesService.Modificar(clientes);
            if (respuestaBD.status == Status.Error)
            {
                var respuestaError = new RespuestaError()
                {
                    error = respuestaBD.status,
                    message = respuestaBD.response
                };
                return BadRequest(respuestaError);
            }
            return Ok(respuestaBD);
        }


        // DELETE api/Clientes/5
        [HttpDelete("{codigo}")]
        //[Authorize(Roles = Roles.Administrador)]
        public async Task<ActionResult> Delete(long codigo)
        {
            // string nsecUsuario = User!.FindFirst(ClaimTypes.Sid)!.Value;
            var clientes = await _clientesService.BuscarPorNumSec(codigo);
            // clientes.nsec_usuario_registro = long.Parse(nsecUsuario);
            var respuestaBD = await _clientesService.Eliminar(clientes);
            if (respuestaBD.status == Status.Error)
            {
                var respuestaError = new RespuestaError()
                {
                    error = respuestaBD.status,
                    message = respuestaBD.response
                };
                return BadRequest(respuestaError);
            }
            return Ok(respuestaBD);
        }

    }
}

