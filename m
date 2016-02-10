Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gregkh@linuxfoundation.org>) id 1aTXQg-0006el-I1
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 10 Feb 2016 16:15:46 +0000
Received: from mail.linuxfoundation.org ([140.211.169.12])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1aTXQe-0000jV-Bn
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 10 Feb 2016 16:15:46 +0000
Date: Wed, 10 Feb 2016 08:15:37 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Message-ID: <20160210161536.GA11999@kroah.com>
References: <1455114596-3532-1-git-send-email-vegard.nossum@oracle.com>
	<1455114596-3532-2-git-send-email-vegard.nossum@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1455114596-3532-2-git-send-email-vegard.nossum@oracle.com>
Subject: Re: [uml-devel] [PATCH 02/21] usb: add HAS_IOMEM dependency to
	USB_NET2272
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
To: Vegard Nossum <vegard.nossum@oracle.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, Richard Weinberger <richard@nod.at>, James McMechan <James_McMechan@hotmail.com>, linux-usb@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, Martin Schwidefsky <schwidefsky@de.ibm.com>

T24gV2VkLCBGZWIgMTAsIDIwMTYgYXQgMDM6Mjk6MzdQTSArMDEwMCwgVmVnYXJkIE5vc3N1bSB3
cm90ZToKPiBkcml2ZXJzL3VzYi9nYWRnZXQvdWRjL25ldDIyNzIuYzogSW4gZnVuY3Rpb24g4oCY
bmV0MjI3Ml9yZW1vdmXigJk6Cj4gZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9uZXQyMjcyLmM6MjIz
MjoyOiBlcnJvcjogaW1wbGljaXQgZGVjbGFyYXRpb24gb2YgZnVuY3Rpb24g4oCYaW91bm1hcOKA
mSBbLVdlcnJvcj1pbXBsaWNpdC1mdW5jdGlvbi1kZWNsYXJhdGlvbl0KPiAgIGlvdW5tYXAoZGV2
LT5iYXNlX2FkZHIpOwo+ICAgXgo+IGRyaXZlcnMvdXNiL2dhZGdldC91ZGMvbmV0MjI3Mi5jOiBJ
biBmdW5jdGlvbiDigJhuZXQyMjcyX3BsYXRfcHJvYmXigJk6Cj4gZHJpdmVycy91c2IvZ2FkZ2V0
L3VkYy9uZXQyMjcyLmM6MjY1MDoyOiBlcnJvcjogaW1wbGljaXQgZGVjbGFyYXRpb24gb2YgZnVu
Y3Rpb24g4oCYaW9yZW1hcF9ub2NhY2hl4oCZIFstV2Vycm9yPWltcGxpY2l0LWZ1bmN0aW9uLWRl
Y2xhcmF0aW9uXQo+ICAgZGV2LT5iYXNlX2FkZHIgPSBpb3JlbWFwX25vY2FjaGUoYmFzZSwgbGVu
KTsKPiAgIF4KPiBkcml2ZXJzL3VzYi9nYWRnZXQvdWRjL25ldDIyNzIuYzoyNjUwOjE3OiB3YXJu
aW5nOiBhc3NpZ25tZW50IG1ha2VzIHBvaW50ZXIgZnJvbSBpbnRlZ2VyIHdpdGhvdXQgYSBjYXN0
IFtlbmFibGVkIGJ5IGRlZmF1bHRdCj4gICBkZXYtPmJhc2VfYWRkciA9IGlvcmVtYXBfbm9jYWNo
ZShiYXNlLCBsZW4pOwo+ICAgICAgICAgICAgICAgICAgXgo+IAo+IFNpZ25lZC1vZmYtYnk6IFZl
Z2FyZCBOb3NzdW0gPHZlZ2FyZC5ub3NzdW1Ab3JhY2xlLmNvbT4KPiAtLS0KPiAgZHJpdmVycy91
c2IvZ2FkZ2V0L3VkYy9LY29uZmlnIHwgMSArCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlv
bigrKQo+IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9nYWRnZXQvdWRjL0tjb25maWcgYi9k
cml2ZXJzL3VzYi9nYWRnZXQvdWRjL0tjb25maWcKPiBpbmRleCA3NTNjMjliLi5jYTE5ZjZmIDEw
MDY0NAo+IC0tLSBhL2RyaXZlcnMvdXNiL2dhZGdldC91ZGMvS2NvbmZpZwo+ICsrKyBiL2RyaXZl
cnMvdXNiL2dhZGdldC91ZGMvS2NvbmZpZwo+IEBAIC0yODcsNiArMjg3LDcgQEAgY29uZmlnIFVT
Ql9GU0xfUUUKPiAgCSAgIGR5bmFtaWNhbGx5IGxpbmtlZCBtb2R1bGUgY2FsbGVkICJmc2xfcWVf
dWRjIi4KPiAgCj4gIGNvbmZpZyBVU0JfTkVUMjI3Mgo+ICsJZGVwZW5kcyBvbiBIQVNfSU9NRU0K
CldoeSBub3QgZml4IHRoZSByb290IG9mIHRoZSBwcm9ibGVtIGFuZCBwcm92aWRlIHRoZSBjb3Jy
ZWN0IGZ1bmN0aW9ucwpmb3IgdGhpcyB3aGVuIEhBU19JT01FTSBpcyBub3QgZW5hYmxlZD8KCnRo
YW5rcywKCmdyZWcgay1oCgotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KU2l0ZTI0eDcgQVBNIEluc2ln
aHQ6IEdldCBEZWVwIFZpc2liaWxpdHkgaW50byBBcHBsaWNhdGlvbiBQZXJmb3JtYW5jZQpBUE0g
KyBNb2JpbGUgQVBNICsgUlVNOiBNb25pdG9yIDMgQXBwIGluc3RhbmNlcyBhdCBqdXN0ICQzNS9N
b250aApNb25pdG9yIGVuZC10by1lbmQgd2ViIHRyYW5zYWN0aW9ucyBhbmQgdGFrZSBjb3JyZWN0
aXZlIGFjdGlvbnMgbm93ClRyb3VibGVzaG9vdCBmYXN0ZXIgYW5kIGltcHJvdmUgZW5kLXVzZXIg
ZXhwZXJpZW5jZS4gU2lnbnVwIE5vdyEKaHR0cDovL3B1YmFkcy5nLmRvdWJsZWNsaWNrLm5ldC9n
YW1wYWQvY2xrP2lkPTI3MjQ4NzE1MSZpdT0vNDE0MApfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpVc2VyLW1vZGUtbGludXgtZGV2ZWwgbWFpbGluZyBsaXN0
ClVzZXItbW9kZS1saW51eC1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0
cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vdXNlci1tb2RlLWxpbnV4LWRldmVsCg==

