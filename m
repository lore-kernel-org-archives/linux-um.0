Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48CF4C3ABC6
	for <linux-um@archiver.kernel.org>; Thu,  8 May 2025 17:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DaPmEK3MeKb1iMh1NlJFKZhNyNIIPi6dL7yTJklAm38=; b=bMlfBeaA9hZM/5X3o2NxzMCi/I
	5hm3Rd5ZZF9yIK+4LfIkYkoezcMvVoe1EGTMtZ5EcV4fg+8CpgoMVaunxBCCyW1m/3BJUsRKgKowr
	Reim4YQMZ1Q3sBySEDLS2T1c13u9hh2uN1xTNwfCIyEaCvv5+lmgNwjtUH2h8O7ZAsB/RuTWJuXn6
	0tSlRn5BT7miOSxMw3t4SdV3cghad0G8+BtcsMdR9gOTa/SXbjTUpUPe24Groa9iNYFwVUuKkbU+1
	T0/iB4nMzFv/BbE+o5PUuisGVzcwc3/3MMfEeqI61vCTOwsbCgNb6IZ+26YlHkM35qi2j6mm54Pu9
	bS1R77/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uD4w4-00000001NcZ-40iz;
	Thu, 08 May 2025 17:21:28 +0000
Received: from mxex2.tik.uni-stuttgart.de ([2001:7c0:2041:24::a:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uD4c3-00000001Kk5-0rqh
	for linux-um@lists.infradead.org;
	Thu, 08 May 2025 17:00:49 +0000
Received: from localhost (localhost [127.0.0.1])
	by mxex2.tik.uni-stuttgart.de (Postfix) with ESMTP id ACA2B6072C;
	Thu,  8 May 2025 19:00:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=uni-stuttgart.de;
	 h=content-transfer-encoding:content-type:content-type
	:in-reply-to:organization:from:from:content-language:references
	:subject:subject:user-agent:mime-version:date:date:message-id;
	 s=dkim; i=@isd.uni-stuttgart.de; t=1746723630; x=1748462431;
	 bh=OyuIWm4IMT0P5Xd3YnD3AKzFv4vivn4bMHgsgz1kcIY=; b=mJuYCmEEFUYp
	4u7feMXMlPso9JTU/eitCoLd7BlbbWH4c18h+vDPlmKz/Q9m4joYCXZh+Fvia186
	RU22Y1WpP6ykAn1tbYou/UjfDzRsz2qJ2n41wyXMC7CzHzupVzU0IfqpVcdqIMfS
	Yh927rkaoxpEc3IPvk4U4Z3PJ4UVcK0yQECj68tLltGVRvjNoaCsyeflzmtHJjPJ
	SnTn93d4VUrVM3YcnsTyc5fdogTIKGjQkMSYgkafQKqdPfl7YE2hGrZWKKp/1pZ5
	jj4ZE7ikS40qs5Jk/mXe4DuT5iq0HJDkKjhHYjEw2tuTeiO+ZM1lqWKBqXsVhOfh
	nKMqzG3/tQ==
X-Virus-Scanned: USTUTT mailrelay AV services at mxex2.tik.uni-stuttgart.de
Received: from mxex2.tik.uni-stuttgart.de ([127.0.0.1])
 by localhost (mxex2.tik.uni-stuttgart.de [127.0.0.1]) (amavis, port 10031)
 with ESMTP id vQ7Sv7mdwQ-X; Thu,  8 May 2025 19:00:30 +0200 (CEST)
Received: from authenticated client
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxex2.tik.uni-stuttgart.de (Postfix) with ESMTPSA
Message-ID: <0df8de9f-d24a-4ffb-8234-7d7bbe1660a4@isd.uni-stuttgart.de>
Date: Thu, 8 May 2025 19:00:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Missing patch in 6.12.27 - breaks UM target builds
To: Benjamin Berg <benjamin@sipsolutions.net>, linux-um@lists.infradead.org,
 stable@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20250314130815.226872-1-benjamin@sipsolutions.net>
Content-Language: de-DE
From: Christian Lamparter <christian.lamparter@isd.uni-stuttgart.de>
Organization: Universitaet Stuttgart - ISD
In-Reply-To: <20250314130815.226872-1-benjamin@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250508_100047_958371_0F98ED9D 
X-CRM114-Status: GOOD (  29.69  )
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

Hi,

On 3/14/25 2:08 PM, Benjamin Berg wrote:
> From: Benjamin Berg <benjamin.berg@intel.com>
>     um: work around sched_yield not yielding in time-travel mode
>
> sched_yield by a userspace may not actually cause scheduling in
> time-travel mode as no time has passed. In the case seen it appears to
> be a badly implemented userspace spinlock in ASAN. Unfortunately, with
> time-travel it causes an extreme slowdown or even deadlock depending on
> the kernel configuration (CONFIG_UML_MAX_USERSPACE_ITERATIONS).
>
> Work around it by accounting time to the process whenever it executes a
> sched_yield syscall.
>
> Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>

 From what I can tell the patch mentioned above was backported to 6.12.27 by:
<https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/arch/um?id=887c5c12e80c8424bd471122d2e8b6b462e12874>

but without the upstream
|Commit 0b8b2668f9981c1fefc2ef892bd915288ef01f33
|Author: Benjamin Berg <benjamin.berg@intel.com>
|Date:   Thu Oct 10 16:25:37 2024 +0200
|  um: insert scheduler ticks when userspace does not yield
|
|   In time-travel mode userspace can do a lot of work without any time
|   passing. Unfortunately, this can result in OOM situations as the RCU
|  core code will never be run. [...]

the kernel build for 6.12.27 for the UM-Target will fail:

| /usr/bin/ld: arch/um/kernel/skas/syscall.o: in function `handle_syscall': linux-6.12.27/arch/um/kernel/skas/syscall.c:43:(.text+0xa2): undefined reference to `tt_extra_sched_jiffies'
| collect2: error: ld returned 1 exit status

is it possible to backport 0b8b2668f9981c1fefc2ef892bd915288ef01f33 too?
Or is it better to revert 887c5c12e80c8424bd471122d2e8b6b462e12874 again
in the stable releases?

Best Regards,
Christian Lamparter

>
> ---
>
> I suspect it is this code in ASAN that uses sched_yield
>    https://github.com/llvm/llvm-project/blob/main/compiler-rt/lib/sanitizer_common/sanitizer_mutex.cpp
> though there are also some other places that use sched_yield.
>
> I doubt that code is reasonable. At the same time, not sure that
> sched_yield is behaving as advertised either as it obviously is not
> necessarily relinquishing the CPU.
> ---
>   arch/um/include/linux/time-internal.h |  2 ++
>   arch/um/kernel/skas/syscall.c         | 11 +++++++++++
>   2 files changed, 13 insertions(+)
>
> diff --git a/arch/um/include/linux/time-internal.h b/arch/um/include/linux/time-internal.h
> index b22226634ff6..138908b999d7 100644
> --- a/arch/um/include/linux/time-internal.h
> +++ b/arch/um/include/linux/time-internal.h
> @@ -83,6 +83,8 @@ extern void time_travel_not_configured(void);
>   #define time_travel_del_event(...) time_travel_not_configured()
>   #endif /* CONFIG_UML_TIME_TRAVEL_SUPPORT */
>   
> +extern unsigned long tt_extra_sched_jiffies;
> +
>   /*
>    * Without CONFIG_UML_TIME_TRAVEL_SUPPORT this is a linker error if used,
>    * which is intentional since we really shouldn't link it in that case.
> diff --git a/arch/um/kernel/skas/syscall.c b/arch/um/kernel/skas/syscall.c
> index b09e85279d2b..a5beaea2967e 100644
> --- a/arch/um/kernel/skas/syscall.c
> +++ b/arch/um/kernel/skas/syscall.c
> @@ -31,6 +31,17 @@ void handle_syscall(struct uml_pt_regs *r)
>   		goto out;
>   
>   	syscall = UPT_SYSCALL_NR(r);
> +
> +	/*
> +	 * If no time passes, then sched_yield may not actually yield, causing
> +	 * broken spinlock implementations in userspace (ASAN) to hang for long
> +	 * periods of time.
> +	 */
> +	if ((time_travel_mode == TT_MODE_INFCPU ||
> +	     time_travel_mode == TT_MODE_EXTERNAL) &&
> +	    syscall == __NR_sched_yield)
> +		tt_extra_sched_jiffies += 1;
> +
>   	if (syscall >= 0 && syscall < __NR_syscalls) {
>   		unsigned long ret = EXECUTE_SYSCALL(syscall, regs);
>   


