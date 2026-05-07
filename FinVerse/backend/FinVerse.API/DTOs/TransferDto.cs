namespace FinVerse.API.DTOs
{
    public class TransferDto
    {
        public string ReceiverEmail { get; set; } = string.Empty;

        public decimal Amount { get; set; }
    }
}