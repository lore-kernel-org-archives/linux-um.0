Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1YWQcP-0006LP-N6
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 13 Mar 2015 14:31:17 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YWQcJ-0004ha-Ni
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 13 Mar 2015 14:31:17 +0000
Message-ID: <5502F4A4.6070201@nod.at>
Date: Fri, 13 Mar 2015 15:31:00 +0100
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
	<5502E8D5.8040500@gmx.de>
In-Reply-To: <5502E8D5.8040500@gmx.de>
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

QW0gMTMuMDMuMjAxNSB1bSAxNDo0MCBzY2hyaWViIFRvcmFsZiBGw7Zyc3RlcjoKPiBPbiAwMy8x
MC8yMDE1IDEwOjIxIFBNLCBSaWNoYXJkIFdlaW5iZXJnZXIgd3JvdGU6Cj4+IEFtIDEwLjAzLjIw
MTUgdW0gMTk6NTYgc2NocmllYiBUb3JhbGYgRsO2cnN0ZXI6Cj4+PiBPbiAwMy8xMC8yMDE1IDA3
OjQzIFBNLCBSaWNoYXJkIFdlaW5iZXJnZXIgd3JvdGU6Cj4+Pj4gQWxzbyBwbGVhc2Ugc2VuZCBt
ZSB5b3VyIC5jb25maWcuCj4+PiBhdHRhY2hlZAo+Pgo+PiBUaGlzIC5jb25maWcgd29ya3MgcGVy
ZmVjbHkgZmluZSBoZXJlLgo+PiBTbywgd2hhdCBkb2VzIHlvdXIgdXNlcnNwYWNlPyBEb2VzIFVN
TCBjcmFzaCB3aGlsZSBib290aW5nIHVwPwo+PiBCVFc6IFlvdSBkbyBub3Qgc3BlY2lmeSBtZW09
LCBzbyB5b3UgaGF2ZSBvbmx5IHZlcnkgZmV3IG1lbW9yeS4uLgo+Pgo+PiBUaGFua3MsCj4+IC8v
cmljaGFyZAo+Pgo+IFdlbGwsCj4gaW4gZmFjdCBJIG5ldmVyIGV2ZXIgbWFuYWdlZCBpdCB0byBi
b290IHRoZSBVTUwgZ3Vlc3QgaGVyZSBhdCBteSBuZXcgaGFyZGVuZWQgaG9zdC4KPiBCdXQgYXQg
ZWxhc3QgKHRvZGF5KSBJIGdldCByZWxpYWJsZSBhIGNyYXNoIGluIHRoZSBzYW1lIHBsYWNlIChh
Z2FpbiBhbmQgYWdhaW4pOgoKQW5kIHdoYXQgYWJvdXQgYSByZWd1bGFyICJ1bmhhcmRlbmVkIiBo
b3N0PwpEb2VzIGl0IHdvcmsgaWYgeW91IGJvb3QgYSByYW5kb20geDg2XzY0IGxpdmVjZD8KClRo
YW5rcywKLy9yaWNoYXJkCgotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KRGl2ZSBpbnRvIHRoZSBXb3Js
ZCBvZiBQYXJhbGxlbCBQcm9ncmFtbWluZyBUaGUgR28gUGFyYWxsZWwgV2Vic2l0ZSwgc3BvbnNv
cmVkCmJ5IEludGVsIGFuZCBkZXZlbG9wZWQgaW4gcGFydG5lcnNoaXAgd2l0aCBTbGFzaGRvdCBN
ZWRpYSwgaXMgeW91ciBodWIgZm9yIGFsbAp0aGluZ3MgcGFyYWxsZWwgc29mdHdhcmUgZGV2ZWxv
cG1lbnQsIGZyb20gd2Vla2x5IHRob3VnaHQgbGVhZGVyc2hpcCBibG9ncyB0bwpuZXdzLCB2aWRl
b3MsIGNhc2Ugc3R1ZGllcywgdHV0b3JpYWxzIGFuZCBtb3JlLiBUYWtlIGEgbG9vayBhbmQgam9p
biB0aGUgCmNvbnZlcnNhdGlvbiBub3cuIGh0dHA6Ly9nb3BhcmFsbGVsLnNvdXJjZWZvcmdlLm5l
dC8KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVXNlci1t
b2RlLWxpbnV4LWRldmVsIG1haWxpbmcgbGlzdApVc2VyLW1vZGUtbGludXgtZGV2ZWxAbGlzdHMu
c291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3Rp
bmZvL3VzZXItbW9kZS1saW51eC1kZXZlbAo=

