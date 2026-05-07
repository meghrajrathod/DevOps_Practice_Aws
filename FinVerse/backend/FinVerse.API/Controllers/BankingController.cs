using FinVerse.API.Data;
using FinVerse.API.DTOs;
using FinVerse.API.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Security.Claims;

namespace FinVerse.API.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class BankingController : ControllerBase
    {
        private readonly ApplicationDbContext _context;

        public BankingController(ApplicationDbContext context)
        {
            _context = context;
        }

        [Authorize]
        [HttpGet("my-account")]
        public IActionResult MyAccount()
        {
            var email = User.FindFirst(ClaimTypes.Email)?.Value;

            return Ok(new
            {
                Message = "Protected banking data accessed successfully.",
                LoggedInUser = email
            });
        }

        [Authorize]
        [HttpPost("deposit")]
        public async Task<IActionResult> Deposit(DepositDto dto)
        {
            var email = User.FindFirst(ClaimTypes.Email)?.Value;

            var user = await _context.Users
                .FirstOrDefaultAsync(x => x.Email == email);

            if (user == null)
            {
                return NotFound("User not found.");
            }

            user.Balance += dto.Amount;

            var transaction = new Transaction
            {
                SenderEmail = email!,
                ReceiverEmail = email!,
                Amount = dto.Amount,
                TransactionType = "Deposit"
            };

            _context.Transactions.Add(transaction);

            await _context.SaveChangesAsync();

            return Ok(new
            {
                Message = "Deposit successful.",
                CurrentBalance = user.Balance
            });
        }

        [Authorize]
[HttpPost("withdraw")]
public async Task<IActionResult> Withdraw(DepositDto dto)
{
    var email = User.FindFirst(ClaimTypes.Email)?.Value;

    var user = await _context.Users
        .FirstOrDefaultAsync(x => x.Email == email);

    if (user == null)
    {
        return NotFound("User not found.");
    }

    if (user.Balance < dto.Amount)
    {
        return BadRequest("Insufficient balance.");
    }

    user.Balance -= dto.Amount;

    var transaction = new Transaction
    {
        SenderEmail = email!,
        ReceiverEmail = email!,
        Amount = dto.Amount,
        TransactionType = "Withdraw"
    };

    _context.Transactions.Add(transaction);

    await _context.SaveChangesAsync();

    return Ok(new
    {
        Message = "Withdrawal successful.",
        CurrentBalance = user.Balance
    });
}

[Authorize]
[HttpPost("transfer")]
public async Task<IActionResult> Transfer(TransferDto dto)
{
    var senderEmail = User.FindFirst(ClaimTypes.Email)?.Value;

    var sender = await _context.Users
        .FirstOrDefaultAsync(x => x.Email == senderEmail);

    var receiver = await _context.Users
        .FirstOrDefaultAsync(x => x.Email == dto.ReceiverEmail);

    if (sender == null)
    {
        return NotFound("Sender not found.");
    }

    if (receiver == null)
    {
        return NotFound("Receiver not found.");
    }

    if (sender.Balance < dto.Amount)
    {
        return BadRequest("Insufficient balance.");
    }

    sender.Balance -= dto.Amount;
    receiver.Balance += dto.Amount;

    var transaction = new Transaction
    {
        SenderEmail = senderEmail!,
        ReceiverEmail = dto.ReceiverEmail,
        Amount = dto.Amount,
        TransactionType = "Transfer"
    };

    _context.Transactions.Add(transaction);

    await _context.SaveChangesAsync();

    return Ok(new
    {
        Message = "Transfer successful.",
        SenderBalance = sender.Balance
    });
}

[Authorize]
[HttpGet("transactions")]
public async Task<IActionResult> GetTransactions()
{
    var email = User.FindFirst(ClaimTypes.Email)?.Value;

    var transactions = await _context.Transactions
        .Where(x =>
            x.SenderEmail == email ||
            x.ReceiverEmail == email)
        .OrderByDescending(x => x.CreatedAt)
        .ToListAsync();

    return Ok(transactions);
}
    }
}