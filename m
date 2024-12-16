Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 717E0E7717F
	for <linux-um@archiver.kernel.org>; Mon, 16 Dec 2024 20:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3EfsgiLuEZpT8xsRppiqSwVXpZ7RDZSu4foO30f3Bu4=; b=xRssdpD4rE71WaOnVPAoLiJuwT
	bU06rMMpTP6tOITRj66NHzrehXzS0V+JjGZ5Exx/jy7G8am9aJPgYHT3nPu1HV0w1qrGDH+yooL0x
	momecdSgdFwJEkY4H2buylEi39Jx/OUdtLeQIFKRJSWefXhi3Fg5i4hY8PKXPOigPnOl8JOkX1VW4
	fLawBYUhVDOoQ/lAE+I4/skh+R7pn4q5D4IsB2yHjQy/yOdkNwokXjeZdbhcJyTc8gAJb1Qk4lsUq
	8dBMxDGHb76+UUseE+4tIGbQDgiwcKOvlJpLwjWAPwotOFYD5+16znLq6s+KYq51GD8tiid4iNs8/
	oHr2ms7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tNHMC-0000000BCvE-3MSK;
	Mon, 16 Dec 2024 20:06:20 +0000
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tNHM9-0000000BCuj-47Tj
	for linux-um@lists.infradead.org;
	Mon, 16 Dec 2024 20:06:19 +0000
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-7fd51285746so2540856a12.3
        for <linux-um@lists.infradead.org>; Mon, 16 Dec 2024 12:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734379576; x=1734984376; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3EfsgiLuEZpT8xsRppiqSwVXpZ7RDZSu4foO30f3Bu4=;
        b=T6ubtoJqXZa3H0eHM9BnuO1e8inCtqK3S+0zD+o698yRu11YM0NrEV5HCpq36h+haH
         5Z4xt3NekGtpiu07Vkvq82TRQxrpXwPAYNpOoAFdzPmPTIPl+HfTygrtDxSShmaNMmys
         DKIe6dW/3aHOj41JgJyMPojUBGY1kohhIqrUo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734379576; x=1734984376;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3EfsgiLuEZpT8xsRppiqSwVXpZ7RDZSu4foO30f3Bu4=;
        b=DNMJpSUtSE38+W0g0C80GM+V0c9Hm9+i4R3K2+7VXlDejgRWWFlupJ/4A2NuY9IbAV
         HfQM7cbhhdo8aLJThjZ/z9T5O+jHqm32Vh1aLGXLbb9FuLogIJ2o53ys5n8NfRScLAJA
         7NIRruVe1TbfQAGFM1rqOUJizNlt3wytmC8nU5tmJ/R4nIduSFi2NCpEbYKkDSHbl+rj
         3TUltlYgPbP6Spes8//oJE7qc8D6n1+xXp1Hu1zNqBpG+7Avysa8Q3zLEspsRBofY2FR
         erRc8xWg8DERnBRtrk86V+wcEOE3a7/01SM515zaN3zSYPfZU8Q/lApEbliF6aDZW7HI
         texw==
X-Gm-Message-State: AOJu0YzTJ8EouajHUF430lvuwzV5H0uFtCXnClV5WRF3FHPpK/lDGOct
	v9dt+P4TEK4hbApj0KsXsfpSH5g7neJsbG/Aeg85Ti7iB/nschVkL2AWjboScQ==
X-Gm-Gg: ASbGncv9Y8OPgyJI6S5EnVBuc//NlsO/4Q5gbJvpWE2ytGddJ7xw+eDyWo0JHkbuWmr
	0Im1/TvLAHCuqqjFTnNl/8KJE+I+zDwuPjFfrUkgkpCSwky069Qhi9NzH1o+FvG95XCs8Z/p7tz
	Uon3RMj+FHw3h/88CKe1toPZrBjpvXf2ljEVVcGlhO6smtmPzy0auA9P0ANr7ckvwPme7nQdd9Q
	Lx3ySqpJUVNeoMfKpyGGrJCzHo/FvgzwJNjKCiCCMXxgF3pJ974+H+cPUJjuGb0CPrJgwEbBu60
	i3mO0lPUgWNNEltkOA==
