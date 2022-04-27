using System.Text.Json.Serialization;

namespace Domain.Models.almacen
{
	public class Ingresos
    {
        public long num_sec { get; set; }
		public long nsec_proveedor { get; set; }
		public long nsec_ususario { get; set; }
		public string? tipo_comprobante { get; set; }
		public string? serie_comprobante { get; set; }
		public string? num_comprobante { get; set; }
		public decimal impuesto { get; set; }
		public decimal total_ingresos { get; set; }
        [JsonIgnore]
		public string? estado { get; set; }
		public string? created_at { get; set; }
		public string? updated_at { get; set; }

        public long nsec_usuario_registro { get; set; }
    }
}
