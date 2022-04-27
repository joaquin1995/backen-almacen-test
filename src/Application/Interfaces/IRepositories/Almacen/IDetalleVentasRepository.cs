using Application.DTOs.almacen;
using Application.Interfaces.Common;
using Domain.Models.almacen;

namespace Application.Interfaces.IRepositories.almacen
{
    public interface IDetalleVentasRepository: IGenericRepository<DetalleVentas>
    {
        public Task<IEnumerable<DetalleVentasDto>> BuscarListado(string? valor, string? parametro, int numeroPagina, int cantidadMostrar);
    }
}
