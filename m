Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 434FCCAC592
	for <linux-um@archiver.kernel.org>; Mon, 15 Sep 2025 15:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=L6dZCTCv0ekTvnB79bPrbUgTG6ZUXUIE32/eXsGwtiQ=; b=Je7FAFRhP4qFnBCznSNSEB0E3m
	ii08ae0F9VTVTMrdy5DxqViBlftXkdH20gqHif2N2egaTnmc4kXonCB54/vTVDhHM8uDuA7K593j4
	6cTwa/npkIOMTSj7PVR31kVxJsxWYOaTitnWxZrXUJwd98vgeVRjoU4RXMmBlOHhtoTkTxoVugmwN
	gGIwzlhzydrMweguPdGqd5gJ8XAD6mz8iV4cyr/2+g0Vrsm6JebPbi5OpUZiG1O3k+3QCfFM64bsg
	/dawRnfx+vXgVwLA16S/EnSQ8HSa7/L2j6dgG24SBLZBoWtCnFPyOo6H0upsPXz2AIQCq1mqVM1D6
	K5g4xWww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyB9T-00000004x4n-2Sam;
	Mon, 15 Sep 2025 15:29:59 +0000
Received: from out-181.mta1.migadu.com ([2001:41d0:203:375::b5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyB9Q-00000004x3G-28r8
	for linux-um@lists.infradead.org;
	Mon, 15 Sep 2025 15:29:58 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757950194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L6dZCTCv0ekTvnB79bPrbUgTG6ZUXUIE32/eXsGwtiQ=;
	b=H1O0tI4xGB0N/hHGuYWlm1DaRSWuGnkMIm6DnAl5J4mhDHjS+7EWDUaD4DZDSAOMmEF2yi
	ERwuU8Uym25TORvIAdm2tn2Wr5rpUnP5r9oCj9xCj+6E/aYLxIdlooA/h+SGmYvNz8+2sX
	uK9o+HvEXVChBMrXpVRYAVSXcy9WxLo=
From: Tiwei Bie <tiwei.bie@linux.dev>
To: arnd@arndb.de
Cc: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	benjamin@sipsolutions.net,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-um@lists.infradead.org,
	tiwei.btw@antgroup.com,
	tiwei.bie@linux.dev
Subject: Re: [PATCH v3 6/7] asm-generic: percpu: Add assembly guard
Date: Mon, 15 Sep 2025 23:29:30 +0800
Message-Id: <20250915152930.2654981-1-tiwei.bie@linux.dev>
In-Reply-To: <a10395f7-6666-4bdb-9aa0-bdd873029cc9@app.fastmail.com>
References: <a10395f7-6666-4bdb-9aa0-bdd873029cc9@app.fastmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250915_082957_189240_377DA2F6 
X-CRM114-Status: GOOD (  15.38  )
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

On Mon, 15 Sep 2025 09:40:35 +0200, Arnd Bergmann wrote:
> On Sun, Sep 14, 2025, at 17:56, Tiwei Bie wrote:
> > From: Tiwei Bie <tiwei.btw@antgroup.com>
> >
> > Currently, asm/percpu.h is directly or indirectly included by
> > some assembly files on x86. Some of them (e.g., checksum_32.S)
> > are also used on um. But x86 and um provide different versions
> > of asm/percpu.h -- um uses asm-generic/percpu.h directly.
> >
> > When SMP is enabled, asm-generic/percpu.h will introduce C code
> > that cannot be assembled. Since asm-generic/percpu.h currently
> > is not designed for use in assembly, and these assembly files
> > do not actually need asm/percpu.h on um, let's add the assembly
> > guard in asm-generic/percpu.h to fix this issue.
> >
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: linux-arch@vger.kernel.org
> > Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
> 
> Have you tried if you can remove the percpu.h dependency from
> the files that currently include it? In many cases it should
> be enough to use percpu-defs.h.

It doesn't seem to work. The indirect inclusion of asm/percpu.h
comes from asm/nospec-branch.h, which expands DECLARE_PER_CPU()
and thus requires asm/percpu.h.

> 
> If that doesn't work, I have no objections to this patch either.
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Thanks! :)

Regards,
Tiwei

