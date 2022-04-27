using System.Text.Json.Serialization;

namespace Domain.Models.almacen
{
	public class Clientes
    {
        public long num_sec { get; set; }
		public string? nombre { get; set; }
		public string? tipo_documento { get; set; }
		public string? num_documento { get; set; }
		public string? direccion { get; set; }
		public string? telefono { get; set; }
		public string? email { get; set; }
		public string? created_at { get; set; }
		public string? updated_at { get; set; }

        public long nsec_usuario_registro { get; set; }
    }
}
