Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF1D8C001DE
	for <linux-um@archiver.kernel.org>; Fri, 28 Jul 2023 08:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=B+/rQ+rMOCbyoQTmjNq5AB3C5rPcg/KI0IIUKycbS8o=; b=A1eCzF7g6eOPJ5
	KzeFgCUwoDXBukY3b9XiaUKFWtna95mXNoZ0sgCbnpkeMOoN76ZSNkT1kHqEOZD3AryUPrCbPztRX
	jKG+C5FCe1v7mbJLI1UXTHwRgNEvnHBKunaEu/k8JINjW6kYkITp+VKhkT/Cx/HYH58iQ15alLoLv
	AZ0lW4FRiiRDQGGKxoXr1NDyORnOqxA0B9jSWGzgTv/viP/fB0jI39cNT07zny87jKtvOSn15m/+s
	lgCWz4LEucdR5Tda0sZbmgz0d2P2NJLxkddwopt32j777EDsOmhsbptHO3JvK1Uz/aKuGdfepYNr6
	cBYyGcCHxkrqJdMsUULg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qPJCp-002TVF-0l;
	Fri, 28 Jul 2023 08:52:15 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qPJCh-002TUP-23
	for linux-um@lists.infradead.org;
	Fri, 28 Jul 2023 08:52:09 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 86D7762071
	for <linux-um@lists.infradead.org>; Fri, 28 Jul 2023 08:52:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A713C433CA
	for <linux-um@lists.infradead.org>; Fri, 28 Jul 2023 08:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690534325;
	bh=vlJpUCrv2ALxslQErLAhvVvaZrwz4OsGjEvmf2Y+iu0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CBi6cn4Lj2WE+3ndu8ojTuLCbCpK7Pkmx9A6xtinX0HCBOZXhEZF98ugJzTOeLFAu
	 +0XMAZNEYpti4YI8V6nchFBp+xpcfTWTHZps6mKo9/8VGwdADXksAATF9qh3LJsTTB
	 /h1qfr19Z4W4JEDvguLAMduLZRTpPYOcqcmk0arqtOaHQwE4cvmDthraAt5bzOw9M1
	 aVv1xh2gTuR7awDFF4SXPauublFBaHAFoLy+vhYC3DRRLSTVPs3IJz2RFLX2+HnKdc
	 qKaF7MGOAQHIF057Hd7Wa1bbsBT16hXTF2FulnhU0N3iOGJXgPcvq03ROV6GFoLYK6
	 tIfGzXbc2MbVA==
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3a3fbfb616dso1453638b6e.3
        for <linux-um@lists.infradead.org>; Fri, 28 Jul 2023 01:52:05 -0700 (PDT)
X-Gm-Message-State: ABy/qLbApdermBXgmQjKC2+XMr/nMIuWgWVbiO5EMiMSN5qqS3XUlHZ2
	qN7+giRLLuUzozYV0tlGBgoXlVmo8nP4rqWgs28=
X-Google-Smtp-Source: APBJJlHDe8hfWrxF/nfBaQSGuEQ6bNQXuA7hrJmGUDKgzOxljYyC1ls87OOK7YRy0OrT3TlhYCmy7eRtQ7kYiLbq06Q=
X-Received: by 2002:a54:400b:0:b0:3a3:ed22:6b51 with SMTP id
 x11-20020a54400b000000b003a3ed226b51mr2282641oie.50.1690534324598; Fri, 28
 Jul 2023 01:52:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230728043013.27776-1-rdunlap@infradead.org>
In-Reply-To: <20230728043013.27776-1-rdunlap@infradead.org>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Fri, 28 Jul 2023 17:51:27 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR4BkAKhZZ8+Zybed3Jm3omxzzdgus-Nqj-9MjWAeSmiA@mail.gmail.com>
Message-ID: <CAK7LNAR4BkAKhZZ8+Zybed3Jm3omxzzdgus-Nqj-9MjWAeSmiA@mail.gmail.com>
Subject: Re: [PATCH v3] um/drivers: fix hostaudio build errors
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org, 
	Tejun Heo <tj@kernel.org>, Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Nicolas Schier <nicolas@fjasle.eu>, linux-kbuild@vger.kernel.org, 
	alsa-devel@alsa-project.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230728_015207_777739_2FFE7843 
X-CRM114-Status: GOOD (  22.13  )
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

