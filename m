Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AnHG5-0003Zh-DM
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 01 Feb 2004 05:03:29 -0800
Received: from hermes.dur.ac.uk ([129.234.4.9])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1AnHG3-00037Z-0h
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 01 Feb 2004 05:03:27 -0800
Received: from mercury.dur.ac.uk (mercury.dur.ac.uk [129.234.4.40])
	by hermes.dur.ac.uk (8.11.7-20030923/8.11.7) with ESMTP id i11D3K122580
	for <user-mode-linux-devel@lists.sourceforge.net>; Sun, 1 Feb 2004 13:03:20 GMT
Received: from vega.dur.ac.uk (vega.dur.ac.uk [129.234.4.198])
	by mercury.dur.ac.uk (8.12.10+Sun/8.11.7) with ESMTP id i11D3I7V008408
	for <user-mode-linux-devel@lists.sourceforge.net>; Sun, 1 Feb 2004 13:03:18 GMT
Received: from vega.dur.ac.uk (localhost [127.0.0.1])
	by vega.dur.ac.uk (8.12.8/8.11.1) with ESMTP id i11D3IH9014971
	for <user-mode-linux-devel@lists.sourceforge.net>; Sun, 1 Feb 2004 13:03:18 GMT
Received: from localhost (dit0may@localhost)
	by vega.dur.ac.uk (8.12.8/8.12.8/Submit) with ESMTP id i11D3ItX014967
	for <user-mode-linux-devel@lists.sourceforge.net>; Sun, 1 Feb 2004 13:03:18 GMT
From: M A Young <m.a.young@durham.ac.uk>
Message-ID: <Pine.LNX.4.58.0402011254480.14738@vega.dur.ac.uk>
MIME-Version: 1.0
Content-Type: MULTIPART/Mixed; BOUNDARY="-360593916-67275562-1075640081=:14738"
Subject: [uml-devel] sigjmp cleanup patch (2.6)
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
Date: Sun, 1 Feb 2004 13:03:18 +0000 (GMT)
To: user-mode-linux-devel@lists.sourceforge.net


  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---360593916-67275562-1075640081=:14738
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII

This patch cleans up the code so that the sigsetjmp calls use the correct
data type (sigjmp_buf rather than jmp_buf). This could fix a potential
bug, though I don't know of any actual bugs that this fixes. The patch is
for 2.6, though 2.4 has the same issue also.

	Michael Young
---360593916-67275562-1075640081=:14738
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="sigjmp2.patch"
Content-Transfer-Encoding: BASE64
Content-Description: 
Content-Disposition: attachment; filename="sigjmp2.patch"

