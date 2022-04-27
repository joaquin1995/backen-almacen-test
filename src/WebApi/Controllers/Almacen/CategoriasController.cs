
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
    public class CategoriasController : ControllerBase
    {
        private readonly ICategoriasService _categoriasService;

        public CategoriasController(ICategoriasService categoriasService)
        {
            _categoriasService = categoriasService;
        }

        // GET: api/Categorias
        [HttpGet]
        //[Authorize(Roles = Roles.Administrador)]
        public async Task<ActionResult> Get(string? valor, string? parametro, int numeroPagina, int cantidadMostrar)
        {
            var respuestaListado = await _categoriasService.BuscarListado(valor, parametro, numeroPagina, cantidadMostrar);
            return Ok(respuestaListado);
        }

        // GET api/Categorias/5
        [HttpGet("{codigo}")]
        //[Authorize(Roles = Roles.Administrador)]
        public async Task<ActionResult> Get(long codigo)
        {
            var datos = await _categoriasService.BuscarPorNumSec(codigo);    
            var respuesta = new RespuestaCore()
            {
                status = Status.Success,
                response = datos
            };
            return Ok(respuesta);
        }

        // POST api/Categorias
        [HttpPost]
        //[Authorize(Roles = Roles.Administrador)]
        public async Task<ActionResult> Post([FromBody] Categorias categorias)
        {
            //string nsecUsuario = User!.FindFirst(ClaimTypes.Sid)!.Value;
            //categorias.nsec_usuario_registro = long.Parse(nsecUsuario);
            var respuestaBD = await _categoriasService.Guardar(categorias);
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

        // PUT api/Categorias
        [HttpPut]
        //[Authorize(Roles = Roles.Administrador)]
        public async Task<ActionResult> Put([FromBody] Categorias categorias)
        {
            //string nsecUsuario = User!.FindFirst(ClaimTypes.Sid)!.Value;
            //categorias.nsec_usuario_registro = long.Parse(nsecUsuario);
            var respuestaBD = await _categoriasService.Modificar(categorias);
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


        // DELETE api/Categorias/5
        [HttpDelete("{codigo}")]
        //[Authorize(Roles = Roles.Administrador)]
        public async Task<ActionResult> Delete(long codigo)
        {
            //string nsecUsuario = User!.FindFirst(ClaimTypes.Sid)!.Value;
            var categorias = await _categoriasService.BuscarPorNumSec(codigo);
            //categorias.nsec_usuario_registro = long.Parse(nsecUsuario);
            var respuestaBD = await _categoriasService.Eliminar(categorias);
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

