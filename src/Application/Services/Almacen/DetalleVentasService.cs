using Application.DTOs.almacen;
using Application.Interfaces.IRepositories.almacen;
using Application.Interfaces.IServices.almacen;
using Application.Services.Common;
using Application.Utils;
using Domain.Models.Data;
using Domain.Models.almacen;

namespace Application.Services.almacen
{

    public class DetalleVentasService : GenericService<DetalleVentas>,  IDetalleVentasService
    {
        private readonly IDetalleVentasRepository _detalleVentasRepository;

        public DetalleVentasService(IDetalleVentasRepository detalleVentasRepository): base(detalleVentasRepository)
        {
            _detalleVentasRepository = detalleVentasRepository;
        }

        public async Task<RespuestaListado<DetalleVentasDto>> BuscarListado(string? valor, string? parametro, int numeroPagina, int cantidadMostrar)
        {
            var respuestaListado = new RespuestaListado<DetalleVentasDto>(){
                response = await _detalleVentasRepository.BuscarListado(valor, parametro, numeroPagina, cantidadMostrar),
                status = Status.Success
            };

            if (respuestaListado.response.Count() > 0)
            {
                int elementosTotales = respuestaListado.response.ElementAt(0).total;
                respuestaListado.total = elementosTotales;
            }

            return respuestaListado;
        }

    }

}

