using System.Text.Json.Serialization;

namespace Domain.Models.almacen
{
	public class Productos
    {
        public long num_sec { get; set; }
		public long nsec_categoria { get; set; }
		public long nsec_marca { get; set; }
		public string? codigo { get; set; }
		public string? ruta { get; set; }
		public string? nombre { get; set; }
		public decimal precio_venta { get; set; }
		public int stock { get; set; }
		public string? descripcion { get; set; }
        [JsonIgnore]
		public string?  estado { get; set; }
		public string? created_at { get; set; }
		public string? updated_at { get; set; }

        public long nsec_usuario_registro { get; set; }
    }
}
