using Application.DTOs.almacen;
using Application.Interfaces.IRepositories.almacen;
using Application.Interfaces.IData;
using Domain.Models.almacen;
using Infrastructure.Repositories.Common;
using System.Data;
using System.Collections;

namespace Infrastructure.Repositories.almacen
{
    public class RolRepository : GenericRepository<Rol>, IRolRepository
    {
        private readonly IApplicationDbContext _applicationDbContext;
        public RolRepository(IApplicationDbContext applicationDbContext) : base(applicationDbContext)
        {
            _applicationDbContext = applicationDbContext;
        }

        public async Task<IEnumerable<RolDto>> BuscarListado(string? valor, string? parametro, int numeroPagina, int cantidadMostrar)
        {
            try
            {
                IEnumerable<RolDto>? arrayDatos = new RolDto[] { };
                string nombreFuncion = "sp_listado_rol";

                Hashtable parametros = new Hashtable();
                parametros.Add("valor_bus", valor == null ? "" : valor);
                parametros.Add("parametro_bus", parametro);
                parametros.Add("numeropaginaactual", numeroPagina);
                parametros.Add("cantidadmostrar", cantidadMostrar);

                arrayDatos = await _applicationDbContext.TraerArrayObjeto<RolDto>(nombreFuncion, parametros);

                return arrayDatos;

            }
            catch (Exception)
            {
                throw;
            }
        }

    }
}

