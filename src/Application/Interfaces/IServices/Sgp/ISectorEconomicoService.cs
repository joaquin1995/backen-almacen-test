using Application.DTOs.Sgp;
using Application.Interfaces.Common;
using Domain.Models.Data;
using Domain.Models.Sgp;

namespace Application.Interfaces.IServices.Sgp
{
    public interface ISectorEconomicoService : IGenericService<SectorEconomico>
    {
        public Task<RespuestaListado<SectorEconomicoDto>> BuscarListado(string? valor, string? parametro, int numeroPagina, int cantidadMostrar);
    }
}