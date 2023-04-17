Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83606C77B70
	for <linux-um@archiver.kernel.org>; Mon, 17 Apr 2023 07:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:In-Reply-To:
	Subject:cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WfNb4QpMCaMDkAAHauv3xSA7QOEEE/LXJu20ewbPE7k=; b=tDQrLSfZ3bmcP0RcIRQia45kOI
	5PmGANXtFwkBx3kgUwvaFwjvavhKaTaqayNxcfTZeuo7hmj6scuNsFO0f5LXEbqIHT9mOxOVQd4ek
	OOvP0//VYHqLkJscnfzQ2xkKUhs0CVXC6+GmrXMFo41pyoNsHv2iBg3P/Jrgucw86fqhngKo7x47x
	7p9EvG+DEgeSIroq+4YaV5UIzRJw8AX2Co3m8rQkk435Aha//opDkBTjS12jgg2IO3LXPYtOCQEYN
	h1uVbh2wdVIZDEsqUnAB4fWEodCuAwWLu041lgFT94EyVhjUM28iXjEgiC1H0yuptoe2zq1Rrvkzn
	+N+Uih2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1poJ8b-00F9ay-0n;
	Mon, 17 Apr 2023 07:18:57 +0000
Received: from albert.telenet-ops.be ([2a02:1800:110:4::f00:1a])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1poJ8W-00F9aH-1q
	for linux-um@lists.infradead.org;
	Mon, 17 Apr 2023 07:18:54 +0000
Received: from ramsan.of.borg ([84.195.187.55])
	by albert.telenet-ops.be with bizsmtp
	id ljJk2900L1C8whw06jJk4X; Mon, 17 Apr 2023 09:18:46 +0200
Received: from geert (helo=localhost)
	by ramsan.of.borg with local-esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1poJ8O-00GyYx-Gn;
	Mon, 17 Apr 2023 09:18:44 +0200
Date: Mon, 17 Apr 2023 09:18:44 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: linux-kernel@vger.kernel.org
cc: linux-spi@vger.kernel.org, linux-um@lists.infradead.org
Subject: Re: Build regressions/improvements in v6.3-rc7
In-Reply-To: <20230417071429.965980-1-geert@linux-m68k.org>
Message-ID: <1ab2158e-dda-c1c5-4a3b-301cd41f9ef@linux-m68k.org>
References: <CAHk-=wjwK59PegTZb9r=EVuCPwbigcbbby5AwEboMBgykhL-KA@mail.gmail.com> <20230417071429.965980-1-geert@linux-m68k.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230417_001852_768738_87ABD544 
X-CRM114-Status: GOOD (  12.82  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

On Mon, 17 Apr 2023, Geert Uytterhoeven wrote:
> JFYI, when comparing v6.3-rc7[1] to v6.3-rc6[3], the summaries are:
>  - build errors: +1/-2

   + /kisskb/src/drivers/spi/spi-stm32-qspi.c: error: 'op' is used uninitialized [-Werror=uninitialized]:  => 564:27, 523:27

um-x86_64-gcc12/um-all{mod,yes}config

Seen before, and looks completely bogus to me, unless there's a bug in
the UML implementation of memcpy() and memset(), which are used to
initialize "op".

> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/6a8f57ae2eb07ab39a6f0ccad60c760743051026/ (all 152 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/09a9639e56c01c7a00d6c0ca63f4c7c41abe075d/ (all 152 configs)

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
