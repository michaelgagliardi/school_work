import random


# function for finding gcd of two numbers using euclidean algorithm
def gcd(a, b):
    while b != 0:
        a, b = b, a % b
    return a


# uses extended euclidean algorithm to get the d value


def get_d(e, z):
    ###################################your code goes here#####################################
    d = 0
    if e == 0:
        return z, 0, 1
    else:
        gcd, x1, y = get_d(z % e, e)
        x = y - (z // e) * x1
        d = x1

        return gcd, x, d


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
    ###################################your code goes here####################################
    n = p * q
    z = (p - 1) * (q - 1)
    e = random.randrange(1, n)
    while gcd(e, z) != 1:
        e = random.randrange(1, n)
    d = get_d(e, z)
    d = d[1]
    if d <= 0:
        d = d + z

    return ((e, n), (d, n))


def encrypt(pk, plaintext):
    ###################################your code goes here#####################################
    # plaintext is a single character
    # cipher is a decimal number which is the encrypted version of plaintext
    # the pow function is much faster in calculating power compared to the ** symbol !!!
    e, n = pk

    cipher = pow(ord(plaintext), e, n)

    return cipher


def decrypt(pk, ciphertext):
    ###################################your code goes here#####################################
    # ciphertext is a single decimal number
    # the returned value is a character that is the decryption of ciphertext

    plain = chr(pow(ciphertext, pk[0], pk[1]))

    return ''.join(plain)


if __name__ == '__main__':
    print(get_d(60, 37))
    p = int(input('p: '))
    q = int(input('q: '))
    pk, pk2 = generate_keypair(p, q)
    plaintext = input('enter message: ')
    print("e = ", pk[0])
    print("d = ", pk2[0])
    encrypted_message = encrypt(pk2, plaintext)
    print("Encrypted Message", encrypted_message)
    decrypted_message = decrypt(pk, encrypted_message)
    print("Decrypted Message", decrypted_message)