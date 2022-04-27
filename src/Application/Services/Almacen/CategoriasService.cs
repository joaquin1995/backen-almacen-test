using Application.DTOs.almacen;
using Application.Interfaces.IRepositories.almacen;
using Application.Interfaces.IServices.almacen;
using Application.Services.Common;
using Application.Utils;
using Domain.Models.Data;
using Domain.Models.almacen;

namespace Application.Services.almacen
{

    public class CategoriasService : GenericService<Categorias>,  ICategoriasService
    {
        private readonly ICategoriasRepository _categoriasRepository;

        public CategoriasService(ICategoriasRepository categoriasRepository): base(categoriasRepository)
        {
            _categoriasRepository = categoriasRepository;
        }

        public async Task<RespuestaListado<CategoriasDto>> BuscarListado(string? valor, string? parametro, int numeroPagina, int cantidadMostrar)
        {
            var respuestaListado = new RespuestaListado<CategoriasDto>(){
                response = await _categoriasRepository.BuscarListado(valor, parametro, numeroPagina, cantidadMostrar),
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

