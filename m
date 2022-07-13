Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBa0U-002pyZ-Qr
	for linux-um@lists.infradead.org; Wed, 13 Jul 2022 10:54:16 +0000
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH] um: include linux/stddef.h for __always_inline
Date: Wed, 13 Jul 2022 12:54:06 +0200
Message-Id: <20220713105406.309966-1-Jason@zx2c4.com>
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
To: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, johannes@sipsolutions.net
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>

V2hlbiBjb21waWxpbmcgYWdhaW5zdCBtdXNsLCB0aGVpciBzaGlwcGVkIDxzdGRkZWYuaD4gZG9l
c24ndCBoYXZlCl9fYWx3YXlzX2lubGluZS4gU28gaW5zdGVhZCBleHBsaWNpdGx5IGluY2x1ZGUg
dGhlIGtlcm5lbCB1YXBpIGhlYWRlciwKPGxpbnV4L3N0ZGRlZi5oPiwgd2hpY2ggZG9lcy4KClRo
aXMgcHJldmVudHMgdGhlIGZvbGxvd2luZyBidWlsZCBlcnJvcjoKCkluIGZpbGUgaW5jbHVkZWQg
ZnJvbSBhcmNoL3g4Ni91bS9zaGFyZWQvc3lzZGVwL3N0dWIuaDoxMSwKICAgICAgICAgICAgICAg
ICBmcm9tIGFyY2gvdW0va2VybmVsL3NrYXMvY2xvbmUuYzoxNDoKYXJjaC94ODYvdW0vc2hhcmVk
L3N5c2RlcC9zdHViXzY0Lmg6MTExOjIzOiBlcnJvcjogZXhwZWN0ZWQg4oCYO+KAmSBiZWZvcmUg
4oCYdm9pZOKAmQogIDExMSB8IHN0YXRpYyBfX2Fsd2F5c19pbmxpbmUgdm9pZCAqZ2V0X3N0dWJf
cGFnZSh2b2lkKQogICAgICB8ICAgICAgICAgICAgICAgICAgICAgICBefn5+fgogICAgICB8ICAg
ICAgICAgICAgICAgICAgICAgICA7Cm1ha2VbNF06ICoqKiBbc2NyaXB0cy9NYWtlZmlsZS5idWls
ZDoyNDk6IGFyY2gvdW0va2VybmVsL3NrYXMvY2xvbmUub10gRXJyb3IgMQoKU2lnbmVkLW9mZi1i
eTogSmFzb24gQS4gRG9uZW5mZWxkIDxKYXNvbkB6eDJjNC5jb20+Ci0tLQogYXJjaC94ODYvdW0v
c2hhcmVkL3N5c2RlcC9zdHViXzY0LmggfCAxICsKIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlv
bigrKQoKZGlmZiAtLWdpdCBhL2FyY2gveDg2L3VtL3NoYXJlZC9zeXNkZXAvc3R1Yl82NC5oIGIv
YXJjaC94ODYvdW0vc2hhcmVkL3N5c2RlcC9zdHViXzY0LmgKaW5kZXggZTljNGIyYjM4ODAzLi45
MmVhMTY3MGNmMWMgMTAwNjQ0Ci0tLSBhL2FyY2gveDg2L3VtL3NoYXJlZC9zeXNkZXAvc3R1Yl82
NC5oCisrKyBiL2FyY2gveDg2L3VtL3NoYXJlZC9zeXNkZXAvc3R1Yl82NC5oCkBAIC04LDYgKzgs
NyBAQAogCiAjaW5jbHVkZSA8c3lzZGVwL3B0cmFjZV91c2VyLmg+CiAjaW5jbHVkZSA8Z2VuZXJh
dGVkL2FzbS1vZmZzZXRzLmg+CisjaW5jbHVkZSA8bGludXgvc3RkZGVmLmg+CiAKICNkZWZpbmUg
U1RVQl9NTUFQX05SIF9fTlJfbW1hcAogI2RlZmluZSBNTUFQX09GRlNFVChvKSAobykKLS0gCjIu
MzUuMQoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxp
bnV4LXVtIG1haWxpbmcgbGlzdApsaW51eC11bUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9s
aXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtdW0K