X-Google-Smtp-Source: AGHT+IEQhIpmwdpRiNybl+qbALbuMIKFDwgfNyivINB2kRI7uemeh84BFmgUmgIXGB1ZH7mkLzLtyA==
X-Received: by 2002:a17:90b:4e85:b0:2f1:2fa5:1924 with SMTP id 98e67ed59e1d1-2f28ffa4e4cmr17934259a91.26.1734379576253;
        Mon, 16 Dec 2024 12:06:16 -0800 (PST)
Received: from localhost ([2a00:79e0:2e14:7:953:5b91:a52c:e817])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-218a1dcc463sm46738955ad.79.2024.12.16.12.06.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2024 12:06:15 -0800 (PST)
Date: Mon, 16 Dec 2024 12:06:14 -0800
From: Brian Norris <briannorris@chromium.org>
To: Benjamin Berg <benjamin@sipsolutions.net>
Cc: linux-um@lists.infradead.org, johannes@sipsolutions.net,
	kasan-dev@googlegroups.com
Subject: Re: [PATCH v5] um: switch to regset API and depend on XSTATE
Message-ID: <Z2CINocd5Pqkzykw@google.com>
References: <20241023094120.4083426-1-benjamin@sipsolutions.net>
 <Z1ySXmjZm-xOqk90@google.com>
 <689539526e48a2648134bb8de463c3bf68724993.camel@sipsolutions.net>
 <c9bc87ceb666a9ab04a8c10a543ecfb6aa002aa2.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c9bc87ceb666a9ab04a8c10a543ecfb6aa002aa2.camel@sipsolutions.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241216_120618_056429_408F4692 
X-CRM114-Status: GOOD (  58.22  )
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

(+ kasan-dev; leaving most of this thread intact)

On Sat, Dec 14, 2024 at 01:25:59PM +0100, Benjamin Berg wrote:
> Hi,
> 
> On Sat, 2024-12-14 at 00:08 +0100, Benjamin Berg wrote:
> > outch. It is doing a memcpy of init_task. Now, struct task_struct is
> > variably sized, but init_struct is statically allocated, which could
> > explain why the memcpy is not permitted to read the larger memory (for
> > the FP register space).
> > I can reproduce it with the kunit.py script, but didn't run into it
> > with my own configuration.
> > 
> > Now, this patch works around the problem:
> > 
> > diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
> > index 30bdc0a87dc8..7748df822d30 100644
> > --- a/arch/um/kernel/process.c
> > +++ b/arch/um/kernel/process.c
> > @@ -191,7 +191,10 @@ void initial_thread_cb(void (*proc)(void *), void
> > *arg)
> >  int arch_dup_task_struct(struct task_struct *dst,
> >                          struct task_struct *src)
> >  {
> > -       memcpy(dst, src, arch_task_struct_size);
> > +       if (src == &init_task)
> > +               memcpy(dst, src, sizeof(init_task));
> > +       else
> > +               memcpy(dst, src, arch_task_struct_size);
> >         return 0;
> >  }
> >  

FWIW, after fixing up the mangled whitespace, this works for me:

Tested-by: Brian Norris <briannorris@chromium.org>

> > 
> > However, that cannot really be correct. I believe what should be
> > happening is that init_task is loaded into init_stack (see
> > INIT_TASK_DATA in vmlinux.lds.h). I am assuming that if this was the
> > case, then KASAN would be happy with it. However, I see the following
> > addresses
> >   __start_init_stack: 0x606dc000
> >   __end_init_stack: 0x606e0000
> >   init_task: 0x606e2ec0
> > and I am not sure why the linker script is not placing init_task into
> > the stack here.
> > 
> > Also note that commit 2f681ba4b352 ("um: move thread info into task")
> > may be part of a correct fix here.
> 
> So, I dug a bit more, and found
> 
> commit 0eb5085c38749f2a91e5bd8cbebb1ebf3398343c
> Author: Heiko Carstens <hca@linux.ibm.com>
> Date:   Thu Nov 16 14:36:38 2023 +0100
> 
>     arch: remove ARCH_TASK_STRUCT_ON_STACK
> 
> This explains why init_task is not on init_stack. It also means that
> the related linker script entries that I saw can be removed.
> 
> So, maybe the above patch is actually acceptable. We never need the FPU
> register state for init_task, so we do not really need it to be
> allocated either. The only place where it causes issues is in
> arch_dup_task_struct.
> In that case, x86 would require the same fix.
> 
> 
> My best guess right now is that whether the error occurs depends on the
> on the size/alignment of init_task. If we happen to have enough padding
> afterwards then we do not run into the red zone of the next
> (unexported) global variable (init_sighand for me). But, if the padding
> is too small, then KASAN detects the error and aborts.
> 
> 
> Does someone maybe know a KASAN/x86 expert that we could talk to?

