using Application.DTOs.almacen;
using Application.Interfaces.Common;
using Domain.Models.almacen;

namespace Application.Interfaces.IRepositories.almacen
{
    public interface IPersonasRepository: IGenericRepository<Personas>
    {
        public Task<IEnumerable<PersonasDto>> BuscarListado(string? valor, string? parametro, int numeroPagina, int cantidadMostrar);
    }
}
