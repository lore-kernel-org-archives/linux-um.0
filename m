Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7A20C02181
	for <linux-um@archiver.kernel.org>; Mon, 20 Jan 2025 13:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=t0Y1ype3ppnk0OeLhlW6Fo6oGTzJOolSI9eUh0ZWOLg=; b=S23Hith7XrV9WwDmkvEgrG9axv
	IG7t/BauSGuv98g8rXC7xG0uh7ujR7+YJvon5U4EpSeu/vwRaNtM8lzvjGT6DR/illkU/sKMaHWaQ
	SVwL0P6Cj+AmwWZ7nyoTeDjxZfnNC3y0kCa7ywCWuh+oNJSkJk5XnWn6RbfjnvpzGvmyZcK0IrTNu
	UVC3Itg7j0BXi+7r3tCP9wlfegLq/crSYbXZVWx6f+sf/+5Pq0R5lw3MdY5gcO9dToY6woD7DU6Vg
	MrA3MzCsZVMxg7s/vtCogl9cgVsjuiR4hTEK8c2hyIPebOJueBBoYZcaz0tiu04HDseTeY4P672YN
	R6JYs0pg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tZrwy-00000005gFR-2JHn;
	Mon, 20 Jan 2025 13:36:20 +0000
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tZrww-00000005gF2-2ZmX
	for linux-um@lists.infradead.org;
	Mon, 20 Jan 2025 13:36:20 +0000
Date: Mon, 20 Jan 2025 14:36:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1737380174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t0Y1ype3ppnk0OeLhlW6Fo6oGTzJOolSI9eUh0ZWOLg=;
	b=ucadM5bOVbfdvZCnRWtmy+aDeTh37dAelp+eIEo03lbXyp9t8rzHFm4M+J2pnUVkwxX7xn
	z5LSbxYY6Iv/XEIRYfq4UV+oJ8u5XKGPmKophcyFqcNT6ZG/CTpzJB+x2iHN54IR7whTh/
	wj/oAIs8dt5dEXV8E9LRyPUORpBS88Kk3YJX7kQoNkDZVWaabl7N230Qqi9lRNUyCuslVH
	OSmWEzwWqfHcPzS4Y7C5VaKpzCq6EKLqfb/AM5N4WyVAu055qu2Muz4lixXOLqVfjUMpdA
	BdehfMeW3YloV5jWITXEmlMi3sOJwjKyhEgjVl98KoFEgIsI54WXHOtieK0BNw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1737380174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t0Y1ype3ppnk0OeLhlW6Fo6oGTzJOolSI9eUh0ZWOLg=;
	b=O9o4F5V46TdLOi2N39ZpjQB39vyvKSyb0ubc96CpLkE6yHaZDWDffzOiUqFO1NZpxJo2vn
	rnLIlrIrptM6C7Cw==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Benjamin Berg <benjamin@sipsolutions.net>
Cc: linux-arch@vger.kernel.org, linux-um@lists.infradead.org, 
	x86@kernel.org, briannorris@chromium.org, linux-kernel@vger.kernel.org, 
	kasan-dev@googlegroups.com, Benjamin Berg <benjamin.berg@intel.com>
Subject: Re: [PATCH 2/3] um: avoid copying FP state from init_task
Message-ID: <20250120142855-9d570200-cef7-4cfb-9ee5-81c8005a99d8@linutronix.de>
References: <20241217202745.1402932-1-benjamin@sipsolutions.net>
 <20241217202745.1402932-3-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241217202745.1402932-3-benjamin@sipsolutions.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250120_053618_798345_501C8DAB 
X-CRM114-Status: GOOD (  18.87  )
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

On Tue, Dec 17, 2024 at 09:27:44PM +0100, Benjamin Berg wrote:
> From: Benjamin Berg <benjamin.berg@intel.com>
> 
> The init_task instance of struct task_struct is statically allocated and
> does not contain the dynamic area for the userspace FP registers. As
> such, limit the copy to the valid area of init_task and fill the rest
> with zero.
> 
> Note that the FP state is only needed for userspace, and as such it is
> entirely reasonable for init_task to not contain it.
> 
> Reported-by: Brian Norris <briannorris@chromium.org>
> Closes: https://lore.kernel.org/Z1ySXmjZm-xOqk90@google.com
> Fixes: 3f17fed21491 ("um: switch to regset API and depend on XSTATE")

No stable backport? The broken commit is now in the 6.13 release.

> Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>

Tested-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>

> ---
>  arch/um/kernel/process.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
> index 30bdc0a87dc8..3a67ba8aa62d 100644
> --- a/arch/um/kernel/process.c
> +++ b/arch/um/kernel/process.c
> @@ -191,7 +191,15 @@ void initial_thread_cb(void (*proc)(void *), void *arg)
>  int arch_dup_task_struct(struct task_struct *dst,
>  			 struct task_struct *src)
>  {
> -	memcpy(dst, src, arch_task_struct_size);
> +	/* init_task is not dynamically sized (missing FPU state) */
> +	if (unlikely(src == &init_task)) {
> +		memcpy(dst, src, sizeof(init_task));
> +		memset((void *)dst + sizeof(init_task), 0,
> +		       arch_task_struct_size - sizeof(init_task));
> +	} else {
> +		memcpy(dst, src, arch_task_struct_size);
> +	}

Nitpick:
This could make use of memcpy_and_pad() in various forms.

> +
>  	return 0;
>  }
>  
> -- 
> 2.47.1
> 

