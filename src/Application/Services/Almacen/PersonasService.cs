using Application.DTOs.almacen;
using Application.Interfaces.IRepositories.almacen;
using Application.Interfaces.IServices.almacen;
using Application.Services.Common;
using Application.Utils;
using Domain.Models.Data;
using Domain.Models.almacen;

namespace Application.Services.almacen
{

    public class PersonasService : GenericService<Personas>,  IPersonasService
    {
        private readonly IPersonasRepository _personasRepository;

        public PersonasService(IPersonasRepository personasRepository): base(personasRepository)
        {
            _personasRepository = personasRepository;
        }

        public async Task<RespuestaListado<PersonasDto>> BuscarListado(string? valor, string? parametro, int numeroPagina, int cantidadMostrar)
        {
            var respuestaListado = new RespuestaListado<PersonasDto>(){
                response = await _personasRepository.BuscarListado(valor, parametro, numeroPagina, cantidadMostrar),
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

