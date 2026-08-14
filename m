Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAC36C5B572
	for <linux-um@archiver.kernel.org>; Fri, 14 Aug 2026 22:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Subject:Cc:To:From:Message-ID:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/ufcPNnfJAyI3kkCJgjhE8EqLR38Q7jjROlx/CU0gNg=; b=tCZc/fbX18uMrySGNwDHqxKze1
	WyZy1xAh8AVod/unEGAyRGybzVsVo/PgLFK9NjrCG2pm83/OMBdpifpgvJXMCqdToIgR7WMQPMHzw
	9KcNpJoq4qRLgvU77i63FQXbKtOUm65yPSIcMZYP38bFK0RpuUtU5WfT5QVm6XTBY9/kihESMNzfl
	ht9a5a1054ZQRCF+l+uIsLA9eU1dbMTj/7LUUFWv64j0yqvG7wVKZn3SmEl35GoxcnM4oFrlT3v9x
	OXVxx4iRdlqgTHo3+Ks2onjkdxacXwuZvystIOlfMMNysXCV9iJxns89/msChZFxq5h/ikJuWh3FG
	hDDE2a2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wv0P6-00000003Go9-1icY;
	Fri, 14 Aug 2026 22:29:32 +0000
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wv0P1-00000003Gnl-0ymw
	for linux-um@lists.infradead.org;
	Fri, 14 Aug 2026 22:29:31 +0000
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-38e07ebd263so1129638a91.1
        for <linux-um@lists.infradead.org>; Fri, 14 Aug 2026 15:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786746566; x=1787351366; darn=lists.infradead.org;
        h=content-type:mime-version:user-agent:references:in-reply-to:subject
         :cc:to:from:message-id:date:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/ufcPNnfJAyI3kkCJgjhE8EqLR38Q7jjROlx/CU0gNg=;
        b=C9Uv83v48H3ptXF5WicX4Y7hIxhA74yzUETg6D4TcuEaz6nHyWSkgICWnRI9dv6FoF
         hwAj56CGjWldCvDhyJ0CKiugfB57/jhg1XGwGUyjE2WpwSEorLdrWA61SmWfLQUugt/b
         +V8JtKE6dfjiBWf0gKbDp5UCfq7PpysPzFY0IaF/WApdcGl7uyYkjcStv9fr5PwLFugC
         oc0uRIRqcZbEnIGDW/PJgxE1xJBEnE0suaH/fdPmDHHZTAjL3yx0g/oO3GRoP2Gw/WiR
         +0KWEvcFPro/VD6DfB0d7gE9JPu/1S+rFIocDsAqQlaIsM4YXP2I1toe8z4QuUC+Snp8
         y6aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786746566; x=1787351366;
        h=content-type:mime-version:user-agent:references:in-reply-to:subject
         :cc:to:from:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/ufcPNnfJAyI3kkCJgjhE8EqLR38Q7jjROlx/CU0gNg=;
        b=hZqeIn6CuTVDVk+2CyJa50cczTd9uSRPx6IViQdwussxAzg5lwMTFF0IrDxwz+Cvp1
         TTpDyQixIty0We1RHqQC8/Dr0YkHhgKTcFXk5YnhnvC+jRyR6dQ04JlNzGWfHZ/pDCut
         QsgBgxNxpL6Dwpz2mF9D0WBWA266BjvzVAZjAwfDaikDi/MAiCkufjQN9v/5o9ibWs0p
         cpduJkLL2qinCWspNWEy0z3mfXBPQP+g1aB8XPl+yJGqVbVsmcX3vMY0KJAI8mgOx9hZ
         l9zT4fjQzrK2X78MneznVU9OOGVOtsFLJnMYWZ6tW7kFUCP0ri5cVg1T2lnnzRMydd/2
         VmZQ==
X-Forwarded-Encrypted: i=1; AHgh+RrEIguCeKE0WW3End/3FKNhNk6Rs5tQtC0137hrMjL2uercXoZvNCW9Rt4FP3w+qpUlk2uMzMvljw==@lists.infradead.org
X-Gm-Message-State: AOJu0YwCw3HEEIENbsAi+K7H7vGJciht2uOFRQ+y93C9ZXWeHOLlE2hS
	3ka0GrEBqZ/zmnB4GVeQlKB4EJ+C7y2TE8wUHJpQXMP4NPfcM/UxkhOW
