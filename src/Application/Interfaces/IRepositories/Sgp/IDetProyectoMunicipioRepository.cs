using Application.DTOs.Sgp;
using Application.Interfaces.Common;
using Domain.Models.Sgp;

namespace Application.Interfaces.IRepositories.Sgp
{
    public interface IDetProyectoMunicipioRepository: IGenericRepository<DetProyectoMunicipio>
    {
        public Task<IEnumerable<DetProyectoMunicipioDto>> BuscarListado(string? valor, string? parametro, int numeroPagina, int cantidadMostrar);
    }
}
