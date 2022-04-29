
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
    public class ProductosController : ControllerBase
    {
        private readonly IProductosService _productosService;

        public ProductosController(IProductosService productosService)
        {
            _productosService = productosService;
        }

        // GET: api/Productos
        [HttpGet]
        // [Authorize(Roles = Roles.Administrador)]
        public async Task<ActionResult> Get(string? valor, string? parametro, int numeroPagina, int cantidadMostrar)
        {
            var respuestaListado = await _productosService.BuscarListado(valor, parametro, numeroPagina, cantidadMostrar);
            return Ok(respuestaListado);
        }

        // GET api/Productos/5
        [HttpGet("{codigo}")]
        // [Authorize(Roles = Roles.Administrador)]
        public async Task<ActionResult> Get(long codigo)
        {
            var datos = await _productosService.BuscarPorNumSec(codigo);
            var respuesta = new RespuestaCore()
            {
                status = Status.Success,
                response = datos
            };
            return Ok(respuesta);
        }

        // POST api/Productos
        [HttpPost]
        // [Authorize(Roles = Roles.Administrador)]
        public async Task<ActionResult> Post([FromBody] Productos productos)
        {
            // string nsecUsuario = User!.FindFirst(ClaimTypes.Sid)!.Value;
            // productos.nsec_usuario_registro = long.Parse(nsecUsuario);
            var respuestaBD = await _productosService.Guardar(productos);
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

        // PUT api/Productos
        [HttpPut]
        // [Authorize(Roles = Roles.Administrador)]
        public async Task<ActionResult> Put([FromBody] Productos productos)
        {
            // string nsecUsuario = User!.FindFirst(ClaimTypes.Sid)!.Value;
            // productos.nsec_usuario_registro = long.Parse(nsecUsuario);
            var respuestaBD = await _productosService.Modificar(productos);
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


        // DELETE api/Productos/5
        [HttpDelete("{codigo}")]
        // [Authorize(Roles = Roles.Administrador)]
        public async Task<ActionResult> Delete(long codigo)
        {
            // string nsecUsuario = User!.FindFirst(ClaimTypes.Sid)!.Value;
            var productos = await _productosService.BuscarPorNumSec(codigo);
            // productos.nsec_usuario_registro = long.Parse(nsecUsuario);
            var respuestaBD = await _productosService.Eliminar(productos);
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

