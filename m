Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D34E3C7EE33
	for <linux-um@archiver.kernel.org>; Thu,  1 Jun 2023 08:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wRZ0XxawZXWqLmKvqfngpqafylqwFtO16D1zRfXXOAk=; b=mMccLAPxsgYAxs
	k6JYhp9zvaehnRz0XEaDpI668J+twHqZyanf3ZKmD03jcrzpc/kewFZXLXvxdUQpifajMzp9oAogv
	qEOURGBbnYoqPwfENlbTIjpd+8Ve75OiLU1TesB3enUGUBBfrgm6NuFNat5yauuuAvocfPHtuNZjx
	GOEUG5OMoNFXrHS5h55xG2UAUjWsy1A25Ezp2m+e8Cgn94l1vi8zReWkpzJ/xCkKsOatd8rWdf2lT
	miqz3TtBmcg/dxJLX/4gddzSVGF+m6z9EHgRisml50tjul1HU63WWbhq2g6hgfqPrhcgCnp7Ybt2l
	HqVrHYQ482TBqEksMTrQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q4dZb-002X6O-1e;
	Thu, 01 Jun 2023 08:22:19 +0000
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q4dZY-002X4S-1C;
	Thu, 01 Jun 2023 08:22:17 +0000
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-565cdb77b01so5259067b3.0;
        Thu, 01 Jun 2023 01:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685607734; x=1688199734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F3q8fSv1CYQ8OeBSkoHHq8yQzPVMEdcVj1sJJBohCe0=;
        b=scnpKoycafdSA6Zmoxe64NtU1IPtpP1XoN7u6BxbHgaNpHHpBaRgfB2X/NbVQI3XUI
         S43vtnrb0VpUQFKtCtNAL2Z4eQGxKB9jkDmQzBef6OSmzPFkANcNw2nEHbBaxtIGRJFx
         F2gdbWX0/JO50BjGXzMMRjG/dVaN6/37Aaxe3j2XyiD9NBGl22snChdmfv7CpIBT4YsT
         wzEsBAOaAGJLasaxdabRza57BmBoAT7cVmGOq5aUEFhtYj/c1WejBdPyTkL2OU+y9vxz
         zNiBma0es8vOX0CahjWds9KH8J6DH6xHzp6sGGczNoDJQcyp7Q2snP8wt+QQc7Qs4GOa
         fyBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685607734; x=1688199734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F3q8fSv1CYQ8OeBSkoHHq8yQzPVMEdcVj1sJJBohCe0=;
        b=gVsfO0fOSbFC7K4YNJCHYkB5dkJoxEDuyDFg2c40pCvDiwtMeSNNI5Olj7b7XiCSjM
         qpctU/B4+Zy5C1MczhrnrFBjOXdMSkCc4dzAJTi/PKZJjI4vvgqtwua9TERYhDOui6pH
         Y+YguXZ1zWe0toIzvsyuvW7/j85D2cdWMLbm/zIIsKAogoaa/U/900+0r3v5wFoe7IB0
         IERTPLa+XRPrMlR/jTtpGsqRIvNmJ9qoHqqxjKyeo2pcf85FNxBrCNEq707plbB0puVA
         gA4c3qW3yDKIOL5Hk/Tbtl9M1k85VPO1tbPrzWFtvGfAZsv3hZaUH/a59TzQbBF7E8WW
         ToLw==
X-Gm-Message-State: AC+VfDzD5N8SHbv1HCd5vx6DzZPTHWUziIW6cw5t8oljhpggfGi/HSpX
	lE/ntmdi6ItQzj0BDg/95XbUHrp+DSWsTMXavcY=
