using System.Text.Json.Serialization;

namespace Domain.Models.almacen
{
	public class Facturas
    {
        public long num_sec { get; set; }
		public int nsec_cliente { get; set; }
		public int nsec_usuario { get; set; }
		public string? nro_factura { get; set; }
		public string? created_at { get; set; }
		public string? updated_at { get; set; }

        public long nsec_usuario_registro { get; set; }
    }
}
