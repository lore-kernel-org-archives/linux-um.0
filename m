Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1YVOyf-00057j-6z
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 10 Mar 2015 18:34:01 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YVOyd-0001zx-Sq
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 10 Mar 2015 18:34:01 +0000
Message-ID: <54FF3910.8060502@nod.at>
Date: Tue, 10 Mar 2015 19:33:52 +0100
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
References: <54FCBB88.70605@gmx.de>
	<CAFLxGvy8mLg9R9J38uAGFdZA_QdN=qZ3L-_niYoX8+n7GA0+Vg@mail.gmail.com>
	<54FCCFF8.3030209@gmx.de> <54FCD0DB.4060308@nod.at>
	<54FF01F3.5060203@gmx.de> <54FF03DE.1080206@nod.at>
	<54FF09B5.5020707@gmx.de> <54FF1281.7070709@nod.at>
	<54FF2D3B.5090301@gmx.de> <54FF2F89.604@nod.at>
	<54FF36CC.4010401@gmx.de>
In-Reply-To: <54FF36CC.4010401@gmx.de>
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

QW0gMTAuMDMuMjAxNSB1bSAxOToyNCBzY2hyaWViIFRvcmFsZiBGw7Zyc3RlcjoKPiBPbiAwMy8x
MC8yMDE1IDA2OjUzIFBNLCBSaWNoYXJkIFdlaW5iZXJnZXIgd3JvdGU6Cj4+IFdoYXQgaXMgYWRk
cjJsaW5lIC1lIGxpbnV4IDAwMDAwMDAwNjAyNTBjMGU/Cj4gCj4gJCBhZGRyMmxpbmUgLWUgbGlu
dXggMDAwMDAwMDA2MDI1MGMwZQo+IC9ob21lL3Rmb2Vyc3RlL2RldmVsL2xpbnV4L2luY2x1ZGUv
bGludXgvc2tidWZmLmg6MTUwMgo+IAo+ICQgYWRkcjJsaW5lIC1lIGxpbnV4IDAwMDAwMDAwNjAy
MzhhMDEKPiAvaG9tZS90Zm9lcnN0ZS9kZXZlbC9saW51eC9uZXQvaXB2NC90Y3Bfb3V0cHV0LmM6
MTkxOQo+IAo+IAo+IFRoZSBjb21tYW5kIGxpbmUgaXM6Cj4gJD4gL2hvbWUvdGZvZXJzdGUvZGV2
ZWwvbGludXgvbGludXggZWFybHlwcmludGsgdWJkYT0vaG9tZS90Zm9lcnN0ZS92aXJ0dWFsL3Vt
bC90cmluaXR5IHViZGI9L21udC9yYW1kaXNrL3RyaW5pdHlfc3dhcCBldGgwPXR1bnRhcCx0YXAw
LDcyOmVmOjNkOjlmOmMzOjVhIG1lbT0xMDAwTSBjb24wPWZkOjAsZmQ6MSBjb249cHRzIHVtaWQ9
dW1sX3RyaW5pdHkgcm9vdGZzdHlwZT1leHQ0IHNvZnRsb2NrdXBfYWxsX2NwdV9iYWNrdHJhY2U9
MQo+IAo+IGJ1dCBhIHNpbXBsZSAKPiAkPiAgL2hvbWUvdGZvZXJzdGUvZGV2ZWwvbGludXgvbGlu
dXggdWJkYT0vaG9tZS90Zm9lcnN0ZS92aXJ0dWFsL3VtbC90cmluaXR5Cj4gaXMgZW5vdWdoIHRv
byB0byBnZXQgdGhlIGlzc3VlLgoKUmVhbGx5PyBBbHNvIGluIHNrYnVmZiBhbmQgdGNwX291dHB1
dD8KCj4gV2hhdCBsZXQgbWUgd29uZGVyIGlzIHRoYXQgSSBjYW4ndCByZXByb2R1Y2UgdGhlIFJJ
UCBmcm9tIHRoZSBmaXJzdCBlbWFpbCBpbiBtb21lbnQuIEhvd2V2ZXIgbm93IEkgZG8gZ2V0IHJl
cHJvZHVjaWJsZSBhIFJJUCBvZiAwMDAwN2ZjNjQ4Nzc2NWZiIGFuZCAwMDAwMDAwMDYwMDFiMDEx
IHJlc3BlY3RpdmVseSA6CgpTbyB5b3Ugc2VlICpyYW5kb20qIGNyYXNoZXM/CgpUaGFua3MsCi8v
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

