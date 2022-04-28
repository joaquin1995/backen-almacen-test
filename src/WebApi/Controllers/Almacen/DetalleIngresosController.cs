
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
    // [Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme)]
    [ApiController]
    public class DetalleIngresosController : ControllerBase
    {
        private readonly IDetalleIngresosService _detalleIngresosService;

        public DetalleIngresosController(IDetalleIngresosService detalleIngresosService)
        {
            _detalleIngresosService = detalleIngresosService;
        }

        // GET: api/DetalleIngresos
        [HttpGet]
        // [Authorize(Roles = Roles.Administrador)]
        public async Task<ActionResult> Get(string? valor, string? parametro, int numeroPagina, int cantidadMostrar)
        {
            var respuestaListado = await _detalleIngresosService.BuscarListado(valor, parametro, numeroPagina, cantidadMostrar);
            return Ok(respuestaListado);
        }

        // GET api/DetalleIngresos/5
        [HttpGet("{codigo}")]
        // [Authorize(Roles = Roles.Administrador)]
        public async Task<ActionResult> Get(long codigo)
        {
            var datos = await _detalleIngresosService.BuscarPorNumSec(codigo);
            var respuesta = new RespuestaCore()
            {
                status = Status.Success,
                response = datos
            };
            return Ok(respuesta);
        }

        // POST api/DetalleIngresos
        [HttpPost]
        // [Authorize(Roles = Roles.Administrador)]
        public async Task<ActionResult> Post([FromBody] DetalleIngresos detalleIngresos)
        {
            // string nsecUsuario = User!.FindFirst(ClaimTypes.Sid)!.Value;
            // detalleIngresos.nsec_usuario_registro = long.Parse(nsecUsuario);
            var respuestaBD = await _detalleIngresosService.Guardar(detalleIngresos);
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

        // PUT api/DetalleIngresos
        [HttpPut]
        // [Authorize(Roles = Roles.Administrador)]
        public async Task<ActionResult> Put([FromBody] DetalleIngresos detalleIngresos)
        {
            // string nsecUsuario = User!.FindFirst(ClaimTypes.Sid)!.Value;
            // detalleIngresos.nsec_usuario_registro = long.Parse(nsecUsuario);
            var respuestaBD = await _detalleIngresosService.Modificar(detalleIngresos);
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


        // DELETE api/DetalleIngresos/5
        [HttpDelete("{codigo}")]
        // [Authorize(Roles = Roles.Administrador)]
        public async Task<ActionResult> Delete(long codigo)
        {
            // string nsecUsuario = User!.FindFirst(ClaimTypes.Sid)!.Value;
            var detalleIngresos = await _detalleIngresosService.BuscarPorNumSec(codigo);
            // detalleIngresos.nsec_usuario_registro = long.Parse(nsecUsuario);
            var respuestaBD = await _detalleIngresosService.Eliminar(detalleIngresos);
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

