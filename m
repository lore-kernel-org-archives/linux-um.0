Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1INxnY-0002qY-8p for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 22 Aug 2007 14:31:38 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1INxnW-0006Aa-PF
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 22 Aug 2007 14:31:32 -0700
Date: Wed, 22 Aug 2007 17:31:15 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070822213115.GB14287@c2.user-mode-linux.org>
References: <200708212148.05392.rob@landley.net>
	<20070822172456.GB11966@c2.user-mode-linux.org>
	<200708221626.53510.rob@landley.net>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <200708221626.53510.rob@landley.net>
Subject: Re: [uml-devel] UML doesn't build in 2.6.23-rc3.
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
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Rob Landley <rob@landley.net>
Cc: uml-devel <user-mode-linux-devel@lists.sourceforge.net>

T24gV2VkLCBBdWcgMjIsIDIwMDcgYXQgMDQ6MjY6NTNQTSAtMDUwMCwgUm9iIExhbmRsZXkgd3Jv
dGU6Cj4gaW5jbHVkZS9hc20tZ2VuZXJpYy90bGIuaDogSW4gZnVuY3Rpb24g4oCYdGxiX2ZsdXNo
X21tdeKAmToKPiBpbmNsdWRlL2FzbS1nZW5lcmljL3RsYi5oOjc2OiBlcnJvcjogaW1wbGljaXQg
ZGVjbGFyYXRpb24gb2YgCj4gZnVuY3Rpb24g4oCYcmVsZWFzZV9wYWdlc+KAmQo+IGluY2x1ZGUv
YXNtLWdlbmVyaWMvdGxiLmg6IEluIGZ1bmN0aW9uIOKAmHRsYl9yZW1vdmVfcGFnZeKAmToKPiBp
bmNsdWRlL2FzbS1nZW5lcmljL3RsYi5oOjEwNTogZXJyb3I6IGltcGxpY2l0IGRlY2xhcmF0aW9u
IG9mIAo+IGZ1bmN0aW9uIOKAmHBhZ2VfY2FjaGVfcmVsZWFzZeKAmQoKU2hvdWxkbid0IHRoZSBu
ZXcgaW5jbHVkZSBnbyBpbiBhc20tZ2VuZXJpYy90bGIuaCBpbnN0ZWFkPwoKSW5kZXg6IGxpbnV4
LTIuNi4yMi9pbmNsdWRlL2FzbS1nZW5lcmljL3RsYi5oCj09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KLS0tIGxpbnV4LTIu
Ni4yMi5vcmlnL2luY2x1ZGUvYXNtLWdlbmVyaWMvdGxiLmgJMjAwNy0wNy0wOCAxOTozMjoxNy4w
MDAwMDAwMDAgLTA0MDAKKysrIGxpbnV4LTIuNi4yMi9pbmNsdWRlL2FzbS1nZW5lcmljL3RsYi5o
CTIwMDctMDgtMjIgMTc6Mjk6NDUuMDAwMDAwMDAwIC0wNDAwCkBAIC0xMyw2ICsxMyw3IEBACiAj
aWZuZGVmIF9BU01fR0VORVJJQ19fVExCX0gKICNkZWZpbmUgX0FTTV9HRU5FUklDX19UTEJfSAog
CisjaW5jbHVkZSA8bGludXgvcGFnZW1hcC5oPgogI2luY2x1ZGUgPGxpbnV4L3N3YXAuaD4KICNp
bmNsdWRlIDxhc20vcGdhbGxvYy5oPgogI2luY2x1ZGUgPGFzbS90bGJmbHVzaC5oPgoKVGhpcyBk
b2Vzbid0IGNhdXNlIGFueSBvYnZpb3VzIHByb2JsZW1zLCBidXQgdGhlbiBJIHdhc24ndCBzZWVp
bmcgdGhlCmJ1aWxkIGZhaWx1cmUgaW4gdGhlIGZpcnN0IHBsYWNlLgoKCQkJCUplZmYKCi0tIApX
b3JrIGVtYWlsIC0gamRpa2UgYXQgbGludXggZG90IGludGVsIGRvdCBjb20KCi0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0KVGhpcyBTRi5uZXQgZW1haWwgaXMgc3BvbnNvcmVkIGJ5OiBTcGx1bmsgSW5jLgpTdGls
bCBncmVwcGluZyB0aHJvdWdoIGxvZyBmaWxlcyB0byBmaW5kIHByb2JsZW1zPyAgU3RvcC4KTm93
IFNlYXJjaCBsb2cgZXZlbnRzIGFuZCBjb25maWd1cmF0aW9uIGZpbGVzIHVzaW5nIEFKQVggYW5k
IGEgYnJvd3Nlci4KRG93bmxvYWQgeW91ciBGUkVFIGNvcHkgb2YgU3BsdW5rIG5vdyA+PiAgaHR0
cDovL2dldC5zcGx1bmsuY29tLwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpVc2VyLW1vZGUtbGludXgtZGV2ZWwgbWFpbGluZyBsaXN0ClVzZXItbW9kZS1s
aW51eC1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3Jn
ZS5uZXQvbGlzdHMvbGlzdGluZm8vdXNlci1tb2RlLWxpbnV4LWRldmVsCg==
