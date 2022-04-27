using Application.DTOs.Sgp;
using Application.Interfaces.Common;
using Domain.Models.Sgp;

namespace Application.Interfaces.IRepositories.Sgp
{
    public interface IJuntaVecinalRepository: IGenericRepository<JuntaVecinal>
    {
        public Task<IEnumerable<JuntaVecinalDto>> BuscarListado(string? valor, string? parametro, int numeroPagina, int cantidadMostrar);
    }
}
