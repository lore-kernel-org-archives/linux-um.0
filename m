Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21E22C5DF69
	for <linux-um@archiver.kernel.org>; Fri, 14 Aug 2026 12:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Subject:Cc:To:From:Message-ID:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uVL8QQveaA14mGW2dIQPVe+Wbaf5USv9xkXEwll8c7c=; b=kJlU7qVB1I52mFgoEuICDJ2TmT
	Z42543D8khbEH7peeQQluCt6qVa4dvMA34UWHyHnCgKPAg31gobiOqHrz1a6U71sONUPoxsK1Gr2B
	jMk2BEiqcSJXPMmDDTd8gHRn6tuxuClkQsUji6e7KE7I3c7dWf/j5zdDzb9bM4NiiJ1jjuoCyr6fc
	hVfHa2K5mPsIO78y7znF9tU4k98L2RQl0QhDMxbnWyf1UoVBsMorGO9U7bbzQGjW7JmNtT4xppvXE
	1qJIorGirCAKXjp2gYFkSz4b3yZzQSITa67KN4guHJN8k7MmpjMSbwFYY0QOXXQF/wBj8Vsvgu3o1
	wImKLvTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wurHK-00000002fe8-1pWH;
	Fri, 14 Aug 2026 12:44:54 +0000
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wurHH-00000002fdl-3QFF
	for linux-um@lists.infradead.org;
	Fri, 14 Aug 2026 12:44:53 +0000
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-84eb992a881so610024b3a.2
        for <linux-um@lists.infradead.org>; Fri, 14 Aug 2026 05:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786711490; x=1787316290; darn=lists.infradead.org;
        h=content-type:mime-version:user-agent:references:in-reply-to:subject
         :cc:to:from:message-id:date:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=uVL8QQveaA14mGW2dIQPVe+Wbaf5USv9xkXEwll8c7c=;
        b=IE1eVLpbWNAHBksUrOZEUkI51gNY6D5MlzC/+M1RKB+QPOQGwB7ampuBi/cYIzaXt6
         8NlFBXhipoDYIkxCdUhslz/j/5JUNRMIsrKM+qQtj9ZLP037y7L0lWzA5tEF2eU9DD9v
         B28sz7TNoEALu5wDjyDBV6WZjS1gMX9c5ZU2DRU/KaWgpelo9KTPhqrup4OG6zgPNuD9
         Nj0hLQ9CHLGl4in5nkBh5y3Vd9O1AdaGREcyXEQBRY4aOzLKPziyZnDHY5VhAHiS3ZWI
         Q7k9ZOZOZQojvzs6A6UzbsbFtEola1x+wUNXXt98MRhqdKldVvtWo/D9sLXY47liochS
         wduw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786711490; x=1787316290;
        h=content-type:mime-version:user-agent:references:in-reply-to:subject
         :cc:to:from:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uVL8QQveaA14mGW2dIQPVe+Wbaf5USv9xkXEwll8c7c=;
        b=I9ItrClhnhna1o4crWIS/pEbaTqXg5PVHXS6Fh3S+ua8pKFct0ahha3gTG6QsMhDYF
         oIaRaWLmSile5S7HBWzPBOZuVza1zdQaozOcqDk4KWz24nVgjPZI+UTYvYGEOA28PbfH
         uvmEmG8hZblE3PUwMKSx+M30IPskMPcdD8xPi2p1tHyz6/SL03RJeaHQbrjEtvFmAsG6
         0D6N6otFg5I2nioQR/eUvafz7UwkbLwkdAmSbQIPd7FGvsxXJVd2QK46xdKuMftI3nc+
         sg/8f+PTB6Oz3O6apZAzf1tYNILNKGpU5fq99R9BWdQZDACh1YGFiCjEKxXuHMzLR2P0
         +6zQ==
X-Forwarded-Encrypted: i=1; AHgh+RoSB9lvGpr20cK29l6aWkizgznq0Y49OiacVnX8X9cNQSOQtbksqohCXp6tAm9dFY/8PrPuD1pY+A==@lists.infradead.org
X-Gm-Message-State: AOJu0Yw7VISXS7xczWH6z56Q0iGPVT61gB8xDdYcGoQs9+vCJvLK9u2L
	qh5b1UkwfUh4Zwl3hTzWidlVlTc5PLopiDm7C2ueVuGQYg66ZNwoG/rp
