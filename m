Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1YX6ht-0002kJ-6x
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 15 Mar 2015 11:27:45 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YX6hr-0004wW-GD
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 15 Mar 2015 11:27:45 +0000
Message-ID: <55056CA7.1080700@nod.at>
Date: Sun, 15 Mar 2015 12:27:35 +0100
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
	<550564D2.5070103@gmx.de>
In-Reply-To: <550564D2.5070103@gmx.de>
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

QW0gMTUuMDMuMjAxNSB1bSAxMTo1NCBzY2hyaWViIFRvcmFsZiBGw7Zyc3RlcjoKPiBPbiAwMy8x
My8yMDE1IDAzOjMxIFBNLCBSaWNoYXJkIFdlaW5iZXJnZXIgd3JvdGU6Cj4+IEFuZCB3aGF0IGFi
b3V0IGEgcmVndWxhciAidW5oYXJkZW5lZCIgaG9zdD8KPj4gRG9lcyBpdCB3b3JrIGlmIHlvdSBi
b290IGEgcmFuZG9tIHg4Nl82NCBsaXZlY2Q/Cj4gCj4gdGVzdGVkIHdpdGggR1JNTCAtIGZhaWxl
ZCB0b28uCgpCVFc6IEluIEdSTUwgeW91IG5lZWQgdG8gcmVtb3VudCAvZGV2L3NobSB3aXRoIGV4
ZWMuIERpZCB5b3U/CgpUaGFua3MsCi8vcmljaGFyZAoKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCkRp
dmUgaW50byB0aGUgV29ybGQgb2YgUGFyYWxsZWwgUHJvZ3JhbW1pbmcgVGhlIEdvIFBhcmFsbGVs
IFdlYnNpdGUsIHNwb25zb3JlZApieSBJbnRlbCBhbmQgZGV2ZWxvcGVkIGluIHBhcnRuZXJzaGlw
IHdpdGggU2xhc2hkb3QgTWVkaWEsIGlzIHlvdXIgaHViIGZvciBhbGwKdGhpbmdzIHBhcmFsbGVs
IHNvZnR3YXJlIGRldmVsb3BtZW50LCBmcm9tIHdlZWtseSB0aG91Z2h0IGxlYWRlcnNoaXAgYmxv
Z3MgdG8KbmV3cywgdmlkZW9zLCBjYXNlIHN0dWRpZXMsIHR1dG9yaWFscyBhbmQgbW9yZS4gVGFr
ZSBhIGxvb2sgYW5kIGpvaW4gdGhlIApjb252ZXJzYXRpb24gbm93LiBodHRwOi8vZ29wYXJhbGxl
bC5zb3VyY2Vmb3JnZS5uZXQvCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fClVzZXItbW9kZS1saW51eC1kZXZlbCBtYWlsaW5nIGxpc3QKVXNlci1tb2RlLWxp
bnV4LWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdl
Lm5ldC9saXN0cy9saXN0aW5mby91c2VyLW1vZGUtbGludXgtZGV2ZWwK

