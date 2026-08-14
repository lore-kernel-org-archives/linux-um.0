Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C19CCC5CFDB
	for <linux-um@archiver.kernel.org>; Fri, 14 Aug 2026 12:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4sg2Fpi/B0x2kWvzgITLa65nTIYhPhK7l7uRWEIj1A8=; b=I3xkCmDlUkrC5/6V12DOR+EXp1
	l4g7Nx4ZlTeVT04CJH47q/4aTtBOpGfo8ljd5k7j1xfwesSXNdN7OPDgXKjOXZ0KTQiIbabs113yu
	lluQ0Tp9BNpaYyEST04oSI+l4JrKZ0r77giOsAldYrjm2OE++PPIV+hQAOxXMpRYQGgC7ObFqg/II
	vV+2Uw2+DimWtIvva1PLsT1QJKM9R2ROL3x9jdKD8S/tCfWPancH3z2KO3SqyPa3nDau1zlJSfMKF
	MXXOG4T/Hidae5kqTKEFL6rQQooPA57xm3vepz2apVJN0X6FSET3jmVKfTBEjU6Qu8k9PVcjTekrE
	c56joJXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wurCU-00000002fGs-33uF;
	Fri, 14 Aug 2026 12:39:54 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wurCT-00000002fGl-1UA7
	for linux-um@lists.infradead.org;
	Fri, 14 Aug 2026 12:39:53 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 6F133600C3;
	Fri, 14 Aug 2026 12:39:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8C5E1F00A3A;
	Fri, 14 Aug 2026 12:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786711191;
	bh=4sg2Fpi/B0x2kWvzgITLa65nTIYhPhK7l7uRWEIj1A8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=O+kVpgCiOmkp8MZDf66Mx7mlR3n94nqd1qtfgseHoWHpco+dyzQY2x1b77Q47piJC
	 V0kVXfP06DjTRL4VxW2tlseUWftYTnTBNL/egp79Z6DW1S8rCm3Q8CEOJBm3LKKVun
	 AcpBf8WqTSpncOY0zaZOEbsJV9Fp54WVwBa0q8oZPiwBSEGHq7oBdIl77PhbpqA427
	 50KAv5SH/rqGr8R68XsP71fpTQoKLn/fsoubLPq7CiHz3Bq4IdGQvK6JWOgpcU2Gqy
	 rJLz4cXoVKBFcNa7WlDSjHBM4EV9z+BpkXq+FYeoSzVtP1r6QtvWfEUlrY7ntZMsF2
	 zXnQmTbraQe/w==
Date: Fri, 14 Aug 2026 13:39:33 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Hajime Tazaki <thehajime@gmail.com>
Cc: linux-mm@kvack.org, geert@linux-m68k.org, daniel@thingy.jp, 
	Shuah Khan <shuah@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, linux-kselftest@vger.kernel.org, 
	linux-um@lists.infradead.org
Subject: Re: [RFC PATCH 4/6] selftests: fix build errors on alpine linux
Message-ID: <an8MHlxZzu6a_1ui@lucifer>
References: <20260813063401.1786548-1-thehajime@gmail.com>
 <20260813063401.1786548-5-thehajime@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813063401.1786548-5-thehajime@gmail.com>
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

On Thu, Aug 13, 2026 at 03:33:59PM +0900, Hajime Tazaki wrote:
> Some nommu architectures only work on Alpine Linux, which doesn't use
> glibc for the standard library.  It uses musl-libc and is implemented in
> a different way as glibc, resulting build failures.
>
> This commit fixes this issue by adding missing definitions. The fixes
> are now only covered to TARGETS=mm which was tested for the moment;
> future contributions are needed to fully build/execute tests on nommu
> platforms.
>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@kernel.org>
> Cc: Lorenzo Stoakes <ljs@kernel.org>
> Cc: "Liam R. Howlett" <liam@infradead.org>
> Cc: Vlastimil Babka <vbabka@kernel.org>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: linux-kselftest@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: linux-um@lists.infradead.org
> Signed-off-by: Hajime Tazaki <thehajime@gmail.com>

I mean vaguely looks un-invasive which is the test here.

Couple comments below.

