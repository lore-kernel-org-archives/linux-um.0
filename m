Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <toralf.foerster@gmx.de>) id 1VNfqZ-0002Id-8m
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 22 Sep 2013 09:20:55 +0000
Received: from mout.gmx.net ([212.227.17.21])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1VNfqX-0007We-BF
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 22 Sep 2013 09:20:55 +0000
Received: from [80.171.221.199] ([80.171.221.199]) by mail.gmx.com (mrgmx101)
	with ESMTPSA (Nemesis) id 0LfXmv-1VhZJv3dTl-00p45r for
	<user-mode-linux-devel@lists.sourceforge.net>; Sun, 22 Sep 2013 11:20:47
	+0200
Message-ID: <523EB66B.5020608@gmx.de>
Date: Sun, 22 Sep 2013 11:20:43 +0200
From: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>
MIME-Version: 1.0
References: <52376466.2040601@gmx.de>
	<CAFLxGvyw7j_xGpk0F-DLLhxJFEXUjW_Jc0ggKySmRe0NszDAuw@mail.gmail.com>
	<523EA9FF.60804@gmx.de>
In-Reply-To: <523EA9FF.60804@gmx.de>
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
Subject: Re: [uml-devel] difference of a shell script versus command line
 WRT "winch_thread : TIOCSCTTY failed on fd 1 err = 1"
To: richard -rw- weinberger <richard.weinberger@gmail.com>
Cc: UML devel <user-mode-linux-devel@lists.sourceforge.net>

