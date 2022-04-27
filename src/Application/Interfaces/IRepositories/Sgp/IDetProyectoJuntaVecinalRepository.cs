using Application.DTOs.Sgp;
using Application.Interfaces.Common;
using Domain.Models.Sgp;

namespace Application.Interfaces.IRepositories.Sgp
{
    public interface IDetProyectoJuntaVecinalRepository: IGenericRepository<DetProyectoJuntaVecinal>
    {
        public Task<IEnumerable<DetProyectoJuntaVecinalDto>> BuscarListado(string? valor, string? parametro, int numeroPagina, int cantidadMostrar);
    }
}