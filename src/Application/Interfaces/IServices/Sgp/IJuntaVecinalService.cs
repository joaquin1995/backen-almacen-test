using Application.DTOs.Sgp;
using Application.Interfaces.Common;
using Domain.Models.Data;
using Domain.Models.Sgp;

namespace Application.Interfaces.IServices.Sgp
{
    public interface IJuntaVecinalService : IGenericService<JuntaVecinal>
    {
        public Task<RespuestaListado<JuntaVecinalDto>> BuscarListado(string? valor, string? parametro, int numeroPagina, int cantidadMostrar);
    }
}
