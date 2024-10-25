Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2B05D0C60B
	for <linux-um@archiver.kernel.org>; Fri, 25 Oct 2024 13:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Subject:Cc:To:From:Message-ID:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5E+5IGmjD5RYhRDoYf+p51x7iks9smyytpRiSxJ79eU=; b=uvpg6LYE4hTqExtsvMBb/noq65
	Q395Kvsg1RNPg0N72shhob8quyOXEyvBaYIWSxxPZXdQ5rSFiiSGQ8kAPtDF33Y6pQXxldWQwl25z
	oOjFatD5B7UKB7Q0NJiAXxvgrm51rjIBBHcJm1wZyFgZjwGpcMHQ5XkpsLVn0VzJF8D8jTM5eVzts
	kE82s7BG/DNwwHcgFI91dmM8uE5isf9MH+jftrZjl5f6XvjgdE757AIwt7+V681qf4Omruy4u9lyZ
	Y8eMOgbQfhhcrEG9Ixpr8+bADIvX261qs0B83dTWVN4vidyxx6tJwM2hqqpyrLiPpW+5ToJtHblR4
	jU9qNGZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t4K5D-00000003lnc-47rX;
	Fri, 25 Oct 2024 13:10:27 +0000
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t4JpY-00000003jae-1oHg
	for linux-um@lists.infradead.org;
	Fri, 25 Oct 2024 12:54:45 +0000
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-7205b6f51f3so258584b3a.1
        for <linux-um@lists.infradead.org>; Fri, 25 Oct 2024 05:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729860855; x=1730465655; darn=lists.infradead.org;
        h=mime-version:user-agent:references:in-reply-to:subject:cc:to:from
         :message-id:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5E+5IGmjD5RYhRDoYf+p51x7iks9smyytpRiSxJ79eU=;
        b=QfeTgdlGXIES7Ss2JVv7MdTlNUE9RSxVrWX+aXC72mNF5k//SoqLUTRXBC3DOLKKgs
         +sND9AYQ/EKyOjHV0gPj8jVR1qx7nVQiR/MYV/cFJcF3Q5u2uSCOQwSSvEoEHfiP4b/U
         ywNL/u0EbxOba0jfq335Q6S/HtFmLbTdHwuKjSYhiboUJouj6xUMdxObAkREA5Au06g7
         tL0rqg67BEHLvobrW+Endi9EbRt5BJU5XvdGYY1BrOpKOoqZyFmeu4EmzsI+YyFLd2rh
         70Frdf6kKhy1Wk8NQzg8r0wkJL1hHr/paG4O7y4P/hQb9FiiYQ/UayFNNGnhnl1kK5/C
         LMWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729860855; x=1730465655;
        h=mime-version:user-agent:references:in-reply-to:subject:cc:to:from
         :message-id:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5E+5IGmjD5RYhRDoYf+p51x7iks9smyytpRiSxJ79eU=;
        b=FPToput2NIuH3mHDjHvTkb4XcJ1WlKGg3W/9d6kzVxwBOn6ob++Q7mPaXEF9+HAfrO
         lf1EntTnq/LPlY9uN22HowjUwp+u5dlgTkfGfY3mZKVyOBkkAuW4myeMAha9DRMW7vFW
         /gGKVhZ6fGBGfLWzCdROY7A4L+a9tRXgkmpYzSf9C9dLtmQX8jd/CcAQjShLRAKPTi1A
         y7SFVpDoc+OhyYYZQWAH/5gDEKmnW/ZiKENY/7VCnFeDzaduEASS/j/GJSiWASimZmHh
         9lG/cGwz6lqo+8x+sL4U9SO3+VlIMmLzRWhS1SOG9tTYEx1vAaiqDepx0TAaenPOypUj
         0Xiw==
X-Gm-Message-State: AOJu0Yw/XuIq4ewO7j8LpoIoKDYsr8ICExkIvKQZh3/PV49eq7YKhK7P
	U14IKPIk3b+eTnMS48QwQ6LMWbvaYT3PZMrl/IRPHIwybPaxVJx5
X-Google-Smtp-Source: AGHT+IEJsV32RYzl+idFh+LcUZ24o+g7OnwiMcuwcZxoiEpCuqxm4D5Rp6MG7Ye+xrL21cJwGYJ3oQ==
X-Received: by 2002:a05:6a20:d808:b0:1d4:fc66:30e8 with SMTP id adf61e73a8af0-1d978aeaee5mr11694975637.10.1729860854632;
        Fri, 25 Oct 2024 05:54:14 -0700 (PDT)
Received: from mars.local.gmail.com (221x241x217x81.ap221.ftth.ucom.ne.jp. [221.241.217.81])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057a0d025sm991964b3a.101.2024.10.25.05.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 05:54:13 -0700 (PDT)
Date: Fri, 25 Oct 2024 21:54:09 +0900
Message-ID: <m2v7xgny1a.wl-thehajime@gmail.com>
From: Hajime Tazaki<thehajime@gmail.com>
To: johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	jdike@addtoit.com,
	richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	ricarkol@google.com,
	ebiederm@xmission.com,
	kees@kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH 02/13] x86/um: nommu: elf loader for fdpic
In-Reply-To: <d24d5197bff15d64e6ac14f538f9718403e478f6.camel@sipsolutions.net>
References: <cover.1729770373.git.thehajime@gmail.com>
	<db0cc5bc7e55431f1ac6580aa1d983f8cfc661fb.1729770373.git.thehajime@gmail.com>
	<d24d5197bff15d64e6ac14f538f9718403e478f6.camel@sipsolutions.net>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/26.3 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241025_055416_492720_0EF3C01F 
X-CRM114-Status: GOOD (  16.37  )
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


Hello Johannes,

On Fri, 25 Oct 2024 17:56:51 +0900,
Johannes Berg wrote:
> 
> On Thu, 2024-10-24 at 21:09 +0900, Hajime Tazaki wrote:
> > 
> > +#ifndef CONFIG_MMU
> > +#include <asm-generic/bug.h>
> 
> Not sure that makes so much sense in the middle of the file, no harm
> always having it?

agree.

> > +static inline const struct user_regset_view *task_user_regset_view(
> > +	struct task_struct *task)
> 
> What happened to indentation here ;-)
> 
> static inline const ..... *
> task_user_regset_view(....)
> 
> would be far easier to read.

fine, will fix it in the next revision.

> > +++ b/arch/x86/um/asm/module.h
> > @@ -2,23 +2,6 @@
> >  #ifndef __UM_MODULE_H
> >  #define __UM_MODULE_H
> >  
> > -/* UML is simple */
> > -struct mod_arch_specific
> > -{
> > -};
> > -
> > -#ifdef CONFIG_X86_32
> > -
> > -#define Elf_Shdr Elf32_Shdr
> > -#define Elf_Sym Elf32_Sym
> > -#define Elf_Ehdr Elf32_Ehdr
> > -
> > -#else
> > -
> > -#define Elf_Shdr Elf64_Shdr
> > -#define Elf_Sym Elf64_Sym
> > -#define Elf_Ehdr Elf64_Ehdr
> > -
> > -#endif
> > +#include <asm-generic/module.h>
> >  
> >  #endif
> 
> That seems like a worthwhile cleanup on its own, but you should be able
> to just remove the file entirely?

agree. will add module.h to arch/um/include/asm/Kbuild.

-- Hajime

