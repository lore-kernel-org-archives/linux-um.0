Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <xiyou.wangcong@gmail.com>) id 1L5lM9-0002R4-Qp
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 27 Nov 2008 18:12:49 +0000
Received: from nf-out-0910.google.com ([64.233.182.185])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1L5lM5-0001oH-Su for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 27 Nov 2008 18:12:49 +0000
Received: by nf-out-0910.google.com with SMTP id g16so552761nfd.2
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 27 Nov 2008 10:12:43 -0800 (PST)
Date: Thu, 27 Nov 2008 18:12:28 +0000
From: =?utf-8?Q?Am=C3=A9rico?= Wang <xiyou.wangcong@gmail.com>
Message-ID: <20081127181228.GA4417@hack.voiplan.pt>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [Patch] uml: fix the highmem build error
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
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, jdike@addtoit.com, Al Viro <viro@zeniv.linux.org.uk>, user-mode-linux-devel@lists.sourceforge.net

ClRoaXMgcGF0Y2ggZml4ZXMgdGhpcyBlcnJvcjoKCmFyY2gvdW0va2VybmVsL21lbS5jOiBJbiBm
dW5jdGlvbiDigJhpbml0X2hpZ2htZW3igJk6ICAgICAgICAKYXJjaC91bS9rZXJuZWwvbWVtLmM6
MTc3OiBlcnJvcjog4oCYcGttYXBfcGFnZV90YWJsZeKAmSB1bmRlY2xhcmVkIChmaXJzdAp1c2Ug
aW4gdGhpcyBmdW5jdGlvbikgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKYXJjaC91
bS9rZXJuZWwvbWVtLmM6MTc3OiBlcnJvcjogKEVhY2ggdW5kZWNsYXJlZCBpZGVudGlmaWVyIGlz
CnJlcG9ydGVkIG9ubHkgb25jZSAgICAgIAphcmNoL3VtL2tlcm5lbC9tZW0uYzoxNzc6IGVycm9y
OiBmb3IgZWFjaCBmdW5jdGlvbiBpdCBhcHBlYXJzIGluLikgIAoKQ29tcGlsZSBhbmQgcnVuIHRl
c3RlZC4KClNpZ25lZC1vZmYtYnk6IFdBTkcgQ29uZyA8d2FuZ2NvbmdAemV1dXgub3JnPgpDYzog
SmVmZiBEaWtlIDxqZGlrZUBhZGR0b2l0LmNvbT4KQ2M6IEFsIFZpcm8gPHZpcm9AemVuaXYubGlu
dXgub3JnLnVrPgoKLS0tCmRpZmYgLS1naXQgYS9hcmNoL3VtL2luY2x1ZGUvYXNtL2ZpeG1hcC5o
IGIvYXJjaC91bS9pbmNsdWRlL2FzbS9maXhtYXAuaAppbmRleCA2OWMwMjUyLi40ZTY1NmM5IDEw
MDY0NAotLS0gYS9hcmNoL3VtL2luY2x1ZGUvYXNtL2ZpeG1hcC5oCisrKyBiL2FyY2gvdW0vaW5j
bHVkZS9hc20vZml4bWFwLmgKQEAgLTQwLDYgKzQwLDkgQEAgZW51bSBmaXhlZF9hZGRyZXNzZXMg
ewogI2VuZGlmCiAJX19lbmRfb2ZfZml4ZWRfYWRkcmVzc2VzCiB9OworZXh0ZXJuIHB0ZV90ICpw
a21hcF9wYWdlX3RhYmxlOworZXh0ZXJuIHB0ZV90ICprbWFwX3B0ZTsKK2V4dGVybiBwZ3Byb3Rf
dCBrbWFwX3Byb3Q7CiAKIGV4dGVybiB2b2lkIF9fc2V0X2ZpeG1hcCAoZW51bSBmaXhlZF9hZGRy
ZXNzZXMgaWR4LAogCQkJICB1bnNpZ25lZCBsb25nIHBoeXMsIHBncHJvdF90IGZsYWdzKTsKZGlm
ZiAtLWdpdCBhL2FyY2gveDg2L21tL2hpZ2htZW1fMzIuYyBiL2FyY2gveDg2L21tL2hpZ2htZW1f
MzIuYwppbmRleCBiY2MwNzljLi44ODRmOWUyIDEwMDY0NAotLS0gYS9hcmNoL3g4Ni9tbS9oaWdo
bWVtXzMyLmMKKysrIGIvYXJjaC94ODYvbW0vaGlnaG1lbV8zMi5jCkBAIC0xLDMgKzEsNCBAQAor
I2luY2x1ZGUgPGFzbS9maXhtYXAuaD4KICNpbmNsdWRlIDxsaW51eC9oaWdobWVtLmg+CiAjaW5j
bHVkZSA8bGludXgvbW9kdWxlLmg+CiAKCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KVGhpcyBTRi5OZXQgZW1h
aWwgaXMgc3BvbnNvcmVkIGJ5IHRoZSBNb2JsaW4gWW91ciBNb3ZlIERldmVsb3BlcidzIGNoYWxs
ZW5nZQpCdWlsZCB0aGUgY29vbGVzdCBMaW51eCBiYXNlZCBhcHBsaWNhdGlvbnMgd2l0aCBNb2Js
aW4gU0RLICYgd2luIGdyZWF0IHByaXplcwpHcmFuZCBwcml6ZSBpcyBhIHRyaXAgZm9yIHR3byB0
byBhbiBPcGVuIFNvdXJjZSBldmVudCBhbnl3aGVyZSBpbiB0aGUgd29ybGQKaHR0cDovL21vYmxp
bi1jb250ZXN0Lm9yZy9yZWRpcmVjdC5waHA/YmFubmVyX2lkPTEwMCZ1cmw9LwpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpVc2VyLW1vZGUtbGludXgtZGV2
ZWwgbWFpbGluZyBsaXN0ClVzZXItbW9kZS1saW51eC1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5u
ZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vdXNlci1tb2Rl
LWxpbnV4LWRldmVsCg==
