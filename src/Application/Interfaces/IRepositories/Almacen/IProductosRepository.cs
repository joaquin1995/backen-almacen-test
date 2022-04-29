using Application.DTOs.almacen;
using Application.Interfaces.Common;
using Domain.Models.almacen;

namespace Application.Interfaces.IRepositories.almacen
{
    public interface IProductosRepository : IGenericRepository<Productos>
    {
        public Task<IEnumerable<ProductosListadoDto>> BuscarListado(string? valor, string? parametro, int numeroPagina, int cantidadMostrar);
    }
}
