using Application.DTOs.Sgp;
using Application.Interfaces.Common;
using Domain.Models.Sgp;

namespace Application.Interfaces.IRepositories.Sgp
{
    public interface IDetProyectoProvinciaRepository: IGenericRepository<DetProyectoProvincia>
    {
        public Task<IEnumerable<DetProyectoProvinciaDto>> BuscarListado(string? valor, string? parametro, int numeroPagina, int cantidadMostrar);
    }
}
