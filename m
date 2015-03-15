Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1YXBpl-0003Jm-Nh
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 15 Mar 2015 16:56:13 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YXBpk-0001En-8y
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 15 Mar 2015 16:56:13 +0000
Message-ID: <5505B9A4.8030304@nod.at>
Date: Sun, 15 Mar 2015 17:56:04 +0100
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
	<55057604.6050308@gmx.de> <55059907.9060408@nod.at>
	<5505B889.4020401@gmx.de>
In-Reply-To: <5505B889.4020401@gmx.de>
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

QW0gMTUuMDMuMjAxNSB1bSAxNzo1MSBzY2hyaWViIFRvcmFsZiBGw7Zyc3RlcjoKPiBPbiAwMy8x
NS8yMDE1IDAzOjM2IFBNLCBSaWNoYXJkIFdlaW5iZXJnZXIgd3JvdGU6Cj4+IEJUVzogSnVzdCBy
YW4gYSB4ODYgVU1MIHdpdGggQ09ORklHX01DT1JFMj15LiBXb3JrcyBwZXJmZWN0bHkgZmluZS4K
PiAKPiBUaGUgcGljdHVyZSBpc24ndCBjbGVhci4KPiAKPiBBZnRlciB0d2lkZGxpbmcgd2l0aCB0
aGUga2VybmVsIGNvbmZpZyBJIGdvdCBhIHdvcmtpbmcgIC5jb25maWcgd2l0aCBDT1JFMj15LiBU
aGlzIHJ1bnMgZmluZSBpZiBjb21waWxlZCB3aXRoIHZhbmlsbGEgZ2NjIDQuOC4zLgo+IAo+IENv
bXBpbGVkIHdpdGggdGhlIGRlZmF1bHQgKGhhcmRlbmVkKSBnY2MgaXQgaGFuZ3MgYXMgZXhwZWN0
ZWQuIEFmdGVyIHdhaXRpbmcgYSBsb25nIHRpbWUgSSBkbyBnZXQgOgoKVGhlbiBwbGVhc2UgbW92
ZSB0aGUgaGFyZGVuZWQgZ2NjIHRvIC9kZXYvbnVsbC4gOy0pCkkgcmVhbGx5IGRvbid0IGhhdmUg
dGhlIHJlc291cmNlcyB0byBkZWJ1ZyBvdXQtb2YtdHJlZSBnY2MgZmVhdHVyZXMuCklmIHlvdSBj
YW4gdGVsbCBtZSB3aGF0IGhhcmRlbmluZyBmZWF0dXJlIGlzIHRoZSByb290IGNhdXNlIEkgY2Fu
IHRoaW5rIG9mIGEgc29sdXRpb24uCgpUaGFua3MsCi8vcmljaGFyZAoKLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tCkRpdmUgaW50byB0aGUgV29ybGQgb2YgUGFyYWxsZWwgUHJvZ3JhbW1pbmcgVGhlIEdv
IFBhcmFsbGVsIFdlYnNpdGUsIHNwb25zb3JlZApieSBJbnRlbCBhbmQgZGV2ZWxvcGVkIGluIHBh
cnRuZXJzaGlwIHdpdGggU2xhc2hkb3QgTWVkaWEsIGlzIHlvdXIgaHViIGZvciBhbGwKdGhpbmdz
IHBhcmFsbGVsIHNvZnR3YXJlIGRldmVsb3BtZW50LCBmcm9tIHdlZWtseSB0aG91Z2h0IGxlYWRl
cnNoaXAgYmxvZ3MgdG8KbmV3cywgdmlkZW9zLCBjYXNlIHN0dWRpZXMsIHR1dG9yaWFscyBhbmQg
bW9yZS4gVGFrZSBhIGxvb2sgYW5kIGpvaW4gdGhlIApjb252ZXJzYXRpb24gbm93LiBodHRwOi8v
Z29wYXJhbGxlbC5zb3VyY2Vmb3JnZS5uZXQvCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fClVzZXItbW9kZS1saW51eC1kZXZlbCBtYWlsaW5nIGxpc3QKVXNl
ci1tb2RlLWxpbnV4LWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNv
dXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby91c2VyLW1vZGUtbGludXgtZGV2ZWwK

