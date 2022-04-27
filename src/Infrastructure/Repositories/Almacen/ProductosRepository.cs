using Application.DTOs.almacen;
using Application.Interfaces.IRepositories.almacen;
using Application.Interfaces.IData;
using Domain.Models.almacen;
using Infrastructure.Repositories.Common;
using System.Data;
using System.Collections;

namespace Infrastructure.Repositories.almacen
{
    public class ProductosRepository : GenericRepository<Productos>, IProductosRepository
    {
        private readonly IApplicationDbContext _applicationDbContext;
        public ProductosRepository(IApplicationDbContext applicationDbContext) : base(applicationDbContext)
        {
            _applicationDbContext = applicationDbContext;
        }

        public async Task<IEnumerable<ProductosDto>> BuscarListado(string? valor, string? parametro, int numeroPagina, int cantidadMostrar)
        {
            try
            {
                IEnumerable<ProductosDto>? arrayDatos = new ProductosDto[] { };
                string nombreFuncion = "sp_listado_productos";

                Hashtable parametros = new Hashtable();
                parametros.Add("valor_bus", valor == null ? "" : valor);
                parametros.Add("parametro_bus", parametro);
                parametros.Add("numeropaginaactual", numeroPagina);
                parametros.Add("cantidadmostrar", cantidadMostrar);

                arrayDatos = await _applicationDbContext.TraerArrayObjeto<ProductosDto>(nombreFuncion, parametros);

                return arrayDatos;

            }
            catch (Exception)
            {
                throw;
            }
        }

    }
}

