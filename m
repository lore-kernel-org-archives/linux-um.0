Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1YVOLP-00039f-KG
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 10 Mar 2015 17:53:27 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YVOLJ-00013i-Js
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 10 Mar 2015 17:53:27 +0000
Message-ID: <54FF2F89.604@nod.at>
Date: Tue, 10 Mar 2015 18:53:13 +0100
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
References: <54FCBB88.70605@gmx.de>
	<CAFLxGvy8mLg9R9J38uAGFdZA_QdN=qZ3L-_niYoX8+n7GA0+Vg@mail.gmail.com>
	<54FCCFF8.3030209@gmx.de> <54FCD0DB.4060308@nod.at>
	<54FF01F3.5060203@gmx.de> <54FF03DE.1080206@nod.at>
	<54FF09B5.5020707@gmx.de> <54FF1281.7070709@nod.at>
	<54FF2D3B.5090301@gmx.de>
In-Reply-To: <54FF2D3B.5090301@gmx.de>
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

QW0gMTAuMDMuMjAxNSB1bSAxODo0MyBzY2hyaWViIFRvcmFsZiBGw7Zyc3RlcjoKPiBPbiAwMy8x
MC8yMDE1IDA0OjQ5IFBNLCBSaWNoYXJkIFdlaW5iZXJnZXIgd3JvdGU6Cj4+IFRoZW4ganVzdCBy
ZWJvb3QgaW50byBhIHByaXN0aW5lIGtlcm5lbCBhbmQgcmV0ZXN0LiA6LSkKPiAKPiBXaXRoIGxh
dGVzdCBob3N0IHZhbmlsbGEgNC4wLjAtcmMzIGtlcm5lbCBJIGdldCBhIHNpbWlsYXIgcGljdHVy
ZToKCkhtbSwgZG9lcyBub3QgbG9vayBhdCBhbGwgbGlrZSB5b3VyIGluaXRpYWwgcmVwb3J0LiBC
dXQgbWF5YmUgaXQgaXMganVzdCBhbm90aGVyCnN5bXB0b20uCldoYXQgaXMgeW91ciBmdWxsIGtl
cm5lbCBjb21tYW5kbGluZT8KCj4gVFVOL1RBUCBiYWNrZW5kIC0gCj4gd2luY2hfdGhyZWFkIDog
VElPQ1NDVFRZIGZhaWxlZCBvbiBmZCAxIGVyciA9IDEKPiBFWFQ0LWZzICh1YmRhKTogbW91bnRl
ZCBmaWxlc3lzdGVtIHdpdGggb3JkZXJlZCBkYXRhIG1vZGUuIE9wdHM6IChudWxsKQo+IFZGUzog
TW91bnRlZCByb290IChleHQ0IGZpbGVzeXN0ZW0pIHJlYWRvbmx5IG9uIGRldmljZSA5ODowLgo+
IGRldnRtcGZzOiBtb3VudGVkCj4gCj4gTW9kdWxlcyBsaW5rZWQgaW46Cj4gUGlkOiAxLCBjb21t
OiBzd2FwcGVyIE5vdCB0YWludGVkIDQuMC4wLXJjMy0wMDExMS1nYWZmYjgxNwo+IFJJUDogMDAz
MzpbPDAwMDAwMDAwNjAyNTBjMGU+XQoKV2hhdCBpcyBhZGRyMmxpbmUgLWUgbGludXggMDAwMDAw
MDA2MDI1MGMwZT8KClRoYW5rcywKLy9yaWNoYXJkCgotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KRGl2
ZSBpbnRvIHRoZSBXb3JsZCBvZiBQYXJhbGxlbCBQcm9ncmFtbWluZyBUaGUgR28gUGFyYWxsZWwg
V2Vic2l0ZSwgc3BvbnNvcmVkCmJ5IEludGVsIGFuZCBkZXZlbG9wZWQgaW4gcGFydG5lcnNoaXAg
d2l0aCBTbGFzaGRvdCBNZWRpYSwgaXMgeW91ciBodWIgZm9yIGFsbAp0aGluZ3MgcGFyYWxsZWwg
c29mdHdhcmUgZGV2ZWxvcG1lbnQsIGZyb20gd2Vla2x5IHRob3VnaHQgbGVhZGVyc2hpcCBibG9n
cyB0bwpuZXdzLCB2aWRlb3MsIGNhc2Ugc3R1ZGllcywgdHV0b3JpYWxzIGFuZCBtb3JlLiBUYWtl
IGEgbG9vayBhbmQgam9pbiB0aGUgCmNvbnZlcnNhdGlvbiBub3cuIGh0dHA6Ly9nb3BhcmFsbGVs
LnNvdXJjZWZvcmdlLm5ldC8KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KVXNlci1tb2RlLWxpbnV4LWRldmVsIG1haWxpbmcgbGlzdApVc2VyLW1vZGUtbGlu
dXgtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2Uu
bmV0L2xpc3RzL2xpc3RpbmZvL3VzZXItbW9kZS1saW51eC1kZXZlbAo=

