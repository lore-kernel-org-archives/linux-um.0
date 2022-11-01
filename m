Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A2C4FA373D
	for <linux-um@archiver.kernel.org>; Tue,  1 Nov 2022 08:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:In-Reply-To:
	Subject:cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7UKeHrBtSqoK0wJQeOn/qUQrMf6Ednuq1S5VZkbDVAA=; b=SSlUxPFg+Er3tU/6ox8IEJjETb
	g4yK87l9CYf7g0YU+foIxGpQAGxCizdd1B1vkEv3oCrQY31yKQrFtP6mZFFLCwUga4365bmJo6c7b
	+ns9pWDtL2UroF5uJk2YxY3fUNwxVQpnb2Pqvk/aNHQHxHo0zrG7eCswlOWD4Z2Y7slHnCp8lEQPf
	jmN80eCavyNcTYemvN/GHE38+sadQ/bqLT5hkL0/bnBuLaLYWavvtca7nC3pxmjpekuT07vvBDC1e
	jOGy2FrrT1OXed/NdQKYyMJ/ohAM8hhhYTu/ikblVdiwYfbyfnZ9LJ1WN97rC8NqfeQWqf+j2LT7K
	DKPqTKOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1opmJo-00343F-Ek; Tue, 01 Nov 2022 08:08:20 +0000
Received: from laurent.telenet-ops.be ([2a02:1800:110:4::f00:19])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1opmJg-0033hb-WB
	for linux-um@lists.infradead.org; Tue, 01 Nov 2022 08:08:19 +0000
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed10:cd8a:284a:a448:1949])
	by laurent.telenet-ops.be with bizsmtp
	id ew832800N2kye1T01w84Ru; Tue, 01 Nov 2022 09:08:04 +0100
Received: from geert (helo=localhost)
	by ramsan.of.borg with local-esmtp (Exim 4.93)
	(envelope-from <geert@linux-m68k.org>)
	id 1opmJX-002GBw-KJ; Tue, 01 Nov 2022 09:08:03 +0100
Date: Tue, 1 Nov 2022 09:08:03 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
X-X-Sender: geert@ramsan.of.borg
To: linux-kernel@vger.kernel.org
cc: linux-mips@vger.kernel.org, linux-rdma@vger.kernel.org, 
    linux-um@lists.infradead.org
Subject: Re: Build regressions/improvements in v6.1-rc3
In-Reply-To: <20221101080246.795789-1-geert@linux-m68k.org>
Message-ID: <alpine.DEB.2.22.394.2211010906390.538850@ramsan.of.borg>
References: <CAHk-=wgJVNe4mUxGJE5B-_GMg0oOgxkZz3UxehVRiCT3QvoZ0w@mail.gmail.com> <20221101080246.795789-1-geert@linux-m68k.org>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221101_010813_229917_EEB6EDAD 
X-CRM114-Status: GOOD (  13.10  )
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

On Tue, 1 Nov 2022, Geert Uytterhoeven wrote:
> JFYI, when comparing v6.1-rc3[1] to v6.1-rc2[3], the summaries are:
>  - build errors: +4/-0

   + /kisskb/src/arch/sh/include/asm/io.h: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]:  => 239:34

sh4-gcc11/sh-allmodconfig
cvmx_ptr_to_phys() should return physaddr_t instead (patch sent)

   + /kisskb/src/drivers/infiniband/sw/rdmavt/qp.c: error: 'struct cpuinfo_um' has no member named 'x86_cache_size':  => 88:22
   + /kisskb/src/drivers/infiniband/sw/rdmavt/qp.c: error: control reaches end of non-void function [-Werror=return-type]:  => 89:1
   + /kisskb/src/drivers/infiniband/sw/rdmavt/qp.c: error: implicit declaration of function '__copy_user_nocache' [-Werror=implicit-function-declaration]:  => 100:2

um-x86_64/um-all{mod,yes}config

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							     - Linus Torvalds

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