> ---
>  tools/testing/selftests/kselftest.h      | 43 ++++++++++++++++++++++++
>  tools/testing/selftests/lib.mk           |  2 +-
>  tools/testing/selftests/mm/hugetlb_dio.c |  8 ++---
>  tools/testing/selftests/mm/mdwe_test.c   |  4 +--
>  4 files changed, 50 insertions(+), 7 deletions(-)
>
> diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
> index ae18c491ae53..ac21bf3d802e 100644
> --- a/tools/testing/selftests/kselftest.h
> +++ b/tools/testing/selftests/kselftest.h
> @@ -58,6 +58,7 @@
>  #include <string.h>
>  #include <stdio.h>
>  #include <sys/utsname.h>
> +#include <stdint.h>
>  #endif
>
>  #ifndef ARRAY_SIZE
> @@ -81,6 +82,48 @@
>  #endif
>  #endif /* end arch */
>
> +#if !defined(NOLIBC) && !defined(__GLIBC__)
> +#ifdef __LP64__
> +typedef int64_t __fsword_t;
> +#else
> +typedef int32_t __fsword_t;
> +#endif
> +
> +/*
> + * for a workaround to avoid struct conflict under
> + * musl-libc (<sys/prctl.h> v.s. <linux/prctl.h>)
> + */
> +#include <sys/prctl.h>
> +#ifndef _LINUX_PRCTL_H
> +#define _LINUX_PRCTL_H
> +#endif
> +
> +#ifndef PR_SET_MDWE
> +#define PR_SET_MDWE 65
> +#endif
> +
> +#ifndef PR_MDWE_REFUSE_EXEC_GAIN
> +#define PR_MDWE_REFUSE_EXEC_GAIN (1UL << 0)
> +#endif
> +
> +#ifndef PR_MDWE_NO_INHERIT
> +#define PR_MDWE_NO_INHERIT (1UL << 1)
> +#endif
> +
> +#ifndef PR_GET_MDWE
> +#define PR_GET_MDWE 66
> +#endif
> +
> +#ifndef PR_SET_MEMORY_MERGE
> +#define PR_SET_MEMORY_MERGE 67
> +#endif
> +
> +#ifndef PR_GET_MEMORY_MERGE
> +#define PR_GET_MEMORY_MERGE 68
> +#endif
> +
> +#endif
> +
>  /* define kselftest exit codes */
>  #define KSFT_PASS  0
>  #define KSFT_FAIL  1
> diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
> index f02cc8a2e4ae..2cc819006424 100644
> --- a/tools/testing/selftests/lib.mk
> +++ b/tools/testing/selftests/lib.mk
> @@ -197,7 +197,7 @@ clean: $(if $(TEST_GEN_MODS_DIR),clean_mods_dir)
>  	$(CLEAN)
>
>  # Build with _GNU_SOURCE by default

You probably want to update this comment.

> -CFLAGS += -D_GNU_SOURCE=
> +CFLAGS += -D_GNU_SOURCE= -D_LARGEFILE64_SOURCE
>
>  # Additional include paths needed by kselftest.h and local headers
>  CFLAGS += -I${top_srcdir}/tools/testing/selftests
> diff --git a/tools/testing/selftests/mm/hugetlb_dio.c b/tools/testing/selftests/mm/hugetlb_dio.c
> index fb4600570e13..aee6be530ccb 100644
> --- a/tools/testing/selftests/mm/hugetlb_dio.c
> +++ b/tools/testing/selftests/mm/hugetlb_dio.c
> @@ -22,12 +22,9 @@
>  #include "kselftest.h"
>  #include "hugepage_settings.h"
>
> -#ifndef STATX_DIOALIGN
> -#define STATX_DIOALIGN		0x00002000U
> -#endif
> -
>  static int get_dio_alignment(int fd)
>  {
> +#ifdef STATX_DIOALIGN
>  	struct statx stx;
>  	int ret;
>
> @@ -43,6 +40,9 @@ static int get_dio_alignment(int fd)
>  		return 1;
>
>  	return stx.stx_dio_offset_align;
> +#else
> +	return -1;
> +#endif

Probably better to declare different functions to make this less hideous.

>  }
>
>  static bool check_dio_alignment(unsigned int start_off,
> diff --git a/tools/testing/selftests/mm/mdwe_test.c b/tools/testing/selftests/mm/mdwe_test.c
> index 647779653da0..031c79ed067e 100644
> --- a/tools/testing/selftests/mm/mdwe_test.c
> +++ b/tools/testing/selftests/mm/mdwe_test.c
> @@ -1,5 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>
> +#include "kselftest_harness.h"
> +
>  #ifdef __aarch64__
>  #include <asm/hwcap.h>
>  #endif
> @@ -14,8 +16,6 @@
>  #include <sys/wait.h>
>  #include <unistd.h>
>
> -#include "kselftest_harness.h"
> -
>  #ifndef __aarch64__
>  # define PROT_BTI	0
>  #endif
> --
> 2.43.0
>

--
Cheers, Lorenzo

