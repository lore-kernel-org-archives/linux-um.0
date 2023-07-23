Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF004C001E0
	for <linux-um@archiver.kernel.org>; Sun, 23 Jul 2023 05:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cbQ2fRqHyXmMSgBpETmH/jT+19W/b/hHC7HDjNggGmA=; b=DP9+DanjslVo2K
	Mh9i6ZGwdOdaKTLWl9pdW7WYKmZh7x9Q32EIl8WCJUGiwBG8soOKk8aQNkGVIjof62hGY4+mTfFzQ
	f/RePZvBYEmRPkoJotscHOXlrL/tUB3ZvabX8eDks0WXkuJtc8ui5gljQWKnbEgWlDHDqg6aX5yRU
	qzO32KO55p/8QtydAYuGsf/tXu8qBgnNTgS3zj6AQ9IoTJ/t86+4B3/Dhine4O1fbshjdwI+i4XD9
	S7xUL87YeBtSLgKB7sTQawme6JWbtW0ktu3MYxjWMJhKzcR01k0eFWDYrYuAh6V+Yf4MZFXXc2nCA
	BecUJIUNSFO2w0uLsojg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qNRTC-000Ncv-24;
	Sun, 23 Jul 2023 05:17:26 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qNRTA-000NbD-1U
	for linux-um@lists.infradead.org;
	Sun, 23 Jul 2023 05:17:25 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id D8A6960C37
	for <linux-um@lists.infradead.org>; Sun, 23 Jul 2023 05:17:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4509AC433D9
	for <linux-um@lists.infradead.org>; Sun, 23 Jul 2023 05:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690089435;
	bh=vY3zNiZph0FPTgkavHQidnVxVAFy5p+UdrH06drBU+s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=p9qL+IKIRulGqw9cN1IuDyeAN9+OnG+wIcxYq47SgU74c/+wmxKFJ5UTuYZItypom
	 oTIWwh/7p2uhuKfN/6Rr7H5+wMod1ubgZOE6saO0JZYLncfXTqThYSTqNC67EGaP1Y
	 LCpgfPJYpI72gXbJJpiIbhxnVyR9wpjXPJfRHOSx0lj3QpvyZLXXLWq78ib9cUjWHA
	 y7CJOMBsdibcUeOXo0NcWSjd+/x1nDIR6g1PPghF1e467/S16HTJoiKIAOJPlQj6yD
	 L3L0HB9eGXIkF12seVYyUT50i/u6W3eRG4Zhqe30NNyt4DsytTJ5q7srFpIjW/fh9g
	 pAC40EwKbx5KA==
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5634808e16eso2076669eaf.2
        for <linux-um@lists.infradead.org>; Sat, 22 Jul 2023 22:17:15 -0700 (PDT)
X-Gm-Message-State: ABy/qLa7NCTiCm+ashMucoWnymUi1fEK0T8EdPiuRdU9x3raH9FCyLeP
	0VCRzGUOa+K4Aft9WlmE/tjk+9j1SIf3RrtZmwQ=
X-Google-Smtp-Source: APBJJlGYYAujjAjTIpMk4wamTm8HUwIM2sfuCn7LDBIQfhMB3gIz6tuqw/zXHC9zy9YdIwYukciDEhv1Th3vTRMMlss=
X-Received: by 2002:a4a:868c:0:b0:566:ef1e:f11c with SMTP id
 x12-20020a4a868c000000b00566ef1ef11cmr4008103ooh.3.1690089434511; Sat, 22 Jul
 2023 22:17:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230722202548.24746-1-rdunlap@infradead.org>
In-Reply-To: <20230722202548.24746-1-rdunlap@infradead.org>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sun, 23 Jul 2023 14:16:38 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS8R3Kzvu6Fvn3RkspgR2EkSmt9EzLOqsaOiq1=-S8eVw@mail.gmail.com>
Message-ID: <CAK7LNAS8R3Kzvu6Fvn3RkspgR2EkSmt9EzLOqsaOiq1=-S8eVw@mail.gmail.com>
Subject: Re: [PATCH] um/drivers: Kconfig: fix hostaudio build errors
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org, 
	Tejun Heo <tj@kernel.org>, Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Nicolas Schier <nicolas@fjasle.eu>, linux-kbuild@vger.kernel.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230722_221724_631181_B156DAD0 
X-CRM114-Status: GOOD (  19.41  )
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

