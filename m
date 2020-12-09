Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mga14.intel.com ([192.55.52.115])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kn43i-0004zH-5l
 for linux-um@lists.infradead.org; Wed, 09 Dec 2020 18:19:27 +0000
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] um: Increase stack frame size threshold for signal.c
Date: Wed,  9 Dec 2020 20:19:15 +0200
Message-Id: <20201209181915.39147-1-andriy.shevchenko@linux.intel.com>
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
To: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-um@lists.infradead.org, linux-kselftest@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

VGhlIHNpZ25hbC5jIGNhbid0IHVzZSBoZWFwIGZvciBiaXQgZGF0YSBsb2NhdGVkIG9uIHN0YWNr
LiBIb3dldmVyLApieSBkZWZhdWx0IGEgY29tcGlsZXIgd2FybnMgdXMgYWJvdXQgb3ZlcnN0ZXBw
aW5nIHN0YWNrIGZyYW1lIHNpemUKdGhyZXNob2xkOgoKYXJjaC91bS9vcy1MaW51eC9zaWduYWwu
YzogSW4gZnVuY3Rpb24g4oCYc2lnX2hhbmRsZXJfY29tbW9u4oCZOgphcmNoL3VtL29zLUxpbnV4
L3NpZ25hbC5jOjUxOjE6IHdhcm5pbmc6IHRoZSBmcmFtZSBzaXplIG9mIDI5NjAgYnl0ZXMgaXMg
bGFyZ2VyIHRoYW4gMjA0OCBieXRlcyBbLVdmcmFtZS1sYXJnZXItdGhhbj1dCiAgIDUxIHwgfQog
ICAgICB8IF4KYXJjaC91bS9vcy1MaW51eC9zaWduYWwuYzogSW4gZnVuY3Rpb24g4oCYdGltZXJf
cmVhbF9hbGFybV9oYW5kbGVy4oCZOgphcmNoL3VtL29zLUxpbnV4L3NpZ25hbC5jOjk1OjE6IHdh
cm5pbmc6IHRoZSBmcmFtZSBzaXplIG9mIDI5NjAgYnl0ZXMgaXMgbGFyZ2VyIHRoYW4gMjA0OCBi
eXRlcyBbLVdmcmFtZS1sYXJnZXItdGhhbj1dCiAgICA5NSB8IH0KICAgICAgIHwgXgoKRHVlIHRv
IGFib3ZlIGluY3JlYXNlIHN0YWNrIGZyYW1lIHNpemUgdGhyZXNob2xkIGV4cGxpY2l0bHkgZm9y
IHNpZ25hbC5jCnRvIGF2b2lkIHVubmVjZXNzYXJ5IHdhcm5pbmcuCgpTaWduZWQtb2ZmLWJ5OiBB
bmR5IFNoZXZjaGVua28gPGFuZHJpeS5zaGV2Y2hlbmtvQGxpbnV4LmludGVsLmNvbT4KLS0tCiBh
cmNoL3VtL29zLUxpbnV4L01ha2VmaWxlIHwgMiArKwogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0
aW9ucygrKQoKZGlmZiAtLWdpdCBhL2FyY2gvdW0vb3MtTGludXgvTWFrZWZpbGUgYi9hcmNoL3Vt
L29zLUxpbnV4L01ha2VmaWxlCmluZGV4IDgzOTkxNWI4YzMxYy4uNzdhYzUwYmFhM2Y4IDEwMDY0
NAotLS0gYS9hcmNoL3VtL29zLUxpbnV4L01ha2VmaWxlCisrKyBiL2FyY2gvdW0vb3MtTGludXgv
TWFrZWZpbGUKQEAgLTEwLDYgKzEwLDggQEAgb2JqLXkgPSBleGVjdnAubyBmaWxlLm8gaGVscGVy
Lm8gaXJxLm8gbWFpbi5vIG1lbS5vIHByb2Nlc3MubyBcCiAJcmVnaXN0ZXJzLm8gc2lnaW8ubyBz
aWduYWwubyBzdGFydF91cC5vIHRpbWUubyB0dHkubyBcCiAJdW1pZC5vIHVzZXJfc3ltcy5vIHV0
aWwubyBkcml2ZXJzLyBza2FzLwogCitDRkxBR1Nfc2lnbmFsLm8gKz0gLVdmcmFtZS1sYXJnZXIt
dGhhbj00MDk2CisKIG9iai0kKENPTkZJR19BUkNIX1JFVVNFX0hPU1RfVlNZU0NBTExfQVJFQSkg
Kz0gZWxmX2F1eC5vCiAKIFVTRVJfT0JKUyA6PSAkKHVzZXItb2Jqcy15KSBlbGZfYXV4Lm8gZXhl
Y3ZwLm8gZmlsZS5vIGhlbHBlci5vIGlycS5vIFwKLS0gCjIuMjkuMgoKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LXVtIG1haWxpbmcgbGlzdAps
aW51eC11bUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21h
aWxtYW4vbGlzdGluZm8vbGludXgtdW0K

