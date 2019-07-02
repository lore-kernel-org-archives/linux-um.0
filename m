Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hiJxB-0000fi-TX
 for linux-um@lists.infradead.org; Tue, 02 Jul 2019 14:40:19 +0000
Received: by mail-wm1-x342.google.com with SMTP id f17so1323281wme.2
 for <linux-um@lists.infradead.org>; Tue, 02 Jul 2019 07:40:16 -0700 (PDT)
MIME-Version: 1.0
References: <54cee375-f1c3-a2b3-ea89-919b0af60433@yandex.ru>
 <fc526c78-2d3f-90ca-8317-a89eb653cbf9@yandex.ru>
In-Reply-To: <fc526c78-2d3f-90ca-8317-a89eb653cbf9@yandex.ru>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Tue, 2 Jul 2019 16:40:03 +0200
Message-ID: <CAFLxGvytDC1TFdT0m9vvijz_93B8TziWURcR-3mskWB-7TzFag@mail.gmail.com>
Subject: Re: [PATCH] User mode linux bump maximum MTU tuntap interface [RESAND]
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
To: =?UTF-8?B?0JDQu9C10LrRgdC10Lk=?= <ne-vlezay80@yandex.ru>
Cc: netdev@vger.kernel.org, linux-um@lists.infradead.org, Anton Ivanov <anton.ivanov@cambridgegreys.com>

Q0MnaW5nIHVtIGZvbGtzLgoKT24gVHVlLCBKdWwgMiwgMjAxOSBhdCAzOjAxIFBNINCQ0LvQtdC6
0YHQtdC5IDxuZS12bGV6YXk4MEB5YW5kZXgucnU+IHdyb3RlOgo+Cj4gSGVsbG8sIHRoZSBwYXJh
bWV0ZXIgIEVUSF9NQVhfUEFDS0VUIGxpbWl0ZWQgdG8gMTUwMCBieXRlcyBpcyB0aGUgbm90Cj4g
c3VwcG9ydCBqdW1ibyBmcmFtZXMuCj4KPiBUaGlzIHBhdGNoIGNoYW5nZSBFVEhfTUFYX1BBQ0tF
VCB0aGUgNjU1MzUgYnl0ZXMgdG8ganVtYm8gZnJhbWUgc3VwcG9ydAo+IHdpdGggdXNlciBtb2Rl
IGxpbnV4IHR1bnRhcCBkcml2ZXIuCj4KPgo+IFBBVENIOgo+Cj4gLS0tLS0tLS0tLS0tLS0tLS0t
LQo+Cj4KPiBkaWZmIC1ydU5QIC4uL2xpbnV4X29yaWcvbGludXgtNS4xL2FyY2gvdW0vaW5jbHVk
ZS9zaGFyZWQvbmV0X3VzZXIuaAo+IC4vYXJjaC91bS9pbmNsdWRlL3NoYXJlZC9uZXRfdXNlci5o
Cj4gLS0tIGEvYXJjaC91bS9pbmNsdWRlL3NoYXJlZC9uZXRfdXNlci5oICAgIDIwMTktMDUtMDYg
MDA6NDI6NTguMDAwMDAwMDAwCj4gKzAwMDAKPiArKysgYi9hcmNoL3VtL2luY2x1ZGUvc2hhcmVk
L25ldF91c2VyLmggICAgMjAxOS0wNy0wMiAwNzoxNDoxMy41OTMzMzMzNTYKPiArMDAwMAo+IEBA
IC05LDcgKzksNyBAQAo+ICAjZGVmaW5lIEVUSF9BRERSX0xFTiAoNikKPiAgI2RlZmluZSBFVEhf
SEVBREVSX0VUSEVSVEFQICgxNikKPiAgI2RlZmluZSBFVEhfSEVBREVSX09USEVSICgyNikgLyog
MTQgZm9yIGV0aGVybmV0ICsgVkxBTiArIE1QTFMgZm9yCj4gY3JhenkgcGVvcGxlICovCj4gLSNk
ZWZpbmUgRVRIX01BWF9QQUNLRVQgKDE1MDApCj4gKyNkZWZpbmUgRVRIX01BWF9QQUNLRVQgKDY1
NTM1KQo+Cj4gICNkZWZpbmUgVU1MX05FVF9WRVJTSU9OICg0KQo+Cj4gLS0tLS0tLS0tLS0tLS0t
LS0tLQo+Cj4KCgotLSAKVGhhbmtzLAovL3JpY2hhcmQKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LXVtIG1haWxpbmcgbGlzdApsaW51eC11bUBs
aXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlz
dGluZm8vbGludXgtdW0K

