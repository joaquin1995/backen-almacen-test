
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
    [Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme)]
    [ApiController]
    public class MarcasController : ControllerBase
    {
        private readonly IMarcasService _marcasService;

        public MarcasController(IMarcasService marcasService)
        {
            _marcasService = marcasService;
        }

        // GET: api/Marcas
        [HttpGet]
        [Authorize(Roles = Roles.Administrador)]
        public async Task<ActionResult> Get(string? valor, string? parametro, int numeroPagina, int cantidadMostrar)
        {
            var respuestaListado = await _marcasService.BuscarListado(valor, parametro, numeroPagina, cantidadMostrar);
            return Ok(respuestaListado);
        }

        // GET api/Marcas/5
        [HttpGet("{codigo}")]
        [Authorize(Roles = Roles.Administrador)]
        public async Task<ActionResult> Get(long codigo)
        {
            var datos = await _marcasService.BuscarPorNumSec(codigo);    
            var respuesta = new RespuestaCore()
            {
                status = Status.Success,
                response = datos
            };
            return Ok(respuesta);
        }

        // POST api/Marcas
        [HttpPost]
        [Authorize(Roles = Roles.Administrador)]
        public async Task<ActionResult> Post([FromBody] Marcas marcas)
        {
            string nsecUsuario = User!.FindFirst(ClaimTypes.Sid)!.Value;
            marcas.nsec_usuario_registro = long.Parse(nsecUsuario);
            var respuestaBD = await _marcasService.Guardar(marcas);
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

        // PUT api/Marcas
        [HttpPut]
        [Authorize(Roles = Roles.Administrador)]
        public async Task<ActionResult> Put([FromBody] Marcas marcas)
        {
            string nsecUsuario = User!.FindFirst(ClaimTypes.Sid)!.Value;
            marcas.nsec_usuario_registro = long.Parse(nsecUsuario);
            var respuestaBD = await _marcasService.Modificar(marcas);
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


        // DELETE api/Marcas/5
        [HttpDelete("{codigo}")]
        [Authorize(Roles = Roles.Administrador)]
        public async Task<ActionResult> Delete(long codigo)
        {
            string nsecUsuario = User!.FindFirst(ClaimTypes.Sid)!.Value;
            var marcas = await _marcasService.BuscarPorNumSec(codigo);
            marcas.nsec_usuario_registro = long.Parse(nsecUsuario);
            var respuestaBD = await _marcasService.Eliminar(marcas);
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

