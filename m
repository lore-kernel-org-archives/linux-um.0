Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k486X-0004vH-PZ
 for linux-um@lists.infradead.org; Fri, 07 Aug 2020 19:32:38 +0000
Received: by mail-pj1-x1042.google.com with SMTP id e4so1413930pjd.0
 for <linux-um@lists.infradead.org>; Fri, 07 Aug 2020 12:32:35 -0700 (PDT)
From: =?UTF-8?q?Maciej=20=C5=BBenczykowski?= <zenczykowski@gmail.com>
Subject: [PATCH] uml - fix incorrect assumptions about max pid length
Date: Fri,  7 Aug 2020 12:32:26 -0700
Message-Id: <20200807193226.921195-1-zenczykowski@gmail.com>
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: =?UTF-8?q?Maciej=20=C5=BBenczykowski?= <maze@google.com>
Cc: Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, Linux UM Mailing List <linux-um@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Anton Ivanov <anton.ivanov@cambridgegreys.com>

RnJvbTogTWFjaWVqIMW7ZW5jenlrb3dza2kgPG1hemVAZ29vZ2xlLmNvbT4KCkZpeGVzOiBpc191
bWRpcl91c2VkIC0gcGlkIGZpbGVuYW1lIHRvbyBsb25nCgpwaWRzIGFyZSBubyBsb25nZXIgbGlt
aXRlZCB0byAxNi1iaXRzLCBidW1wIHRvIDMyLWJpdHMsCmllLiA5IGRlY2ltYWwgY2hhcmFjdGVy
cy4gIEFkZGl0aW9uYWxseSBzaXplb2YoIi8iKSBhbHJlYWR5CnJldHVybnMgMiAtIGllLiBpdCBh
bHJlYWR5IGFjY291bnRzIGZvciB0cmFpbGluZyB6ZXJvLgoKQ2M6IEplZmYgRGlrZSA8amRpa2VA
YWRkdG9pdC5jb20+CkNjOiBSaWNoYXJkIFdlaW5iZXJnZXIgPHJpY2hhcmRAbm9kLmF0PgpDYzog
QW50b24gSXZhbm92IDxhbnRvbi5pdmFub3ZAY2FtYnJpZGdlZ3JleXMuY29tPgpDYzogTGludXgg
VU0gTWFpbGluZyBMaXN0IDxsaW51eC11bUBsaXN0cy5pbmZyYWRlYWQub3JnPgpTaWduZWQtb2Zm
LWJ5OiBNYWNpZWogxbtlbmN6eWtvd3NraSA8bWF6ZUBnb29nbGUuY29tPgotLS0KIGFyY2gvdW0v
b3MtTGludXgvdW1pZC5jIHwgOCArKysrLS0tLQogMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9u
cygrKSwgNCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9hcmNoL3VtL29zLUxpbnV4L3VtaWQu
YyBiL2FyY2gvdW0vb3MtTGludXgvdW1pZC5jCmluZGV4IDllMTYwNzhhNGJmOC4uMWQ3NTU4ZGFj
NzVmIDEwMDY0NAotLS0gYS9hcmNoL3VtL29zLUxpbnV4L3VtaWQuYworKysgYi9hcmNoL3VtL29z
LUxpbnV4L3VtaWQuYwpAQCAtOTcsNyArOTcsNyBAQCBzdGF0aWMgaW50IHJlbW92ZV9maWxlc19h
bmRfZGlyKGNoYXIgKmRpcikKIAl3aGlsZSAoKGVudCA9IHJlYWRkaXIoZGlyZWN0b3J5KSkgIT0g
TlVMTCkgewogCQlpZiAoIXN0cmNtcChlbnQtPmRfbmFtZSwgIi4iKSB8fCAhc3RyY21wKGVudC0+
ZF9uYW1lLCAiLi4iKSkKIAkJCWNvbnRpbnVlOwotCQlsZW4gPSBzdHJsZW4oZGlyKSArIHNpemVv
ZigiLyIpICsgc3RybGVuKGVudC0+ZF9uYW1lKSArIDE7CisJCWxlbiA9IHN0cmxlbihkaXIpICsg
c3RybGVuKCIvIikgKyBzdHJsZW4oZW50LT5kX25hbWUpICsgMTsKIAkJaWYgKGxlbiA+IHNpemVv
ZihmaWxlKSkgewogCQkJcmV0ID0gLUUyQklHOwogCQkJZ290byBvdXQ7CkBAIC0xMzUsNyArMTM1
LDcgQEAgc3RhdGljIGludCByZW1vdmVfZmlsZXNfYW5kX2RpcihjaGFyICpkaXIpCiAgKi8KIHN0
YXRpYyBpbmxpbmUgaW50IGlzX3VtZGlyX3VzZWQoY2hhciAqZGlyKQogewotCWNoYXIgcGlkW3Np
emVvZigibm5ubm5cMCIpXSwgKmVuZCwgKmZpbGU7CisJY2hhciBwaWRbc2l6ZW9mKCJubm5ubm5u
bm4iKV0sICplbmQsICpmaWxlOwogCWludCBkZWFkLCBmZCwgcCwgbiwgZXJyOwogCXNpemVfdCBm
aWxlbGVuOwogCkBAIC0yMTcsMTAgKzIxNywxMCBAQCBzdGF0aWMgaW50IHVtZGlyX3Rha2VfaWZf
ZGVhZChjaGFyICpkaXIpCiAKIHN0YXRpYyB2b2lkIF9faW5pdCBjcmVhdGVfcGlkX2ZpbGUodm9p
ZCkKIHsKLQljaGFyIHBpZFtzaXplb2YoIm5ubm5uXDAiKV0sICpmaWxlOworCWNoYXIgcGlkW3Np
emVvZigibm5ubm5ubm5uIildLCAqZmlsZTsKIAlpbnQgZmQsIG47CiAKLQluID0gc3RybGVuKHVt
bF9kaXIpICsgVU1JRF9MRU4gKyBzaXplb2YoIi9waWRcMCIpOworCW4gPSBzdHJsZW4odW1sX2Rp
cikgKyBVTUlEX0xFTiArIHNpemVvZigiL3BpZCIpOwogCWZpbGUgPSBtYWxsb2Mobik7CiAJaWYg
KCFmaWxlKQogCQlyZXR1cm47Ci0tIAoyLjI4LjAuMjM2LmdiMTBjYzc5OTY2LWdvb2cKCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC11bSBtYWls
aW5nIGxpc3QKbGludXgtdW1AbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFk
ZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LXVtCg==

