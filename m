Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 864EACAC5B5
	for <linux-um@archiver.kernel.org>; Thu, 19 Sep 2024 12:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MVNG+j2ZVoTwSws8Fh2zCrV+eV9MYL44XD9Xdf1wB6s=; b=x7sW6W4ZLapVw3iOHFH1JCzvI+
	KlGmboqyuZqw2wcgBILe89H0FEi9MxQocm4Xp/XU2c+gb0C42EXx4q6O924HNeID/iRqaN4UiAmp6
	ouMTeQn67qLa/Zkml8kuOtP8wVgsrb+TWvLkeR/wtt+PbfY/nsBoKBqNCKOmQsoP8SwmigS6MUY2D
	F8OfMBsQaRdBzP57aNuDBs3PwqW5bsiSl9V9v3Ym0flDSLMt2HcsP7wxYDsDDxwbJE6q61tp8FIpD
	+35DjR6fWZxTIKWM2NixIKl5EWpP62uM/3E/6dRElMCgZD7v5nHP+DO+NbqhOKN98dWncy+iwOr69
	cqBgqZUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1srG4j-0000000ADXz-0Gnd;
	Thu, 19 Sep 2024 12:15:57 +0000
Received: from out0-194.mail.aliyun.com ([140.205.0.194])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1srG4f-0000000ADX2-2OZo
	for linux-um@lists.infradead.org;
	Thu, 19 Sep 2024 12:15:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1726748148; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=MVNG+j2ZVoTwSws8Fh2zCrV+eV9MYL44XD9Xdf1wB6s=;
	b=0tGGF7RYH6tN8Ey+XRHeaE/OncqMgWpLI90/mmZfXMMdIWUqIV6/ql7N8nAqKf9IU/N0ZE0PGNSh1vAKBFUH3Cfo2fFWS3RIdTcAYxkKlskbBSz1B9bOhssHeNbr6REJ8X6d13w/tvpX4OXh859GHaphA9XtqM6erBhhyxpkzjs=
Received: from 30.212.181.184(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.ZNWojvt_1726748146)
          by smtp.aliyun-inc.com;
          Thu, 19 Sep 2024 20:15:47 +0800
Message-ID: <6cc7df2c-4588-45d9-a7e1-6c3264ca30b7@antgroup.com>
Date: Thu, 19 Sep 2024 20:15:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 5/7] um: Discover host_task_size from envp
To: Benjamin Berg <benjamin@sipsolutions.net>, linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
References: <20240704190506.1438493-1-benjamin@sipsolutions.net>
 <20240704190506.1438493-6-benjamin@sipsolutions.net>
Content-Language: en-US
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
In-Reply-To: <20240704190506.1438493-6-benjamin@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240919_051554_250637_5A4E2C38 
X-CRM114-Status: GOOD (  28.07  )
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

On 2024/7/5 03:05, Benjamin Berg wrote:
[...]
> diff --git a/arch/x86/um/os-Linux/task_size.c b/arch/x86/um/os-Linux/task_size.c
> index 1dc9adc20b1c..a91599799b1a 100644
> --- a/arch/x86/um/os-Linux/task_size.c
> +++ b/arch/x86/um/os-Linux/task_size.c
> @@ -1,151 +1,19 @@
>  // SPDX-License-Identifier: GPL-2.0
> -#include <stdio.h>
> -#include <stdlib.h>
> -#include <signal.h>
> -#include <sys/mman.h>
> -#include <longjmp.h>
>  

Tiny nit: we need to include os.h to avoid below warning:

arch/x86/um/os-Linux/task_size.c:3:15: warning: no previous prototype for
‘os_get_top_address’ [-Wmissing-prototypes]
    3 | unsigned long os_get_top_address(char **envp)
      |               ^~~~~~~~~~~~~~~~~~

Regards,
Tiwei

