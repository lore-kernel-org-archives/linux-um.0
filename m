Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0572AC9830E
	for <linux-um@archiver.kernel.org>; Sat, 26 Sep 2026 02:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Subject:Cc:To:From:Message-ID:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BRZcJ4zmgYP9iknu9G46YMYxRoSwMeK51+7Pcw6q5Ls=; b=xzwZBc4ME4WfjY5RnNjysyrc0d
	znraOF1zdaPodZSU/MSJc3AC7pwoDFBT6YBBFF9IKBeA5OprSwUTkobqg7czRpFlgYMplQ8xJewob
	YosByjwovK1mydeRHXmdy/rlaCuBB2eogaG/Tzs7+7QdddJya/46qtORffw1u6twLQ1y8UBYIBLRt
	VY9AEFXC4Fg68hFDqguuHoclgBRyH5ZtuHyOUNXcxk07+kN1+FH/wrrq3WgFwZEVbvVWARdQhjPLJ
	dBx5VipQnFAlpaSIqKOJdhEjcq9E4AZYETHImK/Tr2bkDEvzwyY/v0XiMyWrd/E3IInEGzk4s2OEy
	JWywvtpQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xAHuK-0000000EqZx-1PI3;
	Sat, 26 Sep 2026 02:12:56 +0000
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xAHuI-0000000EqZb-0l4D
	for linux-um@lists.infradead.org;
	Sat, 26 Sep 2026 02:12:55 +0000
Received: by mail-pj2-x10.google.com with SMTP id d9443c01a7336-2d90ba1d807so11486835ad.3
        for <linux-um@lists.infradead.org>; Fri, 25 Sep 2026 19:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790388773; x=1790993573; darn=lists.infradead.org;
        h=content-type:mime-version:user-agent:references:in-reply-to:subject
         :cc:to:from:message-id:date:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=BRZcJ4zmgYP9iknu9G46YMYxRoSwMeK51+7Pcw6q5Ls=;
        b=XXR2LKWZQvogLULMlb9w7Ef69tMAcQys9e5cpiAcD0opsJt5IhVcHSKgsluBdiT9Ey
         TKac5UfMBvbsCp2BkZZoGjowLOMWH+91y4mPrhdqoTc1UVMBc/dXdiM0Yy9PInyYIEvt
         7IOQe333Dawfch7rzRUkXvnmSMVzayTr3TaZ3yG82VockyvIIipezXIjGc+ly6wZpad1
         hb2U++Cn0yfFf6O3Nzff0IEAJ3JzYkQuph5XadxQmU+gTGIrfipDbuCaS36EKYDpes6q
         YMFAgyF/bnHCgQHGWJtDFjQ0dM7kMriE1u4qXpaj4Yi2rOwX7WutRD6r8sLLdY8BaqfD
         1mJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790388773; x=1790993573;
        h=content-type:mime-version:user-agent:references:in-reply-to:subject
         :cc:to:from:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BRZcJ4zmgYP9iknu9G46YMYxRoSwMeK51+7Pcw6q5Ls=;
        b=a44rYCYrMa+4q/wRSPyaA+Mr5TyZhw4r0qGxv5cSehNHMEtFwZcxl1xYHXoxLHlfIr
         S5ZT11Znvfb8d6wGDgJSHEaRFW8nvuKhdzcLUzF+ww9noiBpQvOGYW5aAnrj7nmqQD5+
         yCdObYP943tA4xtPzRDDXjYyTb1wHBLG4JjZqiMJUVwNm+0kf80+An9J6maJ9T1U0Oeb
         2uZdPehgeTIWgR/4UvHkchzVSMfD9CeHfu2sUzpQSw8l1ah0zXwlbExpM5YsO/bA4fDz
         elDzuMuOAje1PVYO0UxZdtTyGaWoosSMQYNUw+16703R/vnA27HMYQj8ulArPt6kenB5
         fKNw==
