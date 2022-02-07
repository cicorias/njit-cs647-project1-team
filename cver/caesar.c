#include <unistd.h>

/* constants */
#define MSGPROMPT "Enter your message: "
#define RESPONSE  "You entered: "
#define ROTPROMPT "Enter ROT: "
#define STDOUT  1
#define STDIN   0

/* forward declarations */
void print(char*, int);
void input();
void readString();
void readRot();
void cipher();

char plaintext[50];
char ciphertext[50];
char rot_s[50];
int rot = 0;

int main() {

  print(MSGPROMPT, sizeof(MSGPROMPT) );
  readString();

  print(ROTPROMPT, sizeof(ROTPROMPT));
  readRot();

  cipher();
}

void cipher() {
  int rv = rot;
}

void print(char* msg, int len) {
  int rv = write(STDOUT, msg, len);
}

void readString(){
  ssize_t rv = read(STDIN, plaintext, 50);
  print(RESPONSE, sizeof(RESPONSE));
  print(plaintext, rv);
  print("\n", 1);
}

void readRot() {
  ssize_t rv = read(STDIN, rot_s, 50);
  print(RESPONSE, sizeof(RESPONSE));
  print(rot_s, rv);
  print("\n", 1);

  int i = 0;
  int r = 0;
  int v = 0;
  while(i < rv - 1) {
    r = rot_s[i] - '0';
    v = v * 10 + r;
    ++i;
  }

  rot = v;
}