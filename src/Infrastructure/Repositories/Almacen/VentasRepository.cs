using Application.DTOs.almacen;
using Application.Interfaces.IRepositories.almacen;
using Application.Interfaces.IData;
using Domain.Models.almacen;
using Infrastructure.Repositories.Common;
using System.Data;
using System.Collections;

namespace Infrastructure.Repositories.almacen
{
    public class VentasRepository : GenericRepository<Ventas>, IVentasRepository
    {
        private readonly IApplicationDbContext _applicationDbContext;
        public VentasRepository(IApplicationDbContext applicationDbContext) : base(applicationDbContext)
        {
            _applicationDbContext = applicationDbContext;
        }

        public async Task<IEnumerable<VentasDto>> BuscarListado(string? valor, string? parametro, int numeroPagina, int cantidadMostrar)
        {
            try
            {
                IEnumerable<VentasDto>? arrayDatos = new VentasDto[] { };
                string nombreFuncion = "sp_listado_ventas";

                Hashtable parametros = new Hashtable();
                parametros.Add("valor_bus", valor == null ? "" : valor);
                parametros.Add("parametro_bus", parametro);
                parametros.Add("numeropaginaactual", numeroPagina);
                parametros.Add("cantidadmostrar", cantidadMostrar);

                arrayDatos = await _applicationDbContext.TraerArrayObjeto<VentasDto>(nombreFuncion, parametros);

                return arrayDatos;

            }
            catch (Exception)
            {
                throw;
            }
        }

    }
}

