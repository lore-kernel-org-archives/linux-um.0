Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-qk1-x72d.google.com ([2607:f8b0:4864:20::72d])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1luhPs-00HXLk-Lh
 for linux-um@lists.infradead.org; Sat, 19 Jun 2021 20:18:09 +0000
Received: by mail-qk1-x72d.google.com with SMTP id q64so13646583qke.7
 for <linux-um@lists.infradead.org>; Sat, 19 Jun 2021 13:18:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210303155523.124277-1-benjamin@sipsolutions.net>
 <20210303155523.124277-4-benjamin@sipsolutions.net>
In-Reply-To: <20210303155523.124277-4-benjamin@sipsolutions.net>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Sat, 19 Jun 2021 22:17:55 +0200
Message-ID: <CAFLxGvwvpz26-RGw_isFYQq4PzOzbMoQOcXb5gxTYq3+vMxHaQ@mail.gmail.com>
Subject: Re: [PATCH 03/27] um: Drop support for hosts without
 SYSEMU_SINGLESTEP support
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
To: Benjamin Berg <benjamin@sipsolutions.net>
Cc: linux-um <linux-um@lists.infradead.org>

T24gVGh1LCBNYXIgNCwgMjAyMSBhdCAxMjowMyBBTSBCZW5qYW1pbiBCZXJnIDxiZW5qYW1pbkBz
aXBzb2x1dGlvbnMubmV0PiB3cm90ZToKPgo+IFRoZXNlIGZlYXR1cmVzIGhhdmUgZXhpc3RlZCBz
aW5jZSBMaW51eCAyLjYuMTQgYW5kIGNhbiBiZSBjb25zaWRlcmVkCj4gd2lkZWx5IGF2YWlsYWJs
ZSBhdCB0aGlzIHBvaW50LgoKWy4uLl0KCj4gLSNpZm5kZWYgUFRSQUNFX1NZU0VNVQo+IC0jZGVm
aW5lIFBUUkFDRV9TWVNFTVUgMzEKPiAtI2VuZGlmCj4gLSNpZm5kZWYgUFRSQUNFX1NZU0VNVV9T
SU5HTEVTVEVQCj4gLSNkZWZpbmUgUFRSQUNFX1NZU0VNVV9TSU5HTEVTVEVQIDMyCj4gLSNlbmRp
ZgoKV2hlcmUgZGlkIHlvdSB0ZXN0IHRoaXM/IE9uIG15IE9wZW5TVVNFIDE1LjIgbWFjaGluZSB0
aGlzIGNoYW5nZQpjYXVzZXMgYSBidWlsZCBmYWlsdXJlLgoKYXJjaC91bS9vcy1MaW51eC9zdGFy
dF91cC5jOiBJbiBmdW5jdGlvbiDigJhjaGVja19zeXNlbXXigJk6CmFyY2gvdW0vb3MtTGludXgv
c3RhcnRfdXAuYzoxNTM6MTQ6IGVycm9yOiDigJhQVFJBQ0VfU1lTRU1VX1NJTkdMRVNURVDigJkK
dW5kZWNsYXJlZCAoZmlyc3QgdXNlIGluIHRoaXMgZnVuY3Rpb24pOyBkaWQgeW91IG1lYW4K4oCY
UFRSQUNFX1NJTkdMRVNURVDigJk/CiAgIGlmIChwdHJhY2UoUFRSQUNFX1NZU0VNVV9TSU5HTEVT
VEVQLCBwaWQsIDAsIDApIDwgMCkKICAgICAgICAgICAgICBefn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn4KICAgICAgICAgICAgICBQVFJBQ0VfU0lOR0xFU1RFUAoKSSB0aGluayB3ZSBuZWVkIHRvIGNh
cmVmdWxseSBpbmNsdWRlIHRoZSByaWdodCBhc20gaGVhZGVycy4KCi0tIApUaGFua3MsCi8vcmlj
aGFyZAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGlu
dXgtdW0gbWFpbGluZyBsaXN0CmxpbnV4LXVtQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xp
c3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC11bQo=

