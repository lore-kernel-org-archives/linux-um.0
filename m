Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22569C001DF
	for <linux-um@archiver.kernel.org>; Sun,  6 Aug 2023 12:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0USGEdVySrAyKkbYbzCDh9Zqj3cwVBqtbc9d+PEv7JI=; b=Lpg/myPBBC+eom
	yywyeof3eWszuUODarU/FnO74hsTrm6aZrWPKXl3CyvH6NDnUBuZOqnCB1zlRsmeyJueBEZ7oK8yF
	+0U7A9M20A5CK3MPbOvuXowd2RtDQ/Cz5ihwQvU2nBGZmz6ZT14mXx75jD6Pqt3h/H/4pE2uwU4HM
	Y9NGlo3LnETQnakQmfmuv32Ap4Rdzv23xdsVH/aXuj5qZE7F9URxCAU1e/EG+E7L1i+6NaEHkpB1s
	+3b1guj+eFFwp/XtPoJNtUkt9Kq20i9UV3p73bbbmeSgkJdtiJ74j6Bj5IO3i6ruuxOv/D0uyvowb
	pU1y8Wgg2h11Gq3Ez3WA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qSd4Q-00FPr5-1E;
	Sun, 06 Aug 2023 12:41:18 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qSd4M-00FPpx-1Y
	for linux-um@lists.infradead.org;
	Sun, 06 Aug 2023 12:41:15 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id E54EA610F4
	for <linux-um@lists.infradead.org>; Sun,  6 Aug 2023 12:40:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB683C433AD
	for <linux-um@lists.infradead.org>; Sun,  6 Aug 2023 12:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691325655;
	bh=nFD7z3c13NvSK1tSfJL2f3eMNutGbhDjiU3cgo+Y5oo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=IO2oJBX6fwJLrc50nMXI++iSmix7tqD7GnAj/m5VTrgOPixrlMJ5x7QcwUZ6jv6Xs
	 3PLe/6+v6ZNgyWvsePCWSWz2Vxvg9EggO/zhSG0RDe/MO49p3j7gBo5zNHmiBR+8MU
	 zNlNer4aEoN7XIhMQ2szELQwzPNhHTcM3BCSTpAMLReY4s9NejkErQxYWyF74MCfjJ
	 ZDSjNhl3wAAVsvQ12HJEu85C5RDbCczFO0LZ5/rZo4WaFoFCrHaPQ9LDiQoJ3miHBp
	 BFR2JfDM7C4s/2s4i7y0n4iNfvzg/AyIeTtO0yLaudYYzEDSbDrL/gn0fiFD7gacnG
	 V0IIykJB0rk8g==
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3a5ad6087a1so2001741b6e.2
        for <linux-um@lists.infradead.org>; Sun, 06 Aug 2023 05:40:55 -0700 (PDT)
X-Gm-Message-State: AOJu0Yz9D2/IWm8lCol7//QxgJCVCVSzQJZaNNP6KCS4eOuzDU0WeSzS
	lvcKNjb3PkYVN+OSdLXM1J63GyisT9wROq2C2BA=
X-Google-Smtp-Source: AGHT+IGECC3WwLCbh/4btLngvNb293Va8WRKjDpuT4+YY474LsINtVefC2rYRorCpFghi2Glsk6bb5FbAtTZ9/M3pq4=
X-Received: by 2002:a05:6808:918:b0:3a7:4161:44ee with SMTP id
 w24-20020a056808091800b003a7416144eemr5064315oih.6.1691325654832; Sun, 06 Aug
 2023 05:40:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230802051500.13271-1-rdunlap@infradead.org>
In-Reply-To: <20230802051500.13271-1-rdunlap@infradead.org>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sun, 6 Aug 2023 21:40:18 +0900
X-Gmail-Original-Message-ID: <CAK7LNARV8va+4JeYHOxZFh_dLgXAfP1wRVoEqUJ_Uuhj=SKnGg@mail.gmail.com>
Message-ID: <CAK7LNARV8va+4JeYHOxZFh_dLgXAfP1wRVoEqUJ_Uuhj=SKnGg@mail.gmail.com>
Subject: Re: [PATCH v5] um/drivers: fix hostaudio build errors
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org, 
	Tejun Heo <tj@kernel.org>, Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Nicolas Schier <nicolas@fjasle.eu>, linux-kbuild@vger.kernel.org, 
	alsa-devel@alsa-project.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230806_054114_624909_5F0FEB49 
X-CRM114-Status: GOOD (  17.50  )
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

