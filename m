Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1YVMPU-0004jU-Gs
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 10 Mar 2015 15:49:32 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YVMPR-0003VG-W6
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 10 Mar 2015 15:49:32 +0000
Message-ID: <54FF1281.7070709@nod.at>
Date: Tue, 10 Mar 2015 16:49:21 +0100
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
References: <54FCBB88.70605@gmx.de>
	<CAFLxGvy8mLg9R9J38uAGFdZA_QdN=qZ3L-_niYoX8+n7GA0+Vg@mail.gmail.com>
	<54FCCFF8.3030209@gmx.de> <54FCD0DB.4060308@nod.at>
	<54FF01F3.5060203@gmx.de> <54FF03DE.1080206@nod.at>
	<54FF09B5.5020707@gmx.de>
In-Reply-To: <54FF09B5.5020707@gmx.de>
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

QW0gMTAuMDMuMjAxNSB1bSAxNjoxMSBzY2hyaWViIFRvcmFsZiBGw7Zyc3RlcjoKPiBzbywgSSBp
bnN0YWxsZWQgYSBoYXJkZW5lZCA2NGJpdCBHZW50b28gWzFdLCBjb25maWd1cmVkIEdSc2VjdXJp
dHkgaW4gdGhlIGtlcm5lbCA6Cj4gCj4gQ09ORklHX0dSS0VSTlNFQz15Cj4gQ09ORklHX0dSS0VS
TlNFQ19DT05GSUdfQVVUTz15Cj4gIyBDT05GSUdfR1JLRVJOU0VDX0NPTkZJR19DVVNUT00gaXMg
bm90IHNldAo+ICMgQ09ORklHX0dSS0VSTlNFQ19DT05GSUdfU0VSVkVSIGlzIG5vdCBzZXQKPiBD
T05GSUdfR1JLRVJOU0VDX0NPTkZJR19ERVNLVE9QPXkKClRoZW4ganVzdCByZWJvb3QgaW50byBh
IHByaXN0aW5lIGtlcm5lbCBhbmQgcmV0ZXN0LiA6LSkKClRoYW5rcywKLy9yaWNoYXJkCgotLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0KRGl2ZSBpbnRvIHRoZSBXb3JsZCBvZiBQYXJhbGxlbCBQcm9ncmFt
bWluZyBUaGUgR28gUGFyYWxsZWwgV2Vic2l0ZSwgc3BvbnNvcmVkCmJ5IEludGVsIGFuZCBkZXZl
bG9wZWQgaW4gcGFydG5lcnNoaXAgd2l0aCBTbGFzaGRvdCBNZWRpYSwgaXMgeW91ciBodWIgZm9y
IGFsbAp0aGluZ3MgcGFyYWxsZWwgc29mdHdhcmUgZGV2ZWxvcG1lbnQsIGZyb20gd2Vla2x5IHRo
b3VnaHQgbGVhZGVyc2hpcCBibG9ncyB0bwpuZXdzLCB2aWRlb3MsIGNhc2Ugc3R1ZGllcywgdHV0
b3JpYWxzIGFuZCBtb3JlLiBUYWtlIGEgbG9vayBhbmQgam9pbiB0aGUgCmNvbnZlcnNhdGlvbiBu
b3cuIGh0dHA6Ly9nb3BhcmFsbGVsLnNvdXJjZWZvcmdlLm5ldC8KX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVXNlci1tb2RlLWxpbnV4LWRldmVsIG1haWxp
bmcgbGlzdApVc2VyLW1vZGUtbGludXgtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBz
Oi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL3VzZXItbW9kZS1saW51eC1k
ZXZlbAo=

