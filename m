Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <thomas@m3y3r.de>) id 1dTaOW-0007aZ-Qx
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 07 Jul 2017 21:02:32 +0000
Received: from www17.your-server.de ([213.133.104.17])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1dTaOV-00057E-V7
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 07 Jul 2017 21:02:32 +0000
From: Thomas Meyer <thomas@m3y3r.de>
Date: Fri,  7 Jul 2017 23:02:19 +0200
Message-Id: <20170707210219.12808-1-thomas@m3y3r.de>
In-Reply-To: <20170706204737.16383-1-thomas@m3y3r.de>
References: <20170706204737.16383-1-thomas@m3y3r.de>
MIME-Version: 1.0
Subject: [uml-devel] [PATCH] um: v2: Fix gcc 7 sys/sysmacros.h warning
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net

T3JpZ2luYWwgd2FybmluZyB3YXM6CgphcmNoL3VtL29zLUxpbnV4L2ZpbGUuYzogSW4gRnVua3Rp
b24gwrtvc19tYWpvcsKrOgphcmNoL3VtL29zLUxpbnV4L2ZpbGUuYzo2MDA6MTM6IFdhcm51bmc6
IEluIHRoZSBHTlUgQyBMaWJyYXJ5LCAibWFqb3IiIGlzIGRlZmluZWQKIGJ5IDxzeXMvc3lzbWFj
cm9zLmg+LiBGb3IgaGlzdG9yaWNhbCBjb21wYXRpYmlsaXR5LCBpdCBpcwogY3VycmVudGx5IGRl
ZmluZWQgYnkgPHN5cy90eXBlcy5oPiBhcyB3ZWxsLCBidXQgd2UgcGxhbiB0bwogcmVtb3ZlIHRo
aXMgc29vbi4gVG8gdXNlICJtYWpvciIsIGluY2x1ZGUgPHN5cy9zeXNtYWNyb3MuaD4KIGRpcmVj
dGx5LiBJZiB5b3UgZGlkIG5vdCBpbnRlbmQgdG8gdXNlIGEgc3lzdGVtLWRlZmluZWQgbWFjcm8K
ICJtYWpvciIsIHlvdSBzaG91bGQgdW5kZWZpbmUgaXQgYWZ0ZXIgaW5jbHVkaW5nIDxzeXMvdHlw
ZXMuaD4uCiAgcmV0dXJuIG1ham9yKGRldik7CgpTaWduZWQtb2ZmLWJ5OiBUaG9tYXMgTWV5ZXIg
PHRob21hc0BtM3kzci5kZT4KLS0tCiBhcmNoL3VtL29zLUxpbnV4L2ZpbGUuYyB8IDEgKwogMSBm
aWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspCgpkaWZmIC0tZ2l0IGEvYXJjaC91bS9vcy1MaW51
eC9maWxlLmMgYi9hcmNoL3VtL29zLUxpbnV4L2ZpbGUuYwppbmRleCAyZGIxOGNiYmIwZWEuLmQx
OTAxZGU4Y2U5ZiAxMDA2NDQKLS0tIGEvYXJjaC91bS9vcy1MaW51eC9maWxlLmMKKysrIGIvYXJj
aC91bS9vcy1MaW51eC9maWxlLmMKQEAgLTE0LDYgKzE0LDcgQEAKICNpbmNsdWRlIDxzeXMvc3Rh
dC5oPgogI2luY2x1ZGUgPHN5cy91bi5oPgogI2luY2x1ZGUgPHN5cy90eXBlcy5oPgorI2luY2x1
ZGUgPHN5cy9zeXNtYWNyb3MuaD4KICNpbmNsdWRlIDxvcy5oPgogCiBzdGF0aWMgdm9pZCBjb3B5
X3N0YXQoc3RydWN0IHVtbF9zdGF0ICpkc3QsIGNvbnN0IHN0cnVjdCBzdGF0NjQgKnNyYykKLS0g
CjIuMTMuMAoKCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpDaGVjayBvdXQgdGhlIHZpYnJhbnQgdGVj
aCBjb21tdW5pdHkgb24gb25lIG9mIHRoZSB3b3JsZCdzIG1vc3QKZW5nYWdpbmcgdGVjaCBzaXRl
cywgU2xhc2hkb3Qub3JnISBodHRwOi8vc2RtLmxpbmsvc2xhc2hkb3QKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVXNlci1tb2RlLWxpbnV4LWRldmVsIG1h
aWxpbmcgbGlzdApVc2VyLW1vZGUtbGludXgtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0
dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL3VzZXItbW9kZS1saW51
eC1kZXZlbAo=

