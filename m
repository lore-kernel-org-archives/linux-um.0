Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <toralf.foerster@gmx.de>) id 1S3khm-0002OA-0v
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 03 Mar 2012 08:52:42 +0000
Received: from mailout-de.gmx.net ([213.165.64.23])
	by sog-mx-3.v43.ch3.sourceforge.com with smtp (Exim 4.76)
	id 1S3khl-0006Fy-4v for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 03 Mar 2012 08:52:41 +0000
From: Toralf =?utf-8?q?F=C3=B6rster?= <toralf.foerster@gmx.de>
Date: Sat, 3 Mar 2012 09:52:32 +0100
MIME-Version: 1.0
Message-Id: <201203030952.33510.toralf.foerster@gmx.de>
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
Subject: [uml-devel] make oldconfig asks every time for the 3 new options
To: user-mode-linux-devel@lists.sourceforge.net

SSdtIGF0IHRoaXMgbGV2ZWwgOgoKJCBnaXQgZGVzY3JpYmUKdjMuMy1yYzUtMjA0LWdhZTk0MmFl
Cgp1c2luZyBvbGQgdW1sIGxpbnV4IGV4ZSB0byBnZW5lcmF0ZSBhIC5jb25maWcgOgoKJCAvdXNy
L2xvY2FsL2Jpbi9saW51eC12My4zLXJjNS0yMDQtZ2FlOTQyYWUgLS1zaG93Y29uZmlnID4gLmNv
bmZpZwoKYW5kIGJlaW5nIGFzayBldmVyeSB0aW1lIGZvciB0aGVzZSAzIG9wdGlvbnM6CgokIG1h
a2Ugb2xkY29uZmlnIEFSQ0g9dW0Kc2NyaXB0cy9rY29uZmlnL2NvbmYgLS1vbGRjb25maWcgYXJj
aC94ODYvdW0vS2NvbmZpZwoqCiogUmVzdGFydCBjb25maWcuLi4KKgoqCiogTWlzYyBkZXZpY2Vz
CioKRW5jbG9zdXJlIFNlcnZpY2VzIChFTkNMT1NVUkVfU0VSVklDRVMpIFtOL3kvP10gKE5FVykg
TgoqCiogU2lsaWNvbiBMYWJzIEMyIHBvcnQgc3VwcG9ydCAoRVhQRVJJTUVOVEFMKQoqClNpbGlj
b24gTGFicyBDMiBwb3J0IHN1cHBvcnQgKEVYUEVSSU1FTlRBTCkgKEMyUE9SVCkgW04veS8/XSAo
TkVXKSBOCioKKiBFRVBST00gc3VwcG9ydAoqCkVFUFJPTSA5M0NYNiBzdXBwb3J0IChFRVBST01f
OTNDWDYpIFtOL3kvP10gKE5FVykgTgoqCiogVGV4YXMgSW5zdHJ1bWVudHMgc2hhcmVkIHRyYW5z
cG9ydCBsaW5lIGRpc2NpcGxpbmUKKgoqCiogQWx0ZXJhIEZQR0EgZmlybXdhcmUgZG93bmxvYWQg
bW9kdWxlCioKIwojIGNvbmZpZ3VyYXRpb24gd3JpdHRlbiB0byAuY29uZmlnCiMKCgpJJ20gd29u
ZGVyaW5nIHdoeSB0aGlzIGhhcHBlbnMgb25seSBmb3IgdGhlc2UgMyBvcHRpb25zIHNpbmNlIHRo
aXMgcmVsZWFzZQphbmQgbm90IGFsd2F5cyBiZWZvcmUgZm9yIGFsbCBvdGhlciBub3Qtc2V0IHBh
cmFtZXRlci4KCi0tIApNZkcvU2luY2VyZWx5ClRvcmFsZiBGw7Zyc3RlcgpwZ3AgZmluZ2VyIHBy
aW50OiA3QjFBIDA3RjQgRUM4MiAwRjkwIEQ0QzIgODkzNiA4NzJBIEU1MDggN0RCNiA5REEzCgot
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0KVmlydHVhbGl6YXRpb24gJiBDbG91ZCBNYW5hZ2VtZW50IFVz
aW5nIENhcGFjaXR5IFBsYW5uaW5nCkNsb3VkIGNvbXB1dGluZyBtYWtlcyB1c2Ugb2YgdmlydHVh
bGl6YXRpb24gLSBidXQgY2xvdWQgY29tcHV0aW5nIAphbHNvIGZvY3VzZXMgb24gYWxsb3dpbmcg
Y29tcHV0aW5nIHRvIGJlIGRlbGl2ZXJlZCBhcyBhIHNlcnZpY2UuCmh0dHA6Ly93d3cuYWNjZWxh
Y29tbS5jb20vamF3L3NmbmwvMTE0LzUxNTIxMjIzLwpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpVc2VyLW1vZGUtbGludXgtZGV2ZWwgbWFpbGluZyBsaXN0
ClVzZXItbW9kZS1saW51eC1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0
cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vdXNlci1tb2RlLWxpbnV4LWRldmVsCg==

