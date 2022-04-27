using Application.DTOs.Sgp;
using Application.Interfaces.Common;
using Domain.Models.Sgp;

namespace Application.Interfaces.IRepositories.Sgp
{
    public interface IDetProyectoDepartamentoRepository: IGenericRepository<DetProyectoDepartamento>
    {
        public Task<IEnumerable<DetProyectoDepartamentoDto>> BuscarListado(string? valor, string? parametro, int numeroPagina, int cantidadMostrar);
    }
}
