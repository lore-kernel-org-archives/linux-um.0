Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D76ACAC597
	for <linux-um@archiver.kernel.org>; Sat, 20 Sep 2025 09:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BoHupua0Au5N/87gN5timsHD/jTJ6dqkRgwblfpIHrA=; b=FwBNk8YDGBAFKOXVUyJwDzHwQS
	+yom9uqmuTqpUxPO3LV42IeWfv2gf/V45xZZY/k4Z2mOKaiMQ0oYypQs7sdVBsxcx6Ef65UqUY+o1
	dhn6jEBg0KIM52iTYAvfIyJ1vPcIUC1pMNbynHtfmq76IxIYKRQeIaDAVjBo7Kd61HIiPBlGwyp7O
	Yy5zMgBKm9sVrYMsT1OVKz3tQKgP1A1cmIkcObBsxhOIOeH7UZCZKnSRBoY/gpdGeyi+D354RXtTX
	74gCvGiq8F4lyA+ceBs+pG8EIFb6fB/9WT3xFXEJ93EUtCOl7Ya6DhgMbkUFs+k1Hg17rt9rpYZml
	UJsGKGhw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uztaM-000000055Ub-1Mv6;
	Sat, 20 Sep 2025 09:08:50 +0000
Received: from todd.t-8ch.de ([159.69.126.157])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uztaJ-000000055U3-3IqS
	for linux-um@lists.infradead.org;
	Sat, 20 Sep 2025 09:08:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1758359322;
	bh=7AgmdpzSbvpoPfhFtsyGjsBMS0m2QapvG7NWSOjL1NE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Om1UD5I6sqy+ggkvuslzI8wAAQY6oqwalnu5jQUtP5sKaW6Uc3rsuO2X6XejW/a0y
	 HzxD5VMzM1IA9TCrACVY78KDwXWRUeq9DikOOYvlcFWQWPVQfdufi4QvhsKvKZGtaJ
	 MFJQUqC8UslATs9k9e5W/VstrU8DA3Hv5iG5taoo=
Date: Sat, 20 Sep 2025 11:08:36 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Benjamin Berg <benjamin@sipsolutions.net>
Cc: linux-um@lists.infradead.org, Willy Tarreau <w@1wt.eu>, 
	linux-kselftest@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	linux-kernel@vger.kernel.org, Benjamin Berg <benjamin.berg@intel.com>
Subject: Re: [PATCH v2 06/11] tools/nolibc: add option to disable runtime
Message-ID: <a6f669b5-6a4e-4735-8c9d-9debdd65cbc9@t-8ch.de>
References: <20250919153420.727385-1-benjamin@sipsolutions.net>
 <20250919153420.727385-7-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250919153420.727385-7-benjamin@sipsolutions.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250920_020847_980951_78EB349B 
X-CRM114-Status: GOOD (  14.54  )
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

On 2025-09-19 17:34:15+0200, Benjamin Berg wrote:
> From: Benjamin Berg <benjamin.berg@intel.com>
> 
> In principle, it is possible to use nolibc for only some object files in
> a program. In that case, the startup code in _start and _start_c is not
> going to be used. Add the NOLIBC_NO_RUNTIME compile time option to
> disable it entirely and also remove anything that depends on it.
> 
> Doing this avoids warnings from modpost for UML as the _start_c code
> references the main function from the .init.text section while it is not
> inside .init itself.
> 
> Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>

Acked-by: Thomas Weißschuh <linux@weissschuh.net>

> 
> ---
> v2:
> - Renamed from NOLIBC_NO_STARTCODE to NOLIBC_NO_RUNTIME
> - Put the #ifdef around relevant comments
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

(...)

