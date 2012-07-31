Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vleclement@gmail.com>) id 1Sw7oh-00061J-KM
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 31 Jul 2012 08:28:35 +0000
Received: from mail-ey0-f175.google.com ([209.85.215.175])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Sw7oc-0003h1-4o
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 31 Jul 2012 08:28:35 +0000
Received: by eaad12 with SMTP id d12so248358eaa.34
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 31 Jul 2012 01:28:23 -0700 (PDT)
Date: Tue, 31 Jul 2012 10:28:21 +0200
From: Vianney le =?utf-8?Q?Cl=C3=A9ment?= de Saint-Marcq <vleclement@gmail.com>
Message-ID: <50179725.9cO+m/nAt3rcNdV1%vleclement@gmail.com>
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

RnJvbTogVmlhbm5leSBsZSBDbMOpbWVudCBkZSBTYWludC1NYXJjcSA8dmxlY2xlbWVudEBnbWFp
bC5jb20+CgpBcyBvZiBnbGliYyAyLjE2LCBzeXMvd2FpdC5oIGRvZXMgbm8gbG9uZ2VyIGluY2x1
ZGUgc3lzL3Jlc291cmNlLmgsCndoaWNoIGlzIG5lZWRlZCBmb3IgZ2V0cmxpbWl0KCkuIFRoaXMg
cGF0Y2ggZml4ZXMgY29tcGlsaW5nIFVNTCB3aXRoCmdsaWJjIDIuMTYuCgpTaWduZWQtb2ZmLWJ5
OiBWaWFubmV5IGxlIENsw6ltZW50IGRlIFNhaW50LU1hcmNxIDx2bGVjbGVtZW50QGdtYWlsLmNv
bT4KLS0tCi0tLSBsaW51eC0zLjUvYXJjaC91bS9vcy1MaW51eC9zdGFydF91cC5jLm9yaWcJMjAx
Mi0wNy0yMSAyMjo1ODoyOS4wMDAwMDAwMDAgKzAyMDAKKysrIGxpbnV4LTMuNS9hcmNoL3VtL29z
LUxpbnV4L3N0YXJ0X3VwLmMJMjAxMi0wNy0zMCAxNTozOToyMi43NzExOTA2NjQgKzAyMDAKQEAg
LTEzLDYgKzEzLDcgQEAKICNpbmNsdWRlIDxzaWduYWwuaD4KICNpbmNsdWRlIDxzdHJpbmcuaD4K
ICNpbmNsdWRlIDxzeXMvbW1hbi5oPgorI2luY2x1ZGUgPHN5cy9yZXNvdXJjZS5oPgogI2luY2x1
ZGUgPHN5cy9zdGF0Lmg+CiAjaW5jbHVkZSA8c3lzL3dhaXQuaD4KICNpbmNsdWRlIDxhc20vdW5p
c3RkLmg+CgotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KTGl2ZSBTZWN1cml0eSBWaXJ0dWFsIENvbmZl
cmVuY2UKRXhjbHVzaXZlIGxpdmUgZXZlbnQgd2lsbCBjb3ZlciBhbGwgdGhlIHdheXMgdG9kYXkn
cyBzZWN1cml0eSBhbmQgCnRocmVhdCBsYW5kc2NhcGUgaGFzIGNoYW5nZWQgYW5kIGhvdyBJVCBt
YW5hZ2VycyBjYW4gcmVzcG9uZC4gRGlzY3Vzc2lvbnMgCndpbGwgaW5jbHVkZSBlbmRwb2ludCBz
ZWN1cml0eSwgbW9iaWxlIHNlY3VyaXR5IGFuZCB0aGUgbGF0ZXN0IGluIG1hbHdhcmUgCnRocmVh
dHMuIGh0dHA6Ly93d3cuYWNjZWxhY29tbS5jb20vamF3L3Nmcm5sMDQyNDIwMTIvMTE0LzUwMTIy
MjYzLwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpVc2Vy
LW1vZGUtbGludXgtZGV2ZWwgbWFpbGluZyBsaXN0ClVzZXItbW9kZS1saW51eC1kZXZlbEBsaXN0
cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlz
dGluZm8vdXNlci1tb2RlLWxpbnV4LWRldmVsCg==

