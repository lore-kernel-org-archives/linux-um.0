Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1YVP8P-0005gF-Dw
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 10 Mar 2015 18:44:05 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YVP8O-0007yg-0t
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 10 Mar 2015 18:44:05 +0000
Message-ID: <54FF3B6C.9060808@nod.at>
Date: Tue, 10 Mar 2015 19:43:56 +0100
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
References: <54FCBB88.70605@gmx.de>
	<CAFLxGvy8mLg9R9J38uAGFdZA_QdN=qZ3L-_niYoX8+n7GA0+Vg@mail.gmail.com>
	<54FCCFF8.3030209@gmx.de> <54FCD0DB.4060308@nod.at>
	<54FF01F3.5060203@gmx.de> <54FF03DE.1080206@nod.at>
	<54FF09B5.5020707@gmx.de> <54FF1281.7070709@nod.at>
	<54FF2D3B.5090301@gmx.de> <54FF2F89.604@nod.at>
	<54FF36CC.4010401@gmx.de> <54FF3910.8060502@nod.at>
	<54FF3A7A.4010606@gmx.de>
In-Reply-To: <54FF3A7A.4010606@gmx.de>
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

QW0gMTAuMDMuMjAxNSB1bSAxOTozOSBzY2hyaWViIFRvcmFsZiBGw7Zyc3RlcjoKPiBPbiAwMy8x
MC8yMDE1IDA3OjMzIFBNLCBSaWNoYXJkIFdlaW5iZXJnZXIgd3JvdGU6Cj4+IFNvIHlvdSBzZWUg
KnJhbmRvbSogY3Jhc2hlcz8KPiB5ZXMsIHRoZSAxc3QgUklQIGlzIHZhcnlpbmcsIGp1c3QgdGhl
IDJuZCBzdGF5cyBhdCAwMDAwMDAwMDYwMDFiMDExCgpPa2F5LiBDYW4geW91IHBsZWFzZSBmaW5k
IHRoZSBsYXN0IHdvcmtpbmcgcmVsZWFzZT8KSSdtIHN0aWxsIGEgYml0IHB1enpsZWQuCkFsc28g
cGxlYXNlIHNlbmQgbWUgeW91ciAuY29uZmlnLgoKPiBNb2R1bGVzIGxpbmtlZCBpbjoKPiBQaWQ6
IDEsIGNvbW06IHN3YXBwZXIgTm90IHRhaW50ZWQgNC4wLjAtcmMzLTAwMTExLWdhZmZiODE3Cj4g
UklQOiAwMDMzOls8MDAwMDdmY2Q3Nzc5MDVmYj5dCj4gUlNQOiAwMDAwN2ZjZDc3ZTZmZWY4ICBF
RkxBR1M6IDAwMDEwMjAyCj4gUkFYOiAwMDAwMDAwMDAwMDAwMDAwIFJCWDogMDAwMDAwMDA2MzU2
MjAwMCBSQ1g6IDAwMDAwMDAwMDAwMDAwMDAKPiBSRFg6IDAwMDAwMDAwMDAwMDAwMDAgUlNJOiAw
MDAwMDAwMDAwMDAwMDAwIFJESTogMDAwMDAwMDAwMDAwMDAwMAo+IFJCUDogMDAwMDdmY2Q3N2U3
MGYxOCBSMDg6IDAwMDAwMDAwNjAwMTgwOTAgUjA5OiAwMDAwMDAwMDAwMDAwMDAwCj4gUjEwOiAw
MDAwMDAwMDYyY2JiZDAwIFIxMTogMDAwMDAwMDAwMDAwMDI0NiBSMTI6IDAwMDAwMDAwNjAwMTgx
NDAKPiBSMTM6IDAwMDAwMDAwNjAwMTgxZTAgUjE0OiAwMDAwMDAwMDYyY2JiZDAwIFIxNTogMDAw
MDAwMDA2MDBiN2FmZAo+IEtlcm5lbCBwYW5pYyAtIG5vdCBzeW5jaW5nOiBTZWdmYXVsdCB3aXRo
IG5vIG1tCj4gQ1BVOiAwIFBJRDogMSBDb21tOiBzd2FwcGVyIE5vdCB0YWludGVkIDQuMC4wLXJj
My0wMDExMS1nYWZmYjgxNyAjMgo+IFN0YWNrOgo+IAo+IE1vZHVsZXMgbGlua2VkIGluOgo+IFBp
ZDogMSwgY29tbTogc3dhcHBlciBOb3QgdGFpbnRlZCA0LjAuMC1yYzMtMDAxMTEtZ2FmZmI4MTcK
PiBSSVA6IDAwMzM6WzwwMDAwMDAwMDYwMDFiMDExPl0KPiBSU1A6IDAwMDAwMDAwNjAzNGY0ODAg
IEVGTEFHUzogMDAwMTAyMDIKPiBSQVg6IDAwMDAwMDAwMDAwMDAwMDYgUkJYOiAwMDAwMDAwMDYw
MjdhMjc5IFJDWDogMDAwMDAwMDA2MDNmNTVhMAo+IFJEWDogMDAwMDAwMDAwMDAwMDAwMCBSU0k6
IDAwMDAwMDAwNjAzZjA4YjggUkRJOiAwMDAwMDAwMDAwMDAwMDAwCj4gUkJQOiAwMDAwMDAwMDYw
MzRmNGIwIFIwODogMDAwMDAwMDA2MDM0ZjA4OSBSMDk6IDAwMDAwMDAwNjAwNWNlMDEKPiBSMTA6
IDAwMDAwMDAwMDAwMDAwMDggUjExOiAwMDAwMDAwMDAwMDAwMjA2IFIxMjogMDAwMDdmY2Q3N2U2
ZmVmZgo+IFIxMzogMDAwMDAwMDAwMDAwMDAwMSBSMTQ6IDAwMDAwMDAwNjAzNGY3MTAgUjE1OiAw
MDAwMDAwMDYwMzRmYjAxCj4gS2VybmVsIHBhbmljIC0gbm90IHN5bmNpbmc6IFNlZ2ZhdWx0IHdp
dGggbm8gbW0KPiAKPiAKPiAkIGFkZHIybGluZSAtZSBsaW51eCAwMDAwMDAwMDYwMDFiMDExCj4g
L2hvbWUvdGZvZXJzdGUvZGV2ZWwvbGludXgvYXJjaC91bS9rZXJuZWwvc3lzcnEuYzo1NgoKVGhh
dCdzIG9rYXkuCgpUaGFua3MsCi8vcmljaGFyZAoKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCkRpdmUg
aW50byB0aGUgV29ybGQgb2YgUGFyYWxsZWwgUHJvZ3JhbW1pbmcgVGhlIEdvIFBhcmFsbGVsIFdl
YnNpdGUsIHNwb25zb3JlZApieSBJbnRlbCBhbmQgZGV2ZWxvcGVkIGluIHBhcnRuZXJzaGlwIHdp
dGggU2xhc2hkb3QgTWVkaWEsIGlzIHlvdXIgaHViIGZvciBhbGwKdGhpbmdzIHBhcmFsbGVsIHNv
ZnR3YXJlIGRldmVsb3BtZW50LCBmcm9tIHdlZWtseSB0aG91Z2h0IGxlYWRlcnNoaXAgYmxvZ3Mg
dG8KbmV3cywgdmlkZW9zLCBjYXNlIHN0dWRpZXMsIHR1dG9yaWFscyBhbmQgbW9yZS4gVGFrZSBh
IGxvb2sgYW5kIGpvaW4gdGhlIApjb252ZXJzYXRpb24gbm93LiBodHRwOi8vZ29wYXJhbGxlbC5z
b3VyY2Vmb3JnZS5uZXQvCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fClVzZXItbW9kZS1saW51eC1kZXZlbCBtYWlsaW5nIGxpc3QKVXNlci1tb2RlLWxpbnV4
LWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5l
dC9saXN0cy9saXN0aW5mby91c2VyLW1vZGUtbGludXgtZGV2ZWwK