T24gRnJpLCBKdWwgMjgsIDIwMjMgYXQgMTozMOKAr1BNIFJhbmR5IER1bmxhcCA8cmR1bmxhcEBp
bmZyYWRlYWQub3JnPiB3cm90ZToKPgo+IFVzZSAic2VsZWN0InMgdG8gZW5zdXJlIHRoYXQgdGhl
IHJlcXVpcmVkIGtjb25maWcgc3ltYm9scyBhcmUgc2V0Cj4gYXMgZXhwZWN0ZWQuCj4gRHJvcCBI
T1NUQVVESU8gc2luY2UgaXQgaXMgbm93IGVxdWl2YWxlbnQgdG8gVU1MX1NPVU5ELgo+Cj4gQWxs
b3cgU09VTkQgd2l0aCBVTUwgcmVnYXJkbGVzcyBvZiBIQVNfSU9NRU0uIE90aGVyd2lzZSB0aGVy
ZSBpcyBhCj4ga2NvbmZpZyB3YXJuaW5nIGZvciB1bm1ldCBkZXBlbmRlbmNpZXMuIChUaGlzIHdh
cyBub3QgYW4gaXNzdWUgd2hlbgo+IFNPVU5EIHdhcyBkZWZpbmVkIGluIGFyY2gvdW0vZHJpdmVy
cy9LY29uZmlnLiBJIGhhdmUgZG9uZSA1MCByYW5kY29uZmlnCj4gYnVpbGRzIGFuZCBkaWRuJ3Qg
ZmluZCBhbnkgaXNzdWVzLikKPgo+IFRoaXMgZml4ZXMgYnVpbGQgZXJyb3JzIHdoZW4gQ09ORklH
X1NPVU5EIGlzIG5vdCBzZXQ6Cj4KPiBsZDogYXJjaC91bS9kcml2ZXJzL2hvc3RhdWRpb19rZXJu
Lm86IGluIGZ1bmN0aW9uIGBob3N0YXVkaW9fY2xlYW51cF9tb2R1bGUnOgo+IGhvc3RhdWRpb19r
ZXJuLmM6KC5leGl0LnRleHQrMHhhKTogdW5kZWZpbmVkIHJlZmVyZW5jZSB0byBgdW5yZWdpc3Rl
cl9zb3VuZF9taXhlcicKPiBsZDogaG9zdGF1ZGlvX2tlcm4uYzooLmV4aXQudGV4dCsweDE1KTog
dW5kZWZpbmVkIHJlZmVyZW5jZSB0byBgdW5yZWdpc3Rlcl9zb3VuZF9kc3AnCj4gbGQ6IGFyY2gv
dW0vZHJpdmVycy9ob3N0YXVkaW9fa2Vybi5vOiBpbiBmdW5jdGlvbiBgaG9zdGF1ZGlvX2luaXRf
bW9kdWxlJzoKPiBob3N0YXVkaW9fa2Vybi5jOiguaW5pdC50ZXh0KzB4MTkpOiB1bmRlZmluZWQg
cmVmZXJlbmNlIHRvIGByZWdpc3Rlcl9zb3VuZF9kc3AnCj4gbGQ6IGhvc3RhdWRpb19rZXJuLmM6
KC5pbml0LnRleHQrMHgzMSk6IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8gYHJlZ2lzdGVyX3NvdW5k
X21peGVyJwo+IGxkOiBob3N0YXVkaW9fa2Vybi5jOiguaW5pdC50ZXh0KzB4NDkpOiB1bmRlZmlu
ZWQgcmVmZXJlbmNlIHRvIGB1bnJlZ2lzdGVyX3NvdW5kX2RzcCcKPgo+IGFuZCB0aGlzIGtjb25m
aWcgd2FybmluZzoKPiBXQVJOSU5HOiB1bm1ldCBkaXJlY3QgZGVwZW5kZW5jaWVzIGRldGVjdGVk
IGZvciBTT1VORAo+Cj4gRml4ZXM6IDFkYTE3N2U0YzNmNCAoIkxpbnV4LTIuNi4xMi1yYzIiKQo+
IEZpeGVzOiBkODg2ZTg3Y2I4MmIgKCJzb3VuZDogbWFrZSBPU1Mgc291bmQgY29yZSBvcHRpb25h
bCIpCj4gU2lnbmVkLW9mZi1ieTogUmFuZHkgRHVubGFwIDxyZHVubGFwQGluZnJhZGVhZC5vcmc+
Cj4gUmVwb3J0ZWQtYnk6IGtlcm5lbCB0ZXN0IHJvYm90IDxsa3BAaW50ZWwuY29tPgo+IExpbms6
IGxvcmUua2VybmVsLm9yZy9yLzIwMjMwNzE0MTQxNi52eHVSVnBGdi1sa3BAaW50ZWwuY29tCj4g
Q2M6IFJpY2hhcmQgV2VpbmJlcmdlciA8cmljaGFyZEBub2QuYXQ+Cj4gQ2M6IEFudG9uIEl2YW5v
diA8YW50b24uaXZhbm92QGNhbWJyaWRnZWdyZXlzLmNvbT4KPiBDYzogSm9oYW5uZXMgQmVyZyA8
am9oYW5uZXNAc2lwc29sdXRpb25zLm5ldD4KPiBDYzogbGludXgtdW1AbGlzdHMuaW5mcmFkZWFk
Lm9yZwo+IENjOiBUZWp1biBIZW8gPHRqQGtlcm5lbC5vcmc+Cj4gQ2M6IFRha2FzaGkgSXdhaSA8
dGl3YWlAc3VzZS5kZT4KPiBDYzogSmFyb3NsYXYgS3lzZWxhIDxwZXJleEBwZXJleC5jej4KPiBD
YzogTWFzYWhpcm8gWWFtYWRhIDxtYXNhaGlyb3lAa2VybmVsLm9yZz4KPiBDYzogTmF0aGFuIENo
YW5jZWxsb3IgPG5hdGhhbkBrZXJuZWwub3JnPgo+IENjOiBOaWNrIERlc2F1bG5pZXJzIDxuZGVz
YXVsbmllcnNAZ29vZ2xlLmNvbT4KPiBDYzogTmljb2xhcyBTY2hpZXIgPG5pY29sYXNAZmphc2xl
LmV1Pgo+IENjOiBsaW51eC1rYnVpbGRAdmdlci5rZXJuZWwub3JnCj4gQ2M6IGFsc2EtZGV2ZWxA
YWxzYS1wcm9qZWN0Lm9yZwo+IC0tLQo+IHYyOiBkb24ndCBkZWxldGUgdGhlIEhPU1RBVURJTyBL
Y29uZmlnIGVudHJ5IChNYXNhaGlybykKPiB2MzogZHJvcCBIT1NUQVVESU8gYW5kIHVzZSBDT05G
SUdfVU1MX1NPVU5EIGZvciBpdCBpbiBNYWtlZmlsZSAoVGFrYXNoaSk7Cj4gICAgIGFkZCBTT1VO
RCBkZXBlbmRzIG9uICJ8fCBVTUwiIHRvIEhBU19JT01FTQo+Cj4gIGFyY2gvdW0vZHJpdmVycy9L
Y29uZmlnICB8ICAgMTQgKystLS0tLS0tLS0tLS0KPiAgYXJjaC91bS9kcml2ZXJzL01ha2VmaWxl
IHwgICAgMiArLQo+ICBzb3VuZC9LY29uZmlnICAgICAgICAgICAgfCAgICAyICstCj4gIDMgZmls
ZXMgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAxNCBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS0g
YS9hcmNoL3VtL2RyaXZlcnMvS2NvbmZpZyBiL2FyY2gvdW0vZHJpdmVycy9LY29uZmlnCj4gLS0t
IGEvYXJjaC91bS9kcml2ZXJzL0tjb25maWcKPiArKysgYi9hcmNoL3VtL2RyaXZlcnMvS2NvbmZp
Zwo+IEBAIC0xMTEsMjQgKzExMSwxNCBAQCBjb25maWcgU1NMX0NIQU4KPgo+ICBjb25maWcgVU1M
X1NPVU5ECj4gICAgICAgICB0cmlzdGF0ZSAiU291bmQgc3VwcG9ydCIKPiArICAgICAgIHNlbGVj
dCBTT1VORAoKClRoaXMgd291bGQgYmUgdGhlIG9ubHkgaW5zdGFuY2UgdGhhdCBzZWxlY3QncyBT
T1VORC4KUGVyaGFwcywgdGhpcyBjb3VsZCBiZSAnZGVwZW5kcyBvbiBTT1VORCcuCihpbiB0aGF0
IGNhc2UsIGFyY2gvdW0vY29uZmlncy8qX2RlZmNvbmZpZyBuZWVkcyBtb2RpZmljYXRpb24pLgoK
SnVzdCBteSB0d28gY2VudHMuCgoKUmV2aWV3ZWQtYnk6IE1hc2FoaXJvIFlhbWFkYSA8bWFzYWhp
cm95QGtlcm5lbC5vcmc+CgoKCgoKCgoKLS0gCkJlc3QgUmVnYXJkcwpNYXNhaGlybyBZYW1hZGEK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LXVt
IG1haWxpbmcgbGlzdApsaW51eC11bUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5p
bmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtdW0K