X-Gm-Message-State: AFuF++kOG7H0PuuJXyFMp0n0sIxneUNgT9oTfJl7NvSMl7rXW77mm1fA
	Pk/wLr1H+12okr6s3OYKnqBfrc8B4AOTw+GvqATImlsgRypJNGLXSpts
X-Gm-Gg: AYBFou2c4/icjtCCQC8KjuWxdUMK478nPheThnC9xPw6NBG/LafrDx0gHz0WbCUySsM
	SLOYwoboZ+4ZvCH4EFznlyZJqoZgxo97lUMgLkDAI5FAXEpYcM+be46whxYA73PIKkFmNEfTKZx
	ibVAfVZdPHKtJj5UpvogX2oPpqCm2QcIF2htllvCKJMCGzK0u22zi3xXoRMLwz61BTBYrEvGx/d
	2nvngvrkK1PXfx8x9pBS9KDgevsyFrpdaagZkx/hMTCtvonbTQ+rF4rL1+5L87pHPg/6rV1uRWn
	8hi8ynPth7bUT+1rJZtVQkUCLVeBxgAi3O7V2oZsYRm4w9HbVPWBZHu+Qu0hua9RaFg2093bb5d
	XWsSwVsv2ppbje2WJcKV6trz0EeQ0h73rJs876/v1TiS2xXtfOeqcliVL3FNYxTbMFrwXBwI2NW
	yIYmUUKf+xZF7WoHqN2/Pmzais4vOc2fV7Pz5FVTuyp83+pXJoZqWKAQ04ymF1hU06/LLVFUirj
	KwswyTXfPEMrc7N4NUrWWF6g7nB3qwYAK9Cp+me3s/BzAdzcMTmMZ18A+iJMAwfKpRh99Akzyer
	XBJCanPV8HrLSZbbbRbAwQQ3uPw4KvFeiY+XZVPe2mianpXIuDkibgQBlWMl0E7UvTsil8rWYsd
	I
X-Received: by 2002:a17:902:db07:b0:2db:73fc:b57f with SMTP id d9443c01a7336-2df7da5d75emr62886795ad.10.1790388772982;
        Fri, 25 Sep 2026 19:12:52 -0700 (PDT)
Received: from mars.local.gmail.com (221x241x217x81.ap221.ftth.ucom.ne.jp. [221.241.217.81])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df91444763sm17349455ad.60.2026.09.25.19.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 19:12:52 -0700 (PDT)
Date: Sat, 26 Sep 2026 11:12:49 +0900
Message-ID: <m24ifc4v6m.wl-thehajime@gmail.com>
From: Hajime Tazaki <thehajime@gmail.com>
To: johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	johannes.berg@intel.com
Subject: Re: [PATCH] um: mprotect() __init memory
In-Reply-To: <20260921122937.3821fec01e82.Ib959ff1baad7a45e2b804209b530040e69e4b046@changeid>
References: <20260921122937.3821fec01e82.Ib959ff1baad7a45e2b804209b530040e69e4b046@changeid>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260925_191254_251677_88B08ADC 
X-CRM114-Status: GOOD (  26.09  )
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


Hello,

I recently pulled uml/next branch and faced an issue on the exit.

```
Thread 1 "vmlinux" received signal SIGSEGV, Segmentation fault.
0x0000000060003cf3 in start_uml () at ../arch/um/kernel/skas/process.c:41
41      }
(gdb) bt
#0  0x0000000060003cf3 in start_uml () at ../arch/um/kernel/skas/process.c:41
#1  0x0000000060003a69 in linux_main (argc=argc@entry=9, argv=argv@entry=0x7fffffffe118,
    envp=envp@entry=0x7fffffffe168) at ../arch/um/kernel/um_arch.c:404
#2  0x00000000600049dc in main (argc=9, argv=0x7fffffffe118, envp=0x7fffffffe168)
    at ../arch/um/os-Linux/main.c:153
```

