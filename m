Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard.weinberger@gmail.com>) id 1UbcNk-0006NP-ME
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 12 May 2013 19:56:32 +0000
Received: from mail-wi0-f180.google.com ([209.85.212.180])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1UbcNj-0007CL-Sr
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 12 May 2013 19:56:32 +0000
Received: by mail-wi0-f180.google.com with SMTP id h11so2253483wiv.1
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 12 May 2013 12:56:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <518FF354.7020408@gmx.de>
References: <518FB97A.5070907@gmx.de>
	<CAFLxGvzn+Q=D4vjTNuggSTnQKVp0QYLPoHmUwAVBcRbSmD3HWQ@mail.gmail.com>
	<518FBE6A.50605@gmx.de>
	<CAFLxGvyvRb+WD-eLBFnH5O-sXjUdtUkXbKzG6HFqgzm+x2LUow@mail.gmail.com>
	<CAFLxGvwEiE0dfw9Vju_Xg6mXkF_NH_OU_t7puPceYN42dphTLA@mail.gmail.com>
	<518FE33B.60701@gmx.de>
	<CAFLxGvyiKbbkPAG0h42y1fb=Z6YuboJPdyb+2Xk9Z2YYt7oryg@mail.gmail.com>
	<518FF354.7020408@gmx.de>
Date: Sun, 12 May 2013 21:56:25 +0200
Message-ID: <CAFLxGvxYjpt6X9MQF3Huh-Sqzm3CBMJAfGb_Qjpqu00iUzj=qg@mail.gmail.com>
From: richard -rw- weinberger <richard.weinberger@gmail.com>
Content-Type: multipart/mixed; boundary=047d7b343d6291b4d504dc8acb17
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] WARNING: at mm/mmap.c:2757 exit_mmap+0x161/0x170()
To: =?ISO-8859-1?Q?Toralf_F=F6rster?= <toralf.foerster@gmx.de>
Cc: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

--047d7b343d6291b4d504dc8acb17
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Sun, May 12, 2013 at 9:53 PM, Toralf F=F6rster <toralf.foerster@gmx.de> =
wrote:
> On 05/12/2013 09:45 PM, richard -rw- weinberger wrote:
>> Damn, we've underrun the counter. :-\
>> Can you please test the attached 3rd debug patch?
>
> yes - but give me a chance and attach a patch ;)

*grrrr* I'm a way to stupid for that new gmail user interface.

--
Thanks,
//richard

--047d7b343d6291b4d504dc8acb17
Content-Type: application/octet-stream; name="stub_pte_fix3.diff"
Content-Disposition: attachment; filename="stub_pte_fix3.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hgmn88bf0

