Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E01CAC001B0
	for <linux-um@archiver.kernel.org>; Tue,  8 Aug 2023 17:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=57UKec95MAgry9faITzQhKveG167IdRnr07RTGcCfkM=; b=hZV8uDN+nSn2VT
	4osiUigAUlq3MLl/FxqlM9tYzyacLGZusmtJO/iQ3tBKm0kO+h1hqzKIQlEDNm5mV3WBEOzbfEFBT
	rVrVCJH7MtqqsOjcD384kEit/vRiStJd84MLkfDaKSKquF8+YdMFxBVQ+EAgkij8nqxX0R1fpCYa0
	BGc+KMTKSCwo8/tMpaiMD//sLUQNsST5/gQtSfAOnwCPumpHcTPPv3XgBCNMjlqy6O6qiAMVgK43F
	zfZ5Wsieo2RoAprRAdo72nBZE6LDQUj8OFaQymBf6b3E1SNEZaBAm8bENzQoVUzuBVY/zoJKfdv4b
	VrMDxYH+ZZjSGrCpszyQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qTQWH-0037vt-08;
	Tue, 08 Aug 2023 17:29:21 +0000
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qTQWE-0037uK-0X
	for linux-um@lists.infradead.org;
	Tue, 08 Aug 2023 17:29:19 +0000
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-5234dee9a44so366232a12.2
        for <linux-um@lists.infradead.org>; Tue, 08 Aug 2023 10:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691515751; x=1692120551;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YRTbpdHAIcRAL+8fbnX37iDC0EoRIyOQNOdvRt+62Lw=;
        b=DjSyFc466XoPSs0e4ymkKPotfNOOJUf3A/2g6OKlGaTDH+SXaR4NO50LD/IYycgHTF
         N9mN3rzd3YJmnjIv9fJ5OgRtc6kekPPBeKf5DMt9ndXAndHPlyx/cUClBh6XFMRqqLje
         AM2jZaunxmXmUQM4lwfPzIKrvE0WXYl+0S7o3dRSIuANPYbwqYWHil6HtsQn9VYH7z80
         /G0LjfAYWzzjZObiVaDalPjtPAeu+o2LKeE89g9rgNT2fHXdXNCdEiLeH3H8OCOn7AmE
         Mtg5LGfxbYIUcT9VxoaxHAfC2AgSsv8kfzMZwyezLYE9MzugxFsDembayZDf9GZE79pr
         IKrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691515751; x=1692120551;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YRTbpdHAIcRAL+8fbnX37iDC0EoRIyOQNOdvRt+62Lw=;
        b=W26dJFSKnDPYcviTy5k8pUpbZtXMKWAbjWtaVE0dzSt5skmsjNoSNePwMNN4HQYxSh
         DzmdsQGVh6FJZW4tTDAnz2GdkIiA/Mw6OMV4zg7Y3lJYQZkwFp65ate3yS/JTRAJR9Wk
         g+ds8ApWTw1eIuDB1rlOwaFg2DDBwsp+jIv0xllT0My0UvU25j3vQYFEYU+qk7dr5LRQ
         HlPqzAi7Qr2uJlZcfy0ztuYJQVtSzQHAkdZ/9jOrIDiU5/Y9fnqjodBaz+Ap2Kw2QCnm
         9rrOkWyoLZiPTTQnUMmn1qXPb8meNUtDDhtwBl2Vu2pGL2D03ZZ5rkd6DPgQD9shKnbE
         fnzA==
X-Gm-Message-State: AOJu0YzdrWXHVy2MGPFO2eIqg0gXjFICXnGyheELV/7p/GP/mCVYycPu
	Eglh73jvAFmrx60QG6vKJiY4yVaDk3bbwwfG5zAsYbXqwEI/eZyZl3VpW7gG
X-Google-Smtp-Source: AGHT+IEj9jsvS5MROtkM+IvgsvU8cU1CnN/c3z5EIcbbMeYA6EJeqykx7Eu9avENEdzUbqBt4ia3FKkcPXu7iENsbGg=
X-Received: by 2002:aa7:d84b:0:b0:523:366b:9cb4 with SMTP id
 f11-20020aa7d84b000000b00523366b9cb4mr459388eds.1.1691515751068; Tue, 08 Aug
 2023 10:29:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230807-arch-um-v1-1-86dbbfb59709@google.com>
 <CAGG=3QVUqVdkzBo-=vGWprPBUhuV8p3bRSx3Qsvtqx_LDct05w@mail.gmail.com> <202308071636.AF290F0@keescook>
