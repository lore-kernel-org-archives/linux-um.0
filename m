Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BB7CE7717F
	for <linux-um@archiver.kernel.org>; Fri, 13 Dec 2024 20:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TQAcudM6PTcMchJoo8dqSDLe/+ZVCjTpWCb48NQferE=; b=vpXcH3EfYI5pi1ci0XrSdxsD13
	/9jtPkqQcNq6zR+anv0y15xwAP5BCAiMHHi6eNgQ9IbkCyS3xI/xc1xKaMYZVckCnrir3Ucgnn6s+
	0cMjkFrBpPIhp+y5ddKfj4xjLaoO5L1gCtcu3wpEwNvVBT9AA9n4BXf7UXLS6vkopDNU9VRJEFU2W
	Dh3Cb6B5REw4fs9BgSq1H3Tf9YZ+2f9dvR1Kyd8Yjc9K8J90iHn+5HRznJdS+XX3U5i+PVmH7LOWk
	5VC0sFSS/mXt3EzF4kKWaGNeiIyMxokmhY7sZflRJGnjTLA3JheKsVzAq9V7W/BaS4wo30ezOP93F
	lRzw23Ng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tMBq1-00000004uJ6-18vz;
	Fri, 13 Dec 2024 20:00:37 +0000
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tMBpx-00000004uGw-3Elj
	for linux-um@lists.infradead.org;
	Fri, 13 Dec 2024 20:00:36 +0000
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-216401de828so18959605ad.3
        for <linux-um@lists.infradead.org>; Fri, 13 Dec 2024 12:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734120032; x=1734724832; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TQAcudM6PTcMchJoo8dqSDLe/+ZVCjTpWCb48NQferE=;
        b=TGV+/FilSBnFiTbiqPDBZglBxvAXx519YinJSXXds9ST1xZjDyWlRaaBRl7TzhPJuS
         +FCY7pxDnBy2ego9fVYocZSK9nJdUnWZ6M0LFQ0Km2hLq+ev6W5a46tz7DVRQOqFp1vY
         ZAw7VQxR2kcA56e7Q+ccdhbOxDVIEorzvjCk8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734120032; x=1734724832;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TQAcudM6PTcMchJoo8dqSDLe/+ZVCjTpWCb48NQferE=;
        b=K5HXenvHRMtt/q8FzAT/6aIAASXKrKTvTO4OcZlfp/qbzcxsMXAqgJ04ivA5pk5CJg
         TIxxEGZZmib7gfaQeaE8MM1WCSyCaA+E3uU4TBSAnYbMc/EZXNp1TZgalMKBYCL+RiZR
         sFFsmQ47ovlU6zo/+qVpPXC1la/KNsuVBUNyYYS4sssSZeMPa1pPWDUeW/8SXjrgvIsz
         wVVyy/5LZp7cQD3sBlZgD3uJOZDSMn0sQLSJ1xx5XRbka/1+vWVpPhQSVyhN531++uWl
         SDcSiFi+kfLxiv9sP+5Nr2IVZfM0jQfWhjR19PoQxKgeypJ1IwuZ1A2x2Pg3ZMG+dcjy
         UHhg==
X-Gm-Message-State: AOJu0YwRgcw1JPL0Yc0h0t0CPko62C9D7//J8OjBN9zzGPypXqE4bCBL
	iN4iWoOgKcvK7ZxsTKPSkLzRLfcee3qh14OoXf5NERHmcefeI1xdPLU/tXrE1A==
X-Gm-Gg: ASbGnctayKcSrXHN9YtBynqM58R3XMaiv9ckTECHy8FC4cJ9OBEDdxzBluOaHKV0FqC
	4iUOOjsZVIPCslsiveBKo3HlyNr2IgUoCRrr1RRnO6vPv4f792suOTwQfe2mL2u+D4W//n4jsrt
	Mtxz/uGENnmopD0AwwwWKtfBx3yA7yGhYoW+P/0HnH5njc7V/WlLPQng721jyUJkYDHnKUpsIAB
	PvKmtN6zJuNVyHAlbrQA0otwFxwSVvFr69XeU5Kst0NGgCY4fXF5PrLX6cgNse2qHr/5FBUWjed
	F/ditY8jgQLjZXBdbQ==
