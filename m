Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AnH7j-0004Ff-MD
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 01 Feb 2004 04:54:51 -0800
Received: from hermes.dur.ac.uk ([129.234.4.9])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1AnH7i-0007af-RT
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 01 Feb 2004 04:54:51 -0800
Received: from mercury.dur.ac.uk (mercury.dur.ac.uk [129.234.4.40])
	by hermes.dur.ac.uk (8.11.7-20030923/8.11.7) with ESMTP id i11Csj121886
	for <user-mode-linux-devel@lists.sourceforge.net>; Sun, 1 Feb 2004 12:54:45 GMT
Received: from vega.dur.ac.uk (vega.dur.ac.uk [129.234.4.198])
	by mercury.dur.ac.uk (8.12.10+Sun/8.11.7) with ESMTP id i11Csg7V007754
	for <user-mode-linux-devel@lists.sourceforge.net>; Sun, 1 Feb 2004 12:54:42 GMT
Received: from vega.dur.ac.uk (localhost [127.0.0.1])
	by vega.dur.ac.uk (8.12.8/8.11.1) with ESMTP id i11CsgH9014891
	for <user-mode-linux-devel@lists.sourceforge.net>; Sun, 1 Feb 2004 12:54:42 GMT
Received: from localhost (dit0may@localhost)
	by vega.dur.ac.uk (8.12.8/8.12.8/Submit) with ESMTP id i11Csfww014887
	for <user-mode-linux-devel@lists.sourceforge.net>; Sun, 1 Feb 2004 12:54:42 GMT
From: M A Young <m.a.young@durham.ac.uk>
Message-ID: <Pine.LNX.4.58.0402011247190.14738@vega.dur.ac.uk>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-360593916-67275562-1075640081=:14738"
Subject: [uml-devel] Patch for UML running on exec-shield hosts
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Sun, 1 Feb 2004 12:54:41 +0000 (GMT)
To: user-mode-linux-devel@lists.sourceforge.net


  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---360593916-67275562-1075640081=:14738
Content-Type: TEXT/PLAIN; charset=US-ASCII

Here is a revised version of my patch to address the UML crash when you
try to run it on a host kernel with exec-shield enabled, such as on fedora
core 1. The change is that it increases the value of the physmem_size for
exec-shield users, so they actually get the memory they asked for (and
adds zero in the non-exec shield case).

	Michael Young
---360593916-67275562-1075640081=:14738
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="fedoraseg2.patch"
Content-Transfer-Encoding: BASE64
Content-Description: 
Content-Disposition: attachment; filename="fedoraseg2.patch"

