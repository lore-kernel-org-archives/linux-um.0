Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AC29C4332F
	for <linux-um@archiver.kernel.org>; Mon, 12 Dec 2022 10:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kkFCMkmpm2bmiDcRl3DXml0QiWhWZXJwXRZhQ4+6OZo=; b=XgK602kWUHOp3Q
	6gECuX5CfgglLPk+hRnLb4tXB/0Kyv0PxSJhIP2X+cG7A3RQ8voxkdcuujNsEwqgCJlXcHCS2Pgpx
	rqG3uPH24i4KrNNog0/GizT/6E0fL12PIljgnah6DHnavW0tGofldRUEavKZ2a5ExRQud/GqxzTlr
	/zaoOp3IsfOnc7X7cTrEHDJb+t4bzN4oY2wimOJ1Ke43IOWe+40JoWmuZa0jP+4LvmRq7GOnI5Esa
	GNCRx21Jn5XHboChTVKJRlUxfdhpAYT5C+elalhxfEtg855nSTFcT0bcce/aGpGfSf6lW/3Kp4c4B
	W9C7c/QKzedk382mxOaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p4ffn-00CDkG-ET; Mon, 12 Dec 2022 10:04:35 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p4ffi-00CDcf-Bj
	for linux-um@lists.infradead.org; Mon, 12 Dec 2022 10:04:32 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id A76F0B80BFA;
	Mon, 12 Dec 2022 10:04:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC35AC433EF;
	Mon, 12 Dec 2022 10:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1670839466;
	bh=ybMPHt3XK5/GwLcbilV5iJjyInjKq6N8fSXMSwjw0w4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jZXRm0+xMUamQOoyJMgDpKDJe/qJ1ET47c4mbaQZMUM07oID+liB5kygZNfkt+wbK
	 pt1TjwGxOkx83BqzCPCHVekD09z3vXNXFZppSaDh8Blr/NNWvm1qhyD24BsLWl7oEB
	 hvl7IsgGNqjKG+5IkoCdkmavvIFnCQX9PL7rk7g6AYGjQEWxTL7g2EA8klmAN3kYPO
	 sQzCMFFPb2FilWf3slHAELbJeA8Q+88Gz1BMUdatCxFyw2N4FdLEnTdaB7g3Kow/bX
	 aszJMbo2/J16qKfOwfXbX5uS4T50GZ4fnI8byF65cYisElDdl/l9DWHE8AQ/Dm/CZc
	 kx0JIWbvSvOLA==
Date: Mon, 12 Dec 2022 12:04:21 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org, linux-um@lists.infradead.org,
	linux-rdma@vger.kernel.org
Subject: Re: Build regressions/improvements in v6.1
Message-ID: <Y5b8pa75a9EbCwPv@unreal>
References: <CAHk-=wj_HcgFZNyZHTLJ7qC2613zphKDtLh6ndciwopZRfH0aQ@mail.gmail.com>
 <20221212084219.1424746-1-geert@linux-m68k.org>
 <alpine.DEB.2.22.394.2212120951140.5685@ramsan.of.borg>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2212120951140.5685@ramsan.of.borg>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221212_020430_595931_6786F812 
X-CRM114-Status: GOOD (  16.84  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

On Mon, Dec 12, 2022 at 09:51:55AM +0100, Geert Uytterhoeven wrote:
> On Mon, 12 Dec 2022, Geert Uytterhoeven wrote:
> > JFYI, when comparing v6.1[1] to v6.1-rc8[3], the summaries are:
> >  - build errors: +3/-1
> 
>   + /kisskb/src/drivers/infiniband/sw/rdmavt/qp.c: error: 'struct cpuinfo_um' has no member named 'x86_cache_size':  => 88:22
>   + /kisskb/src/drivers/infiniband/sw/rdmavt/qp.c: error: control reaches end of non-void function [-Werror=return-type]:  => 89:1
>   + /kisskb/src/drivers/infiniband/sw/rdmavt/qp.c: error: implicit declaration of function '__copy_user_nocache' [-Werror=implicit-function-declaration]:  => 100:2
> 
> um-x86_64/um-all{mod,yes}config

We have a fix in rdma-next: 323a74fc20f5 ("RDMA: Disable IB HW for UML")

Thanks

> 
> > [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/830b3c68c1fb1e9176028d02ef86f3cf76aa2476/ (all 152 configs)
> > [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/76dcd734eca23168cb008912c0f69ff408905235/ (all 152 configs)
> 
> Gr{oetje,eeting}s,
> 
> 						Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
> 							    -- Linus Torvalds

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