X-Google-Smtp-Source: AGHT+IHKBplxwvlcRRLpZHB3wnt37XK7d1UQJw6n3hDmpqMv1Mcivt6PYdTDHjybzpR992+IHhzVgw==
X-Received: by 2002:a17:902:e752:b0:216:4943:e575 with SMTP id d9443c01a7336-21892a7bd0emr42717285ad.57.1734120032254;
        Fri, 13 Dec 2024 12:00:32 -0800 (PST)
Received: from localhost ([2a00:79e0:2e14:7:356a:489a:83c:f7d9])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-218a1e62bf2sm1391365ad.213.2024.12.13.12.00.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2024 12:00:31 -0800 (PST)
Date: Fri, 13 Dec 2024 12:00:30 -0800
From: Brian Norris <briannorris@chromium.org>
To: Benjamin Berg <benjamin@sipsolutions.net>
Cc: linux-um@lists.infradead.org, johannes@sipsolutions.net,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: Re: [PATCH v5] um: switch to regset API and depend on XSTATE
Message-ID: <Z1ySXmjZm-xOqk90@google.com>
References: <20241023094120.4083426-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023094120.4083426-1-benjamin@sipsolutions.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241213_120033_853553_66188733 
X-CRM114-Status: GOOD (  21.07  )
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

Hi Benjamin,

On Wed, Oct 23, 2024 at 11:41:20AM +0200, Benjamin Berg wrote:
> From: Benjamin Berg <benjamin.berg@intel.com>
> 
> The PTRACE_GETREGSET API has now existed since Linux 2.6.33. The XSAVE
> CPU feature should also be sufficiently common to be able to rely on it.
> 
> With this, define our internal FP state to be the hosts XSAVE data. Add
> discovery for the hosts XSAVE size and place the FP registers at the end
> of task_struct so that we can adjust the size at runtime.
> 
> Next we can implement the regset API on top and update the signal
> handling as well as ptrace APIs to use them. Also switch coredump
> creation to use the regset API and finally set HAVE_ARCH_TRACEHOOK.
> 
> This considerably improves the signal frames. Previously they might not
> have contained all the registers (i386) and also did not have the
> sizes and magic values set to the correct values to permit userspace to
> decode the frame.
> 
> As a side effect, this will permit UML to run on hosts with newer CPU
> extensions (such as AMX) that need even more register state.
> 
> Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>

This patch seems to trip up KASAN. Or at least, KUnit tests fail when I
enable CONFIG_KASAN, and 'git bisect' points me here:

$ git bisect run ./tools/testing/kunit/kunit.py run stackinit.test_user --kconfig_add CONFIG_KASAN=y
[...]
3f17fed2149192c7d3b76a45a6a87b4ff22cd586 is the first bad commit
commit 3f17fed2149192c7d3b76a45a6a87b4ff22cd586
Author: Benjamin Berg <benjamin.berg@intel.com>
Date:   Wed Oct 23 11:41:20 2024 +0200

    um: switch to regset API and depend on XSTATE
[...]

If I run at Linus's latest:

  243f750a2df0 Merge tag 'gpio-fixes-for-v6.13-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux

I get a KASAN warning and panic [1]. I tried this fix for fun, but it
doesn't help:
Subject: [PATCH] um: add back support for FXSAVE registers
https://lore.kernel.org/linux-um/20241204074827.1582917-1-benjamin@sipsolutions.net/

I'm not very familiar with this area, but let me know if there's more I
can help with on tracking the issue down. Hopefully, it's as easy as
running these same commands for you to reproduce.

Brian

