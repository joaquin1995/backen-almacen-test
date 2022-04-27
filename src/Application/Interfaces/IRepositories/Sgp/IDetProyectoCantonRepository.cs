using Application.DTOs.Sgp;
using Application.Interfaces.Common;
using Domain.Models.Sgp;

namespace Application.Interfaces.IRepositories.Sgp
{
    public interface IDetProyectoCantonRepository: IGenericRepository<DetProyectoCanton>
    {
        public Task<IEnumerable<DetProyectoCantonDto>> BuscarListado(string? valor, string? parametro, int numeroPagina, int cantidadMostrar);
    }
}
