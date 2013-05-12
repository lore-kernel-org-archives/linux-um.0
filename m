Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <toralf.foerster@gmx.de>) id 1UbcLL-0006G0-SD
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 12 May 2013 19:54:03 +0000
Received: from mout.gmx.net ([212.227.15.15])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UbcLL-0003rS-0u for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 12 May 2013 19:54:03 +0000
Received: from mailout-de.gmx.net ([10.1.76.32]) by mrigmx.server.lan
	(mrigmx002) with ESMTP (Nemesis) id 0Md1Gm-1Usaxj1TSE-00IAa7 for
	<user-mode-linux-devel@lists.sourceforge.net>; Sun, 12 May 2013 21:53:57
	+0200
Message-ID: <518FF354.7020408@gmx.de>
Date: Sun, 12 May 2013 21:53:56 +0200
From: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>
MIME-Version: 1.0
References: <518FB97A.5070907@gmx.de>
	<CAFLxGvzn+Q=D4vjTNuggSTnQKVp0QYLPoHmUwAVBcRbSmD3HWQ@mail.gmail.com>
	<518FBE6A.50605@gmx.de>
	<CAFLxGvyvRb+WD-eLBFnH5O-sXjUdtUkXbKzG6HFqgzm+x2LUow@mail.gmail.com>
	<CAFLxGvwEiE0dfw9Vju_Xg6mXkF_NH_OU_t7puPceYN42dphTLA@mail.gmail.com>
	<518FE33B.60701@gmx.de>
	<CAFLxGvyiKbbkPAG0h42y1fb=Z6YuboJPdyb+2Xk9Z2YYt7oryg@mail.gmail.com>
In-Reply-To: <CAFLxGvyiKbbkPAG0h42y1fb=Z6YuboJPdyb+2Xk9Z2YYt7oryg@mail.gmail.com>
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
Subject: Re: [uml-devel] WARNING: at mm/mmap.c:2757 exit_mmap+0x161/0x170()
To: richard -rw- weinberger <richard.weinberger@gmail.com>
Cc: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

T24gMDUvMTIvMjAxMyAwOTo0NSBQTSwgcmljaGFyZCAtcnctIHdlaW5iZXJnZXIgd3JvdGU6Cj4g
RGFtbiwgd2UndmUgdW5kZXJydW4gdGhlIGNvdW50ZXIuIDotXAo+IENhbiB5b3UgcGxlYXNlIHRl
c3QgdGhlIGF0dGFjaGVkIDNyZCBkZWJ1ZyBwYXRjaD8KCnllcyAtIGJ1dCBnaXZlIG1lIGEgY2hh
bmNlIGFuZCBhdHRhY2ggYSBwYXRjaCA7KQoKLS0gCk1mRy9TaW5jZXJlbHkKVG9yYWxmIEbDtnJz
dGVyCnBncCBmaW5nZXIgcHJpbnQ6IDdCMUEgMDdGNCBFQzgyIDBGOTAgRDRDMiA4OTM2IDg3MkEg
RTUwOCA3REI2IDlEQTMKCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpMZWFybiBHcmFwaCBEYXRhYmFz
ZXMgLSBEb3dubG9hZCBGUkVFIE8nUmVpbGx5IEJvb2sKIkdyYXBoIERhdGFiYXNlcyIgaXMgdGhl
IGRlZmluaXRpdmUgbmV3IGd1aWRlIHRvIGdyYXBoIGRhdGFiYXNlcyBhbmQgCnRoZWlyIGFwcGxp
Y2F0aW9ucy4gVGhpcyAyMDAtcGFnZSBib29rIGlzIHdyaXR0ZW4gYnkgdGhyZWUgYWNjbGFpbWVk
IApsZWFkZXJzIGluIHRoZSBmaWVsZC4gVGhlIGVhcmx5IGFjY2VzcyB2ZXJzaW9uIGlzIGF2YWls
YWJsZSBub3cuIApEb3dubG9hZCB5b3VyIGZyZWUgYm9vayB0b2RheSEgaHR0cDovL3Auc2YubmV0
L3NmdS9uZW90ZWNoX2QyZF9tYXkKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KVXNlci1tb2RlLWxpbnV4LWRldmVsIG1haWxpbmcgbGlzdApVc2VyLW1vZGUt
bGludXgtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9y
Z2UubmV0L2xpc3RzL2xpc3RpbmZvL3VzZXItbW9kZS1saW51eC1kZXZlbAo=

