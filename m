Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BHJRV-0006JV-8I for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 24 Apr 2004 02:27:25 -0700
Received: from marasystems.com ([213.150.153.194] helo=filer.marasystems.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BHJRU-0001ql-JD for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 24 Apr 2004 02:27:24 -0700
Received: from localhost (henrik@localhost)
	by filer.marasystems.com (8.11.6/8.11.6) with ESMTP id i3O9RL503090
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 24 Apr 2004 11:27:21 +0200
From: Henrik Nordstrom <hno@marasystems.com>
Message-ID: <Pine.LNX.4.44.0404241122180.3059-200000@filer.marasystems.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-1463811839-1789097498-1082798841=:3059"
Subject: [uml-devel] [patch] 2.4 aio.c compile without 2.6 aio_abi.h
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Sat, 24 Apr 2004 11:27:21 +0200 (CEST)
To: user-mode-linux-devel@lists.sourceforge.net


  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1463811839-1789097498-1082798841=:3059
Content-Type: TEXT/PLAIN; charset=US-ASCII

uml-2.4 kernel build fails on aio.c due to references to AIO ABI details 
not present on the host (HAVE_AIO_ABI is not set).

This small patch adds ifdefs as appropriate to not compile the 2.6 AIO
support unless the host headers supports it.

Still building the kernel, but now it at least gets past os-Linux/aio.c

Regards
Henrik

---1463811839-1789097498-1082798841=:3059
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="uml-aio-noabi.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44.0404241127210.3059@filer.marasystems.com>
Content-Description: 
Content-Disposition: attachment; filename="uml-aio-noabi.patch"

SW5kZXg6IGFyY2gvdW0vb3MtTGludXgvYWlvLmMNCj09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT0NClJDUyBmaWxlOiAvY3Zzcm9vdC91c2VyLW1vZGUtbGludXgv
bGludXgvYXJjaC91bS9vcy1MaW51eC9haW8uYyx2DQpyZXRyaWV2aW5nIHJl
dmlzaW9uIDEuMQ0KZGlmZiAtdSAtcCAtcjEuMSBhaW8uYw0KLS0tIGFyY2gv
dW0vb3MtTGludXgvYWlvLmMJNyBBcHIgMjAwNCAyMDo0NDoxOCAtMDAwMAkx
LjENCisrKyBhcmNoL3VtL29zLUxpbnV4L2Fpby5jCTI0IEFwciAyMDA0IDA5
OjE1OjE0IC0wMDAwDQpAQCAtOSw3ICs5LDkgQEANCiAjaW5jbHVkZSA8ZXJy
bm8uaD4NCiAjaW5jbHVkZSA8c2NoZWQuaD4NCiAjaW5jbHVkZSA8c3lzL3N5
c2NhbGwuaD4NCisjaWYgZGVmaW5lZChIQVZFX0FJT19BQkkpDQogI2luY2x1
ZGUgPGxpbnV4L2Fpb19hYmkuaD4NCisjZW5kaWYNCiAjaW5jbHVkZSAib3Mu
aCINCiAjaW5jbHVkZSAiaGVscGVyLmgiDQogI2luY2x1ZGUgImFpby5oIg0K
QEAgLTI0NSw2ICsyNDcsNyBAQCBzdGF0aWMgaW50IGluaXRfYWlvXzI0KHZv
aWQpDQogCXJldHVybigwKTsNCiB9DQogDQorI2lmIGRlZmluZWQoSEFWRV9B
SU9fQUJJKQ0KIHN0YXRpYyBpbnQgaW5pdF9haW9fMjYodm9pZCkNCiB7DQog
CXVuc2lnbmVkIGxvbmcgc3RhY2s7DQpAQCAtMjgyLDYgKzI4NSwxMyBAQCBz
dGF0aWMgaW50IGluaXRfYWlvKHZvaWQpDQogCQlyZXR1cm4oaW5pdF9haW9f
MjQoKSk7DQogCWVsc2UgcmV0dXJuKGluaXRfYWlvXzI2KCkpOw0KIH0NCisj
ZWxzZQ0KK3N0YXRpYyBpbnQgaW5pdF9haW8odm9pZCkNCit7DQorCXByaW50
aygiQ29tcGlsZWQgd2l0aG91dCAyLjYgQUlPIHN1cHBvcnRcbiIpOw0KKwly
ZXR1cm4oaW5pdF9haW9fMjQoKSk7DQorfQ0KKyNlbmRpZg0KIA0KIF9faW5p
dGNhbGwoaW5pdF9haW8pOw0KIA0KQEAgLTMxMyw2ICszMjMsNyBAQCBpbnQg
c3VibWl0X2Fpb18yNChlbnVtIGFpb190eXBlIHR5cGUsIGluDQogCXJldHVy
bihlcnIpOw0KIH0NCiANCisjaWYgZGVmaW5lZChIQVZFX0FJT19BQkkpDQog
aW50IHN1Ym1pdF9haW9fMjYoZW51bSBhaW9fdHlwZSB0eXBlLCBpbnQgaW9f
ZmQsIGNoYXIgKmJ1ZiwgaW50IGxlbiwgDQogCQkgIHVuc2lnbmVkIGxvbmcg
bG9uZyBvZmZzZXQsIGludCByZXBseV9mZCwgdm9pZCAqZGF0YSkNCiB7DQpA
QCAtMzQ1LDYgKzM1NiwxMyBAQCBpbnQgc3VibWl0X2FpbyhlbnVtIGFpb190
eXBlIHR5cGUsIGludCBpDQogCQkJCSAgICAgZGF0YSkpOw0KIAl9DQogfQ0K
KyNlbHNlDQoraW50IHN1Ym1pdF9haW8oZW51bSBhaW9fdHlwZSB0eXBlLCBp
bnQgaW9fZmQsIGNoYXIgKmJ1ZiwgaW50IGxlbiwgDQorCSAgICAgICB1bnNp
Z25lZCBsb25nIGxvbmcgb2Zmc2V0LCBpbnQgcmVwbHlfZmQsIHZvaWQgKmRh
dGEpDQorew0KKwlyZXR1cm4oc3VibWl0X2Fpb18yNCh0eXBlLCBpb19mZCwg
YnVmLCBsZW4sIG9mZnNldCwgcmVwbHlfZmQsIGRhdGEpKTsNCit9DQorI2Vu
ZGlmDQogDQogLyoNCiAgKiBPdmVycmlkZXMgZm9yIEVtYWNzIHNvIHRoYXQg
d2UgZm9sbG93IExpbnVzJ3MgdGFiYmluZyBzdHlsZS4NCg==
---1463811839-1789097498-1082798841=:3059--


-------------------------------------------------------
This SF.net email is sponsored by: The Robotic Monkeys at ThinkGeek
For a limited time only, get FREE Ground shipping on all orders of $35
or more. Hurry up and shop folks, this offer expires April 30th!
http://www.thinkgeek.com/freeshipping/?cpg=12297
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
