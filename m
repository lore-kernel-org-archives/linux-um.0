Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <toralf.foerster@gmx.de>) id 1VJlYM-00041D-N7
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 11 Sep 2013 14:37:58 +0000
Received: from mout.gmx.net ([212.227.15.15])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1VJlYJ-0006bU-86
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 11 Sep 2013 14:37:58 +0000
Received: from [92.224.45.48] ([92.224.45.48]) by mail.gmx.com (mrgmx001)
	with ESMTPSA (Nemesis) id 0Mh9yT-1VXKM12kF7-00MInJ for
	<user-mode-linux-devel@lists.sourceforge.net>; Wed, 11 Sep 2013 16:37:48
	+0200
Message-ID: <5230803A.3030800@gmx.de>
Date: Wed, 11 Sep 2013 16:37:46 +0200
From: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>
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
Subject: [uml-devel] winch_thread : TIOCSCTTY failed on fd 1 err = 1
To: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

VXNpbmcgTGludXMnIGN1cnJlbnQgZ2l0IHRyZWUgdG8gYmlzZWN0IGEgZnMvZGNhY2hlLmMgaXNz
dWUgSSByZWFsaXplZAp0aGlzIG1lc3NhZ2UgKG5ld2x5IGludHJvZHVjZWQgaW4gb25lIG9mIHRo
ZSBsYXN0IGZldyBwdWxscywgbWVhbmluZwpiZXR3ZWVuIGxpbnV4LXYzLjExLTg3MTggYW5kIHYz
LjExLTkwMzEtZ2EyMmEwZmQpOgoKCi4uLgpOZXRkZXZpY2UgMCAoNzI6ZWY6M2Q6ZmQ6NGE6MGIp
IDoKVFVOL1RBUCBiYWNrZW5kIC0Kd2luY2hfdGhyZWFkIDogVElPQ1NDVFRZIGZhaWxlZCBvbiBm
ZCAxIGVyciA9IDEKLi4uCgoKCkRvIEkgaGF2ZSB0byB3b3JyeSBhYm91dCA/CgoKCgpGV0lXIEkg
anVzdCBwYXRjaGVkIHRoZSBrZXJuZWwgYnkgdGhpcyA6CgotLS0geC9rZXJuZWwvZXhpdC5jCisr
KyB4L2tlcm5lbC9leGl0LmMKQEAgLTc4Myw4ICs3ODMsOCBAQCB2b2lkIGRvX2V4aXQobG9uZyBj
b2RlKQogICAgICAgIGV4aXRfc2htKHRzayk7CiAgICAgICAgZXhpdF9maWxlcyh0c2spOwogICAg
ICAgIGV4aXRfZnModHNrKTsKLSAgICAgICBleGl0X3Rhc2tfbmFtZXNwYWNlcyh0c2spOwogICAg
ICAgIGV4aXRfdGFza193b3JrKHRzayk7CisgICAgICAgZXhpdF90YXNrX25hbWVzcGFjZXModHNr
KTsKICAgICAgICBjaGVja19zdGFja191c2FnZSgpOwogICAgICAgIGV4aXRfdGhyZWFkKCk7Cgoo
Z290IGZyb20gT2xlZyBOZXN0ZXJvdikKCi0tIApNZkcvU2luY2VyZWx5ClRvcmFsZiBGw7Zyc3Rl
cgpwZ3AgZmluZ2VyIHByaW50OiA3QjFBIDA3RjQgRUM4MiAwRjkwIEQ0QzIgODkzNiA4NzJBIEU1
MDggN0RCNiA5REEzCgotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KSG93IFNlcnZpY2VOb3cgaGVscHMg
SVQgcGVvcGxlIHRyYW5zZm9ybSBJVCBkZXBhcnRtZW50czoKMS4gQ29uc29saWRhdGUgbGVnYWN5
IElUIHN5c3RlbXMgdG8gYSBzaW5nbGUgc3lzdGVtIG9mIHJlY29yZCBmb3IgSVQKMi4gU3RhbmRh
cmRpemUgYW5kIGdsb2JhbGl6ZSBzZXJ2aWNlIHByb2Nlc3NlcyBhY3Jvc3MgSVQKMy4gSW1wbGVt
ZW50IHplcm8tdG91Y2ggYXV0b21hdGlvbiB0byByZXBsYWNlIG1hbnVhbCwgcmVkdW5kYW50IHRh
c2tzCmh0dHA6Ly9wdWJhZHMuZy5kb3VibGVjbGljay5uZXQvZ2FtcGFkL2Nsaz9pZD01MTI3MTEx
MSZpdT0vNDE0MC9vc3RnLmNsa3RyawpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpVc2VyLW1vZGUtbGludXgtZGV2ZWwgbWFpbGluZyBsaXN0ClVzZXItbW9k
ZS1saW51eC1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vm
b3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vdXNlci1tb2RlLWxpbnV4LWRldmVsCg==

