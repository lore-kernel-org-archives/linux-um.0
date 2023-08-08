Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 849DEC04FDF
	for <linux-um@archiver.kernel.org>; Tue,  8 Aug 2023 18:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sisgXkeQevPIMoZeWOLALmPDJM/hRrFfrUOFnXTBerg=; b=Vz0iAVciP21B5m
	CzC2/SKnUbaNc6PRB2BJcZxqU68Cx8+WVEDRKrsr8UV36BFz55/zp4jd39Hhg9D05HXE0l2lH/D0w
	IR6HkMKeVE5/DOA7BbbSO9lzraBsQyQtjnLuScDSeHvHSYrjlwqWutXUlOpmvj/karnzXFKXZlmTT
	yylBKUdH0t8eYbqktGXn9x4vQVQ9D/F/Fw4KqNAs03srqhFvh0vWx66de1/S4AtzL0esmf5hSJYW0
	TZc+ZGcNake0kql7DHRoRphMVlrQVnlfsCSyPg8LmJwC9ohcBRN6WqMV1indntv40Dta1b5hy8huX
	jq3D1eAYyEANkyC+TRfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qTRNG-003DbE-20;
	Tue, 08 Aug 2023 18:24:06 +0000
Received: from mail-qv1-xf34.google.com ([2607:f8b0:4864:20::f34])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qTRND-003Dai-2S
	for linux-um@lists.infradead.org;
	Tue, 08 Aug 2023 18:24:05 +0000
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-63f4f75b3a7so34451246d6.2
        for <linux-um@lists.infradead.org>; Tue, 08 Aug 2023 11:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691519041; x=1692123841;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SuHu2aaGBtXDGm6ZbqKeYvS7JNps7v7hBHb8nXUWyCA=;
        b=Szm+Vlx1Tmywbd71ISdGfvHzo0S11pvxk8Zu8eH5AWgDVpVmjOfx9T2c/S7v9DhvRs
         SVXeLVpS4LFejNPELELQsdXNFG3tqCy5u/IcY9VGm7ltFF/7Vgp3uc2y+dHfwx/XqGQ2
         nyFbRp7LsFY2cYdWXCCJcG3UzplEGvdj86LimvE/TFAArOnUMZuFlGfKs9voq3fxRew/
         Cdvbw0HwOsexbyJuW8dj4gf1S6ae8FY/Hqq3t7A18oz8ltfyxp32MHDoFE1gaHt7upqZ
         cy2N5fqsx68LfVRUZCJX9Gf/hivW5Y17MUJ9aRcSEnxmHGAmt6kXHSftBagzVSxwEP4t
         O8gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691519041; x=1692123841;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SuHu2aaGBtXDGm6ZbqKeYvS7JNps7v7hBHb8nXUWyCA=;
        b=QcCvMS9lyn4aeAnEktPKwf7OM6+zsf1v6OGq1QGv5RHyU6XHaD2w4j1pRDHhVZYxZC
         WFUlVhJUouTwpZMIA2wC2Nc7LpBEkaWBPMcH1jFOSJVcbL/7tQ5ZMrSRCVhA2J+aJBNw
         hZfJlEFdNJzfBI5/pES0boN0yRvFJgxTD5qHdilPTrjt9WjXPLT2vpOsspnlyPypD/io
         2FyO/r5RzqeIZycIASK4qDfupgAFn7bnDPMU7/Thv1fkU/YMGXGAW3YkUNBEwsHm/isp
         5T6cQ2NGlFHo3klB2mPii1qhliq8897hfP94p/T5WelSdYuNF/svN7aqaxLkg3lXHA6p
         FCUA==
X-Gm-Message-State: AOJu0YzRGZa94fSOQotJSStZP6F6u5jxlIcSPJxVsAgyQtkNPiMdvj0t
	e+2ur8qCpdvBfqWfXwbf8zt4jVN3siR00tN3pM2yFqFPX7V/msvKU8A=
X-Google-Smtp-Source: AGHT+IEuGYfM7Ti1gjPOBrG90iQRTcKJFDV2Zy0ZEcRXgZXpwwv/qmU8lNj+mqkZvmlZCUr5ZljsFeJuq0iBxNf/iao=
X-Received: by 2002:a0c:aa94:0:b0:636:14d4:445b with SMTP id
 f20-20020a0caa94000000b0063614d4445bmr215145qvb.9.1691519041270; Tue, 08 Aug
 2023 11:24:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOd=KCT-aqcWctRPVhEoOjkjP+y5TpNK1hV9mq6PuZDvApQ@mail.gmail.com>
 <CAK7LNASVZLYh1PZ_0QqVEfopGHUKq8fCVDmpKDZfODzgspPXEQ@mail.gmail.com>
In-Reply-To: <CAK7LNASVZLYh1PZ_0QqVEfopGHUKq8fCVDmpKDZfODzgspPXEQ@mail.gmail.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Tue, 8 Aug 2023 11:23:50 -0700
Message-ID: <CAKwvOdno6=XZsAfDpUMgoBtE2kOM+fiO_KOEbkfYMPi1hg+2HA@mail.gmail.com>
Subject: Re: missing separator. Stop. after rebuild
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
	Nathan Chancellor <nathan@kernel.org>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	linux-um@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230808_112403_802321_419A2965 
