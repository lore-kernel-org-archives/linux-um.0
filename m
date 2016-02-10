Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vegard.nossum@oracle.com>) id 1aTVnO-0006gf-9p
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 10 Feb 2016 14:31:06 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1aTVnN-0008Dj-Ij
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 10 Feb 2016 14:31:06 +0000
From: Vegard Nossum <vegard.nossum@oracle.com>
Date: Wed, 10 Feb 2016 15:29:40 +0100
Message-Id: <1455114596-3532-5-git-send-email-vegard.nossum@oracle.com>
In-Reply-To: <1455114596-3532-1-git-send-email-vegard.nossum@oracle.com>
References: <1455114596-3532-1-git-send-email-vegard.nossum@oracle.com>
MIME-Version: 1.0
Subject: [uml-devel] [PATCH 05/21] usb: add HAS_IOMEM dependency to
	USB_R8A66597_HCD
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
To: Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, Richard Weinberger <richard@nod.at>, user-mode-linux-devel@lists.sourceforge.net
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, James McMechan <James_McMechan@hotmail.com>, Vegard Nossum <vegard.nossum@oracle.com>

ICBDQyAgICAgIGRyaXZlcnMvdXNiL2hvc3QvcjhhNjY1OTctaGNkLm8KZHJpdmVycy91c2IvaG9z
dC9yOGE2NjU5Ny1oY2QuYzogSW4gZnVuY3Rpb24g4oCYcjhhNjY1OTdfcmVtb3Zl4oCZOgpkcml2
ZXJzL3VzYi9ob3N0L3I4YTY2NTk3LWhjZC5jOjI0MDE6MjogZXJyb3I6IGltcGxpY2l0IGRlY2xh
cmF0aW9uIG9mIGZ1bmN0aW9uIOKAmGlvdW5tYXDigJkgWy1XZXJyb3I9aW1wbGljaXQtZnVuY3Rp
b24tZGVjbGFyYXRpb25dCiAgaW91bm1hcChyOGE2NjU5Ny0+cmVnKTsKICBeCmRyaXZlcnMvdXNi
L2hvc3QvcjhhNjY1OTctaGNkLmM6IEluIGZ1bmN0aW9uIOKAmHI4YTY2NTk3X3Byb2Jl4oCZOgpk
cml2ZXJzL3VzYi9ob3N0L3I4YTY2NTk3LWhjZC5jOjI0NDc6MjogZXJyb3I6IGltcGxpY2l0IGRl
Y2xhcmF0aW9uIG9mIGZ1bmN0aW9uIOKAmGlvcmVtYXDigJkgWy1XZXJyb3I9aW1wbGljaXQtZnVu
Y3Rpb24tZGVjbGFyYXRpb25dCiAgcmVnID0gaW9yZW1hcChyZXMtPnN0YXJ0LCByZXNvdXJjZV9z
aXplKHJlcykpOwogIF4KZHJpdmVycy91c2IvaG9zdC9yOGE2NjU5Ny1oY2QuYzoyNDQ3OjY6IHdh
cm5pbmc6IGFzc2lnbm1lbnQgbWFrZXMgcG9pbnRlciBmcm9tIGludGVnZXIgd2l0aG91dCBhIGNh
c3QgW2VuYWJsZWQgYnkgZGVmYXVsdF0KICByZWcgPSBpb3JlbWFwKHJlcy0+c3RhcnQsIHJlc291
cmNlX3NpemUocmVzKSk7CiAgICAgIF4KClNpZ25lZC1vZmYtYnk6IFZlZ2FyZCBOb3NzdW0gPHZl
Z2FyZC5ub3NzdW1Ab3JhY2xlLmNvbT4KLS0tCiBkcml2ZXJzL3VzYi9ob3N0L0tjb25maWcgfCAx
ICsKIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMv
dXNiL2hvc3QvS2NvbmZpZyBiL2RyaXZlcnMvdXNiL2hvc3QvS2NvbmZpZwppbmRleCBiZjY4YmQ4
Li5hZjIwZDkzIDEwMDY0NAotLS0gYS9kcml2ZXJzL3VzYi9ob3N0L0tjb25maWcKKysrIGIvZHJp
dmVycy91c2IvaG9zdC9LY29uZmlnCkBAIC03MDEsNiArNzAxLDcgQEAgY29uZmlnIFVTQl9TTDgx
MV9DUwogCiBjb25maWcgVVNCX1I4QTY2NTk3X0hDRAogCXRyaXN0YXRlICJSOEE2NjU5NyBIQ0Qg
c3VwcG9ydCIKKwlkZXBlbmRzIG9uIEhBU19JT01FTQogCWhlbHAKIAkgIFRoZSBSOEE2NjU5NyBp
cyBhIFVTQiAyLjAgaG9zdCBhbmQgcGVyaXBoZXJhbCBjb250cm9sbGVyLgogCi0tIAoxLjkuMQoK
Ci0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpTaXRlMjR4NyBBUE0gSW5zaWdodDogR2V0IERlZXAgVmlz
aWJpbGl0eSBpbnRvIEFwcGxpY2F0aW9uIFBlcmZvcm1hbmNlCkFQTSArIE1vYmlsZSBBUE0gKyBS
VU06IE1vbml0b3IgMyBBcHAgaW5zdGFuY2VzIGF0IGp1c3QgJDM1L01vbnRoCk1vbml0b3IgZW5k
LXRvLWVuZCB3ZWIgdHJhbnNhY3Rpb25zIGFuZCB0YWtlIGNvcnJlY3RpdmUgYWN0aW9ucyBub3cK
VHJvdWJsZXNob290IGZhc3RlciBhbmQgaW1wcm92ZSBlbmQtdXNlciBleHBlcmllbmNlLiBTaWdu
dXAgTm93IQpodHRwOi8vcHViYWRzLmcuZG91YmxlY2xpY2submV0L2dhbXBhZC9jbGs/aWQ9Mjcy
NDg3MTUxJml1PS80MTQwCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fClVzZXItbW9kZS1saW51eC1kZXZlbCBtYWlsaW5nIGxpc3QKVXNlci1tb2RlLWxpbnV4
LWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5l
dC9saXN0cy9saXN0aW5mby91c2VyLW1vZGUtbGludXgtZGV2ZWwK

