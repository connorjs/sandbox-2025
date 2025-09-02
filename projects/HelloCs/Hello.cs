namespace Connorjs.Sandbox2025.HelloCs;

/// <summary>
/// Example “Hello, world!” class.
/// </summary>
public static class Hello
{
	/// <summary>
	/// Returns a hello string.
	/// </summary>
	/// <param name="name">The name to include. Optional.</param>
	/// <returns>A hello string.</returns>
	public static string SayHello(string? name)
	{
		var nameToReturn = string.IsNullOrWhiteSpace(name) ? "world" : name;
		return $"Hello, {nameToReturn}!";
	}
}
