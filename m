Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 3/3] um: stub_32.h: move 'inline' before 'void' to fix W=1
 warning
Date: Tue, 13 Apr 2021 23:43:50 -0700
Message-Id: <20210414064350.3923-4-rdunlap@infradead.org>
In-Reply-To: <20210414064350.3923-1-rdunlap@infradead.org>
References: <20210414064350.3923-1-rdunlap@infradead.org>
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
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-um@lists.infradead.org, kernel test robot <lkp@intel.com>

VXNlIHRoZSBleHBlY3RlZCBvcmRlcmluZyBvZiBmdW5jdGlvbiBtb2RpZmllciBrZXl3b3Jkcy4K
CmFyY2gveDg2L3VtL3NoYXJlZC9zeXNkZXAvc3R1Yl8zMi5oOjgwOjE6IHdhcm5pbmc6IOKAmGlu
bGluZeKAmSBpcyBub3QgYXQgYmVnaW5uaW5nIG9mIGRlY2xhcmF0aW9uIFstV29sZC1zdHlsZS1k
ZWNsYXJhdGlvbl0KIHN0YXRpYyB2b2lkIGlubGluZSByZW1hcF9zdGFja19hbmRfdHJhcCh2b2lk
KQogXn5+fn5+CgpTaWduZWQtb2ZmLWJ5OiBSYW5keSBEdW5sYXAgPHJkdW5sYXBAaW5mcmFkZWFk
Lm9yZz4KUmVwb3J0ZWQtYnk6IGtlcm5lbCB0ZXN0IHJvYm90IDxsa3BAaW50ZWwuY29tPgpDYzog
SmVmZiBEaWtlIDxqZGlrZUBhZGR0b2l0LmNvbT4KQ2M6IFJpY2hhcmQgV2VpbmJlcmdlciA8cmlj
aGFyZEBub2QuYXQ+CkNjOiBBbnRvbiBJdmFub3YgPGFudG9uLml2YW5vdkBjYW1icmlkZ2VncmV5
cy5jb20+CkNjOiBsaW51eC11bUBsaXN0cy5pbmZyYWRlYWQub3JnCi0tLQogYXJjaC94ODYvdW0v
c2hhcmVkL3N5c2RlcC9zdHViXzMyLmggfCAgICAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNl
cnRpb24oKyksIDEgZGVsZXRpb24oLSkKCi0tLSBsaW51eC1uZXh0LTIwMjEwNDEzLm9yaWcvYXJj
aC94ODYvdW0vc2hhcmVkL3N5c2RlcC9zdHViXzMyLmgKKysrIGxpbnV4LW5leHQtMjAyMTA0MTMv
YXJjaC94ODYvdW0vc2hhcmVkL3N5c2RlcC9zdHViXzMyLmgKQEAgLTc3LDcgKzc3LDcgQEAgc3Rh
dGljIGlubGluZSB2b2lkIHRyYXBfbXlzZWxmKHZvaWQpCiAJX19hc20oImludDMiKTsKIH0KIAot
c3RhdGljIHZvaWQgaW5saW5lIHJlbWFwX3N0YWNrX2FuZF90cmFwKHZvaWQpCitzdGF0aWMgaW5s
aW5lIHZvaWQgcmVtYXBfc3RhY2tfYW5kX3RyYXAodm9pZCkKIHsKIAlfX2FzbV9fIHZvbGF0aWxl
ICgKIAkJIm1vdmwgJSVlc3AsJSVlYnggOyIKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmxpbnV4LXVtIG1haWxpbmcgbGlzdApsaW51eC11bUBsaXN0cy5p
bmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8v
bGludXgtdW0K

