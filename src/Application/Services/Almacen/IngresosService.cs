using Application.DTOs.almacen;
using Application.Interfaces.IRepositories.almacen;
using Application.Interfaces.IServices.almacen;
using Application.Services.Common;
using Application.Utils;
using Domain.Models.Data;
using Domain.Models.almacen;

namespace Application.Services.almacen
{

    public class IngresosService : GenericService<Ingresos>,  IIngresosService
    {
        private readonly IIngresosRepository _ingresosRepository;

        public IngresosService(IIngresosRepository ingresosRepository): base(ingresosRepository)
        {
            _ingresosRepository = ingresosRepository;
        }

        public async Task<RespuestaListado<IngresosDto>> BuscarListado(string? valor, string? parametro, int numeroPagina, int cantidadMostrar)
        {
            var respuestaListado = new RespuestaListado<IngresosDto>(){
                response = await _ingresosRepository.BuscarListado(valor, parametro, numeroPagina, cantidadMostrar),
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

