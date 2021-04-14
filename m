Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 1/3] um: pgtable.h: fix W=1 warning for empty body in 'do'
 statement
Date: Tue, 13 Apr 2021 23:43:48 -0700
Message-Id: <20210414064350.3923-2-rdunlap@infradead.org>
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
Cc: Randy Dunlap <rdunlap@infradead.org>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-um@lists.infradead.org

VXNlIHRoZSBjb21tb24ga2VybmVsIHN0eWxlIHRvIGVsaW1pbmF0ZSBhIHdhcm5pbmc6CgouL2Fy
Y2gvdW0vaW5jbHVkZS9hc20vcGd0YWJsZS5oOjMwNTo0Nzogd2FybmluZzogc3VnZ2VzdCBicmFj
ZXMgYXJvdW5kIGVtcHR5IGJvZHkgaW4g4oCYZG/igJkgc3RhdGVtZW50IFstV2VtcHR5LWJvZHld
CiAjZGVmaW5lIHVwZGF0ZV9tbXVfY2FjaGUodm1hLGFkZHJlc3MscHRlcCkgZG8gOyB3aGlsZSAo
MCkKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBeCm1tL2Zp
bGVtYXAuYzozMjEyOjM6IG5vdGU6IGluIGV4cGFuc2lvbiBvZiBtYWNybyDigJh1cGRhdGVfbW11
X2NhY2hl4oCZCiAgIHVwZGF0ZV9tbXVfY2FjaGUodm1hLCBhZGRyLCB2bWYtPnB0ZSk7CiAgIF5+
fn5+fn5+fn5+fn5+fn4KClNpZ25lZC1vZmYtYnk6IFJhbmR5IER1bmxhcCA8cmR1bmxhcEBpbmZy
YWRlYWQub3JnPgpDYzogSmVmZiBEaWtlIDxqZGlrZUBhZGR0b2l0LmNvbT4KQ2M6IFJpY2hhcmQg
V2VpbmJlcmdlciA8cmljaGFyZEBub2QuYXQ+CkNjOiBBbnRvbiBJdmFub3YgPGFudG9uLml2YW5v
dkBjYW1icmlkZ2VncmV5cy5jb20+CkNjOiBsaW51eC11bUBsaXN0cy5pbmZyYWRlYWQub3JnCi0t
LQogYXJjaC91bS9pbmNsdWRlL2FzbS9wZ3RhYmxlLmggfCAgICAyICstCiAxIGZpbGUgY2hhbmdl
ZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCi0tLSBsaW51eC1uZXh0LTIwMjEwNDEz
Lm9yaWcvYXJjaC91bS9pbmNsdWRlL2FzbS9wZ3RhYmxlLmgKKysrIGxpbnV4LW5leHQtMjAyMTA0
MTMvYXJjaC91bS9pbmNsdWRlL2FzbS9wZ3RhYmxlLmgKQEAgLTMwMiw3ICszMDIsNyBAQCBzdGF0
aWMgaW5saW5lIHB0ZV90IHB0ZV9tb2RpZnkocHRlX3QgcHRlCiBzdHJ1Y3QgbW1fc3RydWN0Owog
ZXh0ZXJuIHB0ZV90ICp2aXJ0X3RvX3B0ZShzdHJ1Y3QgbW1fc3RydWN0ICptbSwgdW5zaWduZWQg
bG9uZyBhZGRyKTsKIAotI2RlZmluZSB1cGRhdGVfbW11X2NhY2hlKHZtYSxhZGRyZXNzLHB0ZXAp
IGRvIDsgd2hpbGUgKDApCisjZGVmaW5lIHVwZGF0ZV9tbXVfY2FjaGUodm1hLGFkZHJlc3MscHRl
cCkgZG8ge30gd2hpbGUgKDApCiAKIC8qIEVuY29kZSBhbmQgZGUtY29kZSBhIHN3YXAgZW50cnkg
Ki8KICNkZWZpbmUgX19zd3BfdHlwZSh4KQkJCSgoKHgpLnZhbCA+PiA1KSAmIDB4MWYpCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC11bSBtYWls
aW5nIGxpc3QKbGludXgtdW1AbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFk
ZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LXVtCg==

