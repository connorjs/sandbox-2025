using AwesomeAssertions;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace Connorjs.Sandbox2025.HelloCs.Tests;

[TestClass]
public class HelloTests
{
	[TestMethod]
	[DataRow(null, "Hello, world!")]
	[DataRow("", "Hello, world!")]
	[DataRow(" ", "Hello, world!")]
	[DataRow("esproj", "Hello, esproj!")]
	public void ShouldSayHello(string? name, string expected)
	{
		Hello.SayHello(name).Should().Be(expected);
	}
}
