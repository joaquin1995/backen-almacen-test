using Application.DTOs.almacen;
using Application.Interfaces.Common;
using Domain.Models.Data;
using Domain.Models.almacen;

namespace Application.Interfaces.IServices.almacen
{
    public interface IDetalleVentasService : IGenericService<DetalleVentas>
    {
        public Task<RespuestaListado<DetalleVentasDto>> BuscarListado(string? valor, string? parametro, int numeroPagina, int cantidadMostrar);
    }
}
