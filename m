Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A6CDE7716D
	for <linux-um@archiver.kernel.org>; Wed,  4 Dec 2024 16:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=u6gMjMWojFrt11/93iWZ6ZtQfUSbrnGhOkz6MvQ6wuY=; b=ZG4OzL6os5t8AkeHGHRZMzhb/z
	nBxpPHvfAg3es7iZx5sL+Y/VK4GS6Ib9N4W2+C5GhrZ4CMKQsnQGAn/1573Qmrm2jsHhXwo1VbgRJ
	AToPtAgW05/dnc1HYSKE+c+zIuYKziaV7j7JkIU6huvz7lf4sB1dyb5mC0rqq4oy47FWjszj/v4/W
	T5q3zijwn3QW4hV8woT6FLs9dvMOfeqd2cWxF731bPE2wUc6ivONbfTkY9XQLZsKid1ZUzsf/hD9q
	nDvnm6U6I2kXvDtZfXXyJud04JJQcewKeRX/PqSb094Ij4HxzlaM2NbD9c8VsE7DULyGQmDzVWXxO
	ehY60Dsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tIsZo-0000000DEzj-03ep;
	Wed, 04 Dec 2024 16:50:12 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tIsZl-0000000DEz1-4Adv
	for linux-um@lists.infradead.org;
	Wed, 04 Dec 2024 16:50:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=u6gMjMWojFrt11/93iWZ6ZtQfUSbrnGhOkz6MvQ6wuY=;
	t=1733331009; x=1734540609; b=tur/appITLEpWSVApLVHRNNsrdXGo2n8oQv3Zj0UlkKStB2
	xeaPBckMv2BfbgYjnlPczQhuTFP8CRF60K1jFGMwLn+tZBkmXe91T8q5p0m+TaVEasadt7EWBW1oV
	HYFU9nmVNz1S3aH9Nzc+YM1k9pxTGo6lSis3yHojG9DjtCBUdHqV8ykuZ/QLXCl6WG8w+Zp79PUgs
	XFzaSybLjrs5Eli+CmnbNv9q4N1/aGReINp/zNqcRBixxOr6K9VkRRITLmq47SGfkCgPO4lpv1efz
	t6RD+6tK8hJd3I49N6zxYjbjOR5DjpXwosFNVYkvRn87MZyodtOYcoPdUlf7NABw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tIsZk-000000079Fo-07wd;
	Wed, 04 Dec 2024 17:50:08 +0100
Message-ID: <2085ffbd1d5b0a908f26d0ec38a6d8719db5111c.camel@sipsolutions.net>
Subject: Re: [PATCH v3 07/13] x86/um: nommu: process/thread handling
From: Johannes Berg <johannes@sipsolutions.net>
To: Hajime Tazaki <thehajime@gmail.com>, linux-um@lists.infradead.org
Cc: ricarkol@google.com, Liam.Howlett@oracle.com
Date: Wed, 04 Dec 2024 17:50:07 +0100
In-Reply-To: <7e909114324f92d37dbe0a2f58443cf5ba606c6d.1733199769.git.thehajime@gmail.com>
References: <cover.1733199769.git.thehajime@gmail.com>
	 <7e909114324f92d37dbe0a2f58443cf5ba606c6d.1733199769.git.thehajime@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241204_085010_032134_85AD9EC7 
X-CRM114-Status: GOOD (  22.50  )
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

On Tue, 2024-12-03 at 13:23 +0900, Hajime Tazaki wrote:
>=20
> +++ b/arch/um/kernel/process.c
> @@ -117,13 +117,17 @@ void new_thread_handler(void)
>  	 * callback returns only if the kernel thread execs a process
>  	 */
>  	fn(arg);
> +#ifndef CONFIG_MMU
> +	arch_switch_to(current);
> +#endif
>  	userspace(&current->thread.regs.regs);

that doesn't make sense, arch_switch_to() does nothing anyway on 64-bit

>  /* Called magically, see new_thread_handler above */
>  static void fork_handler(void)
>  {
> -	schedule_tail(current->thread.prev_sched);
> +	if (current->thread.prev_sched)
> +		schedule_tail(current->thread.prev_sched);

Why is that NULL on nommu?

> @@ -134,6 +138,33 @@ static void fork_handler(void)
> =20
>  	current->thread.prev_sched =3D NULL;
> =20
> +#ifndef CONFIG_MMU

again, don't sprinkle ifdefs around the C code files - make inlines in a
header file or something

> +	/*
> +	 * child of vfork(2) comes here.
> +	 * clone(2) also enters here but doesn't need to advance the %rsp.
> +	 *
> +	 * This fork can only come from libc's vfork, which
> +	 * does this:
> +	 *	popq %%rdx;
> +	 *	call *%rax; // zpoline =3D> __kernel_vsyscall
> +	 *	pushq %%rdx;

or maybe not zpoline ... so maybe need to update this

> +++ b/arch/um/os-Linux/skas/process.c
> @@ -144,6 +144,7 @@ void wait_stub_done(int pid)
> =20
>  extern unsigned long current_stub_stack(void);
> =20
> +#ifdef CONFIG_MMU

I'll stop commenting on ifdef sprinkling :)

> +++ b/arch/x86/um/asm/processor.h
> @@ -38,6 +38,18 @@ static __always_inline void cpu_relax(void)
> =20
>  #define task_pt_regs(t) (&(t)->thread.regs)
> =20
> +#ifndef CONFIG_MMU
> +#define task_top_of_stack(task) \
> +({									\
> +	unsigned long __ptr =3D (unsigned long)task->stack;	\
> +	__ptr +=3D THREAD_SIZE;			\
> +	__ptr;					\
> +})
> +
> +extern long current_top_of_stack;
> +extern long current_ptregs;
> +#endif

no need for "extern".

you only use all that once, does it need to be here?

> +
>  #include <asm/processor-generic.h>
> =20
>  #endif
> diff --git a/arch/x86/um/do_syscall_64.c b/arch/x86/um/do_syscall_64.c
> index 5d0fa83e7fdc..ca468caff729 100644
> --- a/arch/x86/um/do_syscall_64.c
> +++ b/arch/x86/um/do_syscall_64.c
> @@ -1,14 +1,43 @@
>  // SPDX-License-Identifier: GPL-2.0
> =20
> +//#define DEBUG 1

please remove

>  #include <linux/kernel.h>
>  #include <linux/ptrace.h>
>  #include <kern_util.h>
>  #include <sysdep/syscalls.h>
>  #include <os.h>
> =20
> +/*
> + * save/restore the return address stored in the stack, as the child ove=
rwrites
> + * the contents after returning to userspace (i.e., by push %rdx).
> + *
> + * see the detail in fork_handler().
> + */
> +static void *vfork_save_stack(void)
> +{
> +	unsigned char *stack_copy;
> +
> +	stack_copy =3D kzalloc(8, GFP_KERNEL);

Using a heap allocation to track 8 bytes, when the pointer to the
allocation is already 8 bytes (you're on 64-bit) seems ... rather
wasteful?

I also don't see you ever free it? Restore probably should, but anyway,
it shouldn't exist.

johannes