[1]
$ ./tools/testing/kunit/kunit.py run stackinit.test_user --kconfig_add CONFIG_KASAN=y --raw_output=all
[...]
<3>==================================================================
<3>BUG: KASAN: global-out-of-bounds in arch_dup_task_struct+0x4b/0x70
<3>Read of size 4616 at addr 0000000060b1aec0 by task swapper/0
<3>
<3>CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 6.13.0-rc2-00194-g6787126c27ef #61
<3>Stack:
<4> 00000000 00000000 ffffff00 60acc428
<4> 60ad2ffc 9f225db0 00000001 6008b7fb
<4> 60b17aa0 6003fbf5 60b1aec0 6004c654
<3>Call Trace:
<3> [<60038c0e>] ? show_stack.cold+0x64/0xf3
<3> [<6008b7fb>] ? dump_stack_lvl+0x8b/0xa7
<3> [<6003fbf5>] ? _printk+0x0/0x103
<3> [<6004c654>] ? print_report+0x145/0x519
<3> [<60090f2b>] ? arch_dup_task_struct+0x4b/0x70
<3> [<6031f854>] ? kasan_report+0x114/0x160
<3> [<60090f2b>] ? arch_dup_task_struct+0x4b/0x70
<3> [<60320830>] ? kasan_check_range+0x0/0x1e0
<3> [<603209a0>] ? kasan_check_range+0x170/0x1e0
<3> [<6032135d>] ? __asan_memcpy+0x2d/0x80
<3> [<60090f2b>] ? arch_dup_task_struct+0x4b/0x70
<3> [<600b9381>] ? copy_process+0x3e1/0x7390
<3> [<600af1a0>] ? block_signals+0x0/0x20
<3> [<603bb46e>] ? vfs_kern_mount.part.0+0x6e/0x140
<3> [<601b48d6>] ? stack_trace_save+0x86/0xa0
<3> [<6063ef2c>] ? stack_depot_save_flags+0x2c/0xa80
<3> [<601b4850>] ? stack_trace_save+0x0/0xa0
<3> [<6031e919>] ? kasan_save_stack+0x49/0x60
<3> [<603bb46e>] ? vfs_kern_mount.part.0+0x6e/0x140
<3> [<6031e919>] ? kasan_save_stack+0x49/0x60
<3> [<600b8fa0>] ? copy_process+0x0/0x7390
<3> [<600c04b3>] ? kernel_clone+0xd3/0x8c0
<3> [<600c03e0>] ? kernel_clone+0x0/0x8c0
<3> [<60038743>] ? arch_irqs_disabled_flags+0x0/0x9
<3> [<60038700>] ? arch_local_save_flags+0x0/0x43
<3> [<600c107d>] ? user_mode_thread+0x9d/0xc0
<3> [<600c0fe0>] ? user_mode_thread+0x0/0xc0
<3> [<60926934>] ? kernel_init+0x0/0x18c
<3> [<6003875e>] ? arch_local_irq_disable+0x0/0xc
<3> [<60038743>] ? arch_irqs_disabled_flags+0x0/0x9
<3> [<60038700>] ? arch_local_save_flags+0x0/0x43
<3> [<603bb69d>] ? kern_mount+0x3d/0xb0
<3> [<6003875e>] ? arch_local_irq_disable+0x0/0xc
<3> [<60926831>] ? rest_init+0x2d/0x130
<3> [<6003875e>] ? arch_local_irq_disable+0x0/0xc
<3> [<60038743>] ? arch_irqs_disabled_flags+0x0/0x9
<3> [<60038700>] ? arch_local_save_flags+0x0/0x43
<3> [<60002679>] ? do_one_initcall+0x0/0x450
<3> [<60005c97>] ? start_kernel_proc+0x0/0x1d
<3> [<60005cb0>] ? start_kernel_proc+0x19/0x1d
<3> [<600904fa>] ? new_thread_handler+0xca/0x130
<3>
<3>The buggy address belongs to the variable:
<3> 0x60b1aec0
<3>
<3>The buggy address belongs to the physical page:
<4>page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0xb1a
<4>flags: 0x2000(reserved|zone=0)
<4>raw: 0000000000002000 000000009f225db8 000000009f225db8 0000000000000000
<4>raw: 0000000000000000 0000000000000000 00000001ffffffff
<4>page dumped because: kasan: bad access detected
<3>
<3>Memory state around the buggy address:
<3> 0000000060b1b600: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
<3> 0000000060b1b680: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
<3>>0000000060b1b700: 00 00 00 00 00 00 00 00 f9 f9 f9 f9 00 00 00 00
<3>                                           ^
<3> 0000000060b1b780: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
<3> 0000000060b1b800: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
<3>==================================================================
<4>Disabling lock debugging due to kernel taint
<4>
<6>Pid: 0, comm: swapper Tainted: G    B              6.13.0-rc2-00194-g6787126c27ef
<6>RIP: 0033:copy_namespaces+0x104/0x2b0
<6>RSP: 0000000060b17b70  EFLAGS: 00010246
<6>RAX: 0000000000000001 RBX: 00000000610a8000 RCX: 0000000060133d7f
<6>RDX: 0000000000000001 RSI: 0000000000000004 RDI: 0000000000000000
<6>RBP: 0000000000000000 R08: 0000000000000001 R09: 0000100000000000
<6>R10: 0000000000000003 R11: ffffffffffffffff R12: 0000000000800300
<6>R13: 000000006102a000 R14: 00000000610a84d8 R15: 0000000060b31ba0
<0>Kernel panic - not syncing: Segfault with no mm
<4>CPU: 0 UID: 0 PID: 0 Comm: swapper Tainted: G    B              6.13.0-rc2-00194-g6787126c27ef #61
<4>Tainted: [B]=BAD_PAGE
<4>Stack:
<4> 00000000 60321286 61070380 0c162f92
<4> 00000000 60b1aec0 61070110 610a8000
<4> 610a8498 600bae85 61001400 60b17ed0
<4>Call Trace:
<4> [<60321286>] ? __asan_memset+0x26/0x50
<4> [<600bae85>] ? copy_process+0x1ee5/0x7390
<4> [<600af1a0>] ? block_signals+0x0/0x20
<4> [<6063ef2c>] ? stack_depot_save_flags+0x2c/0xa80
<4> [<601b4850>] ? stack_trace_save+0x0/0xa0
<4> [<6031e919>] ? kasan_save_stack+0x49/0x60
<4> [<603bb46e>] ? vfs_kern_mount.part.0+0x6e/0x140
<4> [<6031e919>] ? kasan_save_stack+0x49/0x60
<4> [<600b8fa0>] ? copy_process+0x0/0x7390
<4> [<600c04b3>] ? kernel_clone+0xd3/0x8c0
<4> [<600c03e0>] ? kernel_clone+0x0/0x8c0
<4> [<60038743>] ? arch_irqs_disabled_flags+0x0/0x9
<4> [<60038700>] ? arch_local_save_flags+0x0/0x43
<4> [<600c107d>] ? user_mode_thread+0x9d/0xc0
<4> [<600c0fe0>] ? user_mode_thread+0x0/0xc0
<4> [<60926934>] ? kernel_init+0x0/0x18c
<4> [<6003875e>] ? arch_local_irq_disable+0x0/0xc
<4> [<60038743>] ? arch_irqs_disabled_flags+0x0/0x9
<4> [<60038700>] ? arch_local_save_flags+0x0/0x43
<4> [<603bb69d>] ? kern_mount+0x3d/0xb0
<4> [<6003875e>] ? arch_local_irq_disable+0x0/0xc
<4> [<60926831>] ? rest_init+0x2d/0x130
<4> [<6003875e>] ? arch_local_irq_disable+0x0/0xc
<4> [<60038743>] ? arch_irqs_disabled_flags+0x0/0x9
<4> [<60038700>] ? arch_local_save_flags+0x0/0x43
<4> [<60002679>] ? do_one_initcall+0x0/0x450
<4> [<60005c97>] ? start_kernel_proc+0x0/0x1d
<4> [<60005cb0>] ? start_kernel_proc+0x19/0x1d
<4> [<600904fa>] ? new_thread_handler+0xca/0x130
[11:56:56] Elapsed time: 6.794s total, 0.001s configuring, 5.513s building, 1.280s running


