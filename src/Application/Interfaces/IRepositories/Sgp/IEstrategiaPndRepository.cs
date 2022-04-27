using Application.DTOs.Sgp;
using Application.Interfaces.Common;
using Domain.Models.Sgp;

namespace Application.Interfaces.IRepositories.Sgp
{
    public interface IEstrategiaPndRepository: IGenericRepository<EstrategiaPnd>
    {
        public Task<IEnumerable<EstrategiaPndDto>> BuscarListado(string? valor, string? parametro, int numeroPagina, int cantidadMostrar);
    }
}
