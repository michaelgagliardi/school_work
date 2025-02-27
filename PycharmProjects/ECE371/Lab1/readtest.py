import random


# fnction for finding gcd of two numbers using euclidean algorithm
def gcd(a, b):
    while b != 0:
        a, b = b, a % b
    return a


# uses extened euclidean algorithm to get the d value
def get_d(e, z):
    ###################################your code goes here#####################################
    d = 0
    x1 = 0
    x2 = 1
    y1 = 1
    temp_z = z

    while e > 0:
        temp1 = temp_z / e
        temp2 = temp_z - temp1 * e
        temp_z = e
        e = temp2

        x = x2 - temp1 * x1
        y = d - temp1 * y1

        x2 = x1
        x1 = x
        d = y1
        y1 = y

        d = d + z
        return d


def is_prime(num):
    if num > 1:

        # Iterate from 2 to n / 2
        for i in range(2, num // 2):

            # If num is divisible by any number between
            # 2 and n / 2, it is not prime
            if (num % i) == 0:
                return False
                break
            else:
                return True

    else:
        return False


def generate_keypair(p, q):
    if not (is_prime(p) and is_prime(q)):
        raise ValueError('Both numbers must be prime.')
    elif p == q:
        raise ValueError('p and q cannot be equal')
    ###################################your code goes here#####################################
    n = p * q
    z = (p - 1) * (q - 1)
    while True:
        e = random.randint(0, n)
        if gcd(n, e) == 1:
            try:
                d = pow(e, -1, z)
            except Exception:
                continue
            else:
                break
        else:
            continue
    d = get_d(e, z)
    return ((e, n), (d, n))


def encrypt(pk, plaintext):
    ###################################your code goes here#####################################
    # plaintext is a single character
    # cipher is a decimal number which is the encrypted version of plaintext
    # the pow function is much faster in calculating power compared to the ** symbol !!
    e, n = pk
    cipher = pow(int(plaintext), e) % n
    return cipher


def decrypt(pk, ciphertext):
    ###################################your code goes here#####################################
    # ciphertext is a single decimal number
    # the returned value is a character that is the decryption of ciphertext
    c = int(ciphertext)
    plain = pow(c, pk[0]) % pk[1]
    return plain


text = "87392612"

p = 11
q = 7
public, private = generate_keypair(p, q)
print("RSA Public Key pair = " + str(public))
print("RSA Private Key pair = " + str(private))

cipher = []
for i in text:
    c = encrypt(public, i)
    cipher.append(c)
print("cipher text = ", cipher)
plain = []
for i in cipher:
    p = decrypt(private, i)
    plain.append(p)
print("DES key = ", plain)