ZGlmZiAtTmF1ciBsaW51eC0yLjQuMjIvYXJjaC91bS9rZXJuZWwvdHQvbWVt
LmMub3JpZyBsaW51eC0yLjQuMjIvYXJjaC91bS9rZXJuZWwvdHQvbWVtLmMN
Ci0tLSBsaW51eC0yLjQuMjIvYXJjaC91bS9rZXJuZWwvdHQvbWVtLmMub3Jp
ZwkyMDAzLTExLTExIDIxOjUyOjMwLjAwMDAwMDAwMCArMDAwMA0KKysrIGxp
bnV4LTIuNC4yMi9hcmNoL3VtL2tlcm5lbC90dC9tZW0uYwkyMDAzLTExLTEy
IDIwOjA2OjM3LjAwMDAwMDAwMCArMDAwMA0KQEAgLTE4LDcgKzE4LDcgQEAN
CiAJaWYoIWphaWwgfHwgZGVidWcpDQogCQlyZW1hcF9kYXRhKFVNTF9ST1VO
RF9ET1dOKCZfc3RleHQpLCBVTUxfUk9VTkRfVVAoJl9ldGV4dCksIDEpOw0K
IAlyZW1hcF9kYXRhKFVNTF9ST1VORF9ET1dOKCZfc2RhdGEpLCBVTUxfUk9V
TkRfVVAoJl9lZGF0YSksIDEpOw0KLQlyZW1hcF9kYXRhKFVNTF9ST1VORF9E
T1dOKCZfX2Jzc19zdGFydCksIFVNTF9ST1VORF9VUChicmtfc3RhcnQpLCAx
KTsNCisJcmVtYXBfZGF0YShVTUxfUk9VTkRfRE9XTigmX19ic3Nfc3RhcnQp
LCBVTUxfUk9VTkRfVVAoJl9lbmQpLCAxKTsNCiB9DQogDQogI2lmZGVmIENP
TkZJR19IT1NUXzJHXzJHDQpkaWZmIC1OYXVyIGxpbnV4LTIuNC4yMi9hcmNo
L3VtL2tlcm5lbC90dC9wcm9jZXNzX2tlcm4uYy5vcmlnIGxpbnV4LTIuNC4y
Mi9hcmNoL3VtL2tlcm5lbC90dC9wcm9jZXNzX2tlcm4uYw0KLS0tIGxpbnV4
LTIuNC4yMi9hcmNoL3VtL2tlcm5lbC90dC9wcm9jZXNzX2tlcm4uYy5vcmln
CTIwMDMtMTEtMTEgMjE6NTI6MzAuMDAwMDAwMDAwICswMDAwDQorKysgbGlu
dXgtMi40LjIyL2FyY2gvdW0va2VybmVsL3R0L3Byb2Nlc3Nfa2Vybi5jCTIw
MDMtMTEtMTIgMjA6MDc6NDYuMDAwMDAwMDAwICswMDAwDQpAQCAtNDA1LDcg
KzQwNSw3IEBADQogCXByb3RlY3RfbWVtb3J5KHN0YXJ0LCBlbmQgLSBzdGFy
dCwgMSwgdywgMSwgMSk7DQogDQogCXN0YXJ0ID0gKHVuc2lnbmVkIGxvbmcp
IFVNTF9ST1VORF9ET1dOKCZfX2Jzc19zdGFydCk7DQotCWVuZCA9ICh1bnNp
Z25lZCBsb25nKSBVTUxfUk9VTkRfVVAoYnJrX3N0YXJ0KTsNCisJZW5kID0g
KHVuc2lnbmVkIGxvbmcpIFVNTF9ST1VORF9VUCgmX2VuZCk7DQogCXByb3Rl
Y3RfbWVtb3J5KHN0YXJ0LCBlbmQgLSBzdGFydCwgMSwgdywgMSwgMSk7DQog
DQogCW1wcm90ZWN0X2tlcm5lbF92bSh3KTsNCmRpZmYgLU5hdXIgbGludXgt
Mi42LjEvYXJjaC91bS9rZXJuZWwvdW1fYXJjaC5jLm9yaWcgbGludXgtMi42
LjEvYXJjaC91bS9rZXJuZWwvdW1fYXJjaC5jDQotLS0gbGludXgtMi42LjEv
YXJjaC91bS9rZXJuZWwvdW1fYXJjaC5jLm9yaWcJMjAwNC0wMi0wMSAxMjoz
OTo1OS4wMDAwMDAwMDAgKzAwMDANCisrKyBsaW51eC0yLjYuMS9hcmNoL3Vt
L2tlcm5lbC91bV9hcmNoLmMJMjAwNC0wMi0wMSAxMjo0MTo1My4wMDAwMDAw
MDAgKzAwMDANCkBAIC0zMjQsNiArMzI0LDEwIEBADQogDQogCWJya19zdGFy
dCA9ICh1bnNpZ25lZCBsb25nKSBzYnJrKDApOw0KIAlDSE9PU0VfTU9ERV9Q
Uk9DKGJlZm9yZV9tZW1fdHQsIGJlZm9yZV9tZW1fc2thcywgYnJrX3N0YXJ0
KTsNCisJLyogSW5jcmVhc2UgcGh5c2ljYWwgbWVtb3J5IHNpemUgZm9yIGV4
ZWMtc2hpZWxkIHVzZXJzDQorCXNvIHRoZXkgYWN0dWFsbHkgZ2V0IHdoYXQg
dGhleSBhc2tlZCBmb3IuIFRoaXMgc2hvdWxkDQorCWFkZCB6ZXJvIGZvciBu
b24tZXhlYyBzaGllbGQgdXNlcnMgKi8NCisJcGh5c21lbV9zaXplICs9IFVN
TF9ST1VORF9VUChicmtfc3RhcnQpIC0gVU1MX1JPVU5EX1VQKCZfZW5kKTsN
CiANCiAJdW1sX3BoeXNtZW0gPSB1bWxfc3RhcnQ7DQogDQo=

---360593916-67275562-1075640081=:14738--


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
