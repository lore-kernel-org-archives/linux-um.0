Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65233E77188
	for <linux-um@archiver.kernel.org>; Sun, 12 Jan 2025 20:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:Cc:To:From:Date:Content-ID:Content-Description:Resent-Date
	:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8gVvFC2AdlS4Tsx48b2WUB6yTPoFh8WHXw+aTgE/LVQ=; b=4fi+00D15NOQN9WA7SJsQR/mRw
	lCkRZvbs+KAacpEoa5lwQCIP5G+qZeVgtSAKOlN3sh9VJ5ldUuU297R4bYgC348d/TeiHf6BXM+9X
	JN5PEjPZkzSwpQWB0EeNYX0pxK/QEV9CKkCQymAbmpnipUSQkHTVtxVtbppNbqvwd1oKF7DWcDx9y
	xeLYVq2R+wDfCrlli7zBerLUTCHoHPtfnE9ipG1gFofzuplDmk3qQktFtckORHnyDmyomFg02eNU8
	jqI1vdf9sUCgZwbNBmOgmsoIM1V7CFs8ASuk+AMjidWf5nk6+kMTuylimFwVC0wSGS5YlPWGiDmrh
	V4wpr5cQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tX4Fb-00000003N9C-2Fbv;
	Sun, 12 Jan 2025 20:07:59 +0000
Received: from mail-qt1-x82e.google.com ([2607:f8b0:4864:20::82e])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tX4FY-00000003N8a-1mtH
	for linux-um@lists.infradead.org;
	Sun, 12 Jan 2025 20:07:58 +0000
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-4679fc9b5f1so29434711cf.1
        for <linux-um@lists.infradead.org>; Sun, 12 Jan 2025 12:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=efficientek-com.20230601.gappssmtp.com; s=20230601; t=1736712474; x=1737317274; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8gVvFC2AdlS4Tsx48b2WUB6yTPoFh8WHXw+aTgE/LVQ=;
        b=qaoxyH5nxXKTT9wD580ymxY/1OcCJNoj9iwGqSTLJsryFQM9m1Fs7h6h1VyYB9WvoT
         QcrIJ55FKlQYFaspYywJF1vPdEs83Ak8PEWLVtEURc5feD9l9Oa9lyqrk/eqRydG1bds
         Bp76GwX3o5+INpAOO4eVgRtFLktqvITqfBIaRxAJs3j24mR7bM7ZZvQfBDZw5nLn+UHL
         gfXKHa8FE3HTbkAUCQdYdO0EjycmJl5oQPeMwcYswS4KsyK8QM0JgzDSeEKHpvrObYFg
         1KyhMbxBaS6lzPlMB6FE7S9JJfEn5SojCj+ukfZhhnMI50fohSIc7wQ4rg2l1M/ZZtH6
         jr0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736712474; x=1737317274;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8gVvFC2AdlS4Tsx48b2WUB6yTPoFh8WHXw+aTgE/LVQ=;
        b=pc21llVVIF+9ZH1ss8fi/xnj+F/oj9Lq0sq3lzbotCNw0hUiGRs6SLDyQJzX1hbb3P
         2Scbt7VQ1v9GvxzpBq+bnWjeMVgOUNQke+e3/8yIHpBEGCar3ASwYaKsFMeVyVTh3BIh
         cTwsuIAJBDjhe+xUewrS/yTvNa3AOaQwDJ3YHjcjfqcv5zMOhdWPhrtsLLKKDgT1obUu
         6sjJIQdBPFa+W6KpE5s/ksuP6jiT4pTIfcF+QC5BXEtffcDYNzspvJ7mp5U5P9Ad1Xr6
         OQg+Nyq6aybCjqEkp1xw3SWbMFuI+XTE8zw60diKJ+qq/cEhuJMiTVx6YOuQlk0anW+v
         955w==
X-Gm-Message-State: AOJu0YyPUMEj/SFGu/s9xnRXWBUyxCvYQKzt/GBaE3LVrj2hQqJiBQPi
	A6jCUl0jkbF9Fh97wBJbAJphRbuy1GtHWv8PdHFWnJEF43PxTPCD1BiEpoIalQ==
X-Gm-Gg: ASbGncsjkq1gzDImz7X0GQYT2tOgxogpLX/N8HJieeudijHRjYP8oZ5Qi3bRsPQLDEh
	auuq8C+S0V5rYOpKIaNAkRxWTWQzNQfmipKoU/Q2Yzueg2al2VSAdBJA4XvDhqJaTtE5MhTf5xX
	Im7m1UbGKCnR3k6qO8V/9HOFTfAEyrm8kKNw70Bu0ncQVCiWjLT1qR7IdHcKAqMbSu1J6ctuctV
	Q3EzA5tq6shUgLMf6n5koIKR2BSgbUVgqiTu24Xaw8Rsd9PKPJlQT82U51pXDnHYUTp7Xa7zz1/
X-Google-Smtp-Source: AGHT+IFgYqztS1ajyqkBxdiuxTFtjEbaGGQKIZqI9HO69+x5UlV15KtZpX6aO/K0G/CXciYoxhn0Cg==
X-Received: by 2002:ac8:7f14:0:b0:467:5642:5917 with SMTP id d75a77b69052e-46c710aead0mr248312111cf.32.1736712474456;
        Sun, 12 Jan 2025 12:07:54 -0800 (PST)