X-Gm-Gg: AR+sD11eias0T+deYW4z/pCwGUyYFA+jZOVbeSwMv+9YnWacM7uxHM8uVnTjb1PfWfP
	A4VvCPxVEzRa+XIREuWssGU5f0lhHNWNTGYKCrMzHrEY5Cd3XzL53LFmY05ogNIJeM+L0FgDaka
	KeQLJSoNSww+p/fOKAu+PCU7MhmwTYm5vtq1Qoz87AIxTVY7My1bCijAMdzUWKQatncpYyMhUMN
	Mtz9TTo35rgqaHbxnKP8+/Qk9RPh6iAp11otl/NXVSaDd+g+5p241cKRxh77BLGzbr+FpSVQXhC
	8ukST+Xj5YcW+kZrBmj7DQf1wvq20RweETuRkGjOe8h5WIfjIuOKROlY+6z+n5OkVC4MHKqv+6o
	wUisVoqlseiTd+eRs59KSJucli4foRr8koahafGRSE84sUVmoMS0uD51ECI0HeU3xDVnOFsSkfX
	+RD899DtP8ufYFkbpsbskfvwhNYAZvdgQAOQsSJOi/bx2w8PF8Yw+ZUAPd3AD9HAgIyxGbEf+sQ
	hdyruuKgnkotxddaAZ+3ANMPWPNmk8hcQRuLOehSQBamsqE2bT+i/K8R3QcNNQI65K6nRccKzDL
	lY2ujA==
X-Received: by 2002:a05:6a00:3981:b0:848:2eac:bfb2 with SMTP id d2e1a72fcca58-84fde004804mr5805806b3a.13.1786711490219;
        Fri, 14 Aug 2026 05:44:50 -0700 (PDT)
Received: from mars.local.gmail.com (221x241x217x81.ap221.ftth.ucom.ne.jp. [221.241.217.81])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8517d266e36sm399011b3a.55.2026.08.14.05.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 05:44:49 -0700 (PDT)
Date: Fri, 14 Aug 2026 21:44:45 +0900
Message-ID: <m24igwrhvm.wl-thehajime@gmail.com>
From: Hajime Tazaki <thehajime@gmail.com>
To: pfalcato@suse.de
Cc: linux-mm@kvack.org,
	geert@linux-m68k.org,
	daniel@thingy.jp,
	shuah@kernel.org,
	akpm@linux-foundation.org,
	david@kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	linux-kselftest@vger.kernel.org,
	linux-um@lists.infradead.org
Subject: Re: [RFC PATCH 4/6] selftests: fix build errors on alpine linux
In-Reply-To: <an7eC0oBvfjB6g54@pedro-suse.lan>
References: <20260813063401.1786548-1-thehajime@gmail.com>
	<20260813063401.1786548-5-thehajime@gmail.com>
	<an7eC0oBvfjB6g54@pedro-suse.lan>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260814_054451_870418_19E8E004 
X-CRM114-Status: GOOD (  34.75  )
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


Hello Pedro,

thank you for the review and looking at the patch.

On Fri, 14 Aug 2026 18:34:21 +0900,
Pedro Falcato wrote:
> 
> /me puts on his libc hat

thanks, this is really a good news to me.

> > diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
> > index ae18c491ae53..ac21bf3d802e 100644
> > --- a/tools/testing/selftests/kselftest.h
> > +++ b/tools/testing/selftests/kselftest.h
> > @@ -58,6 +58,7 @@
> >  #include <string.h>
> >  #include <stdio.h>
> >  #include <sys/utsname.h>
> > +#include <stdint.h>
> >  #endif
> >  
> >  #ifndef ARRAY_SIZE
> > @@ -81,6 +82,48 @@
> >  #endif
> >  #endif /* end arch */
> >  
> > +#if !defined(NOLIBC) && !defined(__GLIBC__)
> > +#ifdef __LP64__
> > +typedef int64_t __fsword_t;
> > +#else
> > +typedef int32_t __fsword_t;
> > +#endif
> 
> The code should not be using __fsword_t. Per statfs(2):
> 
>        The __fsword_t type used for various fields in the statfs
>        structure definition is a glibc internal type, not intended for
>        public use.  This leaves the programmer in a bit of a conundrum
>        when trying to copy or compare these fields to local variables in
>        a program.  Using unsigned int for such variables suffices on most
>        systems.
> 
> and indeed if you look at musl's statvfs definition:
> struct statvfs {
> 	/* ... */
> 	unsigned int f_type;
> 	/* ... */
> };
> 
> so it should be perfectly cromulent to use unsigned int here. Or use an
> actual usable interface :)

thanks, I will drop this chunk and propose to update mm/gup_longterm.c
to address the issue with musl.

