Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1YVLR3-0001ZD-8g
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 10 Mar 2015 14:47:05 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YVLR1-0006Ox-KW
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 10 Mar 2015 14:47:05 +0000
Message-ID: <54FF03DE.1080206@nod.at>
Date: Tue, 10 Mar 2015 15:46:54 +0100
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
References: <54FCBB88.70605@gmx.de>
	<CAFLxGvy8mLg9R9J38uAGFdZA_QdN=qZ3L-_niYoX8+n7GA0+Vg@mail.gmail.com>
	<54FCCFF8.3030209@gmx.de> <54FCD0DB.4060308@nod.at>
	<54FF01F3.5060203@gmx.de>
In-Reply-To: <54FF01F3.5060203@gmx.de>
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

QW0gMTAuMDMuMjAxNSB1bSAxNTozOCBzY2hyaWViIFRvcmFsZiBGw7Zyc3RlcjoKPiBPbiAwMy8w
OC8yMDE1IDExOjQ0IFBNLCBSaWNoYXJkIFdlaW5iZXJnZXIgd3JvdGU6Cj4+IE9rYXkuIERvZXMg
aXQgd29yayBvbiBhIHJlZ3VsYXIgaG9zdCBzeXN0ZW0/Cj4+IEkuZS4gbm90IGJyb2tlbl5XaGFy
ZGVuZWQuCj4+Cj4+IEkgcnVuIHg4NiBVTUwncyB2ZXJ5IG9mdGVuIG9uIHg4Nl82NC4uLgo+IAo+
IE9rLCBJIGhhdmUgaGVyZSBqdXN0IGEgaGFyZGVuZWQgc3lzdGVtLCBzbyBJJ2xsIGxvb2sgZm9y
IGlzc3VlcyByZWxhdGVkIHRvIHRoYXQgLgoKSXQgd291bGQgYWxzbyBoZWxwIGlmIHlvdSBjb3Vs
ZCBkZXNjcmliZSBpbiBkZXRhaWwgd2hhdCB5b3UndmUgaGFyZGVuZWQuIDopCgpUaGFua3MsCi8v
cmljaGFyZAoKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCkRpdmUgaW50byB0aGUgV29ybGQgb2YgUGFy
YWxsZWwgUHJvZ3JhbW1pbmcgVGhlIEdvIFBhcmFsbGVsIFdlYnNpdGUsIHNwb25zb3JlZApieSBJ
bnRlbCBhbmQgZGV2ZWxvcGVkIGluIHBhcnRuZXJzaGlwIHdpdGggU2xhc2hkb3QgTWVkaWEsIGlz
IHlvdXIgaHViIGZvciBhbGwKdGhpbmdzIHBhcmFsbGVsIHNvZnR3YXJlIGRldmVsb3BtZW50LCBm
cm9tIHdlZWtseSB0aG91Z2h0IGxlYWRlcnNoaXAgYmxvZ3MgdG8KbmV3cywgdmlkZW9zLCBjYXNl
IHN0dWRpZXMsIHR1dG9yaWFscyBhbmQgbW9yZS4gVGFrZSBhIGxvb2sgYW5kIGpvaW4gdGhlIApj
b252ZXJzYXRpb24gbm93LiBodHRwOi8vZ29wYXJhbGxlbC5zb3VyY2Vmb3JnZS5uZXQvCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClVzZXItbW9kZS1saW51
eC1kZXZlbCBtYWlsaW5nIGxpc3QKVXNlci1tb2RlLWxpbnV4LWRldmVsQGxpc3RzLnNvdXJjZWZv
cmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby91c2Vy
LW1vZGUtbGludXgtZGV2ZWwK

