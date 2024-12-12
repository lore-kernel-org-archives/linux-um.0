Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50641E7717D
	for <linux-um@archiver.kernel.org>; Thu, 12 Dec 2024 02:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Subject:Cc:To:From:Message-ID:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZzqE70oaRyZVfTqi8gYX6wfW144edpTlsUuDsSmKiH8=; b=2otKUR05/vlTfz3aPZPFGxSryh
	jgraKZUR13uZVwEvwKj/qQF2Hwr7uFi1kVkwwsBic93wjlpX5WQmeNgMHG1JRso+UZxNMbmo4W3z9
	ts50xFWYsz/jw5O/b499t6xGv00AIxfcmSMq97DJOXWljrOJiUoHldrrH1q5+39vDEcEKJgHcmgHN
	T/ocY+xvirziT36B792lb+k0qK6WldkJJznL5MzGSaIRlylfrey9blzEB+6DdwH5jnknIztRU6mgs
	A8YcnX6m0kvx076WdcwRGX0II1we1CYc1YWA5aOB4H4SK2NUEaAUKqijlUZ9KE/QP9BX0aLv7LcAU
	d/GE2+lw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tLYVY-0000000GhnJ-0c7g;
	Thu, 12 Dec 2024 02:00:52 +0000
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tLYVV-0000000Ghmq-0fjb
	for linux-um@lists.infradead.org;
	Thu, 12 Dec 2024 02:00:50 +0000
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-216401de828so720525ad.3
        for <linux-um@lists.infradead.org>; Wed, 11 Dec 2024 18:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733968847; x=1734573647; darn=lists.infradead.org;
        h=mime-version:user-agent:references:in-reply-to:subject:cc:to:from
         :message-id:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZzqE70oaRyZVfTqi8gYX6wfW144edpTlsUuDsSmKiH8=;
        b=m0zpIwfk/WJMNZCraenm2JNcrsGcdeCzHdPQ6/kynvmKmTpGdX7fCpj0otdfa06tww
         Ef1m82cNa55ItJQrowi3KzoTQjH7Xfg3rHk4x5oouF6MPHY/pPmpsSRDFUpNfdoHH755
         zz0UwMAgQgsImPX4mk9MdlDmyFkt9R//MJ/Buej7Rk5NckpBqMwQMfv4jW5MTNuPpd39
         qBxAFIxEnBdd5YMK3qG/aWIk9YfkmWl8mj2vBXJEmpz1UK8XdFfIOxcrdu96BEh4hKzf
         MdtDEVwzdahsq7+GZAYE+/I+2SJjwTEvEk6Tdq48Ik1JneFhdbaujKpVgZhpMwGD+AIg
         AaRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733968847; x=1734573647;
        h=mime-version:user-agent:references:in-reply-to:subject:cc:to:from
         :message-id:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZzqE70oaRyZVfTqi8gYX6wfW144edpTlsUuDsSmKiH8=;
        b=I+p4hBTIntrWUjn4mWykHDf9Q07Xdfo058SWBD0IltIgM+dLi42CT3ZT41wSOS7yFp
         qDMJvSGSFnwj9il+y/4axjIT8IJqdcuKFzBFt/HYOAK0s3uf0O9fariHUy62nWl5JTZk
         GVKccWj1hCwbhJYNpCfCCcH2b4y4WKOkJ4ni6fd5BT+ZACMrZLN16l5sTUKovZk9a35z
         yHCEXH2Y7h/klGUAQcK2d6/e6KwXTPoPi3oN/qZPAOFmgN2OsdhKnoAJasQloj5PDbIw
         nhQO3u+kyCnHbraMQZrYkXHw4W4hoarLrFceP3WZaWZp2mTFqogRa3afD5cIQnwyrorG
         ulIQ==
X-Gm-Message-State: AOJu0YyxH7V9hlyj18W6IZib5k7pTESoREBJWeKdUlJiJRXGwI1SQ94L
	MK+icPjuujVbm8SWk2lDuKRjt1KdhCRXhZ8tWKiFSfuAxcud0lPMH4tTDQ==
