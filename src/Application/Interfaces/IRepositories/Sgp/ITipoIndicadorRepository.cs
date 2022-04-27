using Application.DTOs.Sgp;
using Application.Interfaces.Common;
using Domain.Models.Sgp;

namespace Application.Interfaces.IRepositories.Sgp
{
    public interface ITipoIndicadorRepository: IGenericRepository<TipoIndicador>
    {
        public Task<IEnumerable<TipoIndicadorDto>> BuscarListado(string? valor, string? parametro, int numeroPagina, int cantidadMostrar);
    }
}
