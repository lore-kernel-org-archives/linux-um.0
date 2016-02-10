Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vegard.nossum@oracle.com>) id 1aTVnH-0006fp-3x
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 10 Feb 2016 14:30:59 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1aTVnG-0005ph-B5
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 10 Feb 2016 14:30:59 +0000
From: Vegard Nossum <vegard.nossum@oracle.com>
Date: Wed, 10 Feb 2016 15:29:38 +0100
Message-Id: <1455114596-3532-3-git-send-email-vegard.nossum@oracle.com>
In-Reply-To: <1455114596-3532-1-git-send-email-vegard.nossum@oracle.com>
References: <1455114596-3532-1-git-send-email-vegard.nossum@oracle.com>
MIME-Version: 1.0
Subject: [uml-devel] [PATCH 03/21] usb: Add HAS_IOMEM dependency to
	USB_M66592
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

ZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9tNjY1OTItdWRjLmM6IEluIGZ1bmN0aW9uIOKAmG02NjU5
Ml9yZW1vdmXigJk6CmRyaXZlcnMvdXNiL2dhZGdldC91ZGMvbTY2NTkyLXVkYy5jOjE1Mzg6Mjog
ZXJyb3I6IGltcGxpY2l0IGRlY2xhcmF0aW9uIG9mIGZ1bmN0aW9uIOKAmGlvdW5tYXDigJkgWy1X
ZXJyb3I9aW1wbGljaXQtZnVuY3Rpb24tZGVjbGFyYXRpb25dCiAgaW91bm1hcChtNjY1OTItPnJl
Zyk7CiAgXgpkcml2ZXJzL3VzYi9nYWRnZXQvdWRjL202NjU5Mi11ZGMuYzogSW4gZnVuY3Rpb24g
4oCYbTY2NTkyX3Byb2Jl4oCZOgpkcml2ZXJzL3VzYi9nYWRnZXQvdWRjL202NjU5Mi11ZGMuYzox
NTc3OjI6IGVycm9yOiBpbXBsaWNpdCBkZWNsYXJhdGlvbiBvZiBmdW5jdGlvbiDigJhpb3JlbWFw
4oCZIFstV2Vycm9yPWltcGxpY2l0LWZ1bmN0aW9uLWRlY2xhcmF0aW9uXQogIHJlZyA9IGlvcmVt
YXAocmVzLT5zdGFydCwgcmVzb3VyY2Vfc2l6ZShyZXMpKTsKICBeCmRyaXZlcnMvdXNiL2dhZGdl
dC91ZGMvbTY2NTkyLXVkYy5jOjE1Nzc6Njogd2FybmluZzogYXNzaWdubWVudCBtYWtlcyBwb2lu
dGVyIGZyb20gaW50ZWdlciB3aXRob3V0IGEgY2FzdCBbZW5hYmxlZCBieSBkZWZhdWx0XQogIHJl
ZyA9IGlvcmVtYXAocmVzLT5zdGFydCwgcmVzb3VyY2Vfc2l6ZShyZXMpKTsKICAgICAgXgoKU2ln
bmVkLW9mZi1ieTogVmVnYXJkIE5vc3N1bSA8dmVnYXJkLm5vc3N1bUBvcmFjbGUuY29tPgotLS0K
IGRyaXZlcnMvdXNiL2dhZGdldC91ZGMvS2NvbmZpZyB8IDEgKwogMSBmaWxlIGNoYW5nZWQsIDEg
aW5zZXJ0aW9uKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9LY29uZmln
IGIvZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9LY29uZmlnCmluZGV4IGNhMTlmNmYuLmUwNmVmYTMg
MTAwNjQ0Ci0tLSBhL2RyaXZlcnMvdXNiL2dhZGdldC91ZGMvS2NvbmZpZworKysgYi9kcml2ZXJz
L3VzYi9nYWRnZXQvdWRjL0tjb25maWcKQEAgLTI0NCw2ICsyNDQsNyBAQCBjb25maWcgVVNCX01W
X1UzRAogCiBjb25maWcgVVNCX002NjU5MgogCXRyaXN0YXRlICJSZW5lc2FzIE02NjU5MiBVU0Ig
UGVyaXBoZXJhbCBDb250cm9sbGVyIgorCWRlcGVuZHMgb24gSEFTX0lPTUVNCiAJaGVscAogCSAg
IE02NjU5MiBpcyBhIGRpc2NyZXRlIFVTQiBwZXJpcGhlcmFsIGNvbnRyb2xsZXIgY2hpcCB0aGF0
CiAJICAgc3VwcG9ydHMgYm90aCBmdWxsIGFuZCBoaWdoIHNwZWVkIFVTQiAyLjAgZGF0YSB0cmFu
c2ZlcnMuCi0tIAoxLjkuMQoKCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpTaXRlMjR4NyBBUE0gSW5z
aWdodDogR2V0IERlZXAgVmlzaWJpbGl0eSBpbnRvIEFwcGxpY2F0aW9uIFBlcmZvcm1hbmNlCkFQ
TSArIE1vYmlsZSBBUE0gKyBSVU06IE1vbml0b3IgMyBBcHAgaW5zdGFuY2VzIGF0IGp1c3QgJDM1
L01vbnRoCk1vbml0b3IgZW5kLXRvLWVuZCB3ZWIgdHJhbnNhY3Rpb25zIGFuZCB0YWtlIGNvcnJl
Y3RpdmUgYWN0aW9ucyBub3cKVHJvdWJsZXNob290IGZhc3RlciBhbmQgaW1wcm92ZSBlbmQtdXNl
ciBleHBlcmllbmNlLiBTaWdudXAgTm93IQpodHRwOi8vcHViYWRzLmcuZG91YmxlY2xpY2submV0
L2dhbXBhZC9jbGs/aWQ9MjcyNDg3MTUxJml1PS80MTQwCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fClVzZXItbW9kZS1saW51eC1kZXZlbCBtYWlsaW5nIGxp
c3QKVXNlci1tb2RlLWxpbnV4LWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xp
c3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby91c2VyLW1vZGUtbGludXgtZGV2ZWwK