Received: from crass-HP-ZBook-15-G2 ([199.58.83.12])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46c873cc86esm33352871cf.53.2025.01.12.12.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2025 12:07:53 -0800 (PST)
Date: Sun, 12 Jan 2025 14:07:36 -0600
From: Glenn Washburn <development@efficientek.com>
To: Benjamin Berg <benjamin@sipsolutions.net>
Cc: linux-um@lists.infradead.org, Benjamin Berg <benjamin.berg@intel.com>
Subject: Re: [PATCH] um: fix execve stub execution on old host OSs
Message-ID: <20250112140736.1fcb25c3@crass-HP-ZBook-15-G2>
In-Reply-To: <20250110161305.558223-1-benjamin@sipsolutions.net>
References: <20250110161305.558223-1-benjamin@sipsolutions.net>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.41; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250112_120756_736125_BA806D8F 
X-CRM114-Status: GOOD (  30.74  )
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
Reply-To: development@efficientek.com
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

On Fri, 10 Jan 2025 17:13:05 +0100
Benjamin Berg <benjamin@sipsolutions.net> wrote:

> From: Benjamin Berg <benjamin.berg@intel.com>
> 
> The stub execution uses the somewhat new close_range and execveat
> syscalls. Of these two, the execveat call is essential, but the
> close_range call is more about stub process hygiene rather than safety
> (and its result is ignored).
> 
> Replace both calls with a raw syscall as older machines might not have a
> recent enough kernel for close_range (with CLOSE_RANGE_CLOEXEC) or a
> libc that does not yet expose both of the syscalls.
> 
> Fixes: 32e8eaf263d9 ("um: use execveat to create userspace MMs")

This change fixes the immediate issue, allowing the compile to complete
successfully.

> Reported-by: Glenn Washburn <development@efficientek.com>
> Closes: https://lore.kernel.org/20250108022404.05e0de1e@crass-HP-ZBook-15-G2
> Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
> ---
>  arch/um/os-Linux/skas/process.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
> index f683cfc9e51a..64e89921bc7f 100644
> --- a/arch/um/os-Linux/skas/process.c
> +++ b/arch/um/os-Linux/skas/process.c
> @@ -181,6 +181,10 @@ extern char __syscall_stub_start[];
>  
>  static int stub_exe_fd;
>  
> +#ifndef CLOSE_RANGE_CLOEXEC
> +#define CLOSE_RANGE_CLOEXEC	(1U << 2)
> +#endif
> +
>  static int userspace_tramp(void *stack)
>  {
>  	char *const argv[] = { "uml-userspace", NULL };
> @@ -202,8 +206,12 @@ static int userspace_tramp(void *stack)
>  	init_data.stub_data_fd = phys_mapping(uml_to_phys(stack), &offset);
>  	init_data.stub_data_offset = MMAP_OFFSET(offset);
>  
> -	/* Set CLOEXEC on all FDs and then unset on all memory related FDs */
> -	close_range(0, ~0U, CLOSE_RANGE_CLOEXEC);
> +	/*
> +	 * Avoid leaking unneeded FDs to the stub by setting CLOEXEC on all FDs
> +	 * and then unsetting it on all memory related FDs.
> +	 * This is not strictly necessary from a safety perspective.
> +	 */
> +	syscall(__NR_close_range, 1, ~0U, CLOSE_RANGE_CLOEXEC);

Was this intentional to change the fd parameter from 0 to 1?

>  
>  	fcntl(init_data.stub_data_fd, F_SETFD, 0);
>  	for (iomem = iomem_regions; iomem; iomem = iomem->next)
> @@ -224,7 +232,9 @@ static int userspace_tramp(void *stack)
>  	if (ret != sizeof(init_data))
>  		exit(4);
>  
> -	execveat(stub_exe_fd, "", argv, NULL, AT_EMPTY_PATH);
> +	/* Raw execveat for compatibility with older libc versions */
> +	syscall(__NR_execveat, stub_exe_fd, (unsigned long)"",
> +		(unsigned long)argv, NULL, AT_EMPTY_PATH);

I think it would look nicer to leave the call unchanged and define a stub
function like libc does, but only if we detect that the stubs are
undefined. I have a glibc specific patch for this, and then realized
that it should be more generic to cover other libcs. So this patch here
is more general. I think to have what I'd like, I'd need to add and run
a test binaries that check for these functions, like autotools does.
I'm not aware that this is really done in the kernel build system,
though I do know that there are binaries built during build for
generating binaries to be included in the kernel. So in theory I don't
think it should be too much trouble to do. Basically the idea would be
to have a system for testing host libc and outputting a config.h which
will define for instance, HAVE_EXECVEAT, if support is detected in the
linked libc for execveat. And in process.c define a stub around the
syscall() for execveat if not defined HAVE_EXECVEAT.

So perhaps for now, this is the best solution, but ultimately it would
be nice to have the above and ultimately reverse these changes.

Glenn

>  
>  	exit(5);
>  }



