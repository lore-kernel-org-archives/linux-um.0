Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KLFZX-0002iL-W1 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 22 Jul 2008 03:58:24 -0700
Received: from mail.gmx.net ([213.165.64.20])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1KLFZW-0000My-62
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 22 Jul 2008 03:58:23 -0700
Date: Tue, 22 Jul 2008 12:58:12 +0200
From: Eric Sesterhenn <snakebyte@gmx.de>
Message-ID: <20080722105812.GB5283@alice>
MIME-Version: 1.0
Content-Disposition: inline
Subject: Re: [uml-devel] [Patch] um: fix a build error
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
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: xiyou.wangcong@gmail.com
Cc: user-mode-linux-devel@lists.sourceforge.net, jdike@addtoit.com, linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk

SSBqdXN0IHJhbiBhY3Jvc3MgdGhlIHNhbWUgYnVpbGQgZXJyb3IsIGRvZXMKc29tZXRoaW5nIGxp
a2UgdGhpcyBsb29rIHJlYXNvbmFibGU/IE9ubHkgYnVpbGQKYW5kIGJvb3QgdGVzdGVkLgoKVGhp
cyBmaXhlcyB0aGUgZm9sbG93aW5nIGJ1aWxkIGVycm9yOgoKICBDQyAgICAgIGFyY2gvdW0vZHJp
dmVycy9saW5lLm8KICBhcmNoL3VtL2RyaXZlcnMvbGluZS5jOiBJbiBmdW5jdGlvbiDigJhsaW5l
X3dyaXRlX2ludGVycnVwdOKAmToKICBhcmNoL3VtL2RyaXZlcnMvbGluZS5jOjM2NjogZXJyb3I6
IOKAmHN0cnVjdCB0dHlfbGRpc2PigJkgaGFzIG5vIG1lbWJlcgogIG5hbWVkIOKAmHdyaXRlX3dh
a2V1cOKAmQogIGFyY2gvdW0vZHJpdmVycy9saW5lLmM6MzY3OiBlcnJvcjog4oCYc3RydWN0IHR0
eV9sZGlzY+KAmSBoYXMgbm8gbWVtYmVyCiAgbmFtZWQg4oCYd3JpdGVfd2FrZXVw4oCZCiAgbWFr
ZVsxXTogKioqIFthcmNoL3VtL2RyaXZlcnMvbGluZS5vXSBFcnJvciAxCiAgbWFrZTogKioqIFth
cmNoL3VtL2RyaXZlcnNdIEVycm9yIDIKCgpTaWduZWQtb2ZmLWJ5OiBFcmljIFNlc3Rlcmhlbm4g
PHNuYWtlYnl0ZUBnbXguZGU+CgotLS0gbGludXgtMi42L2FyY2gvdW0vZHJpdmVycy9saW5lLmMu
b3JpZwkyMDA4LTA3LTIyIDEyOjA2OjE3LjAwMDAwMDAwMCArMDIwMAorKysgbGludXgtMi42L2Fy
Y2gvdW0vZHJpdmVycy9saW5lLmMJMjAwOC0wNy0yMiAxMjowNjo0OS4wMDAwMDAwMDAgKzAyMDAK
QEAgLTM2MiwxMCArMzYyLDggQEAgc3RhdGljIGlycXJldHVybl90IGxpbmVfd3JpdGVfaW50ZXJy
dXB0KAogCWlmICh0dHkgPT0gTlVMTCkKIAkJcmV0dXJuIElSUV9OT05FOwogCi0JaWYgKHRlc3Rf
Yml0KFRUWV9ET19XUklURV9XQUtFVVAsICZ0dHktPmZsYWdzKSAmJgotCSAgICh0dHktPmxkaXNj
LndyaXRlX3dha2V1cCAhPSBOVUxMKSkKLQkJKHR0eS0+bGRpc2Mud3JpdGVfd2FrZXVwKSh0dHkp
OwotCisJaWYgKHRlc3RfYml0KFRUWV9ET19XUklURV9XQUtFVVAsICZ0dHktPmZsYWdzKSkKKwkJ
dHR5X3dha2V1cCh0dHkpOwogCS8qCiAJICogQkxPQ0tJTkcgbW9kZQogCSAqIEluIGJsb2NraW5n
IG1vZGUsIGV2ZXJ5dGhpbmcgc2xlZXBzIG9uIHR0eS0+d3JpdGVfd2FpdC4KCi0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0KVGhpcyBTRi5OZXQgZW1haWwgaXMgc3BvbnNvcmVkIGJ5IHRoZSBNb2JsaW4gWW91ciBN
b3ZlIERldmVsb3BlcidzIGNoYWxsZW5nZQpCdWlsZCB0aGUgY29vbGVzdCBMaW51eCBiYXNlZCBh
cHBsaWNhdGlvbnMgd2l0aCBNb2JsaW4gU0RLICYgd2luIGdyZWF0IHByaXplcwpHcmFuZCBwcml6
ZSBpcyBhIHRyaXAgZm9yIHR3byB0byBhbiBPcGVuIFNvdXJjZSBldmVudCBhbnl3aGVyZSBpbiB0
aGUgd29ybGQKaHR0cDovL21vYmxpbi1jb250ZXN0Lm9yZy9yZWRpcmVjdC5waHA/YmFubmVyX2lk
PTEwMCZ1cmw9LwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpVc2VyLW1vZGUtbGludXgtZGV2ZWwgbWFpbGluZyBsaXN0ClVzZXItbW9kZS1saW51eC1kZXZl
bEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlz
dHMvbGlzdGluZm8vdXNlci1tb2RlLWxpbnV4LWRldmVsCg==
