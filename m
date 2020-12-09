Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kn90J-0008Di-0j
 for linux-um@lists.infradead.org; Wed, 09 Dec 2020 23:36:15 +0000
Received: by mail-lj1-x244.google.com with SMTP id t22so4586079ljk.0
 for <linux-um@lists.infradead.org>; Wed, 09 Dec 2020 15:36:12 -0800 (PST)
MIME-Version: 1.0
References: <20201209181915.39147-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20201209181915.39147-1-andriy.shevchenko@linux.intel.com>
From: David Gow <davidgow@google.com>
Date: Thu, 10 Dec 2020 07:35:59 +0800
Message-ID: <CABVgOSm068MCw1H2m5Gz-deHicpg_U3jcU=GfJTB0S5B-g-ZUQ@mail.gmail.com>
Subject: Re: [PATCH v1] um: Increase stack frame size threshold for signal.c
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
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, linux-um <linux-um@lists.infradead.org>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Anton Ivanov <anton.ivanov@cambridgegreys.com>

T24gVGh1LCBEZWMgMTAsIDIwMjAgYXQgMjoyMyBBTSBBbmR5IFNoZXZjaGVua28KPGFuZHJpeS5z
aGV2Y2hlbmtvQGxpbnV4LmludGVsLmNvbT4gd3JvdGU6Cj4KPiBUaGUgc2lnbmFsLmMgY2FuJ3Qg
dXNlIGhlYXAgZm9yIGJpdCBkYXRhIGxvY2F0ZWQgb24gc3RhY2suIEhvd2V2ZXIsCj4gYnkgZGVm
YXVsdCBhIGNvbXBpbGVyIHdhcm5zIHVzIGFib3V0IG92ZXJzdGVwcGluZyBzdGFjayBmcmFtZSBz
aXplCj4gdGhyZXNob2xkOgo+Cj4gYXJjaC91bS9vcy1MaW51eC9zaWduYWwuYzogSW4gZnVuY3Rp
b24g4oCYc2lnX2hhbmRsZXJfY29tbW9u4oCZOgo+IGFyY2gvdW0vb3MtTGludXgvc2lnbmFsLmM6
NTE6MTogd2FybmluZzogdGhlIGZyYW1lIHNpemUgb2YgMjk2MCBieXRlcyBpcyBsYXJnZXIgdGhh
biAyMDQ4IGJ5dGVzIFstV2ZyYW1lLWxhcmdlci10aGFuPV0KPiAgICA1MSB8IH0KPiAgICAgICB8
IF4KPiBhcmNoL3VtL29zLUxpbnV4L3NpZ25hbC5jOiBJbiBmdW5jdGlvbiDigJh0aW1lcl9yZWFs
X2FsYXJtX2hhbmRsZXLigJk6Cj4gYXJjaC91bS9vcy1MaW51eC9zaWduYWwuYzo5NToxOiB3YXJu
aW5nOiB0aGUgZnJhbWUgc2l6ZSBvZiAyOTYwIGJ5dGVzIGlzIGxhcmdlciB0aGFuIDIwNDggYnl0
ZXMgWy1XZnJhbWUtbGFyZ2VyLXRoYW49XQo+ICAgICA5NSB8IH0KPiAgICAgICAgfCBeCj4KPiBE
dWUgdG8gYWJvdmUgaW5jcmVhc2Ugc3RhY2sgZnJhbWUgc2l6ZSB0aHJlc2hvbGQgZXhwbGljaXRs
eSBmb3Igc2lnbmFsLmMKPiB0byBhdm9pZCB1bm5lY2Vzc2FyeSB3YXJuaW5nLgo+Cj4gU2lnbmVk
LW9mZi1ieTogQW5keSBTaGV2Y2hlbmtvIDxhbmRyaXkuc2hldmNoZW5rb0BsaW51eC5pbnRlbC5j
b20+Cj4gLS0tClRoYW5rcyAtLSB0aGlzIGhhcyBiZWVuIGFubm95aW5nIG1lIGZvciBhIHdoaWxl
IQoKSSd2ZSB0ZXN0ZWQgaXQgLS0gdGhlIHdhcm5pbmcgaXMgaW5kZWVkIGdvbmUsIGFuZCBub3Ro
aW5nIGVsc2Ugc2VlbXMgdG8gYnJlYWsuCgpUZXN0ZWQtYnk6IERhdmlkIEdvdyA8ZGF2aWRnb3dA
Z29vZ2xlLmNvbT4KCkNoZWVycywKLS0gRGF2aWQKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmxpbnV4LXVtIG1haWxpbmcgbGlzdApsaW51eC11bUBsaXN0
cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGlu
Zm8vbGludXgtdW0K

