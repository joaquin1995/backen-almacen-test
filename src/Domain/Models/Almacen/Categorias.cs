using System.Text.Json.Serialization;

namespace Domain.Models.almacen
{
	public class Categorias
    {
        public long num_sec { get; set; }
		public string? nombre { get; set; }
		public string? descripcion { get; set; }
		public string? estado { get; set; }
    }
}