X-CRM114-Status: GOOD (  15.93  )
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

T24gVHVlLCBBdWcgOCwgMjAyMyBhdCAxMTowMuKAr0FNIE1hc2FoaXJvIFlhbWFkYSA8bWFzYWhp
cm95QGtlcm5lbC5vcmc+IHdyb3RlOgo+Cj4gT24gV2VkLCBBdWcgOSwgMjAyMyBhdCAyOjMx4oCv
QU0gTmljayBEZXNhdWxuaWVycyA8bmRlc2F1bG5pZXJzQGdvb2dsZS5jb20+IHdyb3RlOgo+ID4K
PiA+ICQgd2dldCBodHRwczovL2Rvd25sb2FkLjAxLm9yZy8wZGF5LWNpL2FyY2hpdmUvMjAyMzA4
MDgvMjAyMzA4MDgxMDUwLnNaRXc0Y1E1LWxrcEBpbnRlbC5jb20vY29uZmlnCj4gPiAtTyAuY29u
ZmlnCj4gPiAkIG1ha2UgTExWTT0xIEFSQ0g9dW0gLWoxMjggYXJjaC91bS9kcml2ZXJzL3BvcnRf
a2Vybi5vCj4gPiAkIG1ha2UgTExWTT0xIEFSQ0g9dW0gLWoxMjggYXJjaC91bS9kcml2ZXJzL3Bv
cnRfa2Vybi5vCj4gPiBhcmNoL3VtL2RyaXZlcnMvLmhvc3RhdWRpb19rZXJuLm8uY21kOjg0Mzog
KioqIG1pc3Npbmcgc2VwYXJhdG9yLiAgU3RvcC4KPiA+ICQgc2VkIC1uIC1lIDg0MnAgLWUgODQz
cCBhcmNoL3VtL2RyaXZlcnMvLmhvc3RhdWRpb19rZXJuLm8uY21kCj4gPiAkKGRlcHNfYXJjaC91
bS9kcml2ZXJzL2hvc3RhdWRpb19rZXJuLm8pOgo+ID4gbykKPiA+Cj4gPiBBbnkgaWRlYSBpZiB0
aGlzIGlzIHNvbWUgZm9ybSBvZiBtYWxmb3JtZWQgTWFrZWZpbGUgcnVsZSwgb3IgYWN0dWFsbHkK
PiA+IGEgY29tcGlsZXIgYnVnIGdlbmVyYXRpbmcgdGhlc2UgLmNtZCBmaWxlcz8KPgo+Cj4gUHJl
c3VtYWJseSwgdGhpcyBpcyB0aGUgc2FtZSBzeW1wdG9tIGFzIEppcmkgU2xhYnkgcmVwb3J0ZWQK
PiBzb21lIHRpbWUgYWdvLgo+Cj4gSWYgeW91IHJ1biBhIHNpbmdsZSBidWlsZCBmb3IgYXJjaC91
bS9kcml2ZXJzLyosIGJhZCB0aGluZ3MgbWF5IGhhcHBlbi4KPgo+IEhlIHJlcG9ydGVkLgo+ICAg
VGhpcyBsZWFkcyBvZnRlbiB0byBjb3JydXB0ZWQgYXJjaC91bS9hcmNoL3VtL2RyaXZlcnMvLnNz
bC5vLmNtZC4KPgo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWtidWlsZC85MmY0ZGZl
OS1lYjg3LTc2NmItMjcxYS1lNTdhZGEzYTdkYmRAa2VybmVsLm9yZy8KPgo+Cj4gQSBwYXRjaCBl
eGlzdHMgaW4gTUwuCj4KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyMzA3MjExNzE4
NTcuMzYxMjYzOS0yLW1hc2FoaXJveUBrZXJuZWwub3JnLwoKVGhhbmtzLiBUaGF0IHJlc29sdmVz
IHRoZSBpc3N1ZSBmb3IgbWUuIENhbiB5b3UgcGljayBpdCB1cCBpZiB0aGUgVU1MCmZvbGtzIGRv
bid0PyAgSXQncyBiZWVuIG5lYXJseSAzIHdlZWtzLgoKPgo+Cj4KPiBJIHJlYWxseSB3YW50IHRv
IHN0b3AgdXNpbmcgY29yZS15IG9yIGRyaXZlcnMteSBpbiBhcmNoLyovTWFrZWZpbGUuCj4KPgo+
Cj4gLS0KPiBCZXN0IFJlZ2FyZHMKPiBNYXNhaGlybyBZYW1hZGEKCgoKLS0gClRoYW5rcywKfk5p
Y2sgRGVzYXVsbmllcnMKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmxpbnV4LXVtIG1haWxpbmcgbGlzdApsaW51eC11bUBsaXN0cy5pbmZyYWRlYWQub3Jn
Cmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtdW0K
