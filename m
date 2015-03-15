Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1YX7s0-0004Vl-Jc
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 15 Mar 2015 12:42:16 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YX7rz-00072J-37
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 15 Mar 2015 12:42:16 +0000
Message-ID: <55057E1F.8020101@nod.at>
Date: Sun, 15 Mar 2015 13:42:07 +0100
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
PXkgZG8gbm90IHdvcmsKPiAKPiAKPiBJIGRvIGhhdmUgYW4gaTU6CgpJIGhhdmUgdG8gZG91Ymxl
IGNoZWNrIHRoaXMuIE1heWJlIHlvdSBoaW50IGFuIFVNTCBidWcuCgo+IHByb2Nlc3NvciAgICAg
ICA6IDMKPiB2ZW5kb3JfaWQgICAgICAgOiBHZW51aW5lSW50ZWwKPiBjcHUgZmFtaWx5ICAgICAg
OiA2Cj4gbW9kZWwgICAgICAgICAgIDogNjkKPiBtb2RlbCBuYW1lICAgICAgOiBJbnRlbChSKSBD
b3JlKFRNKSBpNS00MzAwVSBDUFUgQCAxLjkwR0h6Cj4gc3RlcHBpbmcgICAgICAgIDogMQo+IG1p
Y3JvY29kZSAgICAgICA6IDB4MWMKPiBjcHUgTUh6ICAgICAgICAgOiA4MDAuMDAwCj4gY2FjaGUg
c2l6ZSAgICAgIDogMzA3MiBLQgo+IHBoeXNpY2FsIGlkICAgICA6IDAKPiBzaWJsaW5ncyAgICAg
ICAgOiA0Cj4gY29yZSBpZCAgICAgICAgIDogMQo+IGNwdSBjb3JlcyAgICAgICA6IDIKPiBhcGlj
aWQgICAgICAgICAgOiAzCj4gaW5pdGlhbCBhcGljaWQgIDogMwo+IGZwdSAgICAgICAgICAgICA6
IHllcwo+IGZwdV9leGNlcHRpb24gICA6IHllcwo+IGNwdWlkIGxldmVsICAgICA6IDEzCj4gd3Ag
ICAgICAgICAgICAgIDogeWVzCj4gZmxhZ3MgICAgICAgICAgIDogZnB1IHZtZSBkZSBwc2UgdHNj
IG1zciBwYWUgbWNlIGN4OCBhcGljIHNlcCBtdHJyIHBnZSBtY2EgY21vdiBwYXQgcHNlMzYgY2xm
bHVzaCBkdHMgYWNwaSBtbXggZnhzciBzc2Ugc3NlMiBzcyBodCB0bSBwYmUgc3lzY2FsbCBueCBw
ZHBlMWdiIHJkdHNjcCBsbSBjb25zdGFudF90c2MgYXJjaF9wZXJmbW9uIHBlYnMgYnRzIHJlcF9n
b29kIG5vcGwgeHRvcG9sb2d5IG5vbnN0b3BfdHNjIGFwZXJmbXBlcmYgZWFnZXJmcHUgcG5pIHBj
bG11bHFkcSBkdGVzNjQgbW9uaXRvciBkc19jcGwgdm14IHNteCBlc3QgdG0yIHNzc2UzIGZtYSBj
eDE2IHh0cHIgcGRjbSBwY2lkIHNzZTRfMSBzc2U0XzIgeDJhcGljIG1vdmJlIHBvcGNudCB0c2Nf
ZGVhZGxpbmVfdGltZXIgYWVzIHhzYXZlIGF2eCBmMTZjIHJkcmFuZCBsYWhmX2xtIGFibSBpZGEg
YXJhdCBlcGIgcGxuIHB0cyBkdGhlcm0gdHByX3NoYWRvdyB2bm1pIGZsZXhwcmlvcml0eSBlcHQg
dnBpZCBzdHJvbmd1ZGVyZWYgZnNnc2Jhc2UgdHNjX2FkanVzdCBibWkxIGF2eDIgc21lcCBibWky
IGVybXMgaW52cGNpZCB4c2F2ZW9wdAo+IGJ1Z3MgICAgICAgICAgICA6Cj4gYm9nb21pcHMgICAg
ICAgIDogNDk4OC4zNAo+IGNsZmx1c2ggc2l6ZSAgICA6IDY0Cj4gY2FjaGVfYWxpZ25tZW50IDog
NjQKPiBhZGRyZXNzIHNpemVzICAgOiAzOSBiaXRzIHBoeXNpY2FsLCA0OCBiaXRzIHZpcnR1YWwK
PiBwb3dlciBtYW5hZ2VtZW50Ogo+IAo+IAo+IAo+PiBCVFc6IEluIEdSTUwgeW91IG5lZWQgdG8g
cmVtb3VudCAvZGV2L3NobSB3aXRoIGV4ZWMuIERpZCB5b3U/Cj4gSWNrLCBmb3JnZXQgdGhhdC4g
QlRXIHRoaXMgd2lya3MgaGVyZSBhdCBteSBob3N0IDoKPiAkPiBncmVwIHNobSAvZXRjL2ZzdGFi
IAo+IHNobSAgICAgICAgICAgICAgICAgICAgIC9kZXYvc2htICAgICAgICAgICAgICAgIHRtcGZz
ICAgICAgICAgICBub3N1aWQsbm9kZXYsc2l6ZT00RyAKClRoaXMgd29ya3MgYmVjYXVzZSBleGVj
IGlzIGRlZmF1bHQuCgpUaGFua3MsCi8vcmljaGFyZAoKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
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