X-Google-Smtp-Source: ACHHUZ4BVGpqKx729yAA7sIpRRuJCk9B2q39qd4V84f+TNhLT6e1WTgI1mcqI+pCtHVuJpHfepvjflFti312UIm7bGk=
X-Received: by 2002:a0d:f5c2:0:b0:568:d63e:dd2c with SMTP id
 e185-20020a0df5c2000000b00568d63edd2cmr6202683ywf.11.1685607733835; Thu, 01
 Jun 2023 01:22:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230531213032.25338-1-vishal.moola@gmail.com>
 <20230531213032.25338-31-vishal.moola@gmail.com> <CAMuHMdU4t4ac_eCH0UaX9F+GQ5-9kYjB_=e+pSfTkxG=3b8DsA@mail.gmail.com>
 <025fc34a24e1a1c26b187f15dba86d382d9617eb.camel@physik.fu-berlin.de>
In-Reply-To: <025fc34a24e1a1c26b187f15dba86d382d9617eb.camel@physik.fu-berlin.de>
From: Vishal Moola <vishal.moola@gmail.com>
Date: Thu, 1 Jun 2023 01:22:03 -0700
Message-ID: <CAOzc2pxnb6WXoVK5JXX42R0Q6FK59Q1uebQskK2fxLn6DuicqA@mail.gmail.com>
Subject: Re: [PATCH v3 30/34] sh: Convert pte_free_tlb() to use ptdescs
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, linux-arch@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, 
	linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, xen-devel@lists.xenproject.org, 
	kvm@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230601_012216_405528_4B747334 
X-CRM114-Status: GOOD (  12.99  )
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

T24gVGh1LCBKdW4gMSwgMjAyMyBhdCAxMjoyOOKAr0FNIEpvaG4gUGF1bCBBZHJpYW4gR2xhdWJp
dHoKPGdsYXViaXR6QHBoeXNpay5mdS1iZXJsaW4uZGU+IHdyb3RlOgo+Cj4gSGkgR2VlcnQhCj4K
PiBPbiBUaHUsIDIwMjMtMDYtMDEgYXQgMDk6MjAgKzAyMDAsIEdlZXJ0IFV5dHRlcmhvZXZlbiB3
cm90ZToKPiA+IE9uIFdlZCwgTWF5IDMxLCAyMDIzIGF0IDExOjMz4oCvUE0gVmlzaGFsIE1vb2xh
IChPcmFjbGUpCj4gPiA8dmlzaGFsLm1vb2xhQGdtYWlsLmNvbT4gd3JvdGU6Cj4gPiA+IFBhcnQg
b2YgdGhlIGNvbnZlcnNpb25zIHRvIHJlcGxhY2UgcGd0YWJsZSBjb25zdHJ1Y3Rvci9kZXN0cnVj
dG9ycyB3aXRoCj4gPiA+IHB0ZGVzYyBlcXVpdmFsZW50cy4gQWxzbyBjbGVhbnMgdXAgc29tZSBz
cGFjaW5nIGlzc3Vlcy4KPiA+ID4KPiA+ID4gU2lnbmVkLW9mZi1ieTogVmlzaGFsIE1vb2xhIChP
cmFjbGUpIDx2aXNoYWwubW9vbGFAZ21haWwuY29tPgo+ID4KPiA+IExHVE0sIHNvCj4gPiBSZXZp
ZXdlZC1ieTogR2VlcnQgVXl0dGVyaG9ldmVuIDxnZWVydCtyZW5lc2FzQGdsaWRlci5iZT4KPgo+
IEkgYXNzdW1lIHRoaXMgc2VyaWVzIGlzIHN1cHBvc2VkIHRvIGdvIHRocm91Z2ggc29tZSBtbSB0
cmVlPwoKSGkgQWRyaWFuLApJIHdhcyBnb2luZyB0byBoYXZlIEFuZHJldyB0YWtlIHRoaXMgdGhy
b3VnaCBtbS11bnN0YWJsZQpvbmNlIGl0IGdldHMgZW5vdWdoIHJldmlldy4KCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LXVtIG1haWxpbmcgbGlz
dApsaW51eC11bUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3Jn
L21haWxtYW4vbGlzdGluZm8vbGludXgtdW0K