T24gMDkvMjIvMjAxMyAxMDoyNyBBTSwgVG9yYWxmIEbDtnJzdGVyIHdyb3RlOgo+IE9uIDA5LzIy
LzIwMTMgMDg6NTIgQU0sIHJpY2hhcmQgLXJ3LSB3ZWluYmVyZ2VyIHdyb3RlOgo+PiBPbiBNb24s
IFNlcCAxNiwgMjAxMyBhdCAxMDowNCBQTSwgVG9yYWxmIEbDtnJzdGVyIDx0b3JhbGYuZm9lcnN0
ZXJAZ214LmRlPiB3cm90ZToKPj4+IElmIEkgcnVuIHRoZSBmb2xsb3dpbmcgc2NyaXB0Cj4+Pgo+
Pj4gJD4gY2F0IGwuc2gKPj4+ICMhL2Jpbi9zaAo+Pj4gIwo+Pj4KPj4+IC91c3IvbG9jYWwvYmlu
L2xpbnV4LXYzLjExLTg3MTgtZzBmYjVjYTEgZWFybHlwcmludGsgdWJkYT0vaG9tZS90Zm9lcnN0
ZS92aXJ0dWFsL3VtbC9uMjJ1bnN0NCB1YmRiPS9tbnQvcmFtZGlzay9uMjJ1bnN0NF9zd2FwIGV0
aDA9dHVudGFwLHRhcDIsNzI6ZWY6M2Q6NWQ6ZDM6ZGIgbWVtPTEwMjVNIGNvbjA9ZmQ6MCxmZDox
IGNvbj1wdHMgdW1pZD11bWxfbjIydW5zdDQgcm9vdGZzdHlwZT1leHQ0Cj4+Pgo+Pj4KPj4+IHRo
ZW4gZHVyaW5nIHN0YXJ0IG9mIHRoZSBVTUwgSSBnZXQKPj4+Cj4+PiAuLi4KPj4+IE5ldGRldmlj
ZSAwICg3MjplZjozZDo1ZDpkMzpkYikgOgo+Pj4gVFVOL1RBUCBiYWNrZW5kIC0KPj4+IHdpbmNo
X3RocmVhZCA6IFRJT0NTQ1RUWSBmYWlsZWQgb24gZmQgMSBlcnIgPSAxCj4+Cj4+IEhtbSwgdGhh
dCdzIGEgcmVncmVzc2lvbiBpbnRyb2R1Y2VkIGJ5Ogo+PiBjb21taXQgMjUwMTI3MjE2ZGQ2NjM1
ZjU3MzA3NTJkNzQ0NGJkZWM5OTJhZWNiMAo+PiBBdXRob3I6IFJpY2hhcmQgV2VpbmJlcmdlciA8
cmljaGFyZEBub2QuYXQ+Cj4+IERhdGU6ICAgU3VuIEF1ZyAxOCAxMzozMDowOSAyMDEzICswMjAw
Cj4+Cj4+ICAgICB1bTogUnVuIFVNTCBpbiBpdCdzIG93biBzZXNzaW9uLgo+Pgo+PiAgICAgSWYg
VU1MIGlzIG5vdCBydW4gYnkgYSBzaGVsbCBpdCBjYW4gaGFwcGVuIHRoYXQgVU1MCj4+ICAgICB3
aWxsIGtpbGwgdW5yZWxhdGVkIHByb2Nlc2VzIHVwb24gYSBmYXRhbCBleGl0IGJlY2F1c2UKPj4g
ICAgIGl0IGlzc3VlcyBhIGtpbGwoMCwgLi4uKS4KPj4gICAgIFRvIHByZXZlbnQgc3VjaCBvZGRp
dGllcyB3ZSBjcmVhdGUgYSBuZXcgc2Vzc2lvbiBpbiBtYWluKCkuCj4+Cj4+ICAgICBSZXBvcnRl
ZC1hbmQtdGVzdGVkLWJ5OiBSaWNoYXJkIFcuTS4gSm9uZXMgPHJqb25lc0ByZWRoYXQuY29tPgo+
PiAgICAgU2lnbmVkLW9mZi1ieTogUmljaGFyZCBXZWluYmVyZ2VyIDxyaWNoYXJkQG5vZC5hdD4K
Pj4KPj4KPj4gVGhlIHdpbmNoLXRocmVhZCBhbHNvIGhhcyBpdCdzIG93biBzZXNzaW9uLCB0aGlz
IHNlZW1zIHRvIGJlIHRvIGFuIGlzc3VlLgo+Pgo+IAo+IHN1cmUgLSBJIGNhbiByZXByb2R1Y2Ug
aXQgd2l0aCBsaW51eC12My4xMS04NzE4LWcwZmI1Y2ExICwgd2hpY2ggZG9lc24ndCBjb250YWlu
IHRoYXQgY29tbWl0LCBvciA/Cj4gCkknZCBsaWtlIHRvIGJpc2VjdCBpaXQsayBidXQgYXMgc29v
biBhcyBJIHJ1biBzb21ldGhpbmcgbGlrZQokPiAuL2wuc2ggfCB0ZWUgPmxvZ2ZpbGU+CnRoZW4g
dGhlIGlzc3VlIHZhbmlzaGVzIC0gc28gSSBjYW4gc2VlIGl0IG9uIHRoZSBjb21tYW5kIGxpbmUu
CkZ1cnRoZXJtb3JlIEkga25vdywgdGhhdCBpdCBpcyBub3QgaW4gMy4xMC4wLTA4NzYzLWc3ZDMx
MDdkLCBidXQgaW4KdjMuMTItcmMxLTQyLWdmNDJiY2YxIC0gYnV0IHdpdGhvdXQgYXV0b21hdGlv
biBiaXNlY3RpbmcgaXMgbm90IGZ1bm55LgoKCi0tIApNZkcvU2luY2VyZWx5ClRvcmFsZiBGw7Zy
c3RlcgpwZ3AgZmluZ2VyIHByaW50OiA3QjFBIDA3RjQgRUM4MiAwRjkwIEQ0QzIgODkzNiA4NzJB
IEU1MDggN0RCNiA5REEzCgotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KTElNSVRFRCBUSU1FIFNBTEUg
LSBGdWxsIFllYXIgb2YgTWljcm9zb2Z0IFRyYWluaW5nIEZvciBKdXN0ICQ0OS45OSEKMSw1MDAr
IGhvdXJzIG9mIHR1dG9yaWFscyBpbmNsdWRpbmcgVmlzdWFsU3R1ZGlvIDIwMTIsIFdpbmRvd3Mg
OCwgU2hhcmVQb2ludAoyMDEzLCBTUUwgMjAxMiwgTVZDIDQsIG1vcmUuIEJFU1QgVkFMVUU6IE5l
dyBNdWx0aS1MaWJyYXJ5IFBvd2VyIFBhY2sgaW5jbHVkZXMKTW9iaWxlLCBDbG91ZCwgSmF2YSwg
YW5kIFVYIERlc2lnbi4gTG93ZXN0IHByaWNlIGV2ZXIhIEVuZHMgOS8yMi8xMy4gCmh0dHA6Ly9w
dWJhZHMuZy5kb3VibGVjbGljay5uZXQvZ2FtcGFkL2Nsaz9pZD02NDU0NTg3MSZpdT0vNDE0MC9v
c3RnLmNsa3RyawpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpVc2VyLW1vZGUtbGludXgtZGV2ZWwgbWFpbGluZyBsaXN0ClVzZXItbW9kZS1saW51eC1kZXZl
bEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlz
dHMvbGlzdGluZm8vdXNlci1tb2RlLWxpbnV4LWRldmVsCg==

