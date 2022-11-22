Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00878C4332F
	for <linux-um@archiver.kernel.org>; Tue, 22 Nov 2022 13:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SQg9hb45o1fM6OeFgUPHf4Ss4fToKY/IIQAL9espLqc=; b=Yu1uabWiQveDMg
	9kVA/K2rzBErFhsUSc0hfmCaCilSvEz6TRORQbfb9jFkUnpCKZVYnhgh+/x4N+P0cTza0Gw3teCs2
	22w2mTIUS8rBDYSdBUkdvqLJ547maIUseKPFgmZbik+ww5QkWW6qwJICyEBfL62h6/z9mZASm4aZT
	ooxBggztvGmPzsARejZVKtx4EFI6W2uUrFpBr0HE/8H277X5XoXZ9iyIV1dkLJMIeJLGrIxNxeNY2
	WkTxRnSe9SJEtvAa51k38INpIk1h2slsr+99RFJqTLVoeRgo8Hi8t2+4X8RF3VEJLzqf8pZOO1wYH
	2gDFHwWZNyEidsKUpOrQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxTkL-009lPb-Nw; Tue, 22 Nov 2022 13:55:33 +0000
Received: from mail-oo1-xc34.google.com ([2607:f8b0:4864:20::c34])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxTkI-009lNt-HF
	for linux-um@lists.infradead.org; Tue, 22 Nov 2022 13:55:32 +0000
Received: by mail-oo1-xc34.google.com with SMTP id r10-20020a4aa2ca000000b0049dd7ad4128so2252696ool.13
        for <linux-um@lists.infradead.org>; Tue, 22 Nov 2022 05:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2SBGeqgV8aQ4ClE1rxARDUjCn/QaGrg5bogBswoE+Gk=;
        b=SnJrJJJB+uAOWpogJlqoVY6znPbePuzs8v8E+Jasq1bg9moQq8Gbla8WPFPotFYdUs
         rdiNTyjJgUOpZ//qEmNSffWMfpXCemCqV4jqqOLcafNGMG3y7VzHk2z9V6YfIYYTp81D
         df5NkH3zm4zUw3PzBRdPGQ4f8CJIBaeUTQh9hasrwmNEXQM/Q4hIQ6dVrmQyovTykNlk
         RNdlw5G+f5UCJDWk4RkG0HUq6cWwz+Pat2UDROelcqWZxV0KlNgJCCVHtdzbVNto0nKe
         fES8l3XJEdiw4y/2lEdykL46NhCsN3MbN/y7RDB/FanhyNqBLX9zLaQeCHNrj9s0p+p2
         fKaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2SBGeqgV8aQ4ClE1rxARDUjCn/QaGrg5bogBswoE+Gk=;
        b=252FSgzaWSRL+APUPC4vpv3hQZ3pV89fRm94Noaaf/Q8LsSmaiQ/OaBmN2CoUrQ79F
         s+O9svpLwUn9A0MbfY199/TUeXmHdQxJAVh+Rqc/yX3lI3tWhbPJPUdcpFyEHz4o1rq1
         INbtUm/vHuGOmimiQXthres7PDSfD2Ri39xkBjpqfXPt8LUqtixteLFi3tCbBZrVDUOr
         YCnQS58zC4okO6dXspCMsXrdp/4ScodZwV+mWtxgyB0Nc+F29EN8TQgwoKqP6fqmGLa9
         V/WqeqGHH87GiI/zsdhs8rwo/Yl9lV9gtRjZ5JqO9NKYphvV0qhvLv1/ZDfUAZo/7LEV
         XBuA==
X-Gm-Message-State: ANoB5pnMyML+yTNRgawXHCpMPhtJ083Gr0eXnT+K0RsDb9kFfng+x/n5
	Du17j+1sMb+P+zg45lXosPjbfsXw924nuVjHya0=
X-Google-Smtp-Source: AA0mqf7ykzweR9BqX2Z1bFr3kRAAU5C3xDVsZgtZl+Svh5PRx1RmM9Dz5FRt4dxqYY1KiJhP24NikZC0YwM35U5Onhk=
X-Received: by 2002:a4a:d1b2:0:b0:498:ce46:9fb1 with SMTP id
 z18-20020a4ad1b2000000b00498ce469fb1mr6131515oor.97.1669125328656; Tue, 22
 Nov 2022 05:55:28 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wjKJyzfJmOzBdEOqCFRc8Fh-rdGM4tvMXfW0WXbbHwV0w@mail.gmail.com>
 <20221122105054.4062213-1-geert@linux-m68k.org> <alpine.DEB.2.22.394.2211221154280.284524@ramsan.of.borg>
In-Reply-To: <alpine.DEB.2.22.394.2211221154280.284524@ramsan.of.borg>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 22 Nov 2022 08:55:17 -0500
Message-ID: <CADnq5_PvouSKugXxJXqkVeZf+kbP8+hhUKFgVALSO=MOW3jzvA@mail.gmail.com>
Subject: Re: Build regressions/improvements in v6.1-rc6
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-staging@lists.linux.dev, linux-um@lists.infradead.org, 
	dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221122_055530_606887_BA25FDD5 
X-CRM114-Status: GOOD (  16.48  )
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

On Tue, Nov 22, 2022 at 5:56 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> On Tue, 22 Nov 2022, Geert Uytterhoeven wrote:
> > JFYI, when comparing v6.1-rc6[1] to v6.1-rc5[3], the summaries are:
> >  - build errors: +6/-0
>
>    + /kisskb/src/arch/sh/include/asm/io.h: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]:  => 239:34
>
> sh4-gcc11/sh-allmodconfig (in cvm_oct_free_hw_memory())
>
>    + /kisskb/src/arch/um/include/asm/processor-generic.h: error: called object is not a function or function pointer:  => 94:18
>    + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_topology.c: error: control reaches end of non-void function [-Werror=return-type]:  => 1934:1
>
> um-x86_64/um-all{mod,yes}config (in kfd_cpumask_to_apic_id())

Presumably cpu_data is not defined on um-x86_64?  Does it even make
sense to build drivers on um-x86_64?

Alex

>
>    + /kisskb/src/drivers/infiniband/hw/qib/qib_wc_x86_64.c: error: 'X86_VENDOR_AMD' undeclared (first use in this function):  => 149:37
>    + /kisskb/src/drivers/infiniband/hw/qib/qib_wc_x86_64.c: error: 'struct cpuinfo_um' has no member named 'x86_vendor':  => 149:22
>    + /kisskb/src/drivers/infiniband/hw/qib/qib_wc_x86_64.c: error: control reaches end of non-void function [-Werror=return-type]:  => 150:1
>
> um-x86_64/um-allyesconfig
>
> > [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/eb7081409f94a9a8608593d0fb63a1aa3d6f95d8/ (all 149 configs)
> > [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/094226ad94f471a9f19e8f8e7140a09c2625abaa/ (all 149 configs)
>
> Gr{oetje,eeting}s,
>
>                                                 Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                                             -- Linus Torvalds

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
