Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF837C4332F
	for <linux-um@archiver.kernel.org>; Mon, 12 Dec 2022 08:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:In-Reply-To:
	Subject:cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=84NVbnCUDYgAjsPW1x8PLAhTan9qB53kpkVhJ2yWqnE=; b=3r3bJ+/t7r9WnFjCbvXs/NZKFQ
	PUQ8wX+FSqoJBvuvIYYNC0AHaELQa4hQhlGv1LiJN3k8EBNR4eO7lo9mpSDZ0MnFhW5W8rCzCQGll
	EQp02Ueops/pTLmnIt/vd59/4HXVfxvppJj8B4eXWCAmN5204/ip8hrHKL160qnJF+Vg0ZowFqxOF
	zVzFnV56r98R+Z1/mftT07mpTeoXNLvu+s58iBpVo3OgqredeIYqdLjA9/FUsExLMRI3DNNDTIWEi
	0hClixSOzpcp9RXv5OKawAB6rWALvapYUM7Li7qaV2K7XsnVfiutxUilVJbyHiKDLkBBUNh7AuSUW
	lM+KDWsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p4eXn-00Ab2U-Or; Mon, 12 Dec 2022 08:52:15 +0000
Received: from michel.telenet-ops.be ([2a02:1800:110:4::f00:18])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p4eXj-00AaiC-3K
	for linux-um@lists.infradead.org; Mon, 12 Dec 2022 08:52:13 +0000
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed10:e0b1:47d7:2716:fd3])
	by michel.telenet-ops.be with bizsmtp
	id vLrv2800Z3pMg3v06LrvC2; Mon, 12 Dec 2022 09:51:56 +0100
Received: from geert (helo=localhost)
	by ramsan.of.borg with local-esmtp (Exim 4.93)
	(envelope-from <geert@linux-m68k.org>)
	id 1p4eXT-0001Tw-JD; Mon, 12 Dec 2022 09:51:55 +0100
Date: Mon, 12 Dec 2022 09:51:55 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
X-X-Sender: geert@ramsan.of.borg
To: linux-kernel@vger.kernel.org
cc: linux-um@lists.infradead.org, linux-rdma@vger.kernel.org
Subject: Re: Build regressions/improvements in v6.1
In-Reply-To: <20221212084219.1424746-1-geert@linux-m68k.org>
Message-ID: <alpine.DEB.2.22.394.2212120951140.5685@ramsan.of.borg>
References: <CAHk-=wj_HcgFZNyZHTLJ7qC2613zphKDtLh6ndciwopZRfH0aQ@mail.gmail.com> <20221212084219.1424746-1-geert@linux-m68k.org>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221212_005211_353282_3BA59BBB 
X-CRM114-Status: GOOD (  11.97  )
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

On Mon, 12 Dec 2022, Geert Uytterhoeven wrote:
> JFYI, when comparing v6.1[1] to v6.1-rc8[3], the summaries are:
>  - build errors: +3/-1

   + /kisskb/src/drivers/infiniband/sw/rdmavt/qp.c: error: 'struct cpuinfo_um' has no member named 'x86_cache_size':  => 88:22
   + /kisskb/src/drivers/infiniband/sw/rdmavt/qp.c: error: control reaches end of non-void function [-Werror=return-type]:  => 89:1
   + /kisskb/src/drivers/infiniband/sw/rdmavt/qp.c: error: implicit declaration of function '__copy_user_nocache' [-Werror=implicit-function-declaration]:  => 100:2

um-x86_64/um-all{mod,yes}config

> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/830b3c68c1fb1e9176028d02ef86f3cf76aa2476/ (all 152 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/76dcd734eca23168cb008912c0f69ff408905235/ (all 152 configs)

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
