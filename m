Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vegard.nossum@oracle.com>) id 1aTVnJ-0002mX-HT
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 10 Feb 2016 14:31:01 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1aTVnI-0007xO-OM
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 10 Feb 2016 14:31:01 +0000
From: Vegard Nossum <vegard.nossum@oracle.com>
Date: Wed, 10 Feb 2016 15:29:39 +0100
Message-Id: <1455114596-3532-4-git-send-email-vegard.nossum@oracle.com>
In-Reply-To: <1455114596-3532-1-git-send-email-vegard.nossum@oracle.com>
References: <1455114596-3532-1-git-send-email-vegard.nossum@oracle.com>
MIME-Version: 1.0
Subject: [uml-devel] [PATCH 04/21] usb: add HAS_IOMEM dependency to
	USB_XHCI_MVEBU
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

ZHJpdmVycy91c2IvaG9zdC94aGNpLW12ZWJ1LmM6IEluIGZ1bmN0aW9uIOKAmHhoY2lfbXZlYnVf
bWJ1c19pbml0X3F1aXJr4oCZOgpkcml2ZXJzL3VzYi9ob3N0L3hoY2ktbXZlYnUuYzo1ODoyOiBl
cnJvcjogaW1wbGljaXQgZGVjbGFyYXRpb24gb2YgZnVuY3Rpb24g4oCYaW9yZW1hcOKAmSBbLVdl
cnJvcj1pbXBsaWNpdC1mdW5jdGlvbi1kZWNsYXJhdGlvbl0KICBiYXNlID0gaW9yZW1hcChyZXMt
PnN0YXJ0LCByZXNvdXJjZV9zaXplKHJlcykpOwogIF4KZHJpdmVycy91c2IvaG9zdC94aGNpLW12
ZWJ1LmM6NTg6Nzogd2FybmluZzogYXNzaWdubWVudCBtYWtlcyBwb2ludGVyIGZyb20gaW50ZWdl
ciB3aXRob3V0IGEgY2FzdCBbZW5hYmxlZCBieSBkZWZhdWx0XQogIGJhc2UgPSBpb3JlbWFwKHJl
cy0+c3RhcnQsIHJlc291cmNlX3NpemUocmVzKSk7CiAgICAgICBeCmRyaXZlcnMvdXNiL2hvc3Qv
eGhjaS1tdmVidS5jOjY5OjI6IGVycm9yOiBpbXBsaWNpdCBkZWNsYXJhdGlvbiBvZiBmdW5jdGlv
biDigJhpb3VubWFw4oCZIFstV2Vycm9yPWltcGxpY2l0LWZ1bmN0aW9uLWRlY2xhcmF0aW9uXQog
IGlvdW5tYXAoYmFzZSk7CiAgXgoKU2lnbmVkLW9mZi1ieTogVmVnYXJkIE5vc3N1bSA8dmVnYXJk
Lm5vc3N1bUBvcmFjbGUuY29tPgotLS0KIGRyaXZlcnMvdXNiL2hvc3QvS2NvbmZpZyB8IDEgKwog
MSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2Iv
aG9zdC9LY29uZmlnIGIvZHJpdmVycy91c2IvaG9zdC9LY29uZmlnCmluZGV4IDY0ZDc4YjEuLmJm
NjhiZDggMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvdXNiL2hvc3QvS2NvbmZpZworKysgYi9kcml2ZXJz
L3VzYi9ob3N0L0tjb25maWcKQEAgLTUzLDYgKzUzLDcgQEAgY29uZmlnIFVTQl9YSENJX01USwog
Y29uZmlnIFVTQl9YSENJX01WRUJVCiAJdHJpc3RhdGUgInhIQ0kgc3VwcG9ydCBmb3IgTWFydmVs
bCBBcm1hZGEgMzc1LzM4eCIKIAlzZWxlY3QgVVNCX1hIQ0lfUExBVEZPUk0KKwlkZXBlbmRzIG9u
IEhBU19JT01FTQogCWRlcGVuZHMgb24gQVJDSF9NVkVCVSB8fCBDT01QSUxFX1RFU1QKIAktLS1o
ZWxwLS0tCiAJICBTYXkgJ1knIHRvIGVuYWJsZSB0aGUgc3VwcG9ydCBmb3IgdGhlIHhIQ0kgaG9z
dCBjb250cm9sbGVyCi0tIAoxLjkuMQoKCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpTaXRlMjR4NyBB
UE0gSW5zaWdodDogR2V0IERlZXAgVmlzaWJpbGl0eSBpbnRvIEFwcGxpY2F0aW9uIFBlcmZvcm1h
bmNlCkFQTSArIE1vYmlsZSBBUE0gKyBSVU06IE1vbml0b3IgMyBBcHAgaW5zdGFuY2VzIGF0IGp1
c3QgJDM1L01vbnRoCk1vbml0b3IgZW5kLXRvLWVuZCB3ZWIgdHJhbnNhY3Rpb25zIGFuZCB0YWtl
IGNvcnJlY3RpdmUgYWN0aW9ucyBub3cKVHJvdWJsZXNob290IGZhc3RlciBhbmQgaW1wcm92ZSBl
bmQtdXNlciBleHBlcmllbmNlLiBTaWdudXAgTm93IQpodHRwOi8vcHViYWRzLmcuZG91YmxlY2xp
Y2submV0L2dhbXBhZC9jbGs/aWQ9MjcyNDg3MTUxJml1PS80MTQwCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClVzZXItbW9kZS1saW51eC1kZXZlbCBtYWls
aW5nIGxpc3QKVXNlci1tb2RlLWxpbnV4LWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRw
czovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby91c2VyLW1vZGUtbGludXgt
ZGV2ZWwK

