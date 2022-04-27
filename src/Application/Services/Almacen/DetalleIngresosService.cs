using Application.DTOs.almacen;
using Application.Interfaces.IRepositories.almacen;
using Application.Interfaces.IServices.almacen;
using Application.Services.Common;
using Application.Utils;
using Domain.Models.Data;
using Domain.Models.almacen;

namespace Application.Services.almacen
{

    public class DetalleIngresosService : GenericService<DetalleIngresos>,  IDetalleIngresosService
    {
        private readonly IDetalleIngresosRepository _detalleIngresosRepository;

        public DetalleIngresosService(IDetalleIngresosRepository detalleIngresosRepository): base(detalleIngresosRepository)
        {
            _detalleIngresosRepository = detalleIngresosRepository;
        }

        public async Task<RespuestaListado<DetalleIngresosDto>> BuscarListado(string? valor, string? parametro, int numeroPagina, int cantidadMostrar)
        {
            var respuestaListado = new RespuestaListado<DetalleIngresosDto>(){
                response = await _detalleIngresosRepository.BuscarListado(valor, parametro, numeroPagina, cantidadMostrar),
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

