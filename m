Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vegard.nossum@oracle.com>) id 1aTVnO-0003f1-CB
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 10 Feb 2016 14:31:06 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1aTVnN-0007xV-H0
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 10 Feb 2016 14:31:06 +0000
From: Vegard Nossum <vegard.nossum@oracle.com>
Date: Wed, 10 Feb 2016 15:29:41 +0100
Message-Id: <1455114596-3532-6-git-send-email-vegard.nossum@oracle.com>
In-Reply-To: <1455114596-3532-1-git-send-email-vegard.nossum@oracle.com>
References: <1455114596-3532-1-git-send-email-vegard.nossum@oracle.com>
MIME-Version: 1.0
Subject: [uml-devel] [PATCH 06/21] usb: add HAS_IOMEM dependency to
	USB_MUSB_TUSB6010
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

ICBDQyAgICAgIGRyaXZlcnMvdXNiL211c2IvdHVzYjYwMTAubwpkcml2ZXJzL3VzYi9tdXNiL3R1
c2I2MDEwLmM6IEluIGZ1bmN0aW9uIOKAmHR1c2JfbXVzYl9pbml04oCZOgpkcml2ZXJzL3VzYi9t
dXNiL3R1c2I2MDEwLmM6MTEzMzoyOiBlcnJvcjogaW1wbGljaXQgZGVjbGFyYXRpb24gb2YgZnVu
Y3Rpb24g4oCYaW9yZW1hcOKAmSBbLVdlcnJvcj1pbXBsaWNpdC1mdW5jdGlvbi1kZWNsYXJhdGlv
bl0KICBzeW5jID0gaW9yZW1hcChtZW0tPnN0YXJ0LCByZXNvdXJjZV9zaXplKG1lbSkpOwogIF4K
ZHJpdmVycy91c2IvbXVzYi90dXNiNjAxMC5jOjExMzM6Nzogd2FybmluZzogYXNzaWdubWVudCBt
YWtlcyBwb2ludGVyIGZyb20gaW50ZWdlciB3aXRob3V0IGEgY2FzdCBbZW5hYmxlZCBieSBkZWZh
dWx0XQogIHN5bmMgPSBpb3JlbWFwKG1lbS0+c3RhcnQsIHJlc291cmNlX3NpemUobWVtKSk7CiAg
ICAgICBeCmRyaXZlcnMvdXNiL211c2IvdHVzYjYwMTAuYzoxMTYyOjQ6IGVycm9yOiBpbXBsaWNp
dCBkZWNsYXJhdGlvbiBvZiBmdW5jdGlvbiDigJhpb3VubWFw4oCZIFstV2Vycm9yPWltcGxpY2l0
LWZ1bmN0aW9uLWRlY2xhcmF0aW9uXQogICAgaW91bm1hcChzeW5jKTsKICAgIF4KClNpZ25lZC1v
ZmYtYnk6IFZlZ2FyZCBOb3NzdW0gPHZlZ2FyZC5ub3NzdW1Ab3JhY2xlLmNvbT4KLS0tCiBkcml2
ZXJzL3VzYi9tdXNiL0tjb25maWcgfCAxICsKIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigr
KQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL211c2IvS2NvbmZpZyBiL2RyaXZlcnMvdXNiL211
c2IvS2NvbmZpZwppbmRleCA0NWM4M2JhLi4wNDAxNTczIDEwMDY0NAotLS0gYS9kcml2ZXJzL3Vz
Yi9tdXNiL0tjb25maWcKKysrIGIvZHJpdmVycy91c2IvbXVzYi9LY29uZmlnCkBAIC04NSw2ICs4
NSw3IEBAIGNvbmZpZyBVU0JfTVVTQl9EQThYWAogCiBjb25maWcgVVNCX01VU0JfVFVTQjYwMTAK
IAl0cmlzdGF0ZSAiVFVTQjYwMTAiCisJZGVwZW5kcyBvbiBIQVNfSU9NRU0KIAlkZXBlbmRzIG9u
IEFSQ0hfT01BUDJQTFVTIHx8IENPTVBJTEVfVEVTVAogCWRlcGVuZHMgb24gTk9QX1VTQl9YQ0VJ
ViA9IFVTQl9NVVNCX0hEUkMgIyBib3RoIGJ1aWx0LWluIG9yIGJvdGggbW9kdWxlcwogCi0tIAox
LjkuMQoKCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpTaXRlMjR4NyBBUE0gSW5zaWdodDogR2V0IERl
ZXAgVmlzaWJpbGl0eSBpbnRvIEFwcGxpY2F0aW9uIFBlcmZvcm1hbmNlCkFQTSArIE1vYmlsZSBB
UE0gKyBSVU06IE1vbml0b3IgMyBBcHAgaW5zdGFuY2VzIGF0IGp1c3QgJDM1L01vbnRoCk1vbml0
b3IgZW5kLXRvLWVuZCB3ZWIgdHJhbnNhY3Rpb25zIGFuZCB0YWtlIGNvcnJlY3RpdmUgYWN0aW9u
cyBub3cKVHJvdWJsZXNob290IGZhc3RlciBhbmQgaW1wcm92ZSBlbmQtdXNlciBleHBlcmllbmNl
LiBTaWdudXAgTm93IQpodHRwOi8vcHViYWRzLmcuZG91YmxlY2xpY2submV0L2dhbXBhZC9jbGs/
aWQ9MjcyNDg3MTUxJml1PS80MTQwCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fClVzZXItbW9kZS1saW51eC1kZXZlbCBtYWlsaW5nIGxpc3QKVXNlci1tb2Rl
LWxpbnV4LWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZv
cmdlLm5ldC9saXN0cy9saXN0aW5mby91c2VyLW1vZGUtbGludXgtZGV2ZWwK

