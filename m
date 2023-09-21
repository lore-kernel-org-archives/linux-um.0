Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27252E7108E
	for <linux-um@archiver.kernel.org>; Thu, 21 Sep 2023 15:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:Cc:From:To:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MWbm87z/4n8VEm4FnvnoJcAx957SOepi5NcZG5tCt9Y=; b=UeAPX2jIpDkgFt
	G8v7f5N5uN4yDV9KGD611srCmViaeuqo1XfC9G9uHHRtH4xW2/eiB97fVakuwt0RT54EqHwmJvT1z
	cAl7FtbZr/avfy7YNElTwjrhPwxpCmzeJAYOwytxrsUwKbtDsENBdxIMn045dOrWczMEiskNvys12
	j0XM+6Q4HaijYCsZXfVw4sDIklk/IJdEcLTP9+4RkZ1W815VQsT7qY+eBPIjJgkbto7PV2zcuGD0d
	3F3TpbQ647b9lhFGOWNzpamOlX0C7DX5M57IxLbUX0qcAZJiX+dy1m8ayQ0MPnYbseggqvge1aoWO
	wjCVTJAn1GGGVCz3IBsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qjLgZ-006Pmj-0U;
	Thu, 21 Sep 2023 15:33:47 +0000
Received: from mail-4317.proton.ch ([185.70.43.17])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qjLgV-006Plh-32
	for linux-um@lists.infradead.org;
	Thu, 21 Sep 2023 15:33:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=n8pjl.ca;
	s=protonmail2; t=1695310418; x=1695569618;
	bh=9ojY+Emp27ZAPGFNE34dvqQPQyDrCIK6LR+b+7yFYBw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=PhqtH5PVsFE/W+C7C27pJYezIuTnG9ZHaeIeqNDRxnW5Y9N+R//8r6dpzNjqutwwq
	 TxzR3WmZr8vFcs1E/V13K3hgWOvSNE+2qnM4Ll5SusqGOlWUvGtHOp3FWkAndTs5I3
	 DrmdMnwelIU7PfoxmAkZpm04qE3YSZMKvihuWxpHZrua+3PO5yp19tpZGcRbdo27fe
	 v2iBfKkzemp7H4wE2Rl0y+ES2ZUjJRUx69gvd74Q826l42ac+zoXZdHT6Y7JQaSm8n
	 1wrdd04514C3b88RZoQR+oyRH7uDfri0Eq/mDLhr0FSVcolVdqYFNSyw3LgasBiTuT
	 pgwh7UJW+bPsA==
Date: Thu, 21 Sep 2023 15:33:26 +0000
To: anton.ivanov@cambridgegreys.com
From: Peter Lafreniere <peter@n8pjl.ca>
Cc: johannes@sipsolutions.net, linux-um@lists.infradead.org, richard@nod.at, Peter Lafreniere <peter@n8pjl.ca>
Subject: Re: [PATCH] um: Fix naming clash between UML and scheduler
Message-ID: <20230921153319.58479-1-peter@n8pjl.ca>
In-Reply-To: <20230921143444.264668-1-anton.ivanov@cambridgegreys.com>
References: <20230921143444.264668-1-anton.ivanov@cambridgegreys.com>
Feedback-ID: 53133685:user:proton
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230921_083345_490467_C0861FE8 
X-CRM114-Status: GOOD (  15.48  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

On Thu, Sep 21, 2023 at 10:34, anton.ivanov@cambridgegreys.com wrote:
> 
> From: Anton Ivanov anton.ivanov@cambridgegreys.com
> 
> 
> __cant_sleep was already used and exported by the scheduler.
> The name had to be changed to a UML specific one.
> 
> Signed-off-by: Anton Ivanov anton.ivanov@cambridgegreys.com
> 
> ---
> arch/um/include/shared/kern_util.h | 2 +-
> arch/um/kernel/process.c | 2 +-
> arch/um/os-Linux/helper.c | 6 +++---
> 3 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/um/include/shared/kern_util.h b/arch/um/include/shared/kern_util.h
> index d8b8b4f07e42..444bae755b16 100644
> --- a/arch/um/include/shared/kern_util.h
> +++ b/arch/um/include/shared/kern_util.h
> @@ -50,7 +50,7 @@ extern void do_uml_exitcalls(void);
> * Are we disallowed to sleep? Used to choose between GFP_KERNEL and
> * GFP_ATOMIC.
> */
> -extern int __cant_sleep(void);
> +extern int __uml_cant_sleep(void);
> extern int get_current_pid(void);
> extern int copy_from_user_proc(void *to, void *from, int size);
> extern char *uml_strdup(const char string);
> diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
> index 106b7da2f8d6..6daffb9d8a8d 100644
> --- a/arch/um/kernel/process.c
> +++ b/arch/um/kernel/process.c
> @@ -220,7 +220,7 @@ void arch_cpu_idle(void)
> um_idle_sleep();
> }
> 
> -int __cant_sleep(void) {
> +int __uml_cant_sleep(void) {
> return in_atomic() || irqs_disabled() || in_interrupt();
> / Is in_interrupt() really needed? */
> }
> diff --git a/arch/um/os-Linux/helper.c b/arch/um/os-Linux/helper.c
> index b459745f52e2..3cb8ac63be6e 100644
> --- a/arch/um/os-Linux/helper.c
> +++ b/arch/um/os-Linux/helper.c
> @@ -46,7 +46,7 @@ int run_helper(void (*pre_exec)(void *), void *pre_data, char **argv)
> unsigned long stack, sp;
> int pid, fds[2], ret, n;
> 
> - stack = alloc_stack(0, __cant_sleep());
> + stack = alloc_stack(0, __uml_cant_sleep());
> if (stack == 0)
> return -ENOMEM;
> 
> @@ -70,7 +70,7 @@ int run_helper(void (*pre_exec)(void *), void *pre_data, char **argv)
> data.pre_data = pre_data;
> data.argv = argv;
> data.fd = fds[1];
> - data.buf = __cant_sleep() ? uml_kmalloc(PATH_MAX, UM_GFP_ATOMIC) :
> + data.buf = __uml_cant_sleep() ? uml_kmalloc(PATH_MAX, UM_GFP_ATOMIC) :
> uml_kmalloc(PATH_MAX, UM_GFP_KERNEL);
> pid = clone(helper_child, (void *) sp, CLONE_VM, &data);
> if (pid < 0) {
> @@ -121,7 +121,7 @@ int run_helper_thread(int (*proc)(void *), void *arg, unsigned int flags,
> unsigned long stack, sp;
> int pid, status, err;
> 
> - stack = alloc_stack(0, __cant_sleep());
> + stack = alloc_stack(0, __uml_cant_sleep());
> if (stack == 0)
> return -ENOMEM;
> 
> --
> 2.30.2

LGTM. Now we get to deal with the errors coming from config.debug

Reviewed-by: Peter Lafreniere <peter@n8pjl.ca>

Cheers, 


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
