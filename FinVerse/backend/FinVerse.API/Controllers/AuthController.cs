using FinVerse.API.Data;
using FinVerse.API.DTOs;
using FinVerse.API.Models;
using FinVerse.API.Services;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Security.Cryptography;
using System.Text;

namespace FinVerse.API.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class AuthController : ControllerBase
    {
        private readonly ApplicationDbContext _context;
        private readonly JwtService _jwtService;

        public AuthController(
            ApplicationDbContext context,
            JwtService jwtService)
        {
            _context = context;
            _jwtService = jwtService;
        }

        [HttpPost("register")]
        public async Task<IActionResult> Register(RegisterDto dto)
        {
            var existingUser = await _context.Users
                .FirstOrDefaultAsync(x => x.Email == dto.Email);

            if (existingUser != null)
            {
                return BadRequest("User already exists.");
            }

            using var sha256 = SHA256.Create();

            var hashedPassword = Convert.ToBase64String(
                sha256.ComputeHash(
                    Encoding.UTF8.GetBytes(dto.Password)));

            var user = new User
            {
                FullName = dto.FullName,
                Email = dto.Email,
                PasswordHash = hashedPassword,
                Balance = 0
            };

            _context.Users.Add(user);

            await _context.SaveChangesAsync();

            return Ok("User registered successfully.");
        }

        [HttpPost("login")]
        public async Task<IActionResult> Login(LoginDto dto)
        {
            using var sha256 = SHA256.Create();

            var hashedPassword = Convert.ToBase64String(
                sha256.ComputeHash(
                    Encoding.UTF8.GetBytes(dto.Password)));

            var user = await _context.Users
                .FirstOrDefaultAsync(x =>
                    x.Email == dto.Email &&
                    x.PasswordHash == hashedPassword);

            if (user == null)
            {
                return Unauthorized("Invalid credentials.");
            }

            var token = _jwtService.GenerateToken(user.Email);

            return Ok(new
            {
                Token = token
            });
        }
    }
}