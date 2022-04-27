using Application.DTOs.almacen;
using Application.Interfaces.Common;
using Domain.Models.Data;
using Domain.Models.almacen;

namespace Application.Interfaces.IServices.almacen
{
    public interface IProductosService : IGenericService<Productos>
    {
        public Task<RespuestaListado<ProductosDto>> BuscarListado(string? valor, string? parametro, int numeroPagina, int cantidadMostrar);
    }
}