ZGlmZiAtLWdpdCBhL2FyY2gvdW0vaW5jbHVkZS9hc20vS2J1aWxkIGIvYXJjaC91bS9pbmNsdWRl
L2FzbS9LYnVpbGQKaW5kZXggYjMwZjM0YS4uZGIyZDg4NSAxMDA2NDQKLS0tIGEvYXJjaC91bS9p
bmNsdWRlL2FzbS9LYnVpbGQKKysrIGIvYXJjaC91bS9pbmNsdWRlL2FzbS9LYnVpbGQKQEAgLTMs
MyArMyw0IEBAIGdlbmVyaWMteSArPSBod19pcnEuaCBpcnFfcmVncy5oIGtkZWJ1Zy5oIHBlcmNw
dS5oIHNlY3Rpb25zLmggdG9wb2xvZ3kuaCB4b3IuaAogZ2VuZXJpYy15ICs9IGZ0cmFjZS5oIHBj
aS5oIGlvLmggcGFyYW0uaCBkZWxheS5oIG11dGV4LmggY3VycmVudC5oIGV4ZWMuaAogZ2VuZXJp
Yy15ICs9IHN3aXRjaF90by5oIGNsa2Rldi5oCiBnZW5lcmljLXkgKz0gdHJhY2VfY2xvY2suaAor
aGVhZGVyLXkgKz0gbW1hbi5oCmRpZmYgLS1naXQgYS9hcmNoL3VtL2tlcm5lbC9za2FzL21tdS5j
IGIvYXJjaC91bS9rZXJuZWwvc2thcy9tbXUuYwppbmRleCBmZjAzMDY3Li5jZGNmMWE0IDEwMDY0
NAotLS0gYS9hcmNoL3VtL2tlcm5lbC9za2FzL21tdS5jCisrKyBiL2FyY2gvdW0va2VybmVsL3Nr
YXMvbW11LmMKQEAgLTIxLDYgKzIxLDcgQEAgc3RhdGljIGludCBpbml0X3N0dWJfcHRlKHN0cnVj
dCBtbV9zdHJ1Y3QgKm1tLCB1bnNpZ25lZCBsb25nIHByb2MsCiAJcHVkX3QgKnB1ZDsKIAlwbWRf
dCAqcG1kOwogCXB0ZV90ICpwdGU7CisJdW5zaWduZWQgbG9uZyBucl9wdGVzID0gbW0tPm5yX3B0
ZXM7CiAKIAlwZ2QgPSBwZ2Rfb2Zmc2V0KG1tLCBwcm9jKTsKIAlwdWQgPSBwdWRfYWxsb2MobW0s
IHBnZCwgcHJvYyk7CkBAIC0zNyw2ICszOCwxMCBAQCBzdGF0aWMgaW50IGluaXRfc3R1Yl9wdGUo
c3RydWN0IG1tX3N0cnVjdCAqbW0sIHVuc2lnbmVkIGxvbmcgcHJvYywKIAogCSpwdGUgPSBta19w
dGUodmlydF90b19wYWdlKGtlcm5lbCksIF9fcGdwcm90KF9QQUdFX1BSRVNFTlQpKTsKIAkqcHRl
ID0gcHRlX21rcmVhZCgqcHRlKTsKKworCWlmIChtbS0+bnJfcHRlcyA+IG5yX3B0ZXMpCisJCW1t
LT5ucl9wdGVzLS07CisKIAlyZXR1cm4gMDsKIAogIG91dF9wdGU6CkBAIC0xMDMsNyArMTA4LDcg
QEAgaW50IGluaXRfbmV3X2NvbnRleHQoc3RydWN0IHRhc2tfc3RydWN0ICp0YXNrLCBzdHJ1Y3Qg
bW1fc3RydWN0ICptbSkKIAogdm9pZCB1bWxfc2V0dXBfc3R1YnMoc3RydWN0IG1tX3N0cnVjdCAq
bW0pCiB7Ci0JaW50IGVyciwgcmV0OworCWludCByZXQ7CiAKIAlpZiAoIXNrYXNfbmVlZHNfc3R1
YikKIAkJcmV0dXJuOwpAQCAtMTIwLDE1ICsxMjUsNiBAQCB2b2lkIHVtbF9zZXR1cF9zdHVicyhz
dHJ1Y3QgbW1fc3RydWN0ICptbSkKIAltbS0+Y29udGV4dC5zdHViX3BhZ2VzWzBdID0gdmlydF90
b19wYWdlKCZfX3N5c2NhbGxfc3R1Yl9zdGFydCk7CiAJbW0tPmNvbnRleHQuc3R1Yl9wYWdlc1sx
XSA9IHZpcnRfdG9fcGFnZShtbS0+Y29udGV4dC5pZC5zdGFjayk7CiAKLQkvKiBkdXBfbW1hcCBh
bHJlYWR5IGhvbGRzIG1tYXBfc2VtICovCi0JZXJyID0gaW5zdGFsbF9zcGVjaWFsX21hcHBpbmco
bW0sIFNUVUJfU1RBUlQsIFNUVUJfRU5EIC0gU1RVQl9TVEFSVCwKLQkJCQkgICAgICBWTV9SRUFE
IHwgVk1fTUFZUkVBRCB8IFZNX0VYRUMgfAotCQkJCSAgICAgIFZNX01BWUVYRUMgfCBWTV9ET05U
Q09QWSwKLQkJCQkgICAgICBtbS0+Y29udGV4dC5zdHViX3BhZ2VzKTsKLQlpZiAoZXJyKSB7Ci0J
CXByaW50ayhLRVJOX0VSUiAiaW5zdGFsbF9zcGVjaWFsX21hcHBpbmcgcmV0dXJuZWQgJWRcbiIs
IGVycik7Ci0JCWdvdG8gb3V0OwotCX0KIAlyZXR1cm47CiAKIG91dDoKZGlmZiAtLWdpdCBhL21t
L21tYXAuYyBiL21tL21tYXAuYwppbmRleCBmNjgxZTE4Li5jYmQzODdkIDEwMDY0NAotLS0gYS9t
bS9tbWFwLmMKKysrIGIvbW0vbW1hcC5jCkBAIC0yNzU0LDcgKzI3NTQsOCBAQCB2b2lkIGV4aXRf
bW1hcChzdHJ1Y3QgbW1fc3RydWN0ICptbSkKIAl9CiAJdm1fdW5hY2N0X21lbW9yeShucl9hY2Nv
dW50ZWQpOwogCi0JV0FSTl9PTihtbS0+bnJfcHRlcyA+IChGSVJTVF9VU0VSX0FERFJFU1MrUE1E
X1NJWkUtMSk+PlBNRF9TSElGVCk7CisJaWYgKFdBUk5fT04obW0tPm5yX3B0ZXMgPiAoRklSU1Rf
VVNFUl9BRERSRVNTK1BNRF9TSVpFLTEpPj5QTURfU0hJRlQpKQorCQlwcmludGsoS0VSTl9FUlIg
IlhYWCBtbS0+bnJfcHRlczogJWx1XG4iLCBtbS0+bnJfcHRlcyk7CiB9CiAKIC8qIEluc2VydCB2
bSBzdHJ1Y3R1cmUgaW50byBwcm9jZXNzIGxpc3Qgc29ydGVkIGJ5IGFkZHJlc3MK
--047d7b343d6291b4d504dc8acb17
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and 
their applications. This 200-page book is written by three acclaimed 
leaders in the field. The early access version is available now. 
Download your free book today! http://p.sf.net/sfu/neotech_d2d_may
--047d7b343d6291b4d504dc8acb17
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--047d7b343d6291b4d504dc8acb17--


