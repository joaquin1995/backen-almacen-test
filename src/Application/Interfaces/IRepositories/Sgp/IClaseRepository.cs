using Application.DTOs.Sgp;
using Application.Interfaces.Common;
using Domain.Models.Sgp;

namespace Application.Interfaces.IRepositories.Sgp
{
    public interface IClaseRepository: IGenericRepository<Clase>
    {
        public Task<IEnumerable<ClaseDto>> BuscarListado(string? valor, string? parametro, int numeroPagina, int cantidadMostrar);
    }
}
