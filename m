Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1YZRrM-0004sF-KW
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 21 Mar 2015 22:27:12 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YZRrL-0005Vo-A2
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 21 Mar 2015 22:27:12 +0000
Message-ID: <550DF038.70202@nod.at>
Date: Sat, 21 Mar 2015 23:27:04 +0100
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
	<5505B889.4020401@gmx.de> <5505B9A4.8030304@nod.at>
	<5506D945.809@gmx.de>
In-Reply-To: <5506D945.809@gmx.de>
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

QW0gMTYuMDMuMjAxNSB1bSAxNDoyMyBzY2hyaWViIFRvcmFsZiBGw7Zyc3RlcjoKPiBPbiAwMy8x
NS8yMDE1IDA1OjU2IFBNLCBSaWNoYXJkIFdlaW5iZXJnZXIgd3JvdGU6Cj4+IFRoZW4gcGxlYXNl
IG1vdmUgdGhlIGhhcmRlbmVkIGdjYyB0byAvZGV2L251bGwuIDstKQo+IAo+IHllcywgYXQgbGVh
c3QgdG8gY29tcGlsZSB0aGUgVU1MIGxpbnV4Cj4gCj4+IElmIHlvdSBjYW4gdGVsbCBtZSB3aGF0
IGhhcmRlbmluZyBmZWF0dXJlIGlzIHRoZSByb290IGNhdXNlIEkgY2FuIHRoaW5rIG9mIGEgc29s
dXRpb24uCj4gV2lsbCBiZSBhIGxvbmdlciB3YXkgSSBmZWFyLgo+IEV2ZXJ5IDJuZCBvciAzcmQg
YXR0ZW1wdCB0aGUgVU1MIGd1ZXN0IGhhbmdzIGR1cmluZyBib290LCBhbiBpbW1lZGlhdGUgYXR0
ZW1wdCB3b3JrcyAtIHNvIHJlYWxseSBoYXJkIHRvIGRpZyBpbnRvIHRoZSByb290IGNhdXNlLgo+
IAo+IEJ1dCBJJ2xsIHRyeSBpdC4KCkkgZGlkIHNvbWUgZnVydGhlciBpbnZlc3RpZ2F0aW9uLiBU
aGUgcm9vdCBjYXVzZSBvZiB0aGUgZ2VudG9vIGhhcmRlbmVkIHN5c3RlbSBzZWVtcyB0byBiZSB0
aGUgaGFyZGVuZWQgbGliYy4KQXMgc29vbiBhIFVNTCBrdGhyZWFkIGlzc3VlcyBhIHN5c2NhbGwg
b24gdGhlIGhvc3Qgc2lkZSBVTUwgZGllcy4KQXQgbGVhc3Qgb24gbXkgUEMgSSBjYW4gYnVpbGQg
YW5kIHJ1biBVTUwgd2l0aCB0aGUgaGFyZGVuZWQgZ2NjLiBCdXQgcnVubmluZyBhbnkgVU1MIG9u
IGEgaGFyZGVuZWQgYmFzZSBzeXN0ZW0gKGxpYmMpIGZhaWxzIGJhZGx5LgoKPiBJbiBtb21lbnQg
bXkgYmlnZ2VzdCBwcm9ibGVtIGlzLCB0aGF0IEkgZ2V0IHRoZSBmb2xsb3dpbmcgZXJyb3IgYXMg
c29vbiBhcyBJIHRyeSB0byBzZW5kIG91dCBhbiBuZXR3b3JrIHBhY2thZ2UgZnJvbSBldGgwIChE
SENQIHdvcmtzLCBidXQgdGhlIGZpcnN0IHBpbmcgdG8gYW4gaXAgYWRkcmVzcyBvdXRzaWRlIHRy
aWdnZXJzIHRoZSBlcnJvcik6CgpEb2VzIHRoaXMgYWxzbyBoYXBwZW4gb24gYSByZWd1bGFyIHN5
c3RlbT8gQmVjYXVzZSBoZXJlIG5ldHdvcmtpbmcgd29ya3MgZmluZS4KClRoYW5rcywKLy9yaWNo
YXJkCgotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KRGl2ZSBpbnRvIHRoZSBXb3JsZCBvZiBQYXJhbGxl
bCBQcm9ncmFtbWluZyBUaGUgR28gUGFyYWxsZWwgV2Vic2l0ZSwgc3BvbnNvcmVkCmJ5IEludGVs
IGFuZCBkZXZlbG9wZWQgaW4gcGFydG5lcnNoaXAgd2l0aCBTbGFzaGRvdCBNZWRpYSwgaXMgeW91
ciBodWIgZm9yIGFsbAp0aGluZ3MgcGFyYWxsZWwgc29mdHdhcmUgZGV2ZWxvcG1lbnQsIGZyb20g
d2Vla2x5IHRob3VnaHQgbGVhZGVyc2hpcCBibG9ncyB0bwpuZXdzLCB2aWRlb3MsIGNhc2Ugc3R1
ZGllcywgdHV0b3JpYWxzIGFuZCBtb3JlLiBUYWtlIGEgbG9vayBhbmQgam9pbiB0aGUgCmNvbnZl
cnNhdGlvbiBub3cuIGh0dHA6Ly9nb3BhcmFsbGVsLnNvdXJjZWZvcmdlLm5ldC8KX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVXNlci1tb2RlLWxpbnV4LWRl
dmVsIG1haWxpbmcgbGlzdApVc2VyLW1vZGUtbGludXgtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2Uu
bmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL3VzZXItbW9k
ZS1saW51eC1kZXZlbAo=

