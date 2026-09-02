Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B990C61DD6
	for <linux-um@archiver.kernel.org>; Wed,  2 Sep 2026 17:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BYnxpZ5PuXcKYcCY+vQ9h01RB6KiigJqE6JVM0/EOWY=; b=TiVKWfFfi9s3n1oCAqnYY4XyY4
	+SUXIsfxnYVV1pHVutiByldJ0xnbvpU6aEkgEJEkTjBHLAtTY7IlqiTZXQsGAfXhAjdl8piSuruR6
	s0Hp6o4tHeKxi/joR/AQJTYB2VhlLrMmeq3OpnnX+7cRmmAeiNYtPpOEtJml8waDAd3hKmGD195mP
	1qauoyj7kkMTb8R+ztZIOZ/wzr2/0Czt8PEPHdZy/YNAdUWPeEWtvRbsfvrjgRuDnGWxLFhXjLjkc
	CaugZLVdeXmGj3tFWnLuHBaa9Qtom0F/RapJs5/lZUb6aAc3iV204UDDHDButukWkKbtXKPcTXmbQ
	kERFbXsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1oVV-0000000FPRU-2MiM;
	Wed, 02 Sep 2026 17:12:17 +0000
Received: from mail.alien8.de ([2a01:4f9:3051:3f93::2])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1oVS-0000000FPQ4-1Va9
	for linux-um@lists.infradead.org;
	Wed, 02 Sep 2026 17:12:16 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id DD9BF40E024B;
	Wed,  2 Sep 2026 17:12:09 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id PrFqerI28FwX; Wed,  2 Sep 2026 17:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1788369119; bh=BYnxpZ5PuXcKYcCY+vQ9h01RB6KiigJqE6JVM0/EOWY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VFo0VC5yDMFz9x4xJVqpMuX5QSExt3QmhkPOx6kWaDCARZQGlOLfarhmUjSG7wWwS
	 PzwWYnKuNN1RhtsfoE5oyKuWeSETTiYjq1uBHWxR8SIMK+fUuD/m0iIE41P89Eq01S
	 pqnk4BThuLg2bdx3dGNpA4wzTHuCOvNBi+wC2bw+fSdfTf/GsYLKmaLa9pOGNTtVAN
	 Nxj9HD6kkULdCv9jgV0411H5lwnLuvTQCCyPZssnEEddJ5rY6PS71YbjbR/+OIVdGv
	 474i6Uh0dZxDDGA7sl5HdVGPmKyOz8U3nqMK+586CRLE0I9rRrDQpo1L/Chs67Nra5
	 GsdKRiomMuzYIvC9F/sPWAo7nDDicoSA0DQ9PndoknAGkIr5MSpG2DOLAARibk0HB6
	 WV4TIiDdwP2gf4pDekZhlvEtL1LF1qUHUSo1SHaQPDxwZOODHyHFOAyR4l1D9D6U3H
	 gBEBjhejERQXpQNuRalRFn+K1o6W708YU8juwFqMMY3KQlbHNb4D+G7gtv/B8VG6jy
	 db1vMbk0exYnV9aeP3VKZ1pKc0bJiwiMCtk2f2ucEFySNq5wPjn5lyFxFOFSYwrJwa
	 DaF0l2q+GHZaXcA+2d3V11EM8EGk9IBmCeNB8KbsK67lnHAdMJcNZgGQlZtLogU8sL
	 dcCMcKKrO9Hm/Kx3WcoBaOUE=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1325840E027F;
	Wed,  2 Sep 2026 17:11:50 +0000 (UTC)
Date: Wed, 2 Sep 2026 10:11:47 -0700
From: Borislav Petkov <bp@alien8.de>
To: Eric Biggers <ebiggers@kernel.org>
Cc: x86@kernel.org, linux-um@lists.infradead.org,
	linux-raid@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v5 0/8] x86: Remove cpu_has_xfeatures() and add AVX-512
 xor_gen()
Message-ID: <20260902171147.GKaphY04eCQFoweH04@fat_crate.local>
References: <20260901145740.42337-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260901145740.42337-1-ebiggers@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260902_101214_553543_DC7D1736 
X-CRM114-Status: UNSURE (   8.52  )
X-CRM114-Notice: Please train this message.
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
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

On Tue, Sep 01, 2026 at 07:57:32AM -0700, Eric Biggers wrote:
> Please consider this series for the x86 tree for 7.4.

Yeah, lemme take a look.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

