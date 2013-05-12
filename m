Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard.weinberger@gmail.com>) id 1UbZBF-0007PQ-3L
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 12 May 2013 16:31:25 +0000
Received: from mail-we0-f169.google.com ([74.125.82.169])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1UbZBE-00057v-CK
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 12 May 2013 16:31:25 +0000
Received: by mail-we0-f169.google.com with SMTP id x54so5608941wes.14
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 12 May 2013 09:31:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFLxGvyvRb+WD-eLBFnH5O-sXjUdtUkXbKzG6HFqgzm+x2LUow@mail.gmail.com>
References: <518FB97A.5070907@gmx.de>
	<CAFLxGvzn+Q=D4vjTNuggSTnQKVp0QYLPoHmUwAVBcRbSmD3HWQ@mail.gmail.com>
	<518FBE6A.50605@gmx.de>
	<CAFLxGvyvRb+WD-eLBFnH5O-sXjUdtUkXbKzG6HFqgzm+x2LUow@mail.gmail.com>
Date: Sun, 12 May 2013 18:31:17 +0200
Message-ID: <CAFLxGvwEiE0dfw9Vju_Xg6mXkF_NH_OU_t7puPceYN42dphTLA@mail.gmail.com>
From: richard -rw- weinberger <richard.weinberger@gmail.com>
Content-Type: multipart/mixed; boundary=047d7b343d62fb99f304dc87edc1
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

--047d7b343d62fb99f304dc87edc1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Sun, May 12, 2013 at 6:10 PM, richard -rw- weinberger
<richard.weinberger@gmail.com> wrote:
> On Sun, May 12, 2013 at 6:08 PM, Toralf F=F6rster <toralf.foerster@gmx.de=
> wrote:
>> On 05/12/2013 05:58 PM, richard -rw- weinberger wrote:
>>> Do you have stub_pte_fix.diff applied?
>> yes, both the stub and the strnlen patch
>
> Okay, I fear stub_pte_fix.diff does not do the right thing.
> /me cooks up a debug patch. Stay tuned.

Toralf, can you please replace stub_pte_fix.diff with the attached patch?

--
Thanks,
//richard

--047d7b343d62fb99f304dc87edc1
Content-Type: application/octet-stream; name="stub_pte_fix2.diff"
Content-Disposition: attachment; filename="stub_pte_fix2.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hgmfwi500

