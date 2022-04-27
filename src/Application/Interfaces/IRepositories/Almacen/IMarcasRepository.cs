using Application.DTOs.almacen;
using Application.Interfaces.Common;
using Domain.Models.almacen;

namespace Application.Interfaces.IRepositories.almacen
{
    public interface IMarcasRepository: IGenericRepository<Marcas>
    {
        public Task<IEnumerable<MarcasDto>> BuscarListado(string? valor, string? parametro, int numeroPagina, int cantidadMostrar);
    }
}
