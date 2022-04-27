using Application.DTOs.Sgp;
using Application.Interfaces.Common;
using Domain.Models.Sgp;

namespace Application.Interfaces.IRepositories.Sgp
{
    public interface IModalidadRepository: IGenericRepository<Modalidad>
    {
        public Task<IEnumerable<ModalidadDto>> BuscarListado(string? valor, string? parametro, int numeroPagina, int cantidadMostrar);
    }
}