X-Gm-Gg: AR+sD11ndmK5A6AJa77Y1ROv1Ybtua89+pl0n3EgnESxXTnP5a43AscRbcS2DmW7SyH
	5XltsAKOnxE+5NfO2C6bFiGUamPoDCbazo6uhf6WmozXboCbB9a7TcTZ2Cmq2uAHlmyBGfADOTg
	+JZ7uBpoAJzkAm9le/5NqSwEbXAmFPM9WZLQLCkI08+Fba7g7q/MWECN7Bq9NLT8zHy7ieCdGlz
	uIyVx+uF0+sBnQWnUYwz15xCezNxOH/HB5wyfp8DppPW7afEMFfM4xjClNliI5MIC0amCxt9jfA
	btt4PfLMAKfolaYQV4raUItxFBvE8hUIX6EZp6WZzojvhyJA2hEWZklrpJL6UYtMDdGYkz0JjBC
	lBEqmD44MKri9cgic5Cu02sa3wIijeTmbTbygnSaL3FHBx6qnx9KWu/2rpLdGHpcXC/2FiWZesq
	MmvrugkRZ8j6G2iQIXhCywkSr0wwIIncWR39GHmUxfa2pvyG1W+3t8+nUmJ4JbQW+BLd2m2DmoB
	qJTMJnbXuRSUmqLnYumuobLpDmVGzw7NqzoFdEIZ+CGOdHcGI1vX+umPZRNNEURrkyRKE2ER0rs
	1VUQog==
X-Received: by 2002:a17:90b:3c91:b0:380:f85c:94b4 with SMTP id 98e67ed59e1d1-3933b78e3c2mr11216186a91.7.1786746566302;
        Fri, 14 Aug 2026 15:29:26 -0700 (PDT)
Received: from mars.local.gmail.com (221x241x217x81.ap221.ftth.ucom.ne.jp. [221.241.217.81])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-394ebb888e3sm4122477a91.11.2026.08.14.15.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 15:29:25 -0700 (PDT)
Date: Sat, 15 Aug 2026 07:29:22 +0900
Message-ID: <m2y0e8pc8t.wl-thehajime@gmail.com>
From: Hajime Tazaki <thehajime@gmail.com>
To: ljs@kernel.org
Cc: linux-mm@kvack.org,
	geert@linux-m68k.org,
	daniel@thingy.jp,
	shuah@kernel.org,
	akpm@linux-foundation.org,
	david@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	linux-kselftest@vger.kernel.org,
	linux-um@lists.infradead.org
Subject: Re: [RFC PATCH 4/6] selftests: fix build errors on alpine linux
In-Reply-To: <an8MHlxZzu6a_1ui@lucifer>
References: <20260813063401.1786548-1-thehajime@gmail.com>
	<20260813063401.1786548-5-thehajime@gmail.com>
	<an8MHlxZzu6a_1ui@lucifer>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260814_152927_902951_3B028630 
X-CRM114-Status: GOOD (  21.70  )
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


On Fri, 14 Aug 2026 21:39:33 +0900,
Lorenzo Stoakes (ARM) wrote:
> 
> On Thu, Aug 13, 2026 at 03:33:59PM +0900, Hajime Tazaki wrote:
> > Some nommu architectures only work on Alpine Linux, which doesn't use
> > glibc for the standard library.  It uses musl-libc and is implemented in
> > a different way as glibc, resulting build failures.
> >
> > This commit fixes this issue by adding missing definitions. The fixes
> > are now only covered to TARGETS=mm which was tested for the moment;
> > future contributions are needed to fully build/execute tests on nommu
> > platforms.
> >
> > Cc: Shuah Khan <shuah@kernel.org>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: David Hildenbrand <david@kernel.org>
> > Cc: Lorenzo Stoakes <ljs@kernel.org>
> > Cc: "Liam R. Howlett" <liam@infradead.org>
> > Cc: Vlastimil Babka <vbabka@kernel.org>
> > Cc: Mike Rapoport <rppt@kernel.org>
> > Cc: Suren Baghdasaryan <surenb@google.com>
> > Cc: Michal Hocko <mhocko@suse.com>
> > Cc: linux-kselftest@vger.kernel.org
> > Cc: linux-mm@kvack.org
> > Cc: linux-um@lists.infradead.org
> > Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
> 
> I mean vaguely looks un-invasive which is the test here.
> 
> Couple comments below.
(snip)
> > diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
> > index f02cc8a2e4ae..2cc819006424 100644
> > --- a/tools/testing/selftests/lib.mk
> > +++ b/tools/testing/selftests/lib.mk
> > @@ -197,7 +197,7 @@ clean: $(if $(TEST_GEN_MODS_DIR),clean_mods_dir)
> >  	$(CLEAN)
> >
> >  # Build with _GNU_SOURCE by default
> 
> You probably want to update this comment.

indeed, will update this part (may even not needed to modify this).

> > -CFLAGS += -D_GNU_SOURCE=
> > +CFLAGS += -D_GNU_SOURCE= -D_LARGEFILE64_SOURCE

(snip)
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
> 
> Probably better to declare different functions to make this less hideous.

I see your point.  will look for the other way.

-- Hajime

