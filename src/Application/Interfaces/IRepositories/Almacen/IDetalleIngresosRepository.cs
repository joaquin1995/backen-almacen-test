using Application.DTOs.almacen;
using Application.Interfaces.Common;
using Domain.Models.almacen;

namespace Application.Interfaces.IRepositories.almacen
{
    public interface IDetalleIngresosRepository: IGenericRepository<DetalleIngresos>
    {
        public Task<IEnumerable<DetalleIngresosDto>> BuscarListado(string? valor, string? parametro, int numeroPagina, int cantidadMostrar);
    }
}
