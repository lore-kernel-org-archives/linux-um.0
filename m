Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77F40CE79AC
	for <linux-um@archiver.kernel.org>; Wed, 20 Sep 2023 09:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cyQDtu3Q9Op/tnlwqSEIeYrGZpYKs09uq5JaYg8u/Ys=; b=Lv2WIe9ZpTw8kU
	nD/swlhAuQRXTK+hoSI8WVbG79G1l7+OSTwa23agzn9RNF5WrdHlhiKuSng4oByjpH5cDNJ6/c73c
	pDeOJ8YW8QOshNd/Cfy+X20VXc51SONI13ia86CTx9/jwymtP8oRPntNwewijuhaRApNqjS6gBNcO
	QAhoeKr+7cWmoHR2bt61lbeJw+PYZIskmAmivdcBICHgUdvZw/xXF8Q/dYYANAr6Q1RqUUxeo392L
	Ikh1exl7S12o2ESHIJY1fubwQGBKaNIrGaWrX/TxfflZyRy8UE1808APY49OvbQ94twCznBFxLr6Z
	+BGBm1PAMin8BEQZ/W5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qitXp-002TLR-21;
	Wed, 20 Sep 2023 09:30:53 +0000
Received: from mail-yb1-f180.google.com ([209.85.219.180])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qitXa-002TG7-2V;
	Wed, 20 Sep 2023 09:30:41 +0000
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-d838c9537baso3989263276.0;
        Wed, 20 Sep 2023 02:30:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695202236; x=1695807036;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JcKwdyW9PID8T3nWdTHS9gLtWKlKQ0LLCT75T/ZuZuw=;
        b=cWpCcXE4JNs1dzbKIMeZiO73cxfahaIira5U7MGbKpaB9iMoZO4XIGLVtFq0JOaoxc
         OplBOu/WNfpgq2F0vuC2dnhZgOn6q7xWz3bfbXUON/6xGBpMLZCtQ8+6U2cVbEaCrLy+
         +fn0FrlM/eduR4Ij7/LumkQVxNpAkNi/spsyQbvkkPWPug/OXgTA2JCdTV/W9fDwZ3/d
         KZ5FmMUtw9/JZz+2i4pHjNJAIaWs/uzCcAs5qG/rqdxNQo0kcTnwP9rXgjT6H7gPCc51
         Av7cYT3+0CF7vv2D6JUkAvpdzNx6czQx47NpdtueSiQOKrSObtDtqcQIfe18hatHHheu
         P3Ew==
X-Gm-Message-State: AOJu0YwyPwViVNYzTEsLlBivP9sdcEwpQofQaAHwB3bZLPxEPSWqZc0K
	KlmDCkrvJBI1P2/izt6OZn3bBqor8U3bEg==
X-Google-Smtp-Source: AGHT+IGf0D9zkoy64OLHgUpL74pY5qyk+Xj3IAS5T0g8O/y8ccIheac53MLSNhGRWe2T5/ay+OURUg==
X-Received: by 2002:a25:b219:0:b0:d3b:108b:c104 with SMTP id i25-20020a25b219000000b00d3b108bc104mr2122104ybj.54.1695202236265;
        Wed, 20 Sep 2023 02:30:36 -0700 (PDT)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id 72-20020a25054b000000b00d7802512079sm3297393ybf.38.2023.09.20.02.30.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Sep 2023 02:30:35 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-59c0281d72dso57414567b3.0;
        Wed, 20 Sep 2023 02:30:35 -0700 (PDT)
X-Received: by 2002:a0d:c705:0:b0:59c:1880:18e0 with SMTP id
 j5-20020a0dc705000000b0059c188018e0mr1688724ywd.21.1695202235254; Wed, 20 Sep
 2023 02:30:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230918175529.19011-1-peter@n8pjl.ca> <20230918234108.GN19790@gate.crashing.org>
 <20230919000026.7409-1-peter@n8pjl.ca> <20230919151630.GO19790@gate.crashing.org>
 <20230919155832.4179-1-peter@n8pjl.ca> <CAMuHMdXQ=xpeY3tmLXe1kgJbRtmVAn62rEhvzO+VB7GCgy4F8w@mail.gmail.com>
 <20230919161535.4774-1-peter@n8pjl.ca>
