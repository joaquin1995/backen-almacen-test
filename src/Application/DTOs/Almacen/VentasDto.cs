using System.Text.Json.Serialization;

namespace Application.DTOs.almacen
{
	public class VentasDto
    {
		public long num_sec { get; set; }
		public int nsec_cliente { get; set; }
		public int nsec_usuario { get; set; }
		public string? tipo_comprobante { get; set; }
		public string? serie_comprobante { get; set; }
		public string? num_comprobante { get; set; }
		public decimal impuesto { get; set; }
		public decimal total_venta { get; set; }
        [JsonIgnore]
		public string? estado { get; set; }
		public string? created_at { get; set; }
		public string? updated_at { get; set; }

        [JsonIgnore]
        public int total { get; set; }
    }
}
