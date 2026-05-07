namespace FinVerse.API.Models
{
    public class Transaction
    {
        public int Id { get; set; }

        public string SenderEmail { get; set; } = string.Empty;

        public string ReceiverEmail { get; set; } = string.Empty;

        public decimal Amount { get; set; }

        public string TransactionType { get; set; } = string.Empty;

        public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
    }
}