Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D860BC678D4
	for <linux-um@archiver.kernel.org>; Mon,  6 Mar 2023 08:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:In-Reply-To:
	Subject:cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tgZA4bEbRv1jAkonxOrRPWEf69cSCDjLepLH1MhNWfA=; b=sFkY3PMPFkB5J2AGbjDkY0bJv/
	/qVrKMONq7TpOW4cBM7jqX/WoGFG042pCOFxUbBoz9kQKsGixOHqFZOcQXaiCxRMg1zqnhhzDbEW1
	RdDvBsGmjG1AvkGR9yLKzd2fEVcYb3R02IJcm/0aVFkZvdBQwwpqeWHVQhuKFl0fI/eJiGP208pWP
	VDk3YkczsZkICGN+zjq9E2erjqwRht1U1eamhneERN+7d//FRofO2NwSpjHy/bWbwBoMoX/jOsTUc
	53fjVDZUvga+4nuOm/StnWADqPeysMTs10hk3SWVMcVsW+ezoTLjzy427pIiJXHSCfmixXIhbmnrH
	pnJLlf4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZ6R4-00BxB7-TK; Mon, 06 Mar 2023 08:43:10 +0000
Received: from albert.telenet-ops.be ([2a02:1800:110:4::f00:1a])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZ6R1-00Bx6m-EQ
	for linux-um@lists.infradead.org; Mon, 06 Mar 2023 08:43:09 +0000
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed50:b745:671d:a946:57fa])
	by albert.telenet-ops.be with bizsmtp
	id Uwiy2900F4LuvSS06wiyHW; Mon, 06 Mar 2023 09:42:59 +0100
Received: from geert (helo=localhost)
	by ramsan.of.borg with local-esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1pZ6Qs-00AzRe-ER;
	Mon, 06 Mar 2023 09:42:58 +0100
Date: Mon, 6 Mar 2023 09:42:58 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: linux-kernel@vger.kernel.org
cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
    linux-um@lists.infradead.org, linux-media@vger.kernel.org, 
    linux-btrfs@vger.kernel.org, linux-sh@vger.kernel.org
Subject: Re: Build regressions/improvements in v6.3-rc1
In-Reply-To: <20230306082035.3709036-1-geert@linux-m68k.org>
Message-ID: <148a4a5f-d228-e289-f333-8d5df6cad4f5@linux-m68k.org>
References: <CAHk-=wgr1D8hb75Z+nn+4LXUnosp0HM+gP+YJEcEav1DgTC=Cw@mail.gmail.com> <20230306082035.3709036-1-geert@linux-m68k.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230306_004307_690686_5AC6EB87 
X-CRM114-Status: GOOD (  16.41  )
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

On Mon, 6 Mar 2023, Geert Uytterhoeven wrote:
> Below is the list of build error/warning regressions/improvements in
> v6.3-rc1[1] compared to v6.2[2].
>
> Summarized:
>  - build errors: +9/-14
>  - build warnings: +4/-1447
>
> Happy fixing! ;-)
>
> Thanks to the linux-next team for providing the build service.
>
> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/fe15c26ee26efa11741a7b632e9f23b01aca4cc6/ (all 152 configs)
> [2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/c9c3395d5e3dcc6daee66c6908354d47bf98cb0c/ (all 152 configs)
>
>
> *** ERRORS ***
>
> 9 error regressions:
>  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_topology.c: error: 'struct cpuinfo_um' has no member named 'apicid':  => 2157:41, 2157:48

um-x86_64/um-all{mod,yes}config
um-x86_64-gcc12/um-all{mod,yes}config

>  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn31/display_mode_vba_31.c: error: the frame size of 2208 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]:  => 7086:1

arm64-gcc5/arm64-allmodconfig

(Already improved from 2224 to 2208 bytes)

>  + /kisskb/src/drivers/gpu/drm/msm/msm_mdss.c: error: case label does not reduce to an integer constant:  => 299:2, 300:2, 296:2

powerpc-gcc5/{ppc32,ppc64_book3e,ppc64le}_allmodconfig
powerpc-gcc5/powerpc-all{mod,yes}config
arm64-gcc5/arm64-allmodconfig

>  + /kisskb/src/drivers/media/i2c/imx290.c: error: 'imx290_runtime_resume' defined but not used [-Werror=unused-function]:  => 1082:12
>  + /kisskb/src/drivers/media/i2c/imx290.c: error: 'imx290_runtime_suspend' defined but not used [-Werror=unused-function]:  => 1090:12

m68k-gcc{8,11}/m68k-allmodconfig
parisc-gcc{8,11}/parisc-allmodconfig
s390x-gcc11/s390-all{mod,yes}config

Fix available since Feb 7.

>  + /kisskb/src/fs/btrfs/inode.c: error: 'location.type' may be used uninitialized [-Werror=maybe-uninitialized]:  => 5730:21

sparc64-gcc11/sparc{,64}-allmodconfig
parisc-gcc11/parisc-allmodconfig

>  + /kisskb/src/fs/btrfs/send.c: error: 'right_gen' may be used uninitialized in this function [-Werror=maybe-uninitialized]:  => 1909:13, 1902:23

powerpc-gcc5/powerpc-all{mod,yes}config
powerpc-gcc5/{ppc32,ppc64_book3e,ppc64le}_allmodconfig
powerpc-gcc5/{ppc64,ppc64le,pseries,pseries_le,skiroot}_defconfig

>  + /opt/cross/kisskb/fe-x86-64-core-i7-2017.05/x86_64-buildroot-linux-gnu/sysroot/usr/include/bits/stdlib-float.h: error: SSE register return with SSE disabled:  => 27:1

um-x86_64/um-allyesconfig

>  + {standard input}: Error: unknown pseudo-op: `.':  => 1118

sh4-gcc11/sh-all{mod,yes}config (ICE)

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
