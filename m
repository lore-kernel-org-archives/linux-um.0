Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <toralf.foerster@gmx.de>) id 1YVLp8-000315-Ks
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 10 Mar 2015 15:11:58 +0000
Received: from mout.gmx.net ([212.227.17.22])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YVLp7-0007GO-Ab
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 10 Mar 2015 15:11:58 +0000
Message-ID: <54FF09B5.5020707@gmx.de>
Date: Tue, 10 Mar 2015 16:11:49 +0100
From: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>
MIME-Version: 1.0
References: <54FCBB88.70605@gmx.de>
	<CAFLxGvy8mLg9R9J38uAGFdZA_QdN=qZ3L-_niYoX8+n7GA0+Vg@mail.gmail.com>
	<54FCCFF8.3030209@gmx.de> <54FCD0DB.4060308@nod.at>
	<54FF01F3.5060203@gmx.de> <54FF03DE.1080206@nod.at>
In-Reply-To: <54FF03DE.1080206@nod.at>
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
To: Richard Weinberger <richard@nod.at>
Cc: UML devel <user-mode-linux-devel@lists.sourceforge.net>

T24gMDMvMTAvMjAxNSAwMzo0NiBQTSwgUmljaGFyZCBXZWluYmVyZ2VyIHdyb3RlOgo+IEFtIDEw
LjAzLjIwMTUgdW0gMTU6Mzggc2NocmllYiBUb3JhbGYgRsO2cnN0ZXI6Cj4+IE9uIDAzLzA4LzIw
MTUgMTE6NDQgUE0sIFJpY2hhcmQgV2VpbmJlcmdlciB3cm90ZToKPj4+IE9rYXkuIERvZXMgaXQg
d29yayBvbiBhIHJlZ3VsYXIgaG9zdCBzeXN0ZW0/Cj4+PiBJLmUuIG5vdCBicm9rZW5eV2hhcmRl
bmVkLgo+Pj4KPj4+IEkgcnVuIHg4NiBVTUwncyB2ZXJ5IG9mdGVuIG9uIHg4Nl82NC4uLgo+Pgo+
PiBPaywgSSBoYXZlIGhlcmUganVzdCBhIGhhcmRlbmVkIHN5c3RlbSwgc28gSSdsbCBsb29rIGZv
ciBpc3N1ZXMgcmVsYXRlZCB0byB0aGF0IC4KPiAKPiBJdCB3b3VsZCBhbHNvIGhlbHAgaWYgeW91
IGNvdWxkIGRlc2NyaWJlIGluIGRldGFpbCB3aGF0IHlvdSd2ZSBoYXJkZW5lZC4gOikKPiAKPiBU
aGFua3MsCj4gLy9yaWNoYXJkCj4gCk9mIGNvdXJzZSwKCnNvLCBJIGluc3RhbGxlZCBhIGhhcmRl
bmVkIDY0Yml0IEdlbnRvbyBbMV0sIGNvbmZpZ3VyZWQgR1JzZWN1cml0eSBpbiB0aGUga2VybmVs
IDoKCkNPTkZJR19HUktFUk5TRUM9eQpDT05GSUdfR1JLRVJOU0VDX0NPTkZJR19BVVRPPXkKIyBD
T05GSUdfR1JLRVJOU0VDX0NPTkZJR19DVVNUT00gaXMgbm90IHNldAojIENPTkZJR19HUktFUk5T
RUNfQ09ORklHX1NFUlZFUiBpcyBub3Qgc2V0CkNPTkZJR19HUktFUk5TRUNfQ09ORklHX0RFU0tU
T1A9eQoKYW5kIHNldCBhdCBib290OgpzeXNjdGwgLXcga2VybmVsLmdyc2VjdXJpdHkuY2hyb290
X2RlbnlfY2htb2Q9MAoKCk5vdGhpbmcgZnVydGhlciwgbm8gU0VsaW51eCwgUkJBQyBldGMuCgoK
WzFdIGh0dHBzOi8vd2lraS5nZW50b28ub3JnL3dpa2kvSGFyZGVuZWRfR2VudG9vCgotLSAKVG9y
YWxmCnBncCBrZXk6IDdCMUEgMDdGNCBFQzgyIDBGOTAgRDRDMiAgODkzNiA4NzJBIEU1MDggMDA3
NiBFOTRFCgoKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
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

