Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92E7DCCD1BF
	for <linux-um@archiver.kernel.org>; Tue, 28 Oct 2025 10:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CIDM+dygb2BUa46zAb+3HHz7zZDAxImWZVxBS/LTMHU=; b=KHPU1iCAvFlbiLIrJfGu2GJnxi
	40Bx0ColfH2DSEiLWUOd1GkK7dFpgjOBvecSu1jP8Nv2dt3CXbtD1T0ff0eEHI8V/v4CoIAv7kPcV
	Gxp2N/Aa78WHJV/1442YUwZuEMq5XhUKOF3Sx8La5HsBkEoAmrUmoSr7KFAHAj57NabY/0OXe9CUh
	ztwO5v9/ZNLNepMGUDOtjgH7ASyiSfYHynmbGa8gQypH112aZatlsCu7RvoP1ypE50aenUBFhHT5f
	SML7NJwY3dzDgxVj62SoqZF7vFuUto6zhaqpIHqTcei0sn0o/bCjLLufJcWAzf3u6GIs/EV1VRv5F
	93ywPc7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDgqH-0000000Fkpl-2HHo;
	Tue, 28 Oct 2025 10:22:17 +0000
Received: from out-183.mta0.migadu.com ([2001:41d0:1004:224b::b7])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDgqE-0000000Fjwl-2LP1
	for linux-um@lists.infradead.org;
	Tue, 28 Oct 2025 10:22:16 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761646700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CIDM+dygb2BUa46zAb+3HHz7zZDAxImWZVxBS/LTMHU=;
	b=Gja65oT6Ej3kxXJIiBfObdJr37XT53qezfnH3LsJZAnwoVZKN2tpcLv8CNpvLYIhbaGQV8
	qYlG2OEB/ZGBARDnNezC6stE3g2U73DKDbmDaNKrbU6L5iLqWTVVzt7rwN1anw7vmoHTxH
	cTMZA6ZmB0/KnSUdsXeqX13lpSlfBPw=
From: Tiwei Bie <tiwei.bie@linux.dev>
To: linux@weissschuh.net
Cc: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	johannes.berg@intel.com,
	linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	tiwei.btw@antgroup.com,
	tiwei.bie@linux.dev
Subject: Re: [PATCH] um: Avoid circular dependency on asm-offsets in pgtable.h
Date: Tue, 28 Oct 2025 18:17:50 +0800
Message-Id: <20251028101750.3263748-1-tiwei.bie@linux.dev>
In-Reply-To: <20251028-uml-offsets-circular-v1-1-601c363cfaaa@weissschuh.net>
References: <20251028-uml-offsets-circular-v1-1-601c363cfaaa@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251028_032214_758616_F4C63D87 
X-CRM114-Status: GOOD (  14.89  )
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

On Tue, 28 Oct 2025 10:02:55 +0100, Thomas Weißschuh wrote:
> Recent changes have added an include of as-layout.h to pgtable.h.
> However this introduces a circular dependency during asm-offsets
> generation as as-layout.h depends on asm-offsets and pgtable.h is an
> input for asm-offsets.
> 
> Building from a clean state results in the following error:
> 
>   CC      arch/um/kernel/asm-offsets.s
> In file included from arch/um/include/asm/pgtable.h:48,
>                  from include/linux/pgtable.h:6,
>                  from include/linux/mm.h:31,
>                  from include/linux/pid_namespace.h:7,
>                  from include/linux/ptrace.h:10,
>                  from include/linux/audit.h:13,
>                  from arch/um/kernel/asm-offsets.c:8:
> arch/um/include/shared/as-layout.h:9:10: fatal error: generated/asm-offsets.h: No such file or directory
>     9 | #include <generated/asm-offsets.h>
>       |          ^~~~~~~~~~~~~~~~~~~~~~~~~
> compilation terminated.
> make[4]: *** [scripts/Makefile.build:182: arch/um/kernel/asm-offsets.s] Error 1
> 
> As the inclusion of as-layout.h in pgtable.h is not yet needed while
> asm-offsets are generated, break the dependency here.
> 
> Fixes: a7f7dbae94a5 ("um: Remove file-based iomem emulation support")
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
>  arch/um/include/asm/pgtable.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/um/include/asm/pgtable.h b/arch/um/include/asm/pgtable.h
> index 1a0d7405e97c..3b42b0f45bf6 100644
> --- a/arch/um/include/asm/pgtable.h
> +++ b/arch/um/include/asm/pgtable.h
> @@ -45,7 +45,9 @@ extern unsigned long *empty_zero_page;
>   * area for the same reason. ;)
>   */
>  
> +#ifndef COMPILE_OFFSETS
>  #include <as-layout.h> /* for high_physmem */
> +#endif

Oops, my bad. Thanks for the fix!

Reviewed-by: Tiwei Bie <tiwei.btw@antgroup.com>

Regards,
Tiwei