In-Reply-To: <20230919161535.4774-1-peter@n8pjl.ca>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 20 Sep 2023 11:30:23 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWQwDzAnbQvBvt3iuL=UPxtufU=TgQM=oKjDvmgmrcy3g@mail.gmail.com>
Message-ID: <CAMuHMdWQwDzAnbQvBvt3iuL=UPxtufU=TgQM=oKjDvmgmrcy3g@mail.gmail.com>
Subject: Re: [PATCH 0/7] arch/*: config: Remove ReiserFS from defconfig
To: Peter Lafreniere <peter@n8pjl.ca>
Cc: anton.ivanov@cambridgegreys.com, ink@jurassic.park.msu.ru, jack@suse.cz, 
	johannes@sipsolutions.net, linux-alpha@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-m68k@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-um@lists.infradead.org, linux@armlinux.org.uk, 
	linuxppc-dev@lists.ozlabs.org, reiserfs-devel@vger.kernel.org, 
	richard.henderson@linaro.org, richard@nod.at, segher@kernel.crashing.org, 
	tsbogend@alpha.franken.de
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230920_023038_819389_A881298E 
X-CRM114-Status: GOOD (  20.89  )
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

SGkgUGV0ZXIsCgpPbiBUdWUsIFNlcCAxOSwgMjAyMyBhdCA2OjE24oCvUE0gUGV0ZXIgTGFmcmVu
aWVyZSA8cGV0ZXJAbjhwamwuY2E+IHdyb3RlOgo+IE9uIFR1ZSwgU2VwIDE5LCAyMDIzIGF0IDEy
OjAyLCBHZWVydCBVeXR0ZXJob2V2ZW4gPGdlZXJ0QGxpbnV4LW02OGsub3JnPiB3cm90ZToKPiA+
IE9uIFR1ZSwgU2VwIDE5LCAyMDIzIGF0IDU6NTjigK9QTSBQZXRlciBMYWZyZW5pZXJlIHBldGVy
QG44cGpsLmNhIHdyb3RlOgo+ID4gPiAyKSBTdG9wcyBidWlsZGluZyBhbiBvYnNvbGV0ZSBhbmQg
bGFyZ2VseS11bnVzZWQgZmlsZXN5c3RlbSB1bm5lY2Vzc2FyaWx5Lgo+ID4gPiBTb21lIGhvYmJ5
aXN0IHRhcmdldHMgbGlrZSBtNjhrIGFuZCBhbHBoYSBtYXkgcHJlZmVyIHRvIGtlZXAgYWxsIGZp
bGVzeXN0ZW1zCj4gPiA+IGF2YWlsYWJsZSB1bnRpbCB0b3RhbCByZW1vdmFsLCBidXQgb3RoZXJz
IGxpa2UgYXJtIGFuZCBVTUwgaGF2ZSBubyBuZWVkIGZvcgo+ID4gPiBSZWlzZXJGUyB0byBiZSBi
dWlsdCB1bmxlc3Mgc3BlY2lmaWNhbGx5IGNvbmZpZ3VyZWQuCj4gPgo+ID4KPiA+IEFzIFVNTCBp
cyB1c2VkIGEgbG90IGZvciB0ZXN0aW5nLCBpc24ndCBpdCBhY3R1YWxseSBjb3VudGVyLXByb2R1
Y3RpdmUKPiA+IHRvIHJlbW92ZSBSZWlzZXJGUyBmcm9tIHRoZSBVTUwgZGVmY29uZmlnPyBUaGUg
bGVzcyB0ZXN0aW5nIGl0Cj4gPiByZWNlaXZlcywgdGhlIGhpZ2hlciB0aGUgY2hhbmNlIG9mIGlu
dHJvZHVjaW5nIHJlZ3Jlc3Npb25zLgo+Cj4gVU1MIGlzIHVzZWQgZm9yIHRlc3RpbmcsIGJ1dCBp
biBteSB2aWV3IHRoYXQgbWFrZXMgdGhlIGluY2x1c2lvbiBvZgo+IFJlaXNlckZTIGluIGl0cyBk
ZWZjb25maWcgZXZlbiB3b3JzZS4gVXNlcnMgb2YgVU1MIGFyZSB0cnlpbmcgdG8gdGVzdCBhCgpX
aHk/CkJlY2F1c2UgeW91IHdhbnQgdG8gYXZvaWQgZG9pbmcgYW55IHRlc3RpbmcgYXQgYWxsIG9u
IGRlcHJlY2F0ZWQgZmVhdHVyZXM/Cgo+IHBhcnRpY3VsYXIgZnVuY3Rpb24sIGFuZCBzbyB0ZW5k
IHRvIHVzZSBleHRbMi00XSwgYXMgdGhvc2UgYXJlIGluY2x1ZGVkIGluCj4gdGhlIGRlZmNvbmZp
ZyBhbmQgYXJlIHdlbGwgdGVzdGVkIGFuZCBzdGFibGUuIFNvIHRoZXJlIGlzIG5vIGV4dHJhIHRl
c3RpbmcKPiBiZWluZyBkb25lIG9uIFJlaXNlckZTIGR1ZSB0byBpdHMgaW5jbHVzaW9uIGluIHRo
ZSBkZWZjb25maWcuCgpJJ2QgZXhwZWN0IGdsb2JhbCBmaWxlIHN5c3RlbSB0ZXN0ZXJzIHRvIHVz
ZSBzb21ldGhpbmcgYWxvbmcgdGhlIGxpbmUgb2Y6CgogICAgZm9yIGkgaW4gJChncmVwIC12IG5v
ZGV2IC9wcm9jL2ZpbGVzeXN0ZW1zICk7IGRvCiAgICAgICAgZWNobyAtLS0gVGVzdGluZyAkaSAt
LS0KICAgICAgICBkZCBpZj0vZGV2L3plcm8gb2Y9dGVzdGltYWdlIGJzPTFNIGNvdW50PTEgc2Vl
az0xMDAwMAogICAgICAgIG1rZnMuJGkgdGVzdGltYWdlCiAgICAgICAgbW91bnQgdGVzdGltYWdl
IC9tbnQgLXQgJGkKICAgICAgICBbcnVuIHhmc3Rlc3RzIG9uIHRlc3RpbWFnZV0KICAgICAgICBy
bSAtZiB0ZXN0aW1hZ2UKICAgIGRvbmUKCj4gS2VlcGluZyBVTUwncyBkZWZjb25maWcgYXMgc2xp
bSBhcyBwb3NzaWJsZSBpbXByb3ZlcyBidWlsZCB0aW1lcywgd2hpY2ggaXMKPiBwYXJ0aWN1bGFy
bHkgaW1wb3J0YW50IGZvciBrZXJuZWwgdGVzdGluZyBhbmQgZGV2ZWxvcG1lbnQuCgpHb29kIGx1
Y2sgdGVzdGluZyBhbGwgZnVuY3Rpb25hbGl0eSB1c2luZyBhICJzbGltIiBrZXJuZWwgOy0pCgpH
cntvZXRqZSxlZXRpbmd9cywKCiAgICAgICAgICAgICAgICAgICAgICAgIEdlZXJ0CgotLSAKR2Vl
cnQgVXl0dGVyaG9ldmVuIC0tIFRoZXJlJ3MgbG90cyBvZiBMaW51eCBiZXlvbmQgaWEzMiAtLSBn
ZWVydEBsaW51eC1tNjhrLm9yZwoKSW4gcGVyc29uYWwgY29udmVyc2F0aW9ucyB3aXRoIHRlY2hu
aWNhbCBwZW9wbGUsIEkgY2FsbCBteXNlbGYgYSBoYWNrZXIuIEJ1dAp3aGVuIEknbSB0YWxraW5n
IHRvIGpvdXJuYWxpc3RzIEkganVzdCBzYXkgInByb2dyYW1tZXIiIG9yIHNvbWV0aGluZyBsaWtl
IHRoYXQuCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLS0gTGludXMgVG9ydmFsZHMK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LXVt
IG1haWxpbmcgbGlzdApsaW51eC11bUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5p
bmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtdW0K
