Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 896EDC02187
	for <linux-um@archiver.kernel.org>; Sun, 19 Jan 2025 16:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:Cc:To:From:Date:Content-ID:Content-Description:Resent-Date
	:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Cyam91n6FlJrIz5bKpFOf9KhUGqhwtv1k7Bv1ud16FY=; b=koMNA9P35awFTnB15Zicli4KW2
	vICR6ctL16Dp1+b3WK8iiyDfloDsPtkZXIknJA5EmmhE3FkPMj5o/0l61cMpLqHTsodkGdblKW+XZ
	kygaGMyhrUbZp0dRy5FFmx02MitafIbCjzxBL8l/eIFtJPRk1q7IByXPYLbTMtEwbt4sY4SaIBWk/
	Fznyb+zs2CSrHgZgmCuqKitdnwqqlCsvp/P8Oww1rBWceRYVG8Mcr/gKQAQva8Puivq4feXA85Ciu
	YMbv92sBRH1ASEM3z2DUNcx982+vWJ3y/l/dG6qhGGzjOuool8+aOCxz3VvHNxkeAd8zoCConIaWH
	dmmB/txQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tZYZd-00000004955-3bZb;
	Sun, 19 Jan 2025 16:54:57 +0000
Received: from mail-qt1-x831.google.com ([2607:f8b0:4864:20::831])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tZYZa-0000000494c-3cfC
	for linux-um@lists.infradead.org;
	Sun, 19 Jan 2025 16:54:56 +0000
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-46901d01355so39180411cf.0
        for <linux-um@lists.infradead.org>; Sun, 19 Jan 2025 08:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=efficientek-com.20230601.gappssmtp.com; s=20230601; t=1737305693; x=1737910493; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Cyam91n6FlJrIz5bKpFOf9KhUGqhwtv1k7Bv1ud16FY=;
        b=B+HCqFpIMZrBjOn1C1DhvByqM0114gLr86lalkwBE7XKdv4r8K+x/gMjZLHpGL4JUg
         g5GImV7sl1K+HS92sGDs0LTMzjDhNJfS7dLFAizskOXEeIvsh/xebu1Pvc+Ns6cQRjVS
         oJQc4TBdlWygtnXa5rde6WL5c9dGL4tZDsBL2cdL4kJoln605xCHeUuJ9zdEqzSEfObI
         0acDWaNrVApPlZa1EevVvRDIeYhpBarc7chwOUjPOLDoFSijVF5wAvyroLfX5TQ8qImw
         6VSZCKA309Rci9NZyfVPkBsEa6betyHFVfyczvm174Y0pstDAMl4Ps+0TKxPajUApl4S
         RO+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737305693; x=1737910493;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Cyam91n6FlJrIz5bKpFOf9KhUGqhwtv1k7Bv1ud16FY=;
        b=MdnD2fvxXoH5JuLvusdURWEldgfwfkZ4oAwjg6a/kXVeI4oiKQYUrfIONDWDf2mlWR
         T/+fZdy+7ze6w0D1uNO3/nDZ1UFZ6+OfmLaHgGJ/a/2COtZ9SwUt6OMHenhLKqaXWkWu
         29TK0yvoSg0Iyx/ZO9PxHwvdeIczuki+NhmiYVpWdvJJNnT+a6ZCSR32rCyfCqVJS0yp
         BtYtTmWGrOEp101KHcL2IZjdwWpMJjApQhbnqYHJEUOKTH8j1vLVICWRRROu3k2Q5vAz
         bwhbdR7jnmYNRNmLco/tkfGT85wLNDd+JFAUrQVTGs9IaM05lKl8wnIltg61JjB+TMll
         OLZw==
X-Gm-Message-State: AOJu0YwdX7+JAFerqWwJQHd/wtHrPtirJk2HyieQxPLK5SUVDSsDXQrX
	1PA3FHT5YV7Ni6H6iYuq1yjoAsCY1twYaCsi03Ptbd5Cw88WeSQS4HPEViVbKA==
X-Gm-Gg: ASbGnctljvLbyXIOELWDW+cD1g4/G1TOl7yz3jYTJFG0v1T+QbL6Bz2GoPQtXSReown
	cCIXr1+x/H0PbWN8DAwgd3Hs1gcYa2S8+X2pd5xEV8N4+vgXmL422k+VSPs6s+Tq8TU/57Husu9
	3nQNkKd6ND/8H5nYfDQB+2Pu//VmoTgF+tP3WVg+GLL8qDcUbVeY94GEWfKuJ1xvxPbN63S5dWI
	K7gxTihcsYWB7b+TraFH73rQcyW4zgDQJtL5r3G+dEpJtFlWptFzz9EygOix2SH5FKX6ZNWkOEo
	6a8gLtrCXOAvBg==
X-Google-Smtp-Source: AGHT+IHX42Ei+4Z6ldV196fO1xnYXLn9mH1VaIh4Pz/ELQXGMr5pde42dsFfybFlmCR3tDEyJOQO0w==
X-Received: by 2002:a05:622a:20b:b0:460:f34c:12b6 with SMTP id d75a77b69052e-46e12bc5b93mr171726251cf.44.1737305693074;
        Sun, 19 Jan 2025 08:54:53 -0800 (PST)
Received: from crass-HP-ZBook-15-G2 ([199.58.83.12])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46e2fdde927sm6457711cf.80.2025.01.19.08.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jan 2025 08:54:52 -0800 (PST)
Date: Sun, 19 Jan 2025 10:54:50 -0600
From: Glenn Washburn <development@efficientek.com>
To: Benjamin Berg <benjamin@sipsolutions.net>
Cc: linux-um@lists.infradead.org, Benjamin Berg <benjamin.berg@intel.com>
Subject: Re: [PATCH v2] um: fix execve stub execution on old host OSs
Message-ID: <20250119105450.4b25f967@crass-HP-ZBook-15-G2>
In-Reply-To: <20250113094107.674738-1-benjamin@sipsolutions.net>
References: <20250113094107.674738-1-benjamin@sipsolutions.net>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.41; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250119_085455_177678_08B058C1 
X-CRM114-Status: GOOD (  20.35  )
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

On Mon, 13 Jan 2025 10:41:07 +0100
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
> Reported-by: Glenn Washburn <development@efficientek.com>
> Closes: https://lore.kernel.org/20250108022404.05e0de1e@crass-HP-ZBook-15-G2
> Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>

Tested-by: Glenn Washburn <development@efficientek.com>

> 
> ---
> 
> v2:
> - Fix regression in previous version to not close FD 0
> ---
>  arch/um/os-Linux/skas/process.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
> index f683cfc9e51a..e2f8f156402f 100644
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
> +	syscall(__NR_close_range, 0, ~0U, CLOSE_RANGE_CLOEXEC);
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
>  
>  	exit(5);
>  }

