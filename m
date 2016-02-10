Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vegard.nossum@oracle.com>) id 1aTVnI-0002mS-5y
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 10 Feb 2016 14:31:00 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1aTVnG-0005eT-AP
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 10 Feb 2016 14:31:00 +0000
From: Vegard Nossum <vegard.nossum@oracle.com>
Date: Wed, 10 Feb 2016 15:29:37 +0100
Message-Id: <1455114596-3532-2-git-send-email-vegard.nossum@oracle.com>
In-Reply-To: <1455114596-3532-1-git-send-email-vegard.nossum@oracle.com>
References: <1455114596-3532-1-git-send-email-vegard.nossum@oracle.com>
MIME-Version: 1.0
Subject: [uml-devel] [PATCH 02/21] usb: add HAS_IOMEM dependency to
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
To: Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, Richard Weinberger <richard@nod.at>, user-mode-linux-devel@lists.sourceforge.net
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, James McMechan <James_McMechan@hotmail.com>, Vegard Nossum <vegard.nossum@oracle.com>

ZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9uZXQyMjcyLmM6IEluIGZ1bmN0aW9uIOKAmG5ldDIyNzJf
cmVtb3Zl4oCZOgpkcml2ZXJzL3VzYi9nYWRnZXQvdWRjL25ldDIyNzIuYzoyMjMyOjI6IGVycm9y
OiBpbXBsaWNpdCBkZWNsYXJhdGlvbiBvZiBmdW5jdGlvbiDigJhpb3VubWFw4oCZIFstV2Vycm9y
PWltcGxpY2l0LWZ1bmN0aW9uLWRlY2xhcmF0aW9uXQogIGlvdW5tYXAoZGV2LT5iYXNlX2FkZHIp
OwogIF4KZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9uZXQyMjcyLmM6IEluIGZ1bmN0aW9uIOKAmG5l
dDIyNzJfcGxhdF9wcm9iZeKAmToKZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9uZXQyMjcyLmM6MjY1
MDoyOiBlcnJvcjogaW1wbGljaXQgZGVjbGFyYXRpb24gb2YgZnVuY3Rpb24g4oCYaW9yZW1hcF9u
b2NhY2hl4oCZIFstV2Vycm9yPWltcGxpY2l0LWZ1bmN0aW9uLWRlY2xhcmF0aW9uXQogIGRldi0+
YmFzZV9hZGRyID0gaW9yZW1hcF9ub2NhY2hlKGJhc2UsIGxlbik7CiAgXgpkcml2ZXJzL3VzYi9n
YWRnZXQvdWRjL25ldDIyNzIuYzoyNjUwOjE3OiB3YXJuaW5nOiBhc3NpZ25tZW50IG1ha2VzIHBv
aW50ZXIgZnJvbSBpbnRlZ2VyIHdpdGhvdXQgYSBjYXN0IFtlbmFibGVkIGJ5IGRlZmF1bHRdCiAg
ZGV2LT5iYXNlX2FkZHIgPSBpb3JlbWFwX25vY2FjaGUoYmFzZSwgbGVuKTsKICAgICAgICAgICAg
ICAgICBeCgpTaWduZWQtb2ZmLWJ5OiBWZWdhcmQgTm9zc3VtIDx2ZWdhcmQubm9zc3VtQG9yYWNs
ZS5jb20+Ci0tLQogZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9LY29uZmlnIHwgMSArCiAxIGZpbGUg
Y2hhbmdlZCwgMSBpbnNlcnRpb24oKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9nYWRnZXQv
dWRjL0tjb25maWcgYi9kcml2ZXJzL3VzYi9nYWRnZXQvdWRjL0tjb25maWcKaW5kZXggNzUzYzI5
Yi4uY2ExOWY2ZiAxMDA2NDQKLS0tIGEvZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9LY29uZmlnCisr
KyBiL2RyaXZlcnMvdXNiL2dhZGdldC91ZGMvS2NvbmZpZwpAQCAtMjg3LDYgKzI4Nyw3IEBAIGNv
bmZpZyBVU0JfRlNMX1FFCiAJICAgZHluYW1pY2FsbHkgbGlua2VkIG1vZHVsZSBjYWxsZWQgImZz
bF9xZV91ZGMiLgogCiBjb25maWcgVVNCX05FVDIyNzIKKwlkZXBlbmRzIG9uIEhBU19JT01FTQog
CXRyaXN0YXRlICJQTFggTkVUMjI3MiIKIAloZWxwCiAJICBQTFggTkVUMjI3MiBpcyBhIFVTQiBw
ZXJpcGhlcmFsIGNvbnRyb2xsZXIgd2hpY2ggc3VwcG9ydHMKLS0gCjEuOS4xCgoKLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tClNpdGUyNHg3IEFQTSBJbnNpZ2h0OiBHZXQgRGVlcCBWaXNpYmlsaXR5IGlu
dG8gQXBwbGljYXRpb24gUGVyZm9ybWFuY2UKQVBNICsgTW9iaWxlIEFQTSArIFJVTTogTW9uaXRv
ciAzIEFwcCBpbnN0YW5jZXMgYXQganVzdCAkMzUvTW9udGgKTW9uaXRvciBlbmQtdG8tZW5kIHdl
YiB0cmFuc2FjdGlvbnMgYW5kIHRha2UgY29ycmVjdGl2ZSBhY3Rpb25zIG5vdwpUcm91Ymxlc2hv
b3QgZmFzdGVyIGFuZCBpbXByb3ZlIGVuZC11c2VyIGV4cGVyaWVuY2UuIFNpZ251cCBOb3chCmh0
dHA6Ly9wdWJhZHMuZy5kb3VibGVjbGljay5uZXQvZ2FtcGFkL2Nsaz9pZD0yNzI0ODcxNTEmaXU9
LzQxNDAKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVXNl
ci1tb2RlLWxpbnV4LWRldmVsIG1haWxpbmcgbGlzdApVc2VyLW1vZGUtbGludXgtZGV2ZWxAbGlz
dHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xp
c3RpbmZvL3VzZXItbW9kZS1saW51eC1kZXZlbAo=

