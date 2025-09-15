Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B919ECAC597
	for <linux-um@archiver.kernel.org>; Mon, 15 Sep 2025 08:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xj+WLtDNql0I4tYiND8z1MyE4WwjKBHaNScbyyZDAz8=; b=TV7vw2rO65AnxVDIC2UVzi6mve
	Gvrkfp9SVYewKeTD3s41EFSS0gH3AETQZ0UMLXBT9w5V0C7XZPot+lMKinnB1hh0Q0HDoTDLCfuMZ
	YnSaqeUIRx6zr2swjaPgwir4ah4H7TcwrF5au+0yOb5GF1EutSiK/apfV2kq2odvU+QbKneVBgnjw
	y2gd6Jm5Z0yWExZQUI22Cbk4CquE4UXG2okTI2DcH9+ocZ/sw+PjbHkr9Q6HsUqmc+aV2ATjX/wip
	7byDaeUhaGWn0Z96kt9dUS1vJNUQ2yq2zVDARvFSH0oTR4PEBXYNplkIPWVGrN7WaWEdNQsTY16+J
	/Zi6QVXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uy500-00000003Ihd-1xIy;
	Mon, 15 Sep 2025 08:55:48 +0000
Received: from todd.t-8ch.de ([159.69.126.157])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uy4zy-00000003IgL-1hqg
	for linux-um@lists.infradead.org;
	Mon, 15 Sep 2025 08:55:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1757926543;
	bh=wumQeK4aV33ZODZF7p8zwB+eZepT7/KIxwdWnzj3rqU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fl+1jpAqH0FHqqwTKgrcFGzynJRpfwmNC9e7CqhsJUTZNS2/RFX8fZVfYPLvq2uJx
	 463NTzafmNeUbz8S3a0LCQEKfqBENv+q7Zuc380YZIsfnZLX+a8VzigQ4PS7W9l0li
	 Tn+Dxqjr1ykhhB/Tyq44MeGJheZsWced8yXw9lxg=
Date: Mon, 15 Sep 2025 10:55:44 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Benjamin Berg <benjamin@sipsolutions.net>
Cc: linux-um@lists.infradead.org, Willy Tarreau <w@1wt.eu>, 
	linux-kselftest@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	linux-kernel@vger.kernel.org, Tiwei Bie <tiwei.btw@antgroup.com>, 
	Benjamin Berg <benjamin.berg@intel.com>
Subject: Re: [PATCH 6/9] tools/nolibc: add option to disable startup code
Message-ID: <e2f2b0e3-a72d-4b6f-9677-02de711b7d3a@t-8ch.de>
References: <20250915071115.1429196-1-benjamin@sipsolutions.net>
 <20250915071115.1429196-7-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915071115.1429196-7-benjamin@sipsolutions.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250915_015546_602703_5CB08181 
X-CRM114-Status: GOOD (  17.66  )
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

On 2025-09-15 09:11:12+0200, Benjamin Berg wrote:
> From: Benjamin Berg <benjamin.berg@intel.com>
> 
> In principle, it is possible to use nolibc for only some object files in
> a program. In that case, the startup code in _start and _start_c is not
> going to be used. Add the NOLIBC_NO_STARTCODE compile time option to
> disable it entirely and also remove anything that depends on it.

Not a big fan of the naming. More than only _start()/_start_c() are
disabled. Maybe NOLIBC_NO_RUNTIME?  I'm horrible at naming...

> Doing this avoids warnings from modpost for UML as the _start_c code
> references the main function from the .init.text section while it is not
> inside .init itself.
> 
> Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
> ---
>  tools/include/nolibc/arch-arm.h       | 2 ++
>  tools/include/nolibc/arch-arm64.h     | 2 ++
>  tools/include/nolibc/arch-loongarch.h | 2 ++
>  tools/include/nolibc/arch-m68k.h      | 2 ++
>  tools/include/nolibc/arch-mips.h      | 2 ++
>  tools/include/nolibc/arch-powerpc.h   | 2 ++
>  tools/include/nolibc/arch-riscv.h     | 2 ++
>  tools/include/nolibc/arch-s390.h      | 2 ++
>  tools/include/nolibc/arch-sh.h        | 2 ++
>  tools/include/nolibc/arch-sparc.h     | 2 ++
>  tools/include/nolibc/arch-x86.h       | 4 ++++
>  tools/include/nolibc/crt.h            | 3 +++
>  tools/include/nolibc/stackprotector.h | 2 ++
>  tools/include/nolibc/stdlib.h         | 2 ++
>  tools/include/nolibc/sys.h            | 3 ++-
>  tools/include/nolibc/sys/auxv.h       | 3 +++
>  16 files changed, 36 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/include/nolibc/arch-arm.h b/tools/include/nolibc/arch-arm.h
> index 1f66e7e5a444..24ad348cc1e8 100644
> --- a/tools/include/nolibc/arch-arm.h
> +++ b/tools/include/nolibc/arch-arm.h
> @@ -185,6 +185,7 @@
>  })
>  
>  /* startup code */
> +#ifndef NOLIBC_NO_STARTCODE

I'd prefer the ifdef around the comments.

>  void __attribute__((weak, noreturn)) __nolibc_entrypoint __no_stack_protector _start(void)
>  {
>  	__asm__ volatile (
> @@ -193,5 +194,6 @@ void __attribute__((weak, noreturn)) __nolibc_entrypoint __no_stack_protector _s
>  	);
>  	__nolibc_entrypoint_epilogue();
>  }
> +#endif /* NOLIBC_NO_STARTCODE */

(...)

