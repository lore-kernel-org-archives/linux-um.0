Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1YVRbD-0002xb-KZ
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 10 Mar 2015 21:21:59 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YVRbC-0003A5-6K
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 10 Mar 2015 21:21:59 +0000
Message-ID: <54FF606E.5050109@nod.at>
Date: Tue, 10 Mar 2015 22:21:50 +0100
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
	<54FF3E5D.8040204@gmx.de>
In-Reply-To: <54FF3E5D.8040204@gmx.de>
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

QW0gMTAuMDMuMjAxNSB1bSAxOTo1NiBzY2hyaWViIFRvcmFsZiBGw7Zyc3RlcjoKPiBPbiAwMy8x
MC8yMDE1IDA3OjQzIFBNLCBSaWNoYXJkIFdlaW5iZXJnZXIgd3JvdGU6Cj4+IEFsc28gcGxlYXNl
IHNlbmQgbWUgeW91ciAuY29uZmlnLgo+IGF0dGFjaGVkCgpUaGlzIC5jb25maWcgd29ya3MgcGVy
ZmVjbHkgZmluZSBoZXJlLgpTbywgd2hhdCBkb2VzIHlvdXIgdXNlcnNwYWNlPyBEb2VzIFVNTCBj
cmFzaCB3aGlsZSBib290aW5nIHVwPwpCVFc6IFlvdSBkbyBub3Qgc3BlY2lmeSBtZW09LCBzbyB5
b3UgaGF2ZSBvbmx5IHZlcnkgZmV3IG1lbW9yeS4uLgoKVGhhbmtzLAovL3JpY2hhcmQKCi0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLQpEaXZlIGludG8gdGhlIFdvcmxkIG9mIFBhcmFsbGVsIFByb2dyYW1t
aW5nIFRoZSBHbyBQYXJhbGxlbCBXZWJzaXRlLCBzcG9uc29yZWQKYnkgSW50ZWwgYW5kIGRldmVs
b3BlZCBpbiBwYXJ0bmVyc2hpcCB3aXRoIFNsYXNoZG90IE1lZGlhLCBpcyB5b3VyIGh1YiBmb3Ig
YWxsCnRoaW5ncyBwYXJhbGxlbCBzb2Z0d2FyZSBkZXZlbG9wbWVudCwgZnJvbSB3ZWVrbHkgdGhv
dWdodCBsZWFkZXJzaGlwIGJsb2dzIHRvCm5ld3MsIHZpZGVvcywgY2FzZSBzdHVkaWVzLCB0dXRv
cmlhbHMgYW5kIG1vcmUuIFRha2UgYSBsb29rIGFuZCBqb2luIHRoZSAKY29udmVyc2F0aW9uIG5v
dy4gaHR0cDovL2dvcGFyYWxsZWwuc291cmNlZm9yZ2UubmV0LwpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpVc2VyLW1vZGUtbGludXgtZGV2ZWwgbWFpbGlu
ZyBsaXN0ClVzZXItbW9kZS1saW51eC1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6
Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vdXNlci1tb2RlLWxpbnV4LWRl
dmVsCg==