In-Reply-To: <202308071636.AF290F0@keescook>
From: Justin Stitt <justinstitt@google.com>
Date: Tue, 8 Aug 2023 10:28:57 -0700
Message-ID: <CAFhGd8oSGJ5=fk58wOSgbuXX_VaP14q0Re=Xfom=rdOR6fT1rQ@mail.gmail.com>
Subject: Re: [PATCH] um: refactor deprecated strncpy to strtomem
To: Kees Cook <keescook@chromium.org>
Cc: Bill Wendling <morbo@google.com>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	linux-hardening@vger.kernel.org, linux-um@lists.infradead.org, 
	linux-kernel@vger.kernel.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230808_102918_202422_C86CB77A 
X-CRM114-Status: GOOD (  31.40  )
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
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
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

T24gTW9uLCBBdWcgNywgMjAyMyBhdCA0OjQw4oCvUE0gS2VlcyBDb29rIDxrZWVzY29va0BjaHJv
bWl1bS5vcmc+IHdyb3RlOgo+Cj4gT24gTW9uLCBBdWcgMDcsIDIwMjMgYXQgMDM6MzY6NTVQTSAt
MDcwMCwgQmlsbCBXZW5kbGluZyB3cm90ZToKPiA+IE9uIE1vbiwgQXVnIDcsIDIwMjMgYXQgMjox
OOKAr1BNIEp1c3RpbiBTdGl0dCA8anVzdGluc3RpdHRAZ29vZ2xlLmNvbT4gd3JvdGU6Cj4gPiA+
Cj4gPiA+IFVzZSBgc3RydG9tZW1gIGhlcmUgc2luY2UgYGNvbnNvbGVfYnVmYCBpcyBub3QgZXhw
ZWN0ZWQgdG8gYmUKPiA+ID4gTlVMLXRlcm1pbmF0ZWQuIFdlIHNob3VsZCBwcm9iYWJseSBhbHNv
IGp1c3QgdXNlIGBNQ09OU09MRV9NQVhfREFUQWAKPgo+IEhvdyBpcyBpdCBrbm93biB0aGF0IGNv
bnNvbGVfYnVmIGlzIG5vdCBhIEMtc3RyaW5nPwpUaGVyZSBhcmUgYSBmZXcgY2x1ZXMgdGhhdCBs
ZWQgbWUgdG8gYmVsaWV2ZSBjb25zb2xlX2J1ZiB3YXMgbm90IGEgQy1zdHJpbmc6CjEpICBgbiA9
IG1pbigoc2l6ZV90KSBsZW4sIEFSUkFZX1NJWkUoY29uc29sZV9idWYpKTtgIG1lYW5zIHRoYXQg
YG5gCmNhbiBiZSBlcXVhbCB0byBzaXplIG9mIGJ1ZmZlciB3aGljaCBpcyB0aGVuIHN1YnNlcXVl
bnRseSBmaWxsZWQKZW50aXJlbHkgYnkgdGhlIGBzdHJuY3B5YCBpbnZvY2F0aW9uLgoyKSBjb25z
b2xlX2J1ZiBsb29rcyB0byBiZSBhIGNpcmN1bGFyIGJ1ZmZlciB3aGVyZWluIG9uY2UgaXQncyBm
aWxsZWQKaXQgc3RhcnRzIGFnYWluIGZyb20gdGhlIGJlZ2lubmluZy4KMykgQVJSQVlfU0laRSBp
cyB1c2VkIG9uIGl0IGFzIG9wcG9zZWQgdG8gc3RybGVuIG9yIHNvbWV0aGluZyBsaWtlCnRoYXQg
KGJ1dCBub3Qgc3VyZSBpZiBBUlJBWV9TSVpFIGlzIGFsc28gdXNlZCBvbiBDLXN0cmluZ3MgdG8g
YmUgZmFpcikKNCkgSXQgaGFzIGBidWZgIGluIGl0cyBuYW1lIHdoaWNoIEkgbG9vc2VseSBhc3Nv
Y2lhdGUgd2l0aCBub24KQy1zdHJpbmdzIGNoYXIgYnVmZmVycy4KCkFsbCBpbiBhbGwsIGl0IGxv
b2tzIHRvIGJlIGEgbm9uIEMtc3RyaW5nIGJ1dCBob25lc3RseSBpdCdzIGhhcmQgdG8KdGVsbCwg
ZXNwZWNpYWxseSBzaW5jZSBpZiBpdCBJUyBhIEMtc3RyaW5nIHRoZSBwcmV2aW91cyBpbXBsZW1l
bnRhdGlvbgpoYWQgc29tZSBidWdzIHdpdGggc3RybmNweSBJIGJlbGlldmUuCgo+Cj4gPiA+IGlu
c3RlYWQgb2YgdXNpbmcgYEFSUkFZX1NJWkUoKWAgZm9yIGV2ZXJ5IGl0ZXJhdGlvbiBvZiB0aGUg
bG9vcC4KPiA+ID4KPiA+IElzIHRoaXMgY2hhbmdlIG5lY2Vzc2FyeT8gSSBoYXZlIGEgZ2VuZXJh
bCBwcmVmZXJlbmNlIGZvciBBUlJBWV9TSVpFLAo+ID4gYmVjYXVzZSBhIGNoYW5nZSBpbiBzaXpl
IGlzIGxlc3MgbGlrZWx5IHRvIGJlIG92ZXJsb29rZWQgKHVubGVzcyB0aGF0Cj4gPiBnb2VzIGFn
YWluc3QgdGhlIGNvZGluZyBzdGFuZGFyZCkuCj4KPiBJIHdvdWxkIHByZWZlciB0aGlzIHN0YXkg
ZWl0aGVyIEFSUkFZX1NJWkUgb3Igc2l6ZW9mLCBhcyBpdCBrZWVwcyBpdAo+IHRpZWQgdG8gdGhl
IHZhcmlhYmxlIGluIHF1ZXN0aW9uLgo+Cj4gPgo+ID4gPiBBbHNvIG1hcmsgY2hhciBidWZmZXIg
YXMgYF9fbm9uc3RyaW5nYCBhcyBwZXIgS2Vlcycgc3VnZ2VzdGlvbiBoZXJlIFsxXQo+ID4gPgo+
ID4gPiBGaW5hbGx5LCBmb2xsb3cgY2hlY2twYXRjaCdzIHJlY29tbWVuZGF0aW9uIG9mIHVzaW5n
IGBtaW5fdGAgb3ZlciBgbWluYAo+ID4gPgo+ID4gPiBMaW5rOiBodHRwczovL2dpdGh1Yi5jb20v
S1NQUC9saW51eC9pc3N1ZXMvOTAgWzFdCj4gPiA+IENjOiBsaW51eC1oYXJkZW5pbmdAdmdlci5r
ZXJuZWwub3JnCj4gPiA+IFNpZ25lZC1vZmYtYnk6IEp1c3RpbiBTdGl0dCA8anVzdGluc3RpdHRA
Z29vZ2xlLmNvbT4KPiA+ID4gLS0tCj4gPiA+IE5vdGVzOgo+ID4gPiBJIG9ubHkgYnVpbGQgdGVz
dGVkIHRoaXMgcGF0Y2guCj4gPiA+IC0tLQo+ID4gPiAgYXJjaC91bS9kcml2ZXJzL21jb25zb2xl
X2tlcm4uYyB8IDcgKysrKy0tLQo+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygr
KSwgMyBkZWxldGlvbnMoLSkKPiA+ID4KPiA+ID4gZGlmZiAtLWdpdCBhL2FyY2gvdW0vZHJpdmVy
cy9tY29uc29sZV9rZXJuLmMgYi9hcmNoL3VtL2RyaXZlcnMvbWNvbnNvbGVfa2Vybi5jCj4gPiA+
IGluZGV4IDUwMjZlN2I5YWRmZS4uZmQ0YzAyNDIwMmFlIDEwMDY0NAo+ID4gPiAtLS0gYS9hcmNo
L3VtL2RyaXZlcnMvbWNvbnNvbGVfa2Vybi5jCj4gPiA+ICsrKyBiL2FyY2gvdW0vZHJpdmVycy9t
Y29uc29sZV9rZXJuLmMKPiA+ID4gQEAgLTQsNiArNCw3IEBACj4gPiA+ICAgKiBDb3B5cmlnaHQg
KEMpIDIwMDEgLSAyMDA4IEplZmYgRGlrZSAoamRpa2VAe2FkZHRvaXQsbGludXguaW50ZWx9LmNv
bSkKPiA+ID4gICAqLwo+ID4gPgo+ID4gPiArI2luY2x1ZGUgImxpbnV4L2NvbXBpbGVyX2F0dHJp
YnV0ZXMuaCIKPiA+Cj4gPiBuaXQ6IFNob3VsZCB0aGlzIGluY2x1ZGUgYmUgaW4gYW5nbGUgYnJh
Y2tldHM/Cj4gPgo+ID4gI2luY2x1ZGUgPGxpbnV4L2NvbXBpbGVyX2F0dHJpYnV0ZXMuaD4KPgo+
IFRydWUsIHRob3VnaCB0aGlzIHNob3VsZG4ndCBuZWVkIHRvIGJlIGluY2x1ZGVkIGF0IGFsbC4g
V2hhdCB3YXMKPiBtaXNzaW5nPwo+Cj4gPgo+ID4gPiAgI2luY2x1ZGUgPGxpbnV4L2NvbnNvbGUu
aD4KPiA+ID4gICNpbmNsdWRlIDxsaW51eC9jdHlwZS5oPgo+ID4gPiAgI2luY2x1ZGUgPGxpbnV4
L3N0cmluZy5oPgo+ID4gPiBAQCAtNTU0LDcgKzU1NSw3IEBAIHN0cnVjdCBtY29uc29sZV9vdXRw
dXQgewo+ID4gPgo+ID4gPiAgc3RhdGljIERFRklORV9TUElOTE9DSyhjbGllbnRfbG9jayk7Cj4g
PiA+ICBzdGF0aWMgTElTVF9IRUFEKGNsaWVudHMpOwo+ID4gPiAtc3RhdGljIGNoYXIgY29uc29s
ZV9idWZbTUNPTlNPTEVfTUFYX0RBVEFdOwo+ID4gPiArc3RhdGljIGNoYXIgY29uc29sZV9idWZb
TUNPTlNPTEVfTUFYX0RBVEFdIF9fbm9uc3RyaW5nOwo+ID4gPgo+ID4gPiAgc3RhdGljIHZvaWQg
Y29uc29sZV93cml0ZShzdHJ1Y3QgY29uc29sZSAqY29uc29sZSwgY29uc3QgY2hhciAqc3RyaW5n
LAo+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgIHVuc2lnbmVkIGludCBsZW4pCj4gPiA+
IEBAIC01NjYsOCArNTY3LDggQEAgc3RhdGljIHZvaWQgY29uc29sZV93cml0ZShzdHJ1Y3QgY29u
c29sZSAqY29uc29sZSwgY29uc3QgY2hhciAqc3RyaW5nLAo+ID4gPiAgICAgICAgICAgICAgICAg
cmV0dXJuOwo+ID4gPgo+ID4gPiAgICAgICAgIHdoaWxlIChsZW4gPiAwKSB7Cj4gPiA+IC0gICAg
ICAgICAgICAgICBuID0gbWluKChzaXplX3QpIGxlbiwgQVJSQVlfU0laRShjb25zb2xlX2J1Zikp
Owo+ID4gPiAtICAgICAgICAgICAgICAgc3RybmNweShjb25zb2xlX2J1Ziwgc3RyaW5nLCBuKTsK
PiA+ID4gKyAgICAgICAgICAgICAgIG4gPSBtaW5fdChzaXplX3QsIGxlbiwgTUNPTlNPTEVfTUFY
X0RBVEEpOwo+ID4gPiArICAgICAgICAgICAgICAgc3RydG9tZW0oY29uc29sZV9idWYsIHN0cmlu
Zyk7Cj4gPiA+ICAgICAgICAgICAgICAgICBzdHJpbmcgKz0gbjsKPiA+ID4gICAgICAgICAgICAg
ICAgIGxlbiAtPSBuOwo+ID4gPgo+ID4gPgo+ID4gPiAtLS0KPiA+ID4gYmFzZS1jb21taXQ6IGMx
YTUxNWQzYzAyNzA2MjhkZjhhZTVmNTExOGJhODU5Yjg1NDY0YTIKPiA+ID4gY2hhbmdlLWlkOiAy
MDIzMDgwNy1hcmNoLXVtLTNlZjI0NDEzNDI3ZQo+ID4gPgo+ID4gPiBCZXN0IHJlZ2FyZHMsCj4g
PiA+IC0tCj4gPiA+IEp1c3RpbiBTdGl0dCA8anVzdGluc3RpdHRAZ29vZ2xlLmNvbT4KPiA+ID4K
Pgo+IC0tCj4gS2VlcyBDb29rCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpsaW51eC11bSBtYWlsaW5nIGxpc3QKbGludXgtdW1AbGlzdHMuaW5mcmFkZWFk
Lm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LXVt
Cg==