X-Gm-Gg: ASbGncsJ7/vLRGquO+KpCTDTRAn5B69fWt9yU+vou9iZY4huAGfEqDpMVIg7n57rMMk
	+zrA/jqC61ftnJbTD+HG/o4xZVcUfpgw60t43Uh8qKdW9mA+MuBaCLnqGiR0dSUffK+TqnbNmk5
	YRYmWbkYSAdeE1rtc5raQntWtvlOpkOC/r6tWlq4Q20x1Cd1FMDzEwJPgZh30tykpooGeKQo6VP
	IDF/7aGE3QTVKdpLykRdHUkbvbdkxNqLuhU4ASPeO18cn/ClznaClpR9vE2Wku3ZShg47hd0Xdv
	LTjm6yx2pb5KvZrjEoC53RdFvxrHMN1Xgbysg9nDusU=
X-Google-Smtp-Source: AGHT+IFqrmvMOpi8IruBoO4CGDNeNVSWzXVzg154/sehrom0J0RFF6iFpljObl1fEsIR2p7jeTJ7tQ==
X-Received: by 2002:a17:903:234f:b0:208:d856:dbb7 with SMTP id d9443c01a7336-2177854a053mr82192715ad.39.1733968847262;
        Wed, 11 Dec 2024 18:00:47 -0800 (PST)
Received: from mars.local.gmail.com (221x241x217x81.ap221.ftth.ucom.ne.jp. [221.241.217.81])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8f0cf61sm112972845ad.188.2024.12.11.18.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 18:00:46 -0800 (PST)
Date: Thu, 12 Dec 2024 11:00:43 +0900
Message-ID: <m234it7j90.wl-thehajime@gmail.com>
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: ricarkol@google.com,
	Liam.Howlett@oracle.com
Subject: Re: [PATCH v4 10/13] x86/um: nommu: signal handling
In-Reply-To: <aa935a0f32fec0ff4073fb004eab4b22f80ac750.1733652929.git.thehajime@gmail.com>
References: <cover.1733652929.git.thehajime@gmail.com>
	<aa935a0f32fec0ff4073fb004eab4b22f80ac750.1733652929.git.thehajime@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/26.3 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241211_180049_201728_60778634 
X-CRM114-Status: GOOD (  18.66  )
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


On Sun, 08 Dec 2024 19:15:37 +0900,
Hajime Tazaki wrote:
> 
> This commit updates the behavior of signal handling under !MMU
> environment. 1) the stack preparation for the signal handlers and
> 2) restoration of stack after rt_sigreturn(2) syscall.  Those are needed
> as the stack usage on vfork(2) syscall is different.
> 
> It also adds the follow up routine for SIGSEGV as a signal delivery runs
> in the same stack frame while we have to avoid endless SIGSEGV.
(snip)
> diff --git a/arch/x86/um/nommu/signal.c b/arch/x86/um/nommu/signal.c
> new file mode 100644
> index 000000000000..a94e9b86273a
> --- /dev/null
> +++ b/arch/x86/um/nommu/signal.c
> @@ -0,0 +1,43 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/syscalls.h>
> +#include <linux/kernel.h>
> +#include <asm/sigframe.h>
> +
> +#include <sysdep/signal.h>
> +
> +int arch_setup_signal_stack_si(struct rt_sigframe __user **frame,
> +			       struct ksignal *ksig)
> +{
> +	int err = 0;
> +
> +	/*
> +	 * we need to push handler address at top of stack, as
> +	 * __kernel_vsyscall, called after this returns with ret with
> +	 * stack contents, thus push the handler here.
> +	 */
> +	*frame = (struct rt_sigframe __user *) ((unsigned long) *frame -
> +					       sizeof(unsigned long));
> +	err |= __put_user((unsigned long)ksig->ka.sa.sa_handler,
> +			  (unsigned long *)*frame);
> +
> +	return err;

this has a serious issue to handle signals.
I also found that manipulation of stack pointer makes the code
cryptic..

I will clean up those parts in the next version.

-- Hajime

