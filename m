Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19xUPW-0004h1-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Thu, 11 Sep 2003 09:35:10 -0700
Received: from pluto.nixia.no ([195.159.42.3])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.22)
	id 19xUPV-0004Kg-Cu
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 11 Sep 2003 09:35:09 -0700
Message-ID: <22298.193.212.97.12.1063290273.squirrel@pluto.nixia.no>
In-Reply-To: <200309111520.h8BFKNfA008937@uml.karaya.com>
References: <200309111520.h8BFKNfA008937@uml.karaya.com>
Subject: Re: [uml-devel] uml-patch-2.4.22-3
From: stian@nixia.no
MIME-Version: 1.0
Content-Type: multipart/mixed;charset=iso-8859-1;
     boundary="----=_20030911162433_21812"
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
Date: Thu, 11 Sep 2003 16:24:33 +0200 (CEST)
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net


------=_20030911162433_21812
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

> This patch fixes the I/O operation mismatch panic, thanks to Oleg.
>
> There were also some small cleanups and bug fixes.

Looking over the code due to you guys hunting down this last bug

Just saw a little detail. If clone() fails in io_start_thread in
ubd_user.c, *fd (thread_fd in caller) is given a value, when it should
close the pipe and don't touch *fd

Secondly, in the caller, we can get io_pid values other than -1 that is
negativ which is not good when this modules cleans it self up. Attaching
minor patch. Mostly just for the sake of the code being clean.


Stian
------=_20030911162433_21812
Content-Type: application/octet-stream; name="uml-cleanup.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="uml-cleanup.patch"

ZGlmZiAtcnUgbGludXgtMi40LjIyL2FyY2gvdW0vZHJpdmVycy91YmRfa2Vybi5jIGxpbnV4LTIu

NC4yMi1vcmlnL2FyY2gvdW0vZHJpdmVycy91YmRfa2Vybi5jCi0tLSBsaW51eC0yLjQuMjIvYXJj

aC91bS9kcml2ZXJzL3ViZF9rZXJuLmMJVGh1IFNlcCAxMSAxODoyNDozNyAyMDAzCisrKyBsaW51

eC0yLjQuMjItb3JpZy9hcmNoL3VtL2RyaXZlcnMvdWJkX2tlcm4uYwlUaHUgU2VwIDExIDE3OjU2

OjMzIDIwMDMKQEAgLTcxNyw2ICs3MTcsNyBAQAogCQlwcmludGsoS0VSTl9FUlIgCiAJCSAgICAg

ICAidWJkIDogRmFpbGVkIHRvIHN0YXJ0IEkvTyB0aHJlYWQgKGVycm5vID0gJWQpIC0gIgogCQkg

ICAgICAgImZhbGxpbmcgYmFjayB0byBzeW5jaHJvbm91cyBJL09cbiIsIC1pb19waWQpOworCQlp

b19waWQ9LTE7CiAJCXJldHVybigwKTsKIAl9CiAJZXJyID0gdW1fcmVxdWVzdF9pcnEoVUJEX0lS

USwgdGhyZWFkX2ZkLCBJUlFfUkVBRCwgdWJkX2ludHIsIApkaWZmIC1ydSBsaW51eC0yLjQuMjIv

YXJjaC91bS9kcml2ZXJzL3ViZF91c2VyLmMgbGludXgtMi40LjIyLW9yaWcvYXJjaC91bS9kcml2

ZXJzL3ViZF91c2VyLmMKLS0tIGxpbnV4LTIuNC4yMi9hcmNoL3VtL2RyaXZlcnMvdWJkX3VzZXIu

YwlUaHUgU2VwIDExIDE4OjI0OjM3IDIwMDMKKysrIGxpbnV4LTIuNC4yMi1vcmlnL2FyY2gvdW0v

ZHJpdmVycy91YmRfdXNlci5jCVRodSBTZXAgMTEgMTg6MTY6NTUgMjAwMwpAQCAtMzM1LDE1ICsz

MzUsMjEgQEAKIAkJcHJpbnRrKCJzdGFydF9pb190aHJlYWQgLSBvc19waXBlIGZhaWxlZCwgZXJy

bm8gPSAlZFxuIiwgLWVycik7CiAJCXJldHVybigtMSk7CiAJfQotCWtlcm5lbF9mZCA9IGZkc1sw

XTsKLQkqZmRfb3V0ID0gZmRzWzFdOwogCiAJcGlkID0gY2xvbmUoaW9fdGhyZWFkLCAodm9pZCAq

KSBzcCwgQ0xPTkVfRklMRVMgfCBDTE9ORV9WTSB8IFNJR0NITEQsCiAJCSAgICBOVUxMKTsKKwkK

IAlpZihwaWQgPCAwKXsKLQkJcHJpbnRrKCJzdGFydF9pb190aHJlYWQgLSBjbG9uZSBmYWlsZWQg

OiBlcnJubyA9ICVkXG4iLCBlcnJubyk7Ci0JCXJldHVybigtZXJybm8pOworCQllcnI9ZXJybm87

CisJCW9zX2Nsb3NlX2ZpbGUoZmRzWzBdKTsKKwkJb3NfY2xvc2VfZmlsZShmZHNbMV0pOworCQlw

cmludGsoInN0YXJ0X2lvX3RocmVhZCAtIGNsb25lIGZhaWxlZCA6IGVycm5vID0gJWRcbiIsIGVy

cik7CisJCXJldHVybigtZXJyKTsKIAl9CisKKwlrZXJuZWxfZmQgPSBmZHNbMF07CisJKmZkX291

dCA9IGZkc1sxXTsKKwogCXJldHVybihwaWQpOwogfQogCg==

------=_20030911162433_21812
Content-Type: text/plain; charset=iso-8859-1; name="antivirus.txt"
Content-Transfer-Encoding: 8bit
Content-Length: 144



This mail has been scanned for known viruses on an open, Linux-based mailsystem
developed by http://Knowledge-Network.no and http://Nixia.no.
------=_20030911162433_21812--



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
