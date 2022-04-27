using Application.DTOs.Sgp;
using Application.Interfaces.Common;
using Domain.Models.Data;
using Domain.Models.Sgp;

namespace Application.Interfaces.IServices.Sgp
{
    public interface IProyectoPndService : IGenericService<ProyectoPnd>
    {
        public Task<RespuestaListado<ProyectoPndDto>> BuscarListado(string? valor, string? parametro, int numeroPagina, int cantidadMostrar);
    }
}
