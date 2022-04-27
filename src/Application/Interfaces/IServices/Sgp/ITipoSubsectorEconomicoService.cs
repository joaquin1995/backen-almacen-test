using Application.DTOs.Sgp;
using Application.Interfaces.Common;
using Domain.Models.Data;
using Domain.Models.Sgp;

namespace Application.Interfaces.IServices.Sgp
{
    public interface ITipoSubsectorEconomicoService : IGenericService<TipoSubsectorEconomico>
    {
        public Task<RespuestaListado<TipoSubsectorEconomicoDto>> BuscarListado(string? valor, string? parametro, int numeroPagina, int cantidadMostrar);
    }
}