ZGlmZiAtTmF1ciBsaW51eC0yLjYuMC9hcmNoL3VtL2tlcm5lbC90cmFwX3Vz
ZXIuYy5vcmlnIGxpbnV4LTIuNi4wL2FyY2gvdW0va2VybmVsL3RyYXBfdXNl
ci5jDQotLS0gbGludXgtMi42LjAvYXJjaC91bS9rZXJuZWwvdHJhcF91c2Vy
LmMub3JpZwkyMDA0LTAxLTEzIDIzOjIxOjM0LjI2NDQ5MTAwMCArMDAwMA0K
KysrIGxpbnV4LTIuNi4wL2FyY2gvdW0va2VybmVsL3RyYXBfdXNlci5jCTIw
MDQtMDEtMTMgMjM6MjI6MTcuMDU0NDkxMDAwICswMDAwDQpAQCAtMTIxLDcg
KzEyMSw3IEBADQogDQogdm9pZCBkb19sb25nam1wKHZvaWQgKmIsIGludCB2
YWwpDQogew0KLQlqbXBfYnVmICpidWYgPSBiOw0KKwlzaWdqbXBfYnVmICpi
dWYgPSBiOw0KIA0KIAlzaWdsb25nam1wKCpidWYsIHZhbCk7DQogfQ0KZGlm
ZiAtTmF1ciBsaW51eC0yLjYuMC9hcmNoL3VtL2tlcm5lbC9wcm9jZXNzLmMu
b3JpZyBsaW51eC0yLjYuMC9hcmNoL3VtL2tlcm5lbC9wcm9jZXNzLmMNCi0t
LSBsaW51eC0yLjYuMC9hcmNoL3VtL2tlcm5lbC9wcm9jZXNzLmMub3JpZwky
MDA0LTAxLTEzIDIzOjIwOjA5LjAwNDQ5MTAwMCArMDAwMA0KKysrIGxpbnV4
LTIuNi4wL2FyY2gvdW0va2VybmVsL3Byb2Nlc3MuYwkyMDA0LTAxLTEzIDIz
OjIxOjEwLjI2NDQ5MTAwMCArMDAwMA0KQEAgLTIzMSw3ICsyMzEsNyBAQA0K
IA0KIGludCBydW5fa2VybmVsX3RocmVhZChpbnQgKCpmbikodm9pZCAqKSwg
dm9pZCAqYXJnLCB2b2lkICoqam1wX3B0cikNCiB7DQotCWptcF9idWYgYnVm
Ow0KKwlzaWdqbXBfYnVmIGJ1ZjsNCiAJaW50IG47DQogDQogCSpqbXBfcHRy
ID0gJmJ1ZjsNCmRpZmYgLU5hdXIgbGludXgtMi42LjAvYXJjaC91bS9rZXJu
ZWwvdWFjY2Vzc191c2VyLmMub3JpZyBsaW51eC0yLjYuMC9hcmNoL3VtL2tl
cm5lbC91YWNjZXNzX3VzZXIuYw0KLS0tIGxpbnV4LTIuNi4wL2FyY2gvdW0v
a2VybmVsL3VhY2Nlc3NfdXNlci5jLm9yaWcJMjAwNC0wMS0xMyAyMzoyMjo0
MS41NTQ0OTEwMDAgKzAwMDANCisrKyBsaW51eC0yLjYuMC9hcmNoL3VtL2tl
cm5lbC91YWNjZXNzX3VzZXIuYwkyMDA0LTAxLTEzIDIzOjIzOjA1Ljk2NDQ5
MTAwMCArMDAwMA0KQEAgLTE4LDcgKzE4LDcgQEANCiB7DQogCXVuc2lnbmVk
IGxvbmcgKmZhZGRycCA9ICh1bnNpZ25lZCBsb25nICopIGZhdWx0X2FkZHIs
IHJldDsNCiANCi0Jam1wX2J1ZiBqYnVmOw0KKwlzaWdqbXBfYnVmIGpidWY7
DQogCSpmYXVsdF9jYXRjaGVyID0gJmpidWY7DQogCWlmKHNpZ3NldGptcChq
YnVmLCAxKSA9PSAwKXsNCiAJCSgqb3ApKHRvLCBmcm9tLCBuKTsNCmRpZmYg
LU5hdXIgbGludXgtMi42LjAvYXJjaC91bS9rZXJuZWwvdHQvdWFjY2Vzc191
c2VyLmMub3JpZyBsaW51eC0yLjYuMC9hcmNoL3VtL2tlcm5lbC90dC91YWNj
ZXNzX3VzZXIuYw0KLS0tIGxpbnV4LTIuNi4wL2FyY2gvdW0va2VybmVsL3R0
L3VhY2Nlc3NfdXNlci5jLm9yaWcJMjAwNC0wMS0xMyAyMzoyODoyOC40NjQ0
OTEwMDAgKzAwMDANCisrKyBsaW51eC0yLjYuMC9hcmNoL3VtL2tlcm5lbC90
dC91YWNjZXNzX3VzZXIuYwkyMDA0LTAxLTEzIDIzOjI5OjQxLjI0NDQ5MTAw
MCArMDAwMA0KQEAgLTcyLDcgKzcyLDcgQEANCiAJc3RydWN0IHR0X3JlZ3Mg
c2F2ZSA9IFRBU0tfUkVHUyhnZXRfY3VycmVudCgpKS0+dHQ7DQogCWludCBy
ZXQ7DQogCXVuc2lnbmVkIGxvbmcgKmZhZGRycCA9ICh1bnNpZ25lZCBsb25n
ICopZmF1bHRfYWRkcjsNCi0Jam1wX2J1ZiBqYnVmOw0KKwlzaWdqbXBfYnVm
IGpidWY7DQogDQogCSpmYXVsdF9jYXRjaGVyID0gJmpidWY7DQogCWlmKHNp
Z3NldGptcChqYnVmLCAxKSA9PSAwKQ0KZGlmZiAtTmF1ciBsaW51eC0yLjYu
MC9hcmNoL3VtL2tlcm5lbC9za2FzL3Byb2Nlc3MuYy5vcmlnIGxpbnV4LTIu
Ni4wL2FyY2gvdW0va2VybmVsL3NrYXMvcHJvY2Vzcy5jDQotLS0gbGludXgt
Mi42LjAvYXJjaC91bS9rZXJuZWwvc2thcy9wcm9jZXNzLmMub3JpZwkyMDA0
LTAxLTEzIDIzOjM2OjEwLjY4NDQ5MTAwMCArMDAwMA0KKysrIGxpbnV4LTIu
Ni4wL2FyY2gvdW0va2VybmVsL3NrYXMvcHJvY2Vzcy5jCTIwMDQtMDEtMTMg
MjM6Mzg6MjguNTg0NDkxMDAwICswMDAwDQpAQCAtMTg4LDcgKzE4OCw3IEBA
DQogdm9pZCBuZXdfdGhyZWFkKHZvaWQgKnN0YWNrLCB2b2lkICoqc3dpdGNo
X2J1Zl9wdHIsIHZvaWQgKipmb3JrX2J1Zl9wdHIsDQogCQl2b2lkICgqaGFu
ZGxlcikoaW50KSkNCiB7DQotCWptcF9idWYgc3dpdGNoX2J1ZiwgZm9ya19i
dWY7DQorCXNpZ2ptcF9idWYgc3dpdGNoX2J1ZiwgZm9ya19idWY7DQogDQog
CSpzd2l0Y2hfYnVmX3B0ciA9ICZzd2l0Y2hfYnVmOw0KIAkqZm9ya19idWZf
cHRyID0gJmZvcmtfYnVmOw0KQEAgLTIwMSw3ICsyMDEsNyBAQA0KIA0KIHZv
aWQgdGhyZWFkX3dhaXQodm9pZCAqc3csIHZvaWQgKmZiKQ0KIHsNCi0Jam1w
X2J1ZiBidWYsICoqc3dpdGNoX2J1ZiA9IHN3LCAqZm9ya19idWY7DQorCXNp
Z2ptcF9idWYgYnVmLCAqKnN3aXRjaF9idWYgPSBzdywgKmZvcmtfYnVmOw0K
IA0KIAkqc3dpdGNoX2J1ZiA9ICZidWY7DQogCWZvcmtfYnVmID0gZmI7DQpA
QCAtMjYzLDIzICsyNjMsMjMgQEANCiANCiB2b2lkIHN3aXRjaF90aHJlYWRz
KHZvaWQgKm1lLCB2b2lkICpuZXh0KQ0KIHsNCi0Jam1wX2J1ZiBteV9idWYs
ICoqbWVfcHRyID0gbWUsICpuZXh0X2J1ZiA9IG5leHQ7DQorCXNpZ2ptcF9i
dWYgbXlfYnVmLCAqKm1lX3B0ciA9IG1lLCAqbmV4dF9idWYgPSBuZXh0Ow0K
IAkNCiAJKm1lX3B0ciA9ICZteV9idWY7DQogCWlmKHNpZ3NldGptcChteV9i
dWYsIDEpID09IDApDQogCQlzaWdsb25nam1wKCpuZXh0X2J1ZiwgMSk7DQog
fQ0KIA0KLXN0YXRpYyBqbXBfYnVmIGluaXRpYWxfam1wYnVmOw0KK3N0YXRp
YyBzaWdqbXBfYnVmIGluaXRpYWxfam1wYnVmOw0KIA0KIC8qIFhYWCBNYWtl
IHRoZXNlIHBlcmNwdSAqLw0KIHN0YXRpYyB2b2lkICgqY2JfcHJvYykodm9p
ZCAqYXJnKTsNCiBzdGF0aWMgdm9pZCAqY2JfYXJnOw0KLXN0YXRpYyBqbXBf
YnVmICpjYl9iYWNrOw0KK3N0YXRpYyBzaWdqbXBfYnVmICpjYl9iYWNrOw0K
IA0KIGludCBzdGFydF9pZGxlX3RocmVhZCh2b2lkICpzdGFjaywgdm9pZCAq
c3dpdGNoX2J1Zl9wdHIsIHZvaWQgKipmb3JrX2J1Zl9wdHIpDQogew0KLQlq
bXBfYnVmICoqc3dpdGNoX2J1ZiA9IHN3aXRjaF9idWZfcHRyOw0KKwlzaWdq
bXBfYnVmICoqc3dpdGNoX2J1ZiA9IHN3aXRjaF9idWZfcHRyOw0KIAlpbnQg
bjsNCiANCiAJKmZvcmtfYnVmX3B0ciA9ICZpbml0aWFsX2ptcGJ1ZjsNCkBA
IC0zMTUsNyArMzE1LDcgQEANCiANCiB2b2lkIGluaXRpYWxfdGhyZWFkX2Ni
X3NrYXModm9pZCAoKnByb2MpKHZvaWQgKiksIHZvaWQgKmFyZykNCiB7DQot
CWptcF9idWYgaGVyZTsNCisJc2lnam1wX2J1ZiBoZXJlOw0KIA0KIAljYl9w
cm9jID0gcHJvYzsNCiAJY2JfYXJnID0gYXJnOw0K

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
