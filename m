Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1YX9f7-0004DW-K5
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 15 Mar 2015 14:37:05 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YX9f6-0007JG-1t
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 15 Mar 2015 14:37:05 +0000
Message-ID: <55059907.9060408@nod.at>
Date: Sun, 15 Mar 2015 15:36:55 +0100
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
References: <54FCBB88.70605@gmx.de>
	<CAFLxGvy8mLg9R9J38uAGFdZA_QdN=qZ3L-_niYoX8+n7GA0+Vg@mail.gmail.com>
	<54FCCFF8.3030209@gmx.de> <54FCD0DB.4060308@nod.at>
	<54FF01F3.5060203@gmx.de> <54FF03DE.1080206@nod.at>
	<54FF09B5.5020707@gmx.de> <54FF1281.7070709@nod.at>
	<54FF2D3B.5090301@gmx.de> <54FF2F89.604@nod.at>
	<54FF36CC.4010401@gmx.de> <54FF3910.8060502@nod.at>
	<54FF3A7A.4010606@gmx.de> <54FF3B6C.9060808@nod.at>
	<54FF3E5D.8040204@gmx.de> <54FF606E.5050109@nod.at>
	<5502E8D5.8040500@gmx.de> <5502F4A4.6070201@nod.at>
	<550564D2.5070103@gmx.de> <55056CA7.1080700@nod.at>
	<55057604.6050308@gmx.de>
In-Reply-To: <55057604.6050308@gmx.de>
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
Subject: Re: [uml-devel] starting an 32 bit x86 chroot uml image at a
 ahrdened Gentoo amd64 system fails
To: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>
Cc: UML devel <user-mode-linux-devel@lists.sourceforge.net>

QW0gMTUuMDMuMjAxNSB1bSAxMzowNyBzY2hyaWViIFRvcmFsZiBGw7Zyc3RlcjoKPiBPbiAwMy8x
NS8yMDE1IDEyOjI3IFBNLCBSaWNoYXJkIFdlaW5iZXJnZXIgd3JvdGU6Cj4gCj4gZm91bmQgdGhl
IGN1bHByaXQgOgo+IENPTkZJR19NUEVOVElVTU09eSB3b3JrcyB3aGVyZSBDT05GSUdfTUNPUkUy
PXkgZG8gbm90IHdvcmsKCkJUVzogSnVzdCByYW4gYSB4ODYgVU1MIHdpdGggQ09ORklHX01DT1JF
Mj15LiBXb3JrcyBwZXJmZWN0bHkgZmluZS4KQnV0IEkgaGF2ZSBhIGRpZmZlcmVudCBDUFUuCgpU
aGFua3MsCi8vcmljaGFyZAoKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCkRpdmUgaW50byB0aGUgV29y
bGQgb2YgUGFyYWxsZWwgUHJvZ3JhbW1pbmcgVGhlIEdvIFBhcmFsbGVsIFdlYnNpdGUsIHNwb25z
b3JlZApieSBJbnRlbCBhbmQgZGV2ZWxvcGVkIGluIHBhcnRuZXJzaGlwIHdpdGggU2xhc2hkb3Qg
TWVkaWEsIGlzIHlvdXIgaHViIGZvciBhbGwKdGhpbmdzIHBhcmFsbGVsIHNvZnR3YXJlIGRldmVs
b3BtZW50LCBmcm9tIHdlZWtseSB0aG91Z2h0IGxlYWRlcnNoaXAgYmxvZ3MgdG8KbmV3cywgdmlk
ZW9zLCBjYXNlIHN0dWRpZXMsIHR1dG9yaWFscyBhbmQgbW9yZS4gVGFrZSBhIGxvb2sgYW5kIGpv
aW4gdGhlIApjb252ZXJzYXRpb24gbm93LiBodHRwOi8vZ29wYXJhbGxlbC5zb3VyY2Vmb3JnZS5u
ZXQvCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClVzZXIt
bW9kZS1saW51eC1kZXZlbCBtYWlsaW5nIGxpc3QKVXNlci1tb2RlLWxpbnV4LWRldmVsQGxpc3Rz
LnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0
aW5mby91c2VyLW1vZGUtbGludXgtZGV2ZWwK