Not exactly, but I've CC'd their development list.

Brian

> Benjamin
> 
> > On Fri, 2024-12-13 at 12:00 -0800, Brian Norris wrote:
> > > Hi Benjamin,
> > > 
> > > On Wed, Oct 23, 2024 at 11:41:20AM +0200, Benjamin Berg wrote:
> > > > From: Benjamin Berg <benjamin.berg@intel.com>
> > > > 
> > > > The PTRACE_GETREGSET API has now existed since Linux 2.6.33. The
> > > > XSAVE
> > > > CPU feature should also be sufficiently common to be able to rely
> > > > on it.
> > > > 
> > > > With this, define our internal FP state to be the hosts XSAVE
> > > > data.
> > > > Add
> > > > discovery for the hosts XSAVE size and place the FP registers at
> > > > the end
> > > > of task_struct so that we can adjust the size at runtime.
> > > > 
> > > > Next we can implement the regset API on top and update the signal
> > > > handling as well as ptrace APIs to use them. Also switch coredump
> > > > creation to use the regset API and finally set
> > > > HAVE_ARCH_TRACEHOOK.
> > > > 
> > > > This considerably improves the signal frames. Previously they
> > > > might
> > > > not
> > > > have contained all the registers (i386) and also did not have the
> > > > sizes and magic values set to the correct values to permit
> > > > userspace to
> > > > decode the frame.
> > > > 
> > > > As a side effect, this will permit UML to run on hosts with newer
> > > > CPU
> > > > extensions (such as AMX) that need even more register state.
> > > > 
> > > > Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
> > > 
> > > This patch seems to trip up KASAN. Or at least, KUnit tests fail
> > > when
> > > I
> > > enable CONFIG_KASAN, and 'git bisect' points me here:
> > > 
> > > $ git bisect run ./tools/testing/kunit/kunit.py run
> > > stackinit.test_user --kconfig_add CONFIG_KASAN=y
> > > [...]
> > > 3f17fed2149192c7d3b76a45a6a87b4ff22cd586 is the first bad commit
> > > commit 3f17fed2149192c7d3b76a45a6a87b4ff22cd586
> > > Author: Benjamin Berg <benjamin.berg@intel.com>
> > > Date:   Wed Oct 23 11:41:20 2024 +0200
> > > 
> > >     um: switch to regset API and depend on XSTATE
> > > [...]
> > > 
> > > If I run at Linus's latest:
> > > 
> > >   243f750a2df0 Merge tag 'gpio-fixes-for-v6.13-rc3' of
> > > git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux
> > > 
> > > I get a KASAN warning and panic [1]. I tried this fix for fun, but
> > > it
> > > doesn't help:
> > > Subject: [PATCH] um: add back support for FXSAVE registers
> > > https://lore.kernel.org/linux-um/20241204074827.1582917-1-benjamin@sipsolutions.net/
> > > 
> > > I'm not very familiar with this area, but let me know if there's
> > > more
> > > I
> > > can help with on tracking the issue down. Hopefully, it's as easy
> > > as
> > > running these same commands for you to reproduce.
> > > 
> > > Brian
> > > 
> > > [1]
> > > $ ./tools/testing/kunit/kunit.py run stackinit.test_user --
> > > kconfig_add CONFIG_KASAN=y --raw_output=all
> > > [...]
> > > <3>================================================================
> > > ==
> > > <3>BUG: KASAN: global-out-of-bounds in
> > > arch_dup_task_struct+0x4b/0x70
> > > <3>Read of size 4616 at addr 0000000060b1aec0 by task swapper/0
> > > <3>
> > > <3>CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 6.13.0-rc2-00194-
> > > g6787126c27ef #61
> > > <3>Stack:
> > > <4> 00000000 00000000 ffffff00 60acc428
> > > <4> 60ad2ffc 9f225db0 00000001 6008b7fb
> > > <4> 60b17aa0 6003fbf5 60b1aec0 6004c654
> > > <3>Call Trace:
> > > <3> [<60038c0e>] ? show_stack.cold+0x64/0xf3
> > > <3> [<6008b7fb>] ? dump_stack_lvl+0x8b/0xa7
> > > <3> [<6003fbf5>] ? _printk+0x0/0x103
> > > <3> [<6004c654>] ? print_report+0x145/0x519
> > > <3> [<60090f2b>] ? arch_dup_task_struct+0x4b/0x70
> > > <3> [<6031f854>] ? kasan_report+0x114/0x160
> > > <3> [<60090f2b>] ? arch_dup_task_struct+0x4b/0x70
> > > <3> [<60320830>] ? kasan_check_range+0x0/0x1e0
> > > <3> [<603209a0>] ? kasan_check_range+0x170/0x1e0
> > > <3> [<6032135d>] ? __asan_memcpy+0x2d/0x80
> > > <3> [<60090f2b>] ? arch_dup_task_struct+0x4b/0x70
> > > <3> [<600b9381>] ? copy_process+0x3e1/0x7390
> > > <3> [<600af1a0>] ? block_signals+0x0/0x20
> > > <3> [<603bb46e>] ? vfs_kern_mount.part.0+0x6e/0x140
> > > <3> [<601b48d6>] ? stack_trace_save+0x86/0xa0
> > > <3> [<6063ef2c>] ? stack_depot_save_flags+0x2c/0xa80
> > > <3> [<601b4850>] ? stack_trace_save+0x0/0xa0
> > > <3> [<6031e919>] ? kasan_save_stack+0x49/0x60
> > > <3> [<603bb46e>] ? vfs_kern_mount.part.0+0x6e/0x140
> > > <3> [<6031e919>] ? kasan_save_stack+0x49/0x60
> > > <3> [<600b8fa0>] ? copy_process+0x0/0x7390
> > > <3> [<600c04b3>] ? kernel_clone+0xd3/0x8c0
> > > <3> [<600c03e0>] ? kernel_clone+0x0/0x8c0
> > > <3> [<60038743>] ? arch_irqs_disabled_flags+0x0/0x9
> > > <3> [<60038700>] ? arch_local_save_flags+0x0/0x43
> > > <3> [<600c107d>] ? user_mode_thread+0x9d/0xc0
> > > <3> [<600c0fe0>] ? user_mode_thread+0x0/0xc0
> > > <3> [<60926934>] ? kernel_init+0x0/0x18c
> > > <3> [<6003875e>] ? arch_local_irq_disable+0x0/0xc
> > > <3> [<60038743>] ? arch_irqs_disabled_flags+0x0/0x9
> > > <3> [<60038700>] ? arch_local_save_flags+0x0/0x43
> > > <3> [<603bb69d>] ? kern_mount+0x3d/0xb0
> > > <3> [<6003875e>] ? arch_local_irq_disable+0x0/0xc
> > > <3> [<60926831>] ? rest_init+0x2d/0x130
> > > <3> [<6003875e>] ? arch_local_irq_disable+0x0/0xc
> > > <3> [<60038743>] ? arch_irqs_disabled_flags+0x0/0x9
> > > <3> [<60038700>] ? arch_local_save_flags+0x0/0x43
> > > <3> [<60002679>] ? do_one_initcall+0x0/0x450
> > > <3> [<60005c97>] ? start_kernel_proc+0x0/0x1d
> > > <3> [<60005cb0>] ? start_kernel_proc+0x19/0x1d
> > > <3> [<600904fa>] ? new_thread_handler+0xca/0x130
> > > <3>
> > > <3>The buggy address belongs to the variable:
> > > <3> 0x60b1aec0
> > > <3>
> > > <3>The buggy address belongs to the physical page:
> > > <4>page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0
> > > pfn:0xb1a
> > > <4>flags: 0x2000(reserved|zone=0)
> > > <4>raw: 0000000000002000 000000009f225db8 000000009f225db8
> > > 0000000000000000
> > > <4>raw: 0000000000000000 0000000000000000 00000001ffffffff
> > > <4>page dumped because: kasan: bad access detected
> > > <3>
> > > <3>Memory state around the buggy address:
> > > <3> 0000000060b1b600: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > 00
> > > <3> 0000000060b1b680: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > 00
> > > <3>>0000000060b1b700: 00 00 00 00 00 00 00 00 f9 f9 f9 f9 00 00 00
> > > 00
> > > <3>                                           ^
> > > <3> 0000000060b1b780: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > 00
> > > <3> 0000000060b1b800: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > 00
> > > <3>================================================================
> > > ==
> > > <4>Disabling lock debugging due to kernel taint
> > > <4>
> > > <6>Pid: 0, comm: swapper Tainted: G    B              6.13.0-rc2-
> > > 00194-g6787126c27ef
> > > <6>RIP: 0033:copy_namespaces+0x104/0x2b0
> > > <6>RSP: 0000000060b17b70  EFLAGS: 00010246
> > > <6>RAX: 0000000000000001 RBX: 00000000610a8000 RCX:
> > > 0000000060133d7f
> > > <6>RDX: 0000000000000001 RSI: 0000000000000004 RDI:
> > > 0000000000000000
> > > <6>RBP: 0000000000000000 R08: 0000000000000001 R09:
> > > 0000100000000000
> > > <6>R10: 0000000000000003 R11: ffffffffffffffff R12:
> > > 0000000000800300
> > > <6>R13: 000000006102a000 R14: 00000000610a84d8 R15:
> > > 0000000060b31ba0
> > > <0>Kernel panic - not syncing: Segfault with no mm
> > > <4>CPU: 0 UID: 0 PID: 0 Comm: swapper Tainted: G    B             
> > > 6.13.0-rc2-00194-g6787126c27ef #61
> > > <4>Tainted: [B]=BAD_PAGE
> > > <4>Stack:
> > > <4> 00000000 60321286 61070380 0c162f92
> > > <4> 00000000 60b1aec0 61070110 610a8000
> > > <4> 610a8498 600bae85 61001400 60b17ed0
> > > <4>Call Trace:
> > > <4> [<60321286>] ? __asan_memset+0x26/0x50
> > > <4> [<600bae85>] ? copy_process+0x1ee5/0x7390
> > > <4> [<600af1a0>] ? block_signals+0x0/0x20
> > > <4> [<6063ef2c>] ? stack_depot_save_flags+0x2c/0xa80
> > > <4> [<601b4850>] ? stack_trace_save+0x0/0xa0
> > > <4> [<6031e919>] ? kasan_save_stack+0x49/0x60
> > > <4> [<603bb46e>] ? vfs_kern_mount.part.0+0x6e/0x140
> > > <4> [<6031e919>] ? kasan_save_stack+0x49/0x60
> > > <4> [<600b8fa0>] ? copy_process+0x0/0x7390
> > > <4> [<600c04b3>] ? kernel_clone+0xd3/0x8c0
> > > <4> [<600c03e0>] ? kernel_clone+0x0/0x8c0
> > > <4> [<60038743>] ? arch_irqs_disabled_flags+0x0/0x9
> > > <4> [<60038700>] ? arch_local_save_flags+0x0/0x43
> > > <4> [<600c107d>] ? user_mode_thread+0x9d/0xc0
> > > <4> [<600c0fe0>] ? user_mode_thread+0x0/0xc0
> > > <4> [<60926934>] ? kernel_init+0x0/0x18c
> > > <4> [<6003875e>] ? arch_local_irq_disable+0x0/0xc
> > > <4> [<60038743>] ? arch_irqs_disabled_flags+0x0/0x9
> > > <4> [<60038700>] ? arch_local_save_flags+0x0/0x43
> > > <4> [<603bb69d>] ? kern_mount+0x3d/0xb0
> > > <4> [<6003875e>] ? arch_local_irq_disable+0x0/0xc
> > > <4> [<60926831>] ? rest_init+0x2d/0x130
> > > <4> [<6003875e>] ? arch_local_irq_disable+0x0/0xc
> > > <4> [<60038743>] ? arch_irqs_disabled_flags+0x0/0x9
> > > <4> [<60038700>] ? arch_local_save_flags+0x0/0x43
> > > <4> [<60002679>] ? do_one_initcall+0x0/0x450
> > > <4> [<60005c97>] ? start_kernel_proc+0x0/0x1d
> > > <4> [<60005cb0>] ? start_kernel_proc+0x19/0x1d
> > > <4> [<600904fa>] ? new_thread_handler+0xca/0x130
> > > [11:56:56] Elapsed time: 6.794s total, 0.001s configuring, 5.513s
> > > building, 1.280s running
> > > 
> > > 
> > 
> > 
> > 
> 

