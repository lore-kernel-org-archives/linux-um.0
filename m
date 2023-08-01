Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDE49C001DF
	for <linux-um@archiver.kernel.org>; Tue,  1 Aug 2023 11:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ddoa6KJNa1RYIsyxs2xOBlIiP9n+Cwx/ZQXwd1Kz190=; b=HkjmGHYRNs8dRO
	qFg5EiUh8dFQUnz0xwnWfv2frLsruQY1u2I6M+9pvUiAlIJcxwra30TYb8X84JhSn4TkaS9m5e6mw
	Pp+eB6iOy6s7oQT9JxBeLjwai/9nKQ0iFCm6/QmQCNy+8dJMSIp7YVdzWUA/fC/zaDThClfnceCL4
	0w9Q3XkrDBcpAB1bCgQXMZ4yWDFPnRGWVoExNgnIE877jCmMzhuyTziQt6XUYhXoT+0wZntbfU0iN
	KQBr694/R4mTD3oR2Ouap76Cn9QcUy5b+58/bl6usjRIejUATMley/b5weAaYwFuN36e1f1acmak/
	ESIVTYp+fC3uuWml1TvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qQnIZ-0023yF-0j;
	Tue, 01 Aug 2023 11:12:19 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qQnIW-0023wu-0f
	for linux-um@lists.infradead.org;
	Tue, 01 Aug 2023 11:12:17 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 649D46155A
	for <linux-um@lists.infradead.org>; Tue,  1 Aug 2023 11:12:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62185C433A9
	for <linux-um@lists.infradead.org>; Tue,  1 Aug 2023 11:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690888334;
	bh=6xJnLUEmWli4Sg8BYYDGqHkD7X50qXBRRg+P9oWfxWM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=asbgjVRS2F6cxeU6FpNpzuvI2yKFsTmlqCuN+fPpeeGw9irwpfreYYqWEEu/cQnP0
	 TavALPyqD+f4VoyPf4uMpD/D18ACRo8x2zvgb9l/dF1r4onQZNGKPBZudy91m61rUu
	 QQERZJTyfmPkCG6m0C0/BacDvJBSg5+S1vmk/k2vvRoPMCceCqxDGNHe838KrAlsoT
	 cbv1Z846wWXGaF7tknN2MF7ix82by8eo7yLMDpUJfGT8bKUgjahpBcoNAoqfirbGoT
	 19YBqcddzYGF9PG+lvcmCKa52DJL751lML2vx3O3vPfVb/w8ulZb52UludMZckO2z1
	 EGoWD2T8cUOJA==
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6bc9811558cso2361517a34.0
        for <linux-um@lists.infradead.org>; Tue, 01 Aug 2023 04:12:14 -0700 (PDT)
X-Gm-Message-State: ABy/qLYMP7WK4YhatbhuVktVXt4mxL22Z2ze3Xw0VeQqAJTF4c2tIdJg
	mMTC8m7AF0ptqfPTBcFY14/Vu6/faUmL5WWdeEg=
X-Google-Smtp-Source: APBJJlF1fcfNFrXijDAvYYZT395hSxnCPp3oosdkuHMjDegV35uuSUXhfNO7tlSE+6JJf73ovDDmQVxKYs9kWwwefw0=
X-Received: by 2002:a05:6870:d784:b0:1bb:a3a8:c7c1 with SMTP id
 bd4-20020a056870d78400b001bba3a8c7c1mr12957380oab.24.1690888333460; Tue, 01
 Aug 2023 04:12:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230801020507.30392-1-rdunlap@infradead.org>
In-Reply-To: <20230801020507.30392-1-rdunlap@infradead.org>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Tue, 1 Aug 2023 20:11:37 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQBoE19Bipk3KT2z+bTEJ5Mkm3qNesa5U92k0N+a-NQ9A@mail.gmail.com>
Message-ID: <CAK7LNAQBoE19Bipk3KT2z+bTEJ5Mkm3qNesa5U92k0N+a-NQ9A@mail.gmail.com>
Subject: Re: [PATCH v4] um/drivers: fix hostaudio build errors
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org, 
	Tejun Heo <tj@kernel.org>, Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Nicolas Schier <nicolas@fjasle.eu>, linux-kbuild@vger.kernel.org, 
	alsa-devel@alsa-project.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230801_041216_328140_B109775A 
X-CRM114-Status: GOOD (  29.11  )
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