> > +
> > +/*
> > + * for a workaround to avoid struct conflict under
> > + * musl-libc (<sys/prctl.h> v.s. <linux/prctl.h>)
> > + */
> > +#include <sys/prctl.h>
> > +#ifndef _LINUX_PRCTL_H
> > +#define _LINUX_PRCTL_H
> > +#endif
> > +
> > +#ifndef PR_SET_MDWE
> > +#define PR_SET_MDWE 65
> > +#endif
> > +
> > +#ifndef PR_MDWE_REFUSE_EXEC_GAIN
> > +#define PR_MDWE_REFUSE_EXEC_GAIN (1UL << 0)
> > +#endif
> > +
> > +#ifndef PR_MDWE_NO_INHERIT
> > +#define PR_MDWE_NO_INHERIT (1UL << 1)
> > +#endif
> > +
> > +#ifndef PR_GET_MDWE
> > +#define PR_GET_MDWE 66
> > +#endif
> > +
> > +#ifndef PR_SET_MEMORY_MERGE
> > +#define PR_SET_MEMORY_MERGE 67
> > +#endif
> > +
> > +#ifndef PR_GET_MEMORY_MERGE
> > +#define PR_GET_MEMORY_MERGE 68
> > +#endif
> > +
> > +#endif
> 
> This looks fine. It's the same old problem with musl and kernel headers.

noted with thanks.

> >  /* define kselftest exit codes */
> >  #define KSFT_PASS  0
> >  #define KSFT_FAIL  1
> > diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
> > index f02cc8a2e4ae..2cc819006424 100644
> > --- a/tools/testing/selftests/lib.mk
> > +++ b/tools/testing/selftests/lib.mk
> > @@ -197,7 +197,7 @@ clean: $(if $(TEST_GEN_MODS_DIR),clean_mods_dir)
> >  	$(CLEAN)
> >  
> >  # Build with _GNU_SOURCE by default
> > -CFLAGS += -D_GNU_SOURCE=
> > +CFLAGS += -D_GNU_SOURCE= -D_LARGEFILE64_SOURCE
> 
> What needs this?

this is a leftover chunk of patch not for TARGETS=mm, but
TARGETS=drivers/dma-buf, which generates the following errors.

udmabuf.c:137:9: error: unknown type name 'off64_t'; did you mean 'off_t'?
  137 |         off64_t size;

I will drop this chunk from this patch as the patch is only focusing
on TARGETS=mm.

> >  
> >  # Additional include paths needed by kselftest.h and local headers
> >  CFLAGS += -I${top_srcdir}/tools/testing/selftests
> > diff --git a/tools/testing/selftests/mm/hugetlb_dio.c b/tools/testing/selftests/mm/hugetlb_dio.c
> > index fb4600570e13..aee6be530ccb 100644
> > --- a/tools/testing/selftests/mm/hugetlb_dio.c
> > +++ b/tools/testing/selftests/mm/hugetlb_dio.c
> > @@ -22,12 +22,9 @@
> >  #include "kselftest.h"
> >  #include "hugepage_settings.h"
> >  
> > -#ifndef STATX_DIOALIGN
> > -#define STATX_DIOALIGN		0x00002000U
> > -#endif
> 
> Why doesn't this fallback work?

I thought that if this macro isn't defined, it's not available in the
underlying kernel, but that's very idiot modification given that the
libc headers is not up-to-date but the kernel is supporting this, this
ifndef should help.

I will look for another approach to address the situation of musl, and
revert this for the original purpose.

> > -
> >  static int get_dio_alignment(int fd)
> >  {
> > +#ifdef STATX_DIOALIGN
> >  	struct statx stx;
> >  	int ret;
> >  
> > @@ -43,6 +40,9 @@ static int get_dio_alignment(int fd)
> >  		return 1;
> >  
> >  	return stx.stx_dio_offset_align;
> > +#else
> > +	return -1;
> > +#endif
> >  }
> >  
> >  static bool check_dio_alignment(unsigned int start_off,
> > diff --git a/tools/testing/selftests/mm/mdwe_test.c b/tools/testing/selftests/mm/mdwe_test.c
> > index 647779653da0..031c79ed067e 100644
> > --- a/tools/testing/selftests/mm/mdwe_test.c
> > +++ b/tools/testing/selftests/mm/mdwe_test.c
> > @@ -1,5 +1,7 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >  
> > +#include "kselftest_harness.h"
> > +
> >  #ifdef __aarch64__
> >  #include <asm/hwcap.h>
> >  #endif
> > @@ -14,8 +16,6 @@
> >  #include <sys/wait.h>
> >  #include <unistd.h>
> >  
> > -#include "kselftest_harness.h"
> > -
> >  #ifndef __aarch64__
> >  # define PROT_BTI	0
> >  #endif
> > -- 
> > 2.43.0
> > 
> > 
> 
> Honestly, I'm surprised you needed so few hacks for this! But if I am to
> guess, there are certainly much more problematic selftests out there.

Currently I only tested with `TARGETS=mm` and didn't look carefully to
other tests.  I will look more into running other tests on alpine
(with CONFIG_MMU enabled) first, then will see !MMU environment with
investigating if those are meaningful to test on nommu.

anyway, (again) thanks for the review.

-- Hajime

