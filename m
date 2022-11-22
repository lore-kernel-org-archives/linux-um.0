Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79894C4332F
	for <linux-um@archiver.kernel.org>; Tue, 22 Nov 2022 10:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:In-Reply-To:
	Subject:cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CgeuJ7FYiQLib8KW6FYoM0Po70IKs6289Dq3feIfypw=; b=KbZ5DKpXEzgL/zY9dYMB6R1w9e
	+3T8id6nstoXOUEDPUzk6cUylSQA5Vu5zVXMY4bXrt1jEzTLzStGkqUa1Epn+80MMxeaML4ol0K4R
	bCvm6WmrtbP2yv8BWlQfqgLwQaXNIPLvEvZZyz5Huda5vApeaZ0x/xadHLxgm/IzWhRKjQC7QMHc0
	w2+aD9DvonRb69zA+9zQfS/nsRc32h01STmA+bq5WIBdxjlQ8o8z2mJ2YSohQK818WxUq4Ro5GvQO
	mCyYcnGYcuU6A9My4d/WOTYgNaDnjC91kyON0xujGbxeuoOqjqOXX98PLeC9vXLg9EFAgvE7QlFEL
	Fo2lHxMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxQxH-008CJY-5W; Tue, 22 Nov 2022 10:56:43 +0000
Received: from albert.telenet-ops.be ([2a02:1800:110:4::f00:1a])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxQxD-008CGh-Bp
	for linux-um@lists.infradead.org; Tue, 22 Nov 2022 10:56:41 +0000
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed10:4821:1ba5:2638:5c3a])
	by albert.telenet-ops.be with bizsmtp
	id nNwZ2800A5WXlCv06NwZjj; Tue, 22 Nov 2022 11:56:33 +0100
Received: from geert (helo=localhost)
	by ramsan.of.borg with local-esmtp (Exim 4.93)
	(envelope-from <geert@linux-m68k.org>)
	id 1oxQx6-001C3A-OH; Tue, 22 Nov 2022 11:56:32 +0100
Date: Tue, 22 Nov 2022 11:56:32 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
X-X-Sender: geert@ramsan.of.borg
To: linux-kernel@vger.kernel.org
cc: linux-staging@lists.linux.dev, amd-gfx@lists.freedesktop.org, 
    dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org, 
    linux-um@lists.infradead.org
Subject: Re: Build regressions/improvements in v6.1-rc6
In-Reply-To: <20221122105054.4062213-1-geert@linux-m68k.org>
Message-ID: <alpine.DEB.2.22.394.2211221154280.284524@ramsan.of.borg>
References: <CAHk-=wjKJyzfJmOzBdEOqCFRc8Fh-rdGM4tvMXfW0WXbbHwV0w@mail.gmail.com> <20221122105054.4062213-1-geert@linux-m68k.org>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221122_025639_588636_FE174279 
X-CRM114-Status: GOOD (  13.33  )
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

On Tue, 22 Nov 2022, Geert Uytterhoeven wrote:
> JFYI, when comparing v6.1-rc6[1] to v6.1-rc5[3], the summaries are:
>  - build errors: +6/-0

   + /kisskb/src/arch/sh/include/asm/io.h: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]:  => 239:34

sh4-gcc11/sh-allmodconfig (in cvm_oct_free_hw_memory())

   + /kisskb/src/arch/um/include/asm/processor-generic.h: error: called object is not a function or function pointer:  => 94:18
   + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_topology.c: error: control reaches end of non-void function [-Werror=return-type]:  => 1934:1

um-x86_64/um-all{mod,yes}config (in kfd_cpumask_to_apic_id())

   + /kisskb/src/drivers/infiniband/hw/qib/qib_wc_x86_64.c: error: 'X86_VENDOR_AMD' undeclared (first use in this function):  => 149:37
   + /kisskb/src/drivers/infiniband/hw/qib/qib_wc_x86_64.c: error: 'struct cpuinfo_um' has no member named 'x86_vendor':  => 149:22
   + /kisskb/src/drivers/infiniband/hw/qib/qib_wc_x86_64.c: error: control reaches end of non-void function [-Werror=return-type]:  => 150:1

um-x86_64/um-allyesconfig

> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/eb7081409f94a9a8608593d0fb63a1aa3d6f95d8/ (all 149 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/094226ad94f471a9f19e8f8e7140a09c2625abaa/ (all 149 configs)

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
