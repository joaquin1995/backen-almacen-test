using Application.DTOs.Sgp;
using Application.Interfaces.Common;
using Domain.Models.Sgp;

namespace Application.Interfaces.IRepositories.Sgp
{
    public interface IDetProyectoLocalidadRepository: IGenericRepository<DetProyectoLocalidad>
    {
        public Task<IEnumerable<DetProyectoLocalidadDto>> BuscarListado(string? valor, string? parametro, int numeroPagina, int cantidadMostrar);
    }
}
