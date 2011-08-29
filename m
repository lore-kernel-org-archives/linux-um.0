Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1Qy4K7-0004OR-06
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 29 Aug 2011 16:04:31 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Qy4K1-0001uh-Ar
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 29 Aug 2011 16:04:30 +0000
From: Richard Weinberger <richard@nod.at>
Date: Mon, 29 Aug 2011 18:03:55 +0200
Message-Id: <1314633842-24515-3-git-send-email-richard@nod.at>
In-Reply-To: <1314633842-24515-1-git-send-email-richard@nod.at>
References: <1314633842-24515-1-git-send-email-richard@nod.at>
MIME-Version: 1.0
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: [uml-devel] [PATCH 2/9] um: drivers/xterm.c: fix a file descriptor
	leak
To: akpm@linux-foundation.org
Cc: Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>

RnJvbTogSm9uYXRoYW4gTmV1c2Now6RmZXIgPGoubmV1c2NoYWVmZXJAZ214Lm5ldD4KCkkgY291
bGQgdXNlIG91dF9jbG9zZTEsIGJ1dCB0aGF0IHNlZW1zIHRvIGJlIHRoZSBjb2RlIHBhdGggdG8g
Y2xvc2UgdGhlCmZkIHJldHVybmVkIGJ5IG9zX2NyZWF0ZV91bml4X3NvY2tldCwgYW5kIHVzaW5n
IGl0IHRvIGNsb3NlIHRoZSBmZApyZXR1cm5lZCBieSBta3N0ZW1wIG1pZ2h0IGxlYWQgdG8gc29t
ZSBjb25mdXNpb24sIHNvIEkgZG9uJ3QgZG8gaXQuCgpTaWduZWQtb2ZmLWJ5OiBKb25hdGhhbiBO
ZXVzY2jDpGZlciA8ai5uZXVzY2hhZWZlckBnbXgubmV0PgpTaWduZWQtb2ZmLWJ5OiBSaWNoYXJk
IFdlaW5iZXJnZXIgPHJpY2hhcmRAbm9kLmF0PgotLS0KIGFyY2gvdW0vZHJpdmVycy94dGVybS5j
IHwgICAgMSArCiAxIGZpbGVzIGNoYW5nZWQsIDEgaW5zZXJ0aW9ucygrKSwgMCBkZWxldGlvbnMo
LSkKCmRpZmYgLS1naXQgYS9hcmNoL3VtL2RyaXZlcnMveHRlcm0uYyBiL2FyY2gvdW0vZHJpdmVy
cy94dGVybS5jCmluZGV4IDhhYzcxNDYuLjJlMWRlNTcgMTAwNjQ0Ci0tLSBhL2FyY2gvdW0vZHJp
dmVycy94dGVybS5jCisrKyBiL2FyY2gvdW0vZHJpdmVycy94dGVybS5jCkBAIC0xMjMsNiArMTIz
LDcgQEAgc3RhdGljIGludCB4dGVybV9vcGVuKGludCBpbnB1dCwgaW50IG91dHB1dCwgaW50IHBy
aW1hcnksIHZvaWQgKmQsCiAJCWVyciA9IC1lcnJubzsKIAkJcHJpbnRrKFVNX0tFUk5fRVJSICJ4
dGVybV9vcGVuIDogdW5saW5rIGZhaWxlZCwgZXJybm8gPSAlZFxuIiwKIAkJICAgICAgIGVycm5v
KTsKKwkJY2xvc2UoZmQpOwogCQlyZXR1cm4gZXJyOwogCX0KIAljbG9zZShmZCk7Ci0tIAoxLjcu
Ni4xCgoKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCkVNQyBWTlg6IHRoZSB3b3JsZCdzIHNpbXBsZXN0
IHN0b3JhZ2UsIHN0YXJ0aW5nIHVuZGVyICQxMEsKVGhlIG9ubHkgdW5pZmllZCBzdG9yYWdlIHNv
bHV0aW9uIHRoYXQgb2ZmZXJzIHVuaWZpZWQgbWFuYWdlbWVudCAKVXAgdG8gMTYwJSBtb3JlIHBv
d2VyZnVsIHRoYW4gYWx0ZXJuYXRpdmVzIGFuZCAyNSUgbW9yZSBlZmZpY2llbnQuIApHdWFyYW50
ZWVkLiBodHRwOi8vcC5zZi5uZXQvc2Z1L2VtYy12bngtZGV2MmRldgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpVc2VyLW1vZGUtbGludXgtZGV2ZWwgbWFp
bGluZyBsaXN0ClVzZXItbW9kZS1saW51eC1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0
cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vdXNlci1tb2RlLWxpbnV4
LWRldmVsCg==