T24gU3VuLCBKdWwgMjMsIDIwMjMgYXQgNToyNeKAr0FNIFJhbmR5IER1bmxhcCA8cmR1bmxhcEBp
bmZyYWRlYWQub3JnPiB3cm90ZToKPgo+IFVzZSAic2VsZWN0InMgdG8gZW5zdXJlIHRoYXQgdGhl
IHJlcXVpcmVkIGtjb25maWcgc3ltYm9scyBhcmUgc2V0Cj4gYXMgZXhwZWN0ZWQuCj4KPiBUaGlz
IGZpeGVzIGJ1aWxkIGVycm9ycyB3aGVuIENPTkZJR19TT1VORCBpcyBub3Qgc2V0Lgo+Cj4gbGQ6
IGFyY2gvdW0vZHJpdmVycy9ob3N0YXVkaW9fa2Vybi5vOiBpbiBmdW5jdGlvbiBgaG9zdGF1ZGlv
X2NsZWFudXBfbW9kdWxlJzoKPiBob3N0YXVkaW9fa2Vybi5jOiguZXhpdC50ZXh0KzB4YSk6IHVu
ZGVmaW5lZCByZWZlcmVuY2UgdG8gYHVucmVnaXN0ZXJfc291bmRfbWl4ZXInCj4gbGQ6IGhvc3Rh
dWRpb19rZXJuLmM6KC5leGl0LnRleHQrMHgxNSk6IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8gYHVu
cmVnaXN0ZXJfc291bmRfZHNwJwo+IGxkOiBhcmNoL3VtL2RyaXZlcnMvaG9zdGF1ZGlvX2tlcm4u
bzogaW4gZnVuY3Rpb24gYGhvc3RhdWRpb19pbml0X21vZHVsZSc6Cj4gaG9zdGF1ZGlvX2tlcm4u
YzooLmluaXQudGV4dCsweDE5KTogdW5kZWZpbmVkIHJlZmVyZW5jZSB0byBgcmVnaXN0ZXJfc291
bmRfZHNwJwo+IGxkOiBob3N0YXVkaW9fa2Vybi5jOiguaW5pdC50ZXh0KzB4MzEpOiB1bmRlZmlu
ZWQgcmVmZXJlbmNlIHRvIGByZWdpc3Rlcl9zb3VuZF9taXhlcicKPiBsZDogaG9zdGF1ZGlvX2tl
cm4uYzooLmluaXQudGV4dCsweDQ5KTogdW5kZWZpbmVkIHJlZmVyZW5jZSB0byBgdW5yZWdpc3Rl
cl9zb3VuZF9kc3AnCj4KPiBGaXhlczogMWRhMTc3ZTRjM2Y0ICgiTGludXgtMi42LjEyLXJjMiIp
Cj4gRml4ZXM6IGQ4ODZlODdjYjgyYiAoInNvdW5kOiBtYWtlIE9TUyBzb3VuZCBjb3JlIG9wdGlv
bmFsIikKPiBTaWduZWQtb2ZmLWJ5OiBSYW5keSBEdW5sYXAgPHJkdW5sYXBAaW5mcmFkZWFkLm9y
Zz4KPiBSZXBvcnRlZC1ieToga2VybmVsIHRlc3Qgcm9ib3QgPGxrcEBpbnRlbC5jb20+Cj4gTGlu
azogbG9yZS5rZXJuZWwub3JnL3IvMjAyMzA3MTQxNDE2LnZ4dVJWcEZ2LWxrcEBpbnRlbC5jb20K
PiBDYzogUmljaGFyZCBXZWluYmVyZ2VyIDxyaWNoYXJkQG5vZC5hdD4KPiBDYzogQW50b24gSXZh
bm92IDxhbnRvbi5pdmFub3ZAY2FtYnJpZGdlZ3JleXMuY29tPgo+IENjOiBKb2hhbm5lcyBCZXJn
IDxqb2hhbm5lc0BzaXBzb2x1dGlvbnMubmV0Pgo+IENjOiBsaW51eC11bUBsaXN0cy5pbmZyYWRl
YWQub3JnCj4gQ2M6IFRlanVuIEhlbyA8dGpAa2VybmVsLm9yZz4KPiBDYzogVGFrYXNoaSBJd2Fp
IDx0aXdhaUBzdXNlLmRlPgo+IENjOiBKYXJvc2xhdiBLeXNlbGEgPHBlcmV4QHBlcmV4LmN6Pgo+
IENjOiBNYXNhaGlybyBZYW1hZGEgPG1hc2FoaXJveUBrZXJuZWwub3JnPgo+IENjOiBOYXRoYW4g
Q2hhbmNlbGxvciA8bmF0aGFuQGtlcm5lbC5vcmc+Cj4gQ2M6IE5pY2sgRGVzYXVsbmllcnMgPG5k
ZXNhdWxuaWVyc0Bnb29nbGUuY29tPgo+IENjOiBOaWNvbGFzIFNjaGllciA8bmljb2xhc0BmamFz
bGUuZXU+Cj4gQ2M6IGxpbnV4LWtidWlsZEB2Z2VyLmtlcm5lbC5vcmcKPiAtLS0KPiAgYXJjaC91
bS9kcml2ZXJzL0tjb25maWcgfCAgIDE1ICsrKy0tLS0tLS0tLS0tLQo+ICAxIGZpbGUgY2hhbmdl
ZCwgMyBpbnNlcnRpb25zKCspLCAxMiBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS0gYS9hcmNoL3Vt
L2RyaXZlcnMvS2NvbmZpZyBiL2FyY2gvdW0vZHJpdmVycy9LY29uZmlnCj4gLS0tIGEvYXJjaC91
bS9kcml2ZXJzL0tjb25maWcKPiArKysgYi9hcmNoL3VtL2RyaXZlcnMvS2NvbmZpZwo+IEBAIC0x
MTEsMjQgKzExMSwxNSBAQCBjb25maWcgU1NMX0NIQU4KPgo+ICBjb25maWcgVU1MX1NPVU5ECj4g
ICAgICAgICB0cmlzdGF0ZSAiU291bmQgc3VwcG9ydCIKPiArICAgICAgIHNlbGVjdCBTT1VORAo+
ICsgICAgICAgc2VsZWN0IFNPVU5EX09TU19DT1JFCj4gKyAgICAgICBzZWxlY3QgSE9TVEFVRElP
Cj4gICAgICAgICBoZWxwCj4gICAgICAgICAgIFRoaXMgb3B0aW9uIGVuYWJsZXMgVU1MIHNvdW5k
IHN1cHBvcnQuICBJZiBlbmFibGVkLCBpdCB3aWxsIHB1bGwgaW4KPiAgICAgICAgICAgc291bmRj
b3JlIGFuZCB0aGUgVU1MIGhvc3RhdWRpbyByZWxheSwgd2hpY2ggYWN0cyBhcyBhIGludGVybWVk
aWFyeQo+ICAgICAgICAgICBiZXR3ZWVuIHRoZSBob3N0J3MgZHNwIGFuZCBtaXhlciBkZXZpY2Vz
IGFuZCB0aGUgVU1MIHNvdW5kIHN5c3RlbS4KPiAgICAgICAgICAgSXQgaXMgc2FmZSB0byBzYXkg
J1knIGhlcmUuCj4KPiAtY29uZmlnIFNPVU5ECj4gLSAgICAgICB0cmlzdGF0ZQo+IC0gICAgICAg
ZGVmYXVsdCBVTUxfU09VTkQKPiAtCj4gLWNvbmZpZyBTT1VORF9PU1NfQ09SRQo+IC0gICAgICAg
Ym9vbAo+IC0gICAgICAgZGVmYXVsdCBVTUxfU09VTkQKClllYWgsIHRoZXNlIHR3byBzaG91bGQg
YmUgcmVtb3ZlZApiZWNhdXNlIHRoZXkgZXhpc3QgaW4gc291bmQvS2NvbmZpZy4KCgo+IC0KPiAt
Y29uZmlnIEhPU1RBVURJTwo+IC0gICAgICAgdHJpc3RhdGUKPiAtICAgICAgIGRlZmF1bHQgVU1M
X1NPVU5ECgoKWW91IG5lZWQgdG8ga2VlcCB0aGlzLCBvdGhlcndpc2UKdGhlcmUgaXMgbm8gZW50
cnkgYW55d2hlcmUuCgoKCgo+IC0KPiAgZW5kbWVudQo+Cj4gIG1lbnUgIlVNTCBOZXR3b3JrIERl
dmljZXMiCgoKCi0tCkJlc3QgUmVnYXJkcwpNYXNhaGlybyBZYW1hZGEKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LXVtIG1haWxpbmcgbGlzdAps
aW51eC11bUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21h
aWxtYW4vbGlzdGluZm8vbGludXgtdW0K
