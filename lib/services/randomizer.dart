import 'dart:math';

String getRandomQuote() {
  // List of quotes
  final List<String> quotes = [
    "Power comes in response to a need, not a desire.",
    "Fear is not evil. It tells you what your weakness is.",
    // "Hard work is worthless for those that don’t believe in themselves.",
    "If you don’t fight, you can’t win!",
    "It’s not over yet. Don’t give up until the end.",
    "To know your limits, you have to surpass them.",
    "Surpass your limits. Right here, right now!",
    "I won’t give up. Ever!",
    "Hard work beats talent. Every time.",
    "Even if you’re weak, you can still fight!",
    "Strength is the only thing that matters in this world",
    "Write your own story",
  ];

  // Create a random number generator
  final Random random = Random();

  // Get a random index
  final int randomIndex = random.nextInt(quotes.length);

  // Return the random quote
  return quotes[randomIndex];
}


