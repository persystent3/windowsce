# windowsce
Implementing Cryptographic Erase (CE) onto an existing Windows installation

OpenShred, designed at DefCon24, is a Drag-and- Drop “File Shredder” or Cryptographic Erase-like program for the Windows Operating System.  OShredAES.rb can be run in a windows command prompt or an exe generated from the file and placed onto the Desktop as an icon, alongside the Recycle Bin.  To delete a file, simply Drag-and-Drop onto the icon.  OpenShred, in theory, it has been designed to permanently make sensitive files unrecoverable by encrypting them with the  Advanced Encryption Standard (AES) encryption cipher with a 256 bit key lengths.

AES is a symmetric-key algorithm which means the same key is used for both encrypting and decrypting the data.  OpenShred generates a random key and initialization vector (IV) each time the program is run.  AES is the first publically accessible cipher approved by the National Security Agency (NSA) for Top Secret information.   The NSA approves greater than AES256 for Top Secret data in their Suite B Cryptography algorithims.  NSA Suite B Cryptography is part of the agencies Cryptographic Modernization Program.  

The result of our conceptual studies of File Shredding and Cryptographic Erase has led us to determine that the symmetrical method cannot guarantee success as the random key used for encryption exists on the machine.  Thus an idea presented to us was to use Asymmetric crypto, and encrypt the file to be deleted with a public key on the machine.  In this case, the RSA keypair would be generated with rsakeypair.rb on a different machine, with the private key never being placed onto the disk of the computer being used to “shred” or CE the file using OpenShredRSA.rb.

Despite issues with the key itself, whether it remains in memory or on disk, or even not on disk with the RSA concept, there still exists the issue of verifying the original unencrypted data still does not exist on the hard disk drive or solid state drive.  Thus, more research is necessary on this aspect for trying to implement file shredding or CE onto a regular Windows installation.

Enjoy,

persyst3nt@tutanota.com

dre4m
