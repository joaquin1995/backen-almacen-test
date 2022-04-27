using Application.DTOs.Sgp;
using Application.Interfaces.Common;
using Domain.Models.Sgp;

namespace Application.Interfaces.IRepositories.Sgp
{
    public interface ISubsectorEconomicoRepository: IGenericRepository<SubsectorEconomico>
    {
        public Task<IEnumerable<SubsectorEconomicoDto>> BuscarListado(string? valor, string? parametro, int numeroPagina, int cantidadMostrar);
    }
}
