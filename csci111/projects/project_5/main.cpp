// Spencer McWilliams (smcwilliams)
// Project 5: Cryptomaniac
// Due 11/28/2011

#include <iostream>
#include <fstream>
#include <cctype>
#include <cstdlib>
using namespace std;

// Get the decision whether to encrypt or decrypt from the user.
char menu();

// Initialize the array holding the cipher.
void initialize_cipher_array(fstream& cipher_file, char cipher[], int size);

// Open all files.
void open_files(fstream& encrypted_file, fstream& unencrypted_file, fstream& cipher_file);

// Encrypt 'unencrypted.txt' to 'encrypted.txt' using the cipher_array.
void encrypt(fstream& encrypted_file, fstream& unencrypted_file, const char cipher[]);

// Decrypt 'encrypted.txt' to 'unencrypted.txt' using the cipher_array.
void decrypt(fstream& encrypted_file, fstream& unencrypted_file, const char cipher[]);








int main()
{
  fstream   cipher_file, encrypted_file, unencrypted_file;
  char choice, cipher[26];
  
  open_files(encrypted_file, unencrypted_file, cipher_file);
  initialize_cipher_array(cipher_file, cipher, 26);
  choice = menu();
  
  switch (choice) {
    case 'e':
    case 'E':
      cout << endl;
      encrypt(encrypted_file, unencrypted_file, cipher);
      break;
      
    case 'd':
    case 'D':
      cout << endl;
      decrypt(encrypted_file, unencrypted_file, cipher);
      break;
      
    default:
      break;
  }
  
  
  return 0;
}











char menu()
{
  char choice;
  
  do
  {
    cout << "Would you like to (E)ncrypt or (D)ecrypt the input file? ";
    cin >> choice;
  } while ((choice != 'e')and(choice != 'E')and(choice != 'd')and(choice != 'D'));
  
  return choice;
}

void initialize_cipher_array(fstream& cipher_file, char cipher[], int size)
{
  for (int i = 0; i < size; i++)
  {
    char ch;
    cipher_file.get(ch);
    cipher[i] = ch;
  }
}

void open_files(fstream& encrypted_file, fstream& unencrypted_file, fstream& cipher_file)
{
  encrypted_file.open("encrypted.txt");
  if (encrypted_file.fail())
  {
    cout << "Missing file 'encrypted.txt'\n";
    exit(1);
  }
  
  unencrypted_file.open("unencrypted.txt");
  if (unencrypted_file.fail())
  {
    cout << "Missing file 'unencrypted.txt'\n";
    exit(1);
  }
  
  cipher_file.open("cipher.txt");
  if (cipher_file.fail())
  {
    cout << "Missing file 'cipher.txt'\n";
    exit(1);
  }
}

void encrypt(fstream& encrypted_file, fstream& unencrypted_file, const char cipher[])
{
  char unencrypted_character;
  int place;
  
  unencrypted_file.get(unencrypted_character);
  
  while (!unencrypted_file.eof())
  {
    
    // Get place of the unencrypted character in the cipher_array
    place = abs(97-unencrypted_character);
    
    
    // Check if letter
    if (!isalpha(unencrypted_character))
    {
      cout.put(unencrypted_character);
    }
    
    else
    {
      // Check if uppercase and print if true
      if (isupper(unencrypted_character))
      {
        // If uppercase, the previous place assignment is incorrect.
        place = abs(97-tolower(unencrypted_character));
        
        cout.put(toupper(cipher[place]));
      }
      
      // If not uppercase, then print the lowercase value.
      else
      {
        cout.put(cipher[place]);
      }
    }
    unencrypted_file.get(unencrypted_character);
    
  }
}

void decrypt(fstream& encrypted_file, fstream& unencrypted_file, const char cipher[])
{
  char encrypted_character, unencrypted_character;
  int place;
  
  encrypted_file.get(encrypted_character);
  
  while (!encrypted_file.eof())
  {
    
    // Check if the encrypted character is an alpha character.
    if (!isalpha(encrypted_character))
    {
      cout.put(encrypted_character);
    }
    
    else
    {
      // Find the location in the cipher_array THAT HOLDS THAT CHARACTER
      for (int i = 0; i < 26; i++)
      {
        if (tolower(encrypted_character) == cipher[i])
          place = i;
      }
      
      // Determine the letter of the alphabet using the place of the encrypted letter and ascii code.
      unencrypted_character = static_cast<char>(97+place);
      
      // Check for uppercase, if true, print the uppercase value.
      if (isupper(encrypted_character))
      {
        cout.put(toupper(unencrypted_character));
      }
      
      // If not uppercase, print the lowercase value.
      else
      {
        cout.put(unencrypted_character);
      }
    }
    
    encrypted_file.get(encrypted_character);
    
  }
}















