Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98BD7C3ABAC
	for <linux-um@archiver.kernel.org>; Tue,  6 May 2025 13:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6MuGPS2ySSDlOXD7jSIEnkN4LXNgvummQIZto8RtO/A=; b=swKJTS9u4fFCGml4S06UcXdCmc
	Dxj6qnQ+0echvtqZI9PCkQr4pdPxOhybXrF9esAlWRwuHdlym/2CExsCTt+TxtWqjSBldE5b2BlX7
	KZdlT99N820Zv0Co6xv6/6JOUGmSezb6f9acMkmXtVXyfkgutnZhcffs7EfJZe2Mn/k16dDww5loH
	ypjtUWBVb7hpMeEZ3NwYuj3eTLajctZ+2F4poP7nVdsbAVztw/7DBaUaNNbLSVV0+0MwX+jczILOX
	lb/AfsHge35zgjCngpFMMrKRmxoI6EnBWDX5TKMJiATH35HItjny6ByXRx5jSMofbulHSYqaCdaoQ
	h6Svhj2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCIF2-0000000C5Ln-2A9G;
	Tue, 06 May 2025 13:21:48 +0000
Received: from out-174.mta0.migadu.com ([91.218.175.174])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCFv7-0000000BdHE-2Kcz
	for linux-um@lists.infradead.org;
	Tue, 06 May 2025 10:53:07 +0000
Date: Tue, 6 May 2025 12:52:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746528769;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6MuGPS2ySSDlOXD7jSIEnkN4LXNgvummQIZto8RtO/A=;
	b=VTyXDrG59T5tyP6Rs9eEqTTHJxK8Tf+aNyp5H7Kap14LChkQyPU/rQPkFih+dJ9gTTwTnD
	gl6sw9KY8ssLno1yasZPvURFGE64lkPaM7FJb1+liF2dl+vuA7YyIR2ZagnfZ6zFI6hv04
	I3I7fFkU/0LrJy3tm9CaMjCsjuy0KnE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Nicolas Schier <nicolas.schier@linux.dev>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	Kees Cook <kees@kernel.org>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Nathan Chancellor <nathan@kernel.org>,
	Richard Weinberger <richard@nod.at>, linux-um@lists.infradead.org
Subject: Re: [PATCH] kbuild: introduce include/generated/global-rebuild.h
Message-ID: <20250506-innocent-calm-grouse-ebbc2e@l-nschier-aarch64>
References: <20250503084145.1994176-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250503084145.1994176-1-masahiroy@kernel.org>
Organization: AVM GmbH
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250506_035305_744941_5B388D18 
X-CRM114-Status: GOOD (  14.34  )
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

On Sat, May 03, 2025 at 05:41:43PM +0900, Masahiro Yamada wrote:
> Sometimes we need to trigger a global rebuild of the kernel tree -
> for instance, when any of the GCC plugins changes. [1]
> 
> This commit provides a simple mechanism to force a global rebuild
> using a single header file.
> 
> The top-level Makefile creates include/generated/global-rebuild.h if
> it does not exist, and this file is included by all kernel sources.
> 
> You can touch it in a build rule when a global rebuild is required.
> 
> The following is an example change to the GCC plugin build rule.
> 
>   quiet_cmd_plugin_cxx_so_c = HOSTCXX $@
>  -      cmd_plugin_cxx_so_c = $(HOSTCXX) $(plugin_cxxflags) $(plugin_ldflags) -o $@ $<
>  +      cmd_plugin_cxx_so_c = $(HOSTCXX) $(plugin_cxxflags) $(plugin_ldflags) -o $@ $<; touch include/generated/global-rebuild.h
> 
> Link: https://lore.kernel.org/linux-kbuild/CAK7LNATDbxc+3HQ6zoSk9t-Lkf4MSNmEUN6S5EqoVWnBQw_K6g@mail.gmail.com/T/#me069145443a17f0b464c13814424dbba0d970863 [1]
> Cc: Kees Cook <kees@kernel.org>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>  Makefile         | 9 ++++++++-
>  arch/um/Makefile | 3 ++-
>  2 files changed, 10 insertions(+), 2 deletions(-)
> 

Looks good to me, thanks!

Reviewed-by: Nicolas Schier <n.schier@avm.de>
Tested-by: Nicolas Schier <n.schier@avm.de>