T24gVHVlLCBBdWcgMSwgMjAyMyBhdCAxMTowNeKAr0FNIFJhbmR5IER1bmxhcCA8cmR1bmxhcEBp
bmZyYWRlYWQub3JnPiB3cm90ZToKPgo+IFVzZSAic2VsZWN0InMgdG8gZW5zdXJlIHRoYXQgdGhl
IHJlcXVpcmVkIGtjb25maWcgc3ltYm9scyBhcmUgc2V0Cj4gYXMgZXhwZWN0ZWQuCgpVc2luZyBw
bHVyYWwsICJzZWxlY3Qicywgc291bmRzIG9kZCBub3cuCgpVc2UgInNlbGVjdCIgYW5kICJkZXBl
bmRzIG9uIiB0byBlbnN1cmUgLi4uICA/CgoKCgpBcyBJIHNhaWQgaW4gdGhlIHByZXZpb3VzIGVt
YWlsLAp5b3UgbmVlZCB0byBhZGQgQ09ORklHX1NPVU5EPXkKdG8gYXJjaC91bS9jb25maWdzL3tp
Mzg2LHg4Nl82NH1fZGVmY29uZmlnLApvdGhlcndpc2UgQ09ORklHX1VNTF9TT1VORCBpcyBoaWRk
ZW4uCgoKCgoKPiBEcm9wIEhPU1RBVURJTyBzaW5jZSBpdCBpcyBub3cgZXF1aXZhbGVudCB0byBV
TUxfU09VTkQuCj4KPiBBbGxvdyBTT1VORCB3aXRoIFVNTCByZWdhcmRsZXNzIG9mIEhBU19JT01F
TS4gT3RoZXJ3aXNlIHRoZXJlIGlzIGEKPiBrY29uZmlnIHdhcm5pbmcgZm9yIHVubWV0IGRlcGVu
ZGVuY2llcy4gKFRoaXMgd2FzIG5vdCBhbiBpc3N1ZSB3aGVuCj4gU09VTkQgd2FzIGRlZmluZWQg
aW4gYXJjaC91bS9kcml2ZXJzL0tjb25maWcuIEkgaGF2ZSBkb25lIDUwIHJhbmRjb25maWcKPiBi
dWlsZHMgYW5kIGRpZG4ndCBmaW5kIGFueSBpc3N1ZXMuKQo+Cj4gVGhpcyBmaXhlcyBidWlsZCBl
cnJvcnMgd2hlbiBDT05GSUdfU09VTkQgaXMgbm90IHNldDoKPgo+IGxkOiBhcmNoL3VtL2RyaXZl
cnMvaG9zdGF1ZGlvX2tlcm4ubzogaW4gZnVuY3Rpb24gYGhvc3RhdWRpb19jbGVhbnVwX21vZHVs
ZSc6Cj4gaG9zdGF1ZGlvX2tlcm4uYzooLmV4aXQudGV4dCsweGEpOiB1bmRlZmluZWQgcmVmZXJl
bmNlIHRvIGB1bnJlZ2lzdGVyX3NvdW5kX21peGVyJwo+IGxkOiBob3N0YXVkaW9fa2Vybi5jOigu
ZXhpdC50ZXh0KzB4MTUpOiB1bmRlZmluZWQgcmVmZXJlbmNlIHRvIGB1bnJlZ2lzdGVyX3NvdW5k
X2RzcCcKPiBsZDogYXJjaC91bS9kcml2ZXJzL2hvc3RhdWRpb19rZXJuLm86IGluIGZ1bmN0aW9u
IGBob3N0YXVkaW9faW5pdF9tb2R1bGUnOgo+IGhvc3RhdWRpb19rZXJuLmM6KC5pbml0LnRleHQr
MHgxOSk6IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8gYHJlZ2lzdGVyX3NvdW5kX2RzcCcKPiBsZDog
aG9zdGF1ZGlvX2tlcm4uYzooLmluaXQudGV4dCsweDMxKTogdW5kZWZpbmVkIHJlZmVyZW5jZSB0
byBgcmVnaXN0ZXJfc291bmRfbWl4ZXInCj4gbGQ6IGhvc3RhdWRpb19rZXJuLmM6KC5pbml0LnRl
eHQrMHg0OSk6IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8gYHVucmVnaXN0ZXJfc291bmRfZHNwJwo+
Cj4gYW5kIHRoaXMga2NvbmZpZyB3YXJuaW5nOgo+IFdBUk5JTkc6IHVubWV0IGRpcmVjdCBkZXBl
bmRlbmNpZXMgZGV0ZWN0ZWQgZm9yIFNPVU5ECj4KPiBGaXhlczogMWRhMTc3ZTRjM2Y0ICgiTGlu
dXgtMi42LjEyLXJjMiIpCj4gRml4ZXM6IGQ4ODZlODdjYjgyYiAoInNvdW5kOiBtYWtlIE9TUyBz
b3VuZCBjb3JlIG9wdGlvbmFsIikKPiBTaWduZWQtb2ZmLWJ5OiBSYW5keSBEdW5sYXAgPHJkdW5s
YXBAaW5mcmFkZWFkLm9yZz4KPiBSZXBvcnRlZC1ieToga2VybmVsIHRlc3Qgcm9ib3QgPGxrcEBp
bnRlbC5jb20+Cj4gQ2xvc2VzOiBsb3JlLmtlcm5lbC5vcmcvci8yMDIzMDcxNDE0MTYudnh1UlZw
RnYtbGtwQGludGVsLmNvbQo+IENjOiBSaWNoYXJkIFdlaW5iZXJnZXIgPHJpY2hhcmRAbm9kLmF0
Pgo+IENjOiBBbnRvbiBJdmFub3YgPGFudG9uLml2YW5vdkBjYW1icmlkZ2VncmV5cy5jb20+Cj4g
Q2M6IEpvaGFubmVzIEJlcmcgPGpvaGFubmVzQHNpcHNvbHV0aW9ucy5uZXQ+Cj4gQ2M6IGxpbnV4
LXVtQGxpc3RzLmluZnJhZGVhZC5vcmcKPiBDYzogVGVqdW4gSGVvIDx0akBrZXJuZWwub3JnPgo+
IENjOiBUYWthc2hpIEl3YWkgPHRpd2FpQHN1c2UuZGU+Cj4gQ2M6IEphcm9zbGF2IEt5c2VsYSA8
cGVyZXhAcGVyZXguY3o+Cj4gQ2M6IE1hc2FoaXJvIFlhbWFkYSA8bWFzYWhpcm95QGtlcm5lbC5v
cmc+Cj4gQ2M6IE5hdGhhbiBDaGFuY2VsbG9yIDxuYXRoYW5Aa2VybmVsLm9yZz4KPiBDYzogTmlj
ayBEZXNhdWxuaWVycyA8bmRlc2F1bG5pZXJzQGdvb2dsZS5jb20+Cj4gQ2M6IE5pY29sYXMgU2No
aWVyIDxuaWNvbGFzQGZqYXNsZS5ldT4KPiBDYzogbGludXgta2J1aWxkQHZnZXIua2VybmVsLm9y
Zwo+IENjOiBhbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKPiAtLS0KPiB2MjogZG9uJ3QgZGVs
ZXRlIHRoZSBIT1NUQVVESU8gS2NvbmZpZyBlbnRyeSAoTWFzYWhpcm8pCj4gdjM6IGRyb3AgSE9T
VEFVRElPIGFuZCB1c2UgQ09ORklHX1VNTF9TT1VORCBmb3IgaXQgaW4gTWFrZWZpbGUgKFRha2Fz
aGkpOwo+ICAgICBhZGQgU09VTkQgZGVwZW5kcyBvbiAifHwgVU1MIiB0byBIQVNfSU9NRU0KPiB2
NDogdXNlIGRlcGVuZHMgb24gaW5zdGVhZCBvZiBzZWxlY3QgZm9yIFNPVU5EIChNYXNhaGlybyk7
Cj4gICAgIHVzZSBDbG9zZXM6IGluc3RlYWQgb2YgTGluazoKPgo+ICBhcmNoL3VtL2RyaXZlcnMv
S2NvbmZpZyAgfCAgIDE2ICsrKy0tLS0tLS0tLS0tLS0KPiAgYXJjaC91bS9kcml2ZXJzL01ha2Vm
aWxlIHwgICAgMiArLQo+ICBzb3VuZC9LY29uZmlnICAgICAgICAgICAgfCAgICAyICstCj4gIDMg
ZmlsZXMgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAxNSBkZWxldGlvbnMoLSkKPgo+IGRpZmYg
LS0gYS9hcmNoL3VtL2RyaXZlcnMvS2NvbmZpZyBiL2FyY2gvdW0vZHJpdmVycy9LY29uZmlnCj4g
LS0tIGEvYXJjaC91bS9kcml2ZXJzL0tjb25maWcKPiArKysgYi9hcmNoL3VtL2RyaXZlcnMvS2Nv
bmZpZwo+IEBAIC0xMTEsMjQgKzExMSwxNCBAQCBjb25maWcgU1NMX0NIQU4KPgo+ICBjb25maWcg
VU1MX1NPVU5ECj4gICAgICAgICB0cmlzdGF0ZSAiU291bmQgc3VwcG9ydCIKPiArICAgICAgIGRl
cGVuZHMgb24gU09VTkQKPiArICAgICAgIHNlbGVjdCBTT1VORF9PU1NfQ09SRQo+ICAgICAgICAg
aGVscAo+ICAgICAgICAgICBUaGlzIG9wdGlvbiBlbmFibGVzIFVNTCBzb3VuZCBzdXBwb3J0LiAg
SWYgZW5hYmxlZCwgaXQgd2lsbCBwdWxsIGluCj4gLSAgICAgICAgIHNvdW5kY29yZSBhbmQgdGhl
IFVNTCBob3N0YXVkaW8gcmVsYXksIHdoaWNoIGFjdHMgYXMgYSBpbnRlcm1lZGlhcnkKPiArICAg
ICAgICAgdGhlIFVNTCBob3N0YXVkaW8gcmVsYXksIHdoaWNoIGFjdHMgYXMgYSBpbnRlcm1lZGlh
cnkKPiAgICAgICAgICAgYmV0d2VlbiB0aGUgaG9zdCdzIGRzcCBhbmQgbWl4ZXIgZGV2aWNlcyBh
bmQgdGhlIFVNTCBzb3VuZCBzeXN0ZW0uCj4gICAgICAgICAgIEl0IGlzIHNhZmUgdG8gc2F5ICdZ
JyBoZXJlLgo+Cj4gLWNvbmZpZyBTT1VORAo+IC0gICAgICAgdHJpc3RhdGUKPiAtICAgICAgIGRl
ZmF1bHQgVU1MX1NPVU5ECj4gLQo+IC1jb25maWcgU09VTkRfT1NTX0NPUkUKPiAtICAgICAgIGJv
b2wKPiAtICAgICAgIGRlZmF1bHQgVU1MX1NPVU5ECj4gLQo+IC1jb25maWcgSE9TVEFVRElPCj4g
LSAgICAgICB0cmlzdGF0ZQo+IC0gICAgICAgZGVmYXVsdCBVTUxfU09VTkQKPiAtCj4gIGVuZG1l
bnUKPgo+ICBtZW51ICJVTUwgTmV0d29yayBEZXZpY2VzIgo+IGRpZmYgLS0gYS9zb3VuZC9LY29u
ZmlnIGIvc291bmQvS2NvbmZpZwo+IC0tLSBhL3NvdW5kL0tjb25maWcKPiArKysgYi9zb3VuZC9L
Y29uZmlnCj4gQEAgLTEsNyArMSw3IEBACj4gICMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQ
TC0yLjAtb25seQo+ICBtZW51Y29uZmlnIFNPVU5ECj4gICAgICAgICB0cmlzdGF0ZSAiU291bmQg
Y2FyZCBzdXBwb3J0Igo+IC0gICAgICAgZGVwZW5kcyBvbiBIQVNfSU9NRU0KPiArICAgICAgIGRl
cGVuZHMgb24gSEFTX0lPTUVNIHx8IFVNTAo+ICAgICAgICAgaGVscAo+ICAgICAgICAgICBJZiB5
b3UgaGF2ZSBhIHNvdW5kIGNhcmQgaW4geW91ciBjb21wdXRlciwgaS5lLiBpZiBpdCBjYW4gc2F5
IG1vcmUKPiAgICAgICAgICAgdGhhbiBhbiBvY2Nhc2lvbmFsIGJlZXAsIHNheSBZLgo+IGRpZmYg
LS0gYS9hcmNoL3VtL2RyaXZlcnMvTWFrZWZpbGUgYi9hcmNoL3VtL2RyaXZlcnMvTWFrZWZpbGUK
PiAtLS0gYS9hcmNoL3VtL2RyaXZlcnMvTWFrZWZpbGUKPiArKysgYi9hcmNoL3VtL2RyaXZlcnMv
TWFrZWZpbGUKPiBAQCAtNTQsNyArNTQsNyBAQCBvYmotJChDT05GSUdfVU1MX05FVCkgKz0gbmV0
Lm8KPiAgb2JqLSQoQ09ORklHX01DT05TT0xFKSArPSBtY29uc29sZS5vCj4gIG9iai0kKENPTkZJ
R19NTUFQUEVSKSArPSBtbWFwcGVyX2tlcm4ubwo+ICBvYmotJChDT05GSUdfQkxLX0RFVl9VQkQp
ICs9IHViZC5vCj4gLW9iai0kKENPTkZJR19IT1NUQVVESU8pICs9IGhvc3RhdWRpby5vCj4gK29i
ai0kKENPTkZJR19VTUxfU09VTkQpICs9IGhvc3RhdWRpby5vCj4gIG9iai0kKENPTkZJR19OVUxM
X0NIQU4pICs9IG51bGwubwo+ICBvYmotJChDT05GSUdfUE9SVF9DSEFOKSArPSBwb3J0Lm8KPiAg
b2JqLSQoQ09ORklHX1BUWV9DSEFOKSArPSBwdHkubwoKCgotLSAKQmVzdCBSZWdhcmRzCk1hc2Fo
aXJvIFlhbWFkYQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KbGludXgtdW0gbWFpbGluZyBsaXN0CmxpbnV4LXVtQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0
cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC11bQo=
