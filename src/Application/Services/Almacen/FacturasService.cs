using Application.DTOs.almacen;
using Application.Interfaces.IRepositories.almacen;
using Application.Interfaces.IServices.almacen;
using Application.Services.Common;
using Application.Utils;
using Domain.Models.Data;
using Domain.Models.almacen;

namespace Application.Services.almacen
{

    public class FacturasService : GenericService<Facturas>,  IFacturasService
    {
        private readonly IFacturasRepository _facturasRepository;

        public FacturasService(IFacturasRepository facturasRepository): base(facturasRepository)
        {
            _facturasRepository = facturasRepository;
        }

        public async Task<RespuestaListado<FacturasDto>> BuscarListado(string? valor, string? parametro, int numeroPagina, int cantidadMostrar)
        {
            var respuestaListado = new RespuestaListado<FacturasDto>(){
                response = await _facturasRepository.BuscarListado(valor, parametro, numeroPagina, cantidadMostrar),
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