> -#ifdef __i386__
> -
> -static jmp_buf buf;
> -
> -static void segfault(int sig)
> -{
> -	longjmp(buf, 1);
> -}
> -
> -static int page_ok(unsigned long page)
> -{
> -	unsigned long *address = (unsigned long *) (page << UM_KERN_PAGE_SHIFT);
> -	unsigned long n = ~0UL;
> -	void *mapped = NULL;
> -	int ok = 0;
> -
> -	/*
> -	 * First see if the page is readable.  If it is, it may still
> -	 * be a VDSO, so we go on to see if it's writable.  If not
> -	 * then try mapping memory there.  If that fails, then we're
> -	 * still in the kernel area.  As a sanity check, we'll fail if
> -	 * the mmap succeeds, but gives us an address different from
> -	 * what we wanted.
> -	 */
> -	if (setjmp(buf) == 0)
> -		n = *address;
> -	else {
> -		mapped = mmap(address, UM_KERN_PAGE_SIZE,
> -			      PROT_READ | PROT_WRITE,
> -			      MAP_FIXED | MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> -		if (mapped == MAP_FAILED)
> -			return 0;
> -		if (mapped != address)
> -			goto out;
> -	}
> -
> -	/*
> -	 * Now, is it writeable?  If so, then we're in user address
> -	 * space.  If not, then try mprotecting it and try the write
> -	 * again.
> -	 */
> -	if (setjmp(buf) == 0) {
> -		*address = n;
> -		ok = 1;
> -		goto out;
> -	} else if (mprotect(address, UM_KERN_PAGE_SIZE,
> -			    PROT_READ | PROT_WRITE) != 0)
> -		goto out;
> -
> -	if (setjmp(buf) == 0) {
> -		*address = n;
> -		ok = 1;
> -	}
> -
> - out:
> -	if (mapped != NULL)
> -		munmap(mapped, UM_KERN_PAGE_SIZE);
> -	return ok;
> -}
> -
> -unsigned long os_get_top_address(void)
> +unsigned long os_get_top_address(char **envp)
>  {
> -	struct sigaction sa, old;
> -	unsigned long bottom = 0;
> -	/*
> -	 * A 32-bit UML on a 64-bit host gets confused about the VDSO at
> -	 * 0xffffe000.  It is mapped, is readable, can be reprotected writeable
> -	 * and written.  However, exec discovers later that it can't be
> -	 * unmapped.  So, just set the highest address to be checked to just
> -	 * below it.  This might waste some address space on 4G/4G 32-bit
> -	 * hosts, but shouldn't hurt otherwise.
> -	 */
> -	unsigned long top = 0xffffd000 >> UM_KERN_PAGE_SHIFT;
> -	unsigned long test, original;
> +	unsigned long top_addr = (unsigned long) &top_addr;
> +	int i;
>  
> -	printf("Locating the bottom of the address space ... ");
> -	fflush(stdout);
> -
> -	/*
> -	 * We're going to be longjmping out of the signal handler, so
> -	 * SA_DEFER needs to be set.
> -	 */
> -	sa.sa_handler = segfault;
> -	sigemptyset(&sa.sa_mask);
> -	sa.sa_flags = SA_NODEFER;
> -	if (sigaction(SIGSEGV, &sa, &old)) {
> -		perror("os_get_top_address");
> -		exit(1);
> -	}
> -
> -	/* Manually scan the address space, bottom-up, until we find
> -	 * the first valid page (or run out of them).
> -	 */
> -	for (bottom = 0; bottom < top; bottom++) {
> -		if (page_ok(bottom))
> -			break;
> -	}
> -
> -	/* If we've got this far, we ran out of pages. */
> -	if (bottom == top) {
> -		fprintf(stderr, "Unable to determine bottom of address "
> -			"space.\n");
> -		exit(1);
> -	}
> -
> -	printf("0x%lx\n", bottom << UM_KERN_PAGE_SHIFT);
> -	printf("Locating the top of the address space ... ");
> -	fflush(stdout);
> -
> -	original = bottom;
> -
> -	/* This could happen with a 4G/4G split */
> -	if (page_ok(top))
> -		goto out;
> -
> -	do {
> -		test = bottom + (top - bottom) / 2;
> -		if (page_ok(test))
> -			bottom = test;
> -		else
> -			top = test;
> -	} while (top - bottom > 1);
> -
> -out:
> -	/* Restore the old SIGSEGV handling */
> -	if (sigaction(SIGSEGV, &old, NULL)) {
> -		perror("os_get_top_address");
> -		exit(1);
> +	/* The earliest variable should be after the program name in ELF */
> +	for (i = 0; envp[i]; i++) {
> +		if ((unsigned long) envp[i] > top_addr)
> +			top_addr = (unsigned long) envp[i];
>  	}
> -	top <<= UM_KERN_PAGE_SHIFT;
> -	printf("0x%lx\n", top);
>  
> -	return top;
> -}
> -
> -#else
> +	top_addr &= ~(UM_KERN_PAGE_SIZE - 1);
> +	top_addr += UM_KERN_PAGE_SIZE;
>  
> -unsigned long os_get_top_address(void)
> -{
> -	/* The old value of CONFIG_TOP_ADDR */
> -	return 0x7fc0002000;
> +	return top_addr;
>  }
>  
> -#endif