T24gV2VkLCBBdWcgMiwgMjAyMyBhdCAyOjE14oCvUE0gUmFuZHkgRHVubGFwIDxyZHVubGFwQGlu
ZnJhZGVhZC5vcmc+IHdyb3RlOgo+Cj4gVXNlICJzZWxlY3QiIHRvIGVuc3VyZSB0aGF0IHRoZSBy
ZXF1aXJlZCBrY29uZmlnIHN5bWJvbHMgYXJlIHNldAo+IGFzIGV4cGVjdGVkLgo+IERyb3AgSE9T
VEFVRElPIHNpbmNlIGl0IGlzIG5vdyBlcXVpdmFsZW50IHRvIFVNTF9TT1VORC4KPgo+IFNldCBD
T05GSUdfU09VTkQ9bSBpbiBBUkNIPXVtIGRlZmNvbmZpZyBmaWxlcyB0byBtYWludGFpbiB0aGUK
PiBzdGF0dXMgcXVvIG9mIHRoZSBkZWZhdWx0IGNvbmZpZ3MuCj4KPiBBbGxvdyBTT1VORCB3aXRo
IFVNTCByZWdhcmRsZXNzIG9mIEhBU19JT01FTS4gT3RoZXJ3aXNlIHRoZXJlIGlzIGEKPiBrY29u
ZmlnIHdhcm5pbmcgZm9yIHVubWV0IGRlcGVuZGVuY2llcy4gKFRoaXMgd2FzIG5vdCBhbiBpc3N1
ZSB3aGVuCj4gU09VTkQgd2FzIGRlZmluZWQgaW4gYXJjaC91bS9kcml2ZXJzL0tjb25maWcuIEkg
aGF2ZSBkb25lIDUwIHJhbmRjb25maWcKPiBidWlsZHMgYW5kIGRpZG4ndCBmaW5kIGFueSBpc3N1
ZXMuKQo+Cj4gVGhpcyBmaXhlcyBidWlsZCBlcnJvcnMgd2hlbiBDT05GSUdfU09VTkQgaXMgbm90
IHNldDoKPgo+IGxkOiBhcmNoL3VtL2RyaXZlcnMvaG9zdGF1ZGlvX2tlcm4ubzogaW4gZnVuY3Rp
b24gYGhvc3RhdWRpb19jbGVhbnVwX21vZHVsZSc6Cj4gaG9zdGF1ZGlvX2tlcm4uYzooLmV4aXQu
dGV4dCsweGEpOiB1bmRlZmluZWQgcmVmZXJlbmNlIHRvIGB1bnJlZ2lzdGVyX3NvdW5kX21peGVy
Jwo+IGxkOiBob3N0YXVkaW9fa2Vybi5jOiguZXhpdC50ZXh0KzB4MTUpOiB1bmRlZmluZWQgcmVm
ZXJlbmNlIHRvIGB1bnJlZ2lzdGVyX3NvdW5kX2RzcCcKPiBsZDogYXJjaC91bS9kcml2ZXJzL2hv
c3RhdWRpb19rZXJuLm86IGluIGZ1bmN0aW9uIGBob3N0YXVkaW9faW5pdF9tb2R1bGUnOgo+IGhv
c3RhdWRpb19rZXJuLmM6KC5pbml0LnRleHQrMHgxOSk6IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8g
YHJlZ2lzdGVyX3NvdW5kX2RzcCcKPiBsZDogaG9zdGF1ZGlvX2tlcm4uYzooLmluaXQudGV4dCsw
eDMxKTogdW5kZWZpbmVkIHJlZmVyZW5jZSB0byBgcmVnaXN0ZXJfc291bmRfbWl4ZXInCj4gbGQ6
IGhvc3RhdWRpb19rZXJuLmM6KC5pbml0LnRleHQrMHg0OSk6IHVuZGVmaW5lZCByZWZlcmVuY2Ug
dG8gYHVucmVnaXN0ZXJfc291bmRfZHNwJwo+Cj4gYW5kIHRoaXMga2NvbmZpZyB3YXJuaW5nOgo+
IFdBUk5JTkc6IHVubWV0IGRpcmVjdCBkZXBlbmRlbmNpZXMgZGV0ZWN0ZWQgZm9yIFNPVU5ECj4K
PiBGaXhlczogMWRhMTc3ZTRjM2Y0ICgiTGludXgtMi42LjEyLXJjMiIpCj4gRml4ZXM6IGQ4ODZl
ODdjYjgyYiAoInNvdW5kOiBtYWtlIE9TUyBzb3VuZCBjb3JlIG9wdGlvbmFsIikKPiBTaWduZWQt
b2ZmLWJ5OiBSYW5keSBEdW5sYXAgPHJkdW5sYXBAaW5mcmFkZWFkLm9yZz4KPiBSZXBvcnRlZC1i
eToga2VybmVsIHRlc3Qgcm9ib3QgPGxrcEBpbnRlbC5jb20+Cj4gQ2xvc2VzOiBsb3JlLmtlcm5l
bC5vcmcvci8yMDIzMDcxNDE0MTYudnh1UlZwRnYtbGtwQGludGVsLmNvbQo+IENjOiBSaWNoYXJk
IFdlaW5iZXJnZXIgPHJpY2hhcmRAbm9kLmF0Pgo+IENjOiBBbnRvbiBJdmFub3YgPGFudG9uLml2
YW5vdkBjYW1icmlkZ2VncmV5cy5jb20+Cj4gQ2M6IEpvaGFubmVzIEJlcmcgPGpvaGFubmVzQHNp
cHNvbHV0aW9ucy5uZXQ+Cj4gQ2M6IGxpbnV4LXVtQGxpc3RzLmluZnJhZGVhZC5vcmcKPiBDYzog
VGVqdW4gSGVvIDx0akBrZXJuZWwub3JnPgo+IENjOiBUYWthc2hpIEl3YWkgPHRpd2FpQHN1c2Uu
ZGU+Cj4gQ2M6IEphcm9zbGF2IEt5c2VsYSA8cGVyZXhAcGVyZXguY3o+Cj4gQ2M6IE1hc2FoaXJv
IFlhbWFkYSA8bWFzYWhpcm95QGtlcm5lbC5vcmc+CgoKClJldmlld2VkLWJ5OiBNYXNhaGlybyBZ
YW1hZGEgPG1hc2FoaXJveUBrZXJuZWwub3JnPgoKCi0tIApCZXN0IFJlZ2FyZHMKTWFzYWhpcm8g
WWFtYWRhCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwps
aW51eC11bSBtYWlsaW5nIGxpc3QKbGludXgtdW1AbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8v
bGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LXVtCg==