ZGlmZiAtLWdpdCBhL2FyY2gvdW0vaW5jbHVkZS9hc20vS2J1aWxkIGIvYXJjaC91bS9pbmNsdWRl
L2FzbS9LYnVpbGQKaW5kZXggYjMwZjM0YS4uZGIyZDg4NSAxMDA2NDQKLS0tIGEvYXJjaC91bS9p
bmNsdWRlL2FzbS9LYnVpbGQKKysrIGIvYXJjaC91bS9pbmNsdWRlL2FzbS9LYnVpbGQKQEAgLTMs
MyArMyw0IEBAIGdlbmVyaWMteSArPSBod19pcnEuaCBpcnFfcmVncy5oIGtkZWJ1Zy5oIHBlcmNw
dS5oIHNlY3Rpb25zLmggdG9wb2xvZ3kuaCB4b3IuaAogZ2VuZXJpYy15ICs9IGZ0cmFjZS5oIHBj
aS5oIGlvLmggcGFyYW0uaCBkZWxheS5oIG11dGV4LmggY3VycmVudC5oIGV4ZWMuaAogZ2VuZXJp
Yy15ICs9IHN3aXRjaF90by5oIGNsa2Rldi5oCiBnZW5lcmljLXkgKz0gdHJhY2VfY2xvY2suaAor
aGVhZGVyLXkgKz0gbW1hbi5oCmRpZmYgLS1naXQgYS9hcmNoL3VtL2tlcm5lbC9za2FzL21tdS5j
IGIvYXJjaC91bS9rZXJuZWwvc2thcy9tbXUuYwppbmRleCBmZjAzMDY3Li5mNDFiMWE4IDEwMDY0
NAotLS0gYS9hcmNoL3VtL2tlcm5lbC9za2FzL21tdS5jCisrKyBiL2FyY2gvdW0va2VybmVsL3Nr
YXMvbW11LmMKQEAgLTIxLDYgKzIxLDcgQEAgc3RhdGljIGludCBpbml0X3N0dWJfcHRlKHN0cnVj
dCBtbV9zdHJ1Y3QgKm1tLCB1bnNpZ25lZCBsb25nIHByb2MsCiAJcHVkX3QgKnB1ZDsKIAlwbWRf
dCAqcG1kOwogCXB0ZV90ICpwdGU7CisJdW5zaWduZWQgbG9uZyBucl9wdGVzID0gbW0tPm5yX3B0
ZXM7CiAKIAlwZ2QgPSBwZ2Rfb2Zmc2V0KG1tLCBwcm9jKTsKIAlwdWQgPSBwdWRfYWxsb2MobW0s
IHBnZCwgcHJvYyk7CkBAIC0zNyw2ICszOCw3IEBAIHN0YXRpYyBpbnQgaW5pdF9zdHViX3B0ZShz
dHJ1Y3QgbW1fc3RydWN0ICptbSwgdW5zaWduZWQgbG9uZyBwcm9jLAogCiAJKnB0ZSA9IG1rX3B0
ZSh2aXJ0X3RvX3BhZ2Uoa2VybmVsKSwgX19wZ3Byb3QoX1BBR0VfUFJFU0VOVCkpOwogCSpwdGUg
PSBwdGVfbWtyZWFkKCpwdGUpOworCW1tLT5ucl9wdGVzID0gbnJfcHRlczsKIAlyZXR1cm4gMDsK
IAogIG91dF9wdGU6CkBAIC0xMDMsNyArMTA1LDcgQEAgaW50IGluaXRfbmV3X2NvbnRleHQoc3Ry
dWN0IHRhc2tfc3RydWN0ICp0YXNrLCBzdHJ1Y3QgbW1fc3RydWN0ICptbSkKIAogdm9pZCB1bWxf
c2V0dXBfc3R1YnMoc3RydWN0IG1tX3N0cnVjdCAqbW0pCiB7Ci0JaW50IGVyciwgcmV0OworCWlu
dCByZXQ7CiAKIAlpZiAoIXNrYXNfbmVlZHNfc3R1YikKIAkJcmV0dXJuOwpAQCAtMTIwLDE1ICsx
MjIsNiBAQCB2b2lkIHVtbF9zZXR1cF9zdHVicyhzdHJ1Y3QgbW1fc3RydWN0ICptbSkKIAltbS0+
Y29udGV4dC5zdHViX3BhZ2VzWzBdID0gdmlydF90b19wYWdlKCZfX3N5c2NhbGxfc3R1Yl9zdGFy
dCk7CiAJbW0tPmNvbnRleHQuc3R1Yl9wYWdlc1sxXSA9IHZpcnRfdG9fcGFnZShtbS0+Y29udGV4
dC5pZC5zdGFjayk7CiAKLQkvKiBkdXBfbW1hcCBhbHJlYWR5IGhvbGRzIG1tYXBfc2VtICovCi0J
ZXJyID0gaW5zdGFsbF9zcGVjaWFsX21hcHBpbmcobW0sIFNUVUJfU1RBUlQsIFNUVUJfRU5EIC0g
U1RVQl9TVEFSVCwKLQkJCQkgICAgICBWTV9SRUFEIHwgVk1fTUFZUkVBRCB8IFZNX0VYRUMgfAot
CQkJCSAgICAgIFZNX01BWUVYRUMgfCBWTV9ET05UQ09QWSwKLQkJCQkgICAgICBtbS0+Y29udGV4
dC5zdHViX3BhZ2VzKTsKLQlpZiAoZXJyKSB7Ci0JCXByaW50ayhLRVJOX0VSUiAiaW5zdGFsbF9z
cGVjaWFsX21hcHBpbmcgcmV0dXJuZWQgJWRcbiIsIGVycik7Ci0JCWdvdG8gb3V0OwotCX0KIAly
ZXR1cm47CiAKIG91dDoKZGlmZiAtLWdpdCBhL21tL21tYXAuYyBiL21tL21tYXAuYwppbmRleCBm
NjgxZTE4Li5jYmQzODdkIDEwMDY0NAotLS0gYS9tbS9tbWFwLmMKKysrIGIvbW0vbW1hcC5jCkBA
IC0yNzU0LDcgKzI3NTQsOCBAQCB2b2lkIGV4aXRfbW1hcChzdHJ1Y3QgbW1fc3RydWN0ICptbSkK
IAl9CiAJdm1fdW5hY2N0X21lbW9yeShucl9hY2NvdW50ZWQpOwogCi0JV0FSTl9PTihtbS0+bnJf
cHRlcyA+IChGSVJTVF9VU0VSX0FERFJFU1MrUE1EX1NJWkUtMSk+PlBNRF9TSElGVCk7CisJaWYg
KFdBUk5fT04obW0tPm5yX3B0ZXMgPiAoRklSU1RfVVNFUl9BRERSRVNTK1BNRF9TSVpFLTEpPj5Q
TURfU0hJRlQpKQorCQlwcmludGsoS0VSTl9FUlIgIlhYWCBtbS0+bnJfcHRlczogJWx1XG4iLCBt
bS0+bnJfcHRlcyk7CiB9CiAKIC8qIEluc2VydCB2bSBzdHJ1Y3R1cmUgaW50byBwcm9jZXNzIGxp
c3Qgc29ydGVkIGJ5IGFkZHJlc3MK
--047d7b343d62fb99f304dc87edc1
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
--047d7b343d62fb99f304dc87edc1
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--047d7b343d62fb99f304dc87edc1--


