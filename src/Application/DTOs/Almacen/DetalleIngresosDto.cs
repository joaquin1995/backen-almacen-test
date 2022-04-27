using System.Text.Json.Serialization;

namespace Application.DTOs.almacen
{
	public class DetalleIngresosDto
    {
		public long num_sec { get; set; }
		public long nsec_ingreso { get; set; }
		public long nsec_producto { get; set; }
		public int cantidad { get; set; }
		public decimal precio { get; set; }
		public string? created_at { get; set; }
		public string? updated_at { get; set; }

        [JsonIgnore]
        public int total { get; set; }
    }
}
