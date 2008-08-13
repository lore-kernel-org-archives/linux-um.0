Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KTKtg-0003qO-JB for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 13 Aug 2008 11:16:36 -0700
Received: from abydos.nerdbox.net ([216.151.149.55])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KTKtf-0007tG-Ae
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 13 Aug 2008 11:16:36 -0700
Received: from vandebo (helo=localhost)
	by abydos.NerdBox.Net with local-esmtp (Exim 4.67)
	(envelope-from <vandebo-uml@NerdBox.Net>) id 1KTKtd-0002bC-Kc
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 13 Aug 2008 11:16:33 -0700
Date: Wed, 13 Aug 2008 11:16:33 -0700 (PDT)
From: Steve VanDeBogart <vandebo-uml@NerdBox.Net>
Message-ID: <alpine.DEB.1.00.0808131058380.15543@abydos.NerdBox.Net>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-1747437675-773727403-1218651393=:15543"
Subject: [uml-devel] [PATCH] ubd does multiple io's when one will suffice
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1747437675-773727403-1218651393=:15543
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII

When running UML under Valgrind (details to be posted later), I found
that ubd_kern.c:do_io() was accessing uninitialized memory. 
Specifically, ubd_test_bit() can be called with the first parameter 
greater than 32 and req->sector_mask is only 32bits long.  This is only 
the case when not using a cow device, as cowify_req() ensures that the 
request size is not more than 32 sectors.

Furthermore, when not using a cow device, there is no reason to break
a request into smaller pieces. The attached patch skips the call
to ubd_test_bit() for the non-cow case and completes the request in
a single batch.

--
Steve
---1747437675-773727403-1218651393=:15543
Content-Type: TEXT/x-diff; name=ubd-batch.patch
Content-Transfer-Encoding: BASE64
Content-ID: <alpine.DEB.1.00.0808131116330.15543@abydos.NerdBox.Net>
Content-Description: 
Content-Disposition: attachment; filename=ubd-batch.patch

ZGlmZiAtdXByTiAtWCBsaW51eC0yLjYuMjYuMi9Eb2N1bWVudGF0aW9uL2Rv
bnRkaWZmIGxpbnV4LTIuNi4yNi4yLXN0b2NrL2FyY2gvdW0vZHJpdmVycy91
YmRfa2Vybi5jIGxpbnV4LTIuNi4yNi4yL2FyY2gvdW0vZHJpdmVycy91YmRf
a2Vybi5jDQotLS0gbGludXgtMi42LjI2LjItc3RvY2svYXJjaC91bS9kcml2
ZXJzL3ViZF9rZXJuLmMJMjAwOC0wOC0wNiAwOToxOTowMS4wMDAwMDAwMDAg
LTA3MDANCisrKyBsaW51eC0yLjYuMjYuMi9hcmNoL3VtL2RyaXZlcnMvdWJk
X2tlcm4uYwkyMDA4LTA4LTEzIDEwOjQzOjUyLjAwMDAwMDAwMCAtMDcwMA0K
QEAgLTEyMTgsOCArMTIxOCw3IEBAIHN0YXRpYyB2b2lkIHByZXBhcmVfcmVx
dWVzdChzdHJ1Y3QgcmVxdWUNCiAJc3RydWN0IHViZCAqdWJkX2RldiA9IGRp
c2stPnByaXZhdGVfZGF0YTsNCiANCiAJaW9fcmVxLT5yZXEgPSByZXE7DQot
CWlvX3JlcS0+ZmRzWzBdID0gKHViZF9kZXYtPmNvdy5maWxlICE9IE5VTEwp
ID8gdWJkX2Rldi0+Y293LmZkIDoNCi0JCXViZF9kZXYtPmZkOw0KKwlpb19y
ZXEtPmZkc1swXSA9ICh1YmRfZGV2LT5jb3cuZmlsZSA9PSBOVUxMKSA/IC0x
IDogdWJkX2Rldi0+Y293LmZkOw0KIAlpb19yZXEtPmZkc1sxXSA9IHViZF9k
ZXYtPmZkOw0KIAlpb19yZXEtPmNvd19vZmZzZXQgPSAtMTsNCiAJaW9fcmVx
LT5vZmZzZXQgPSBvZmZzZXQ7DQpAQCAtMTM3NCwxMiArMTM3MywxNyBAQCBz
dGF0aWMgdm9pZCBkb19pbyhzdHJ1Y3QgaW9fdGhyZWFkX3JlcSAqDQogCW5z
ZWN0b3JzID0gcmVxLT5sZW5ndGggLyByZXEtPnNlY3RvcnNpemU7DQogCXN0
YXJ0ID0gMDsNCiAJZG8gew0KLQkJYml0ID0gdWJkX3Rlc3RfYml0KHN0YXJ0
LCAodW5zaWduZWQgY2hhciAqKSAmcmVxLT5zZWN0b3JfbWFzayk7DQotCQll
bmQgPSBzdGFydDsNCi0JCXdoaWxlKChlbmQgPCBuc2VjdG9ycykgJiYNCi0J
CSAgICAgICh1YmRfdGVzdF9iaXQoZW5kLCAodW5zaWduZWQgY2hhciAqKQ0K
LQkJCQkgICAgJnJlcS0+c2VjdG9yX21hc2spID09IGJpdCkpDQotCQkJZW5k
Kys7DQorCQlpZiAocmVxLT5mZHNbMF0gPT0gLTEpIHsNCisJCQliaXQgPSAx
Ow0KKwkJCWVuZCA9IG5zZWN0b3JzOw0KKwkJfSBlbHNlIHsNCisJCQliaXQg
PSB1YmRfdGVzdF9iaXQoc3RhcnQsICh1bnNpZ25lZCBjaGFyICopICZyZXEt
PnNlY3Rvcl9tYXNrKTsNCisJCQllbmQgPSBzdGFydDsNCisJCQl3aGlsZSgo
ZW5kIDwgbnNlY3RvcnMpICYmDQorCQkJCQkodWJkX3Rlc3RfYml0KGVuZCwg
KHVuc2lnbmVkIGNoYXIgKikNCisJCQkJCQkJCSAgJnJlcS0+c2VjdG9yX21h
c2spID09IGJpdCkpDQorCQkJCWVuZCsrOw0KKwkJfQ0KIA0KIAkJb2ZmID0g
cmVxLT5vZmZzZXQgKyByZXEtPm9mZnNldHNbYml0XSArDQogCQkJc3RhcnQg
KiByZXEtPnNlY3RvcnNpemU7DQo=

---1747437675-773727403-1218651393=:15543
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
---1747437675-773727403-1218651393=:15543
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

---1747437675-773727403-1218651393=:15543--

