Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1YX6Gi-00015P-9z
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 15 Mar 2015 10:59:40 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YX6Gg-0000NF-2W
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 15 Mar 2015 10:59:40 +0000
Message-ID: <55056612.9030000@nod.at>
Date: Sun, 15 Mar 2015 11:59:30 +0100
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
ZCB0b28uCj4gKEFuZCBJIHN3aXRjaGVkIHRoZSBjb21waWxlciB0byBnY2MtNC44LjMtdmFuaWxs
YSBiZWZvcmUgYW5kIGNvbXBpbGVkIHRoZSBsaW51eCBleGUgd2l0aCBpdCkKPiAKPiBBbmQgbGFz
dCBidXQgbm90IGxlYXN0IC0gSSBjb21wYXJlZCB0aGUgbWQ1c3VtIHRvIGVuc3VyZSwgdGhhdCB0
aGUgKDMgR0IgYmlnKSBVTUwgZ3Vlc3RzIHdhcyBjb3BpZWQgZXJyb3ItZnJlZSBmcm9tIHRoZSB4
ODYgc3lzdGVtLCAod2hlcmUgdGhlIFVNTCBndWVzdCBydW5zIGZpbmUpCgpXYWl0IGEgbW9tZW50
LiBTbywgdGhlIGZhaWxpbmcgVU1MIGlzIGEgMzJiaXRzIFVNTD8KVGhlIC5jb25maWcgeW91IHNl
bnQgbWUgaXMgVU1MIHg4Nl82NC4uLgoKVGhhbmtzLAovL3JpY2hhcmQKCi0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLQpEaXZlIGludG8gdGhlIFdvcmxkIG9mIFBhcmFsbGVsIFByb2dyYW1taW5nIFRoZSBH
byBQYXJhbGxlbCBXZWJzaXRlLCBzcG9uc29yZWQKYnkgSW50ZWwgYW5kIGRldmVsb3BlZCBpbiBw
YXJ0bmVyc2hpcCB3aXRoIFNsYXNoZG90IE1lZGlhLCBpcyB5b3VyIGh1YiBmb3IgYWxsCnRoaW5n
cyBwYXJhbGxlbCBzb2Z0d2FyZSBkZXZlbG9wbWVudCwgZnJvbSB3ZWVrbHkgdGhvdWdodCBsZWFk
ZXJzaGlwIGJsb2dzIHRvCm5ld3MsIHZpZGVvcywgY2FzZSBzdHVkaWVzLCB0dXRvcmlhbHMgYW5k
IG1vcmUuIFRha2UgYSBsb29rIGFuZCBqb2luIHRoZSAKY29udmVyc2F0aW9uIG5vdy4gaHR0cDov
L2dvcGFyYWxsZWwuc291cmNlZm9yZ2UubmV0LwpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpVc2VyLW1vZGUtbGludXgtZGV2ZWwgbWFpbGluZyBsaXN0ClVz
ZXItbW9kZS1saW51eC1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5z
b3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vdXNlci1tb2RlLWxpbnV4LWRldmVsCg==