and bisected that this commit is the first rev to introduce this.

indeed, now .text section is in __init label but some of startup code
(start_uml, linux_main) remain un-returned even after init is done.

a quick change below avoid this issue, but not sure if it is your
intention of the original patch.

--- a/arch/um/kernel/mem.c
+++ b/arch/um/kernel/mem.c
@@ -93,7 +93,7 @@ void free_initmem(void)
        unsigned long end = round_down((unsigned long)__init_end, PAGE_SIZE);
 
        if (end > start)
-               os_protect_memory((void *)start, end - start, 0, 0, 0);
+               os_protect_memory((void *)start, end - start, 0, 0, 1);
 }


I guess you're already aware of it (if you boot and halt a UML
instance it should be 100% reproducible), but in case not.

-- Hajime

On Mon, 21 Sep 2026 19:29:37 +0900,
Johannes Berg wrote:
> 
> From: Johannes Berg <johannes.berg@intel.com>
> 
> Unlike what the comment says, we could munmap() this (but
> not reuse it for guest allocations), but then stray libc
> allocations could technically conflict, so mprotect() it
> to catch access bugs. Align it in the linker scripts too
> so that all of it can be covered, not just some.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>  arch/um/kernel/dyn.lds.S |  2 ++
>  arch/um/kernel/mem.c     | 11 ++++++++---
>  arch/um/kernel/uml.lds.S |  2 ++
>  3 files changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/um/kernel/dyn.lds.S b/arch/um/kernel/dyn.lds.S
> index ad3cefeff2ac..5d3d5ef6ebec 100644
> --- a/arch/um/kernel/dyn.lds.S
> +++ b/arch/um/kernel/dyn.lds.S
> @@ -98,8 +98,10 @@ SECTIONS
>  
>    #include <asm/common.lds.S>
>  
> +  . = ALIGN(PAGE_SIZE);
>    __init_begin = .;
>    init.data : { INIT_DATA }
> +  . = ALIGN(PAGE_SIZE);
>    __init_end = .;
>  
>    /* Ensure the __preinit_array_start label is properly aligned.  We
> diff --git a/arch/um/kernel/mem.c b/arch/um/kernel/mem.c
> index 1eef0e42ef5d..00c469fd28ee 100644
> --- a/arch/um/kernel/mem.c
> +++ b/arch/um/kernel/mem.c
> @@ -83,12 +83,17 @@ void __init arch_zone_limits_init(unsigned long *max_zone_pfns)
>  }
>  
>  /*
> - * This can't do anything because nothing in the kernel image can be freed
> - * since it's not in kernel physical memory.
> + * We could munmap() this instead, but then libc allocations could
> + * land in this area and stray initdata access could erroneosly
> + * succeeded - just mprotect() it to reliably catch bad accesses.
>   */
> -
>  void free_initmem(void)
>  {
> +	unsigned long start = PAGE_ALIGN((unsigned long)__init_begin);
> +	unsigned long end = round_down((unsigned long)__init_end, PAGE_SIZE);
> +
> +	if (end > start)
> +		os_protect_memory((void *)start, end - start, 0, 0, 0);
>  }
>  
>  /* Allocate and free page tables. */
> diff --git a/arch/um/kernel/uml.lds.S b/arch/um/kernel/uml.lds.S
> index 30aa24348d60..7085ba6fcb93 100644
> --- a/arch/um/kernel/uml.lds.S
> +++ b/arch/um/kernel/uml.lds.S
> @@ -70,8 +70,10 @@ SECTIONS
>  
>    #include <asm/common.lds.S>
>  
> +  . = ALIGN(PAGE_SIZE);
>    __init_begin = .;
>    init.data : { INIT_DATA }
> +  . = ALIGN(PAGE_SIZE);
>    __init_end = .;
>  
>    .data    :
> -- 
> 2.55.0
> 
> 

