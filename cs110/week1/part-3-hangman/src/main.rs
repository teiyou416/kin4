// Simple Hangman Program
// User gets five incorrect guesses
// Word chosen randomly from words.txt
// Inspiration from: https://doc.rust-lang.org/book/ch02-00-guessing-game-tutorial.html
// This assignment will introduce you to some fundamental syntax in Rust:
// - variable declaration
// - string manipulation
// - conditional statements
// - loops
// - vectors
// - files
// - user input
// We've tried to limit/hide Rust's quirks since we'll discuss those details
// more in depth in the coming lectures.
extern crate rand;
use rand::Rng;
use std::collections::HashSet;
use std::fs;
use std::io;
use std::io::Write;

const NUM_INCORRECT_GUESSES: u32 = 5;
const WORDS_PATH: &str = "../words.txt";

fn pick_a_random_word() -> String {
    let file_string = fs::read_to_string(WORDS_PATH).expect("Unable to read file.");
    let words: Vec<&str> = file_string.split('\n').collect();
    String::from(words[rand::thread_rng().gen_range(0, words.len())].trim())
}
fn print_so_far_word(word_so_far: &Vec<char>) {
    print!("The word so far is :");
    for i in word_so_far {
        print!("{}", i);
    }
    println!("");
}
fn print_guessed_word(guessed_words: &HashSet<char>) {
    print!("You have guessed the following letters:");
    for i in guessed_words {
        print!("{}", i);
    }
    println!("");
}
fn print_not_guessed_word(not_guessed_words: &HashSet<char>) {
    print!("You have not guessed the following letters:");
    for i in not_guessed_words {
        print!("{}", i);
    }
    println!("");
}

fn main() {
    let secret_word = pick_a_random_word();
    // Note: given what you know about Rust so far, it's easier to pull characters out of a
    // vector than it is to pull them out of a string. You can get the ith character of
    // secret_word by doing secret_word_chars[i].
    let secret_word_chars: Vec<char> = secret_word.chars().collect();
    let mut word_so_far = Vec::new();
    let mut guessed_words = HashSet::new();
    let mut not_guessed_words = HashSet::new();
    let mut remained_guess = NUM_INCORRECT_GUESSES;
    // Uncomment for debugging:
    println!("random word: {}", secret_word);

    // Your code here! :)
    // Make sure the prompt from the previous line gets displayed:
    for i in 0..secret_word_chars.len() {
        word_so_far.push('-');
        not_guessed_words.insert(secret_word_chars[i]);
    }

    loop {
        print_so_far_word(&word_so_far);
        print_guessed_word(&guessed_words);
        print_not_guessed_word(&not_guessed_words);
        println!("You have {} guesses left", remained_guess);
        //in mode
        print!("Please guess a letter: ");
        io::stdout().flush().expect("Error flushing stdout.");
        let mut guess = String::new();
        io::stdin()
            .read_line(&mut guess)
            .expect("Error reading line.");
        print!("guessed word: {}", guess);
        //out
        let guess_char: Vec<char> = guess.chars().collect();
        guessed_words.insert(guess_char[0]);
        if not_guessed_words.contains(&guess_char[0]) {
            not_guessed_words.remove(&guess_char[0]);
            for i in 0..secret_word_chars.len() {
                if secret_word_chars[i] == guess_char[0] {
                    word_so_far[i] = guess_char[0];
                }
            }
        } else {
            remained_guess -= 1;
            println!("Not in the letter");
        }
        if remained_guess == 0 {
            println!("No chance left. Fuck off");
            break;
        }
        if not_guessed_words.is_empty() {
            println!("You Won.Congrats");
            break;
        }
    }
}
