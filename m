Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A9Y89-0005YD-00
	for <User-mode-linux-devel@lists.sourceforge.net>; Tue, 14 Oct 2003 15:59:05 -0700
Received: from bay7-f10.bay7.hotmail.com ([64.4.11.10] helo=hotmail.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1A9Y88-0000Gy-PX
	for User-mode-linux-devel@lists.sourceforge.net; Tue, 14 Oct 2003 15:59:04 -0700
From: "Steve Schmidtke" <steve_schmidtke@hotmail.com>
Subject: Re: [uml-devel] filemap feature 2.4.22-5um
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----=_NextPart_000_3386_1234_66e2"
Message-ID: <BAY7-F10EP60A1ozvkh00011910@hotmail.com>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Tue, 14 Oct 2003 22:58:34 +0000
To: jdike@addtoit.com
Cc: User-mode-linux-devel@lists.sourceforge.net


This is a multi-part message in MIME format.

------=_NextPart_000_3386_1234_66e2
Content-Type: text/plain; format=flowed

Jeff Dike wrote:
>Why so pessimistic?  I like filemap - IIRC, i suggested it.

Yeah, but finding the right interface to express it is tough.  I don't even 
want to go in the whole *in* OS_ layer/*above* os_* layer argument again. :) 
  I am also thinking that the filemap database should be generalized so that 
any translation can be supported - like an "xlate" table that can map Unix 
filenames to DOS filenames...

>I'd also like people to use this to see what's missing, if anything, and to
>get any improvements on the command line syntax.

Just so SKAS users don't feel left out, I've attached a small patch that 
adds a "mm" table to filemap for chrooted SKAS mode operation.  Just apply 
it after the first patch.

The following example shows how to use this patch to set up a chrooted SKAS 
UML with 20 available process slots:

  chroot /home/uml /linux mem=32M filemap=mm,30-49 \
  30>/proc/mm 31>/proc/mm 32>/proc/mm 33>/proc/mm 34>/proc/mm \
  35>/proc/mm 36>/proc/mm 37>/proc/mm 38>/proc/mm 39>/proc/mm \
  40>/proc/mm 41>/proc/mm 42>/proc/mm 43>/proc/mm 44>/proc/mm \
  45>/proc/mm 46>/proc/mm 47>/proc/mm 48>/proc/mm 49>/proc/mm \
  filemap=file,25,/proc/mm 25>/proc/mm \
  filemap=vm,20 20<>/dev/shm/vm-$$.0 con=null con0=fd:0,fd:1

Note the dummy "file" table entry for /proc/mm.  This is needed so the boot 
test for /proc/mm succeeds.

ISSUE:  The UML will panic if it runs out of /proc/mm fds.
ISSUE:  What side effects does re-using an address space have?
TODO:  Make the filemap lookup routine re-entrant safe.

Comments? Concerns?

Steve Schmidtke

_________________________________________________________________
STOP MORE SPAM with the new MSN 8 and get 2 months FREE*   
http://join.msn.com/?page=features/junkmail

------=_NextPart_000_3386_1234_66e2
Content-Type: application/octet-stream; name="filemap5-02.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="filemap5-02.diff"

LS0tIGxpbnV4LTIuNC4yMi01dW0uZm0vYXJjaC91bS9rZXJuZWwvZmlsZW1h
cC5jCVR1ZSBPY3QgMTQgMTA6NDQ6NTAgMjAwMworKysgbGludXgtMi40LjIy
LTV1bS5uZXcvYXJjaC91bS9rZXJuZWwvZmlsZW1hcC5jCVR1ZSBPY3QgMTQg
MTM6NTY6MzcgMjAwMwpAQCAtNTAyLDYgKzUwMiwxMSBAQAogCQkuZW50cmll
cyA9IE5VTEwsCiAJCS5vcHMgICAgID0gJmZtX29wc19wb29sLAogCX0sCisJ
eworCQkubmFtZSAgICA9ICJtbSIsCisJCS5lbnRyaWVzID0gTlVMTCwKKwkJ
Lm9wcyAgICAgPSAmZm1fb3BzX3Bvb2wsCisJfSwKIH07CiAKIHN0YXRpYyBz
dHJ1Y3QgZmlsZW1hcF90YWJsZSogZmlsZW1hcF9nZXRfdGFibGUoY29uc3Qg
Y2hhciogdGFibGVfbmFtZSkKLS0tIGxpbnV4LTIuNC4yMi01dW0uZm0vYXJj
aC91bS9rZXJuZWwvc2thcy9wcm9jZXNzLmMJVHVlIE9jdCAxNCAxMDo0NDoz
MSAyMDAzCisrKyBsaW51eC0yLjQuMjItNXVtLm5ldy9hcmNoL3VtL2tlcm5l
bC9za2FzL3Byb2Nlc3MuYwlUdWUgT2N0IDE0IDE0OjI4OjM5IDIwMDMKQEAg
LTI3LDYgKzI3LDggQEAKICNpbmNsdWRlICJza2FzX3B0cmFjZS5oIgogI2lu
Y2x1ZGUgImNoYW5fdXNlci5oIgogCisjaW5jbHVkZSAiZmlsZW1hcC5oIgor
CiBpbnQgaXNfc2thc193aW5jaChpbnQgcGlkLCBpbnQgZmQsIHZvaWQgKmRh
dGEpCiB7CiAJaWYocGlkICE9IGdldHBpZCgpKQpAQCAtMzQwLDEyICszNDIs
MjcgQEAKIGludCBuZXdfbW0oaW50IGZyb20pCiB7CiAJc3RydWN0IHByb2Nf
bW1fb3AgY29weTsKLQlpbnQgbiwgZmQgPSBvc19vcGVuX2ZpbGUoIi9wcm9j
L21tIiwgCisJaW50IG4sIGZkOworCisJLyogdXNlIHRoZSByYXcgYWNjZXNz
IHNpbmNlIC9wcm9jL21tIG9wZW5zIGEgbmV3IGZpbGUgZXZlcnkgdGltZSAq
LyAKKyAgICAgICAgZmQgPSBmaWxlbWFwX2FjY2VzcygibW0iLCAiL3Byb2Mv
bW0iKTsKKyAgICAgICAgaWYoZmQgPj0gMCkgeworICAgICAgICAgICAgICAg
IHByaW50aygiZmlsZW1hcCBhcXVpcmU6IGZkPSVkLCBmaWxlPSVzXG4iLCBm
ZCwgIi9wcm9jL21tIik7CisgICAgICAgICAgICAgICAgZ290byBoYW5kbGVf
ZmQ7CisgICAgICAgIH0KKworCS8qIGlmIC9wcm9jL21tIGV4aXN0cywgdGhl
IHNhbWUgZmQgd291bGQgYmUgcmV0dXJuZWQgb3ZlciBhbmQgb3ZlciAqLwor
ICAgICAgICBpZihmaWxlbWFwX2FjY2VzcygiZmlsZSIsICIvcHJvYy9tbSIp
ID49IDApIHsKKwkJcmV0dXJuKC0xKTsJCisJfQorCisJZmQgPSBvc19vcGVu
X2ZpbGUoIi9wcm9jL21tIiwgCiAJCQkJIG9mX2Nsb2V4ZWMob2Zfd3JpdGUo
T1BFTkZMQUdTKCkpKSwgMCk7CiAKIAlpZihmZCA8IDApCiAJCXJldHVybihm
ZCk7CiAKK2hhbmRsZV9mZDoKIAlpZihmcm9tICE9IC0xKXsKIAkJY29weSA9
ICgoc3RydWN0IHByb2NfbW1fb3ApIHsgLm9wIAk9IE1NX0NPUFlfU0VHTUVO
VFMsCiAJCQkJCSAgICAgIC51IAk9IAotLS0gbGludXgtMi40LjIyLTV1bS5m
bS9hcmNoL3VtL2tlcm5lbC9za2FzL21tdS5jCVR1ZSBPY3QgMTQgMTA6NDQ6
MzEgMjAwMworKysgbGludXgtMi40LjIyLTV1bS5uZXcvYXJjaC91bS9rZXJu
ZWwvc2thcy9tbXUuYwlUdWUgT2N0IDE0IDE2OjQ4OjM2IDIwMDMKQEAgLTIx
LDE0ICsyMSwyMyBAQAogCiAJbW0tPmNvbnRleHQuc2thcy5tbV9mZCA9IG5l
d19tbShmcm9tKTsKIAlpZihtbS0+Y29udGV4dC5za2FzLm1tX2ZkIDwgMCkK
KyNpZiAxCiAJCXBhbmljKCJpbml0X25ld19jb250ZXh0X3NrYXMgLSBuZXdf
bW0gZmFpbGVkLCBlcnJubyA9ICVkXG4iLAogCQkgICAgICBtbS0+Y29udGV4
dC5za2FzLm1tX2ZkKTsKKyNlbHNlIC8qIERPTidUIFBBTklDICovCisJCXJl
dHVybihtbS0+Y29udGV4dC5za2FzLm1tX2ZkKTsKKyNlbmRpZgogCiAJcmV0
dXJuKDApOwogfQogCiB2b2lkIGRlc3Ryb3lfY29udGV4dF9za2FzKHN0cnVj
dCBtbV9zdHJ1Y3QgKm1tKQogeworCS8qIGZpbGVtYXBwZWQgZmlsZXMgd2ls
bCByZXR1cm4gc29tZXRoaW5nIG90aGVyIHRoYW4gLUVOT0VOVCAqLworCWlm
KGZpbGVtYXBfcmVsZWFzZSgibW0iLCBtbS0+Y29udGV4dC5za2FzLm1tX2Zk
KSAhPSAtRU5PRU5UKSB7CisJCXJldHVybjsKKwl9CisKIAlvc19jbG9zZV9m
aWxlKG1tLT5jb250ZXh0LnNrYXMubW1fZmQpOwogfQogCg==


------=_NextPart_000_3386_1234_66e2--


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
