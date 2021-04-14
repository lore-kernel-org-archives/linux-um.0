Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 2/3] um: elf.h: fix W=1 warning for empty body in 'do'
 statement
Date: Tue, 13 Apr 2021 23:43:49 -0700
Message-Id: <20210414064350.3923-3-rdunlap@infradead.org>
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
Y2gveDg2L3VtL2FzbS9lbGYuaDoyMTU6MzI6IHdhcm5pbmc6IHN1Z2dlc3QgYnJhY2VzIGFyb3Vu
ZCBlbXB0eSBib2R5IGluIOKAmGRv4oCZIHN0YXRlbWVudCBbLVdlbXB0eS1ib2R5XQogI2RlZmlu
ZSBTRVRfUEVSU09OQUxJVFkoZXgpIGRvIDsgd2hpbGUoMCkKICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBeCgpTaWduZWQtb2ZmLWJ5OiBSYW5keSBEdW5sYXAgPHJkdW5sYXBAaW5mcmFk
ZWFkLm9yZz4KQ2M6IEplZmYgRGlrZSA8amRpa2VAYWRkdG9pdC5jb20+CkNjOiBSaWNoYXJkIFdl
aW5iZXJnZXIgPHJpY2hhcmRAbm9kLmF0PgpDYzogQW50b24gSXZhbm92IDxhbnRvbi5pdmFub3ZA
Y2FtYnJpZGdlZ3JleXMuY29tPgpDYzogbGludXgtdW1AbGlzdHMuaW5mcmFkZWFkLm9yZwotLS0K
IGFyY2gveDg2L3VtL2FzbS9lbGYuaCB8ICAgIDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2Vy
dGlvbigrKSwgMSBkZWxldGlvbigtKQoKLS0tIGxpbnV4LW5leHQtMjAyMTA0MTMub3JpZy9hcmNo
L3g4Ni91bS9hc20vZWxmLmgKKysrIGxpbnV4LW5leHQtMjAyMTA0MTMvYXJjaC94ODYvdW0vYXNt
L2VsZi5oCkBAIC0yMTIsNiArMjEyLDYgQEAgZXh0ZXJuIGludCBlbGZfY29yZV9jb3B5X2ZwcmVn
cyhzdHJ1Y3QgdAogZXh0ZXJuIGxvbmcgZWxmX2F1eF9od2NhcDsKICNkZWZpbmUgRUxGX0hXQ0FQ
IChlbGZfYXV4X2h3Y2FwKQogCi0jZGVmaW5lIFNFVF9QRVJTT05BTElUWShleCkgZG8gOyB3aGls
ZSgwKQorI2RlZmluZSBTRVRfUEVSU09OQUxJVFkoZXgpIGRvIHt9IHdoaWxlKDApCiAKICNlbmRp
ZgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgt
dW0gbWFpbGluZyBsaXN0CmxpbnV4LXVtQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3Rz
LmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC11bQo=

