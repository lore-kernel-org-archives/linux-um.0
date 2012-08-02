Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vleclement@gmail.com>) id 1Swq8k-000130-G9
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 02 Aug 2012 07:48:14 +0000
Received: from smtp.sgsi.ucl.ac.be ([130.104.5.67] helo=smtp5.sgsi.ucl.ac.be)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Swq8e-0006nK-MH for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 02 Aug 2012 07:48:14 +0000
From: =?UTF-8?q?Vianney=20le=20Cl=C3=A9ment=20de=20Saint-Marcq?=
	<vleclement@gmail.com>
Date: Thu,  2 Aug 2012 09:22:24 +0200
Message-Id: <1343892144-3800-1-git-send-email-vleclement@gmail.com>
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
Subject: [uml-devel] [PATCH] um: fix missing include with glibc 2.16
To: user-mode-linux-devel@lists.sourceforge.net
Cc: =?UTF-8?q?Vianney=20le=20Cl=C3=A9ment=20de=20Saint-Marcq?= <vleclement@gmail.com>

VGhlIFBPU0lYIG1hbnBhZ2UgZm9yIGdldHJsaW1pdCgzKSByZXF1aXJlcyBzeXMvcmVzb3VyY2Uu
aCB0byBiZQppbmNsdWRlZC4gVGhpcyBoZWFkZXIgdXNlZCB0byBiZSBpbmNsdWRlZCBieSBzeXMv
d2FpdC5oIGluIGdsaWJjLgpBcyBvZiBnbGliYyAyLjE2IGhvd2V2ZXIsIHRoaXMgaXMgbm90IHRo
ZSBjYXNlIGFueW1vcmUsIHRodXMgYnJlYWtpbmcKdGhlIGNvbXBpbGF0aW9uLgoKU2lnbmVkLW9m
Zi1ieTogVmlhbm5leSBsZSBDbMOpbWVudCBkZSBTYWludC1NYXJjcSA8dmxlY2xlbWVudEBnbWFp
bC5jb20+Ci0tLQogYXJjaC91bS9vcy1MaW51eC9zdGFydF91cC5jIHwgMSArCiAxIGZpbGUgY2hh
bmdlZCwgMSBpbnNlcnRpb24oKykKCmRpZmYgLS1naXQgYS9hcmNoL3VtL29zLUxpbnV4L3N0YXJ0
X3VwLmMgYi9hcmNoL3VtL29zLUxpbnV4L3N0YXJ0X3VwLmMKaW5kZXggNDI1MTYyZS4uNjc3MDRh
YiAxMDA2NDQKLS0tIGEvYXJjaC91bS9vcy1MaW51eC9zdGFydF91cC5jCisrKyBiL2FyY2gvdW0v
b3MtTGludXgvc3RhcnRfdXAuYwpAQCAtMTMsNiArMTMsNyBAQAogI2luY2x1ZGUgPHNpZ25hbC5o
PgogI2luY2x1ZGUgPHN0cmluZy5oPgogI2luY2x1ZGUgPHN5cy9tbWFuLmg+CisjaW5jbHVkZSA8
c3lzL3Jlc291cmNlLmg+CiAjaW5jbHVkZSA8c3lzL3N0YXQuaD4KICNpbmNsdWRlIDxzeXMvd2Fp
dC5oPgogI2luY2x1ZGUgPGFzbS91bmlzdGQuaD4KLS0gCjEuNy4xMS40CgoKLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tCkxpdmUgU2VjdXJpdHkgVmlydHVhbCBDb25mZXJlbmNlCkV4Y2x1c2l2ZSBsaXZl
IGV2ZW50IHdpbGwgY292ZXIgYWxsIHRoZSB3YXlzIHRvZGF5J3Mgc2VjdXJpdHkgYW5kIAp0aHJl
YXQgbGFuZHNjYXBlIGhhcyBjaGFuZ2VkIGFuZCBob3cgSVQgbWFuYWdlcnMgY2FuIHJlc3BvbmQu
IERpc2N1c3Npb25zIAp3aWxsIGluY2x1ZGUgZW5kcG9pbnQgc2VjdXJpdHksIG1vYmlsZSBzZWN1
cml0eSBhbmQgdGhlIGxhdGVzdCBpbiBtYWx3YXJlIAp0aHJlYXRzLiBodHRwOi8vd3d3LmFjY2Vs
YWNvbW0uY29tL2phdy9zZnJubDA0MjQyMDEyLzExNC81MDEyMjI2My8KX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVXNlci1tb2RlLWxpbnV4LWRldmVsIG1h
aWxpbmcgbGlzdApVc2VyLW1vZGUtbGludXgtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0
dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL3VzZXItbW9kZS1saW51
eC1kZXZlbAo=

