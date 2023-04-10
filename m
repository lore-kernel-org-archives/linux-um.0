Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB3C2C77B61
	for <linux-um@archiver.kernel.org>; Mon, 10 Apr 2023 07:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:cc:To:From:Date:Reply-To:
	Subject:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=nSmj0MOzWC3Vu3nHmAf6GKID2Tn9+uQ1LvjOggC6FIo=; b=P55k1ddZdjsT7JL8LQQIRBJGIM
	MtyaR7hs/LbGhI9mvKQs5/cFpX/TmXvuDwm2+buou2WGI204QKeaZ/Te1RKtqH7BSLGgmpIGytpIb
	bHMqR3YisYG9tKDb0v7z82aXNZ4DQsyvhoWmxpknC0RNeDCGwlI/DWu4KVrluUUGfDgTQdovjuOKh
	AADA+rsFoKjH5ggvTX7XxyMdIaMfm5RcJHP97Cl86iqRb7LlqFPznTEXzAderXE6cE/NKPKMMckHU
	GqRmKGoStst4Jg4BeARbQqCinJwZot6GDOIgryRC44dP5f1TZnHjNjAufQV2lErgEcn6linXEOBbo
	FM0n3TdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1plmJT-00Ekvf-2o;
	Mon, 10 Apr 2023 07:51:43 +0000
Received: from andre.telenet-ops.be ([2a02:1800:120:4::f00:15])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1plmJQ-00Ektp-12
	for linux-um@lists.infradead.org;
	Mon, 10 Apr 2023 07:51:42 +0000
Received: from ramsan.of.borg ([84.195.187.55])
	by andre.telenet-ops.be with bizsmtp
	id ivrV2900K1C8whw01vrVX8; Mon, 10 Apr 2023 09:51:30 +0200
Received: from geert (helo=localhost)
	by ramsan.of.borg with local-esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1plmJF-00GRpq-NG;
	Mon, 10 Apr 2023 09:51:29 +0200
Date: Mon, 10 Apr 2023 09:51:29 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: linux-kernel@vger.kernel.org
cc: amd-gfx@lists.freedesktop.org, linux-um@lists.infradead.org, 
    linux-wireless@vger.kernel.org, linux-sh@vger.kernel.org
Message-ID: <d11fd65-983a-8657-f742-34a326173ee3@linux-m68k.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230410_005140_514392_568B2C9A 
X-CRM114-Status: GOOD (  11.15  )
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

On Mon, 10 Apr 2023, Geert Uytterhoeven wrote:
> JFYI, when comparing v6.3-rc6[1] to v6.3-rc5[3], the summaries are:
>  - build errors: +2/-0

   + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_topology.c: error: 'struct cpuinfo_um' has no member named 'apicid': 2157:48 => 2157:48, 2157:41

um-x86_64/um-allmodconfig
um-x86_64-gcc12/um-all{yes,mod}config

seen before

   + /kisskb/src/drivers/net/wireless/cisco/airo.c: error: 'status_rid.currentXmitRate' is used uninitialized [-Werror=uninitialized]:  => 6163:45

v6.3-rc6/sh4-gcc11/sh-allmodconfig

seen before

> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/09a9639e56c01c7a00d6c0ca63f4c7c41abe075d/ (all 152 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/7e364e56293bb98cae1b55fd835f5991c4e96e7d/ (all 152 configs)

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
