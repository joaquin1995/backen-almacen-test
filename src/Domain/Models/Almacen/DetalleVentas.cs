using System.Text.Json.Serialization;

namespace Domain.Models.almacen
{
	public class DetalleVentas
    {
        public long num_sec { get; set; }
		public long nsec_venta { get; set; }
		public long nsec_prodcuto { get; set; }
		public int cantidad { get; set; }
		public decimal precio { get; set; }
		public decimal descuento { get; set; }
		public string? created_at { get; set; }
		public string? updated_at { get; set; }

        public long nsec_usuario_registro { get; set; }
    }
}
