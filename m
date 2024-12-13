Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D159FE7717F
	for <linux-um@archiver.kernel.org>; Fri, 13 Dec 2024 23:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lAeDhXSjwnmmpNKGAxr/fs/7QEYF8hNpGbm4U6G8CLQ=; b=oPmsSO1pQuLSXcx8ODxXgb5fQc
	2bcPXttWuY3fEVOSS6yrw8TxalQ+5oHl8t17VFL5+huWgj2TBughLyvLu6A3Zd4F86yhovubHYnun
	aUPf+SyzQaiwLl755hWKvWmUjIakHFFyTMoH60ZPUsBu42ntTTer9CgFqPSLA2ZPAShXzVJq/+6vU
	gfgYTTi/F0UUwgm9uABg08JwEdCL2zkojqyb515KYhINvORCsQcCLO2fSViYtrkOoyjjVynAncFS6
	IE/37uM9xbqJCZ49GQ7KXfcoPDeJF9L3jF1JcYvgGW7UKLILxdkaex+pO53rlKVBxmA4FXAWIVKgr
	2B9RCNsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tMElw-00000005FQH-3Muv;
	Fri, 13 Dec 2024 23:08:36 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tMElu-00000005FPd-0VYG
	for linux-um@lists.infradead.org;
	Fri, 13 Dec 2024 23:08:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=lAeDhXSjwnmmpNKGAxr/fs/7QEYF8hNpGbm4U6G8CLQ=;
	t=1734131309; x=1735340909; b=MkEibgmZ2NB+205Nmo6GY9K5dQgPdd3jEsCP7X1CWfdDkyX
	Lj+96f9/krxqESE35Dx1XPipttrsO+HCkrnPMqh3SCjK/CCnZvm81SuB2Kv301RCZw9nZwNLk4Zdd
	Z45v2XaF+pjxOdSREJzW7YzefE0Nb4t3rQpfSxApfxOyL8GoWTrOJXoHM3FS3dKBwIYy1llMJQ31r
	pAniEYJrbQamSg/IH1d4mV7ZCAt4PIp4Md8+k0q5P3GFJpO/7nTVy5onyBG+e2AzwZCEfpAlAF2Ch
	MOyHWluBJgNyhKxBJjl9mWU4nY1VXiBRQ+p7b8TywHLOZJ2015lQ2QMbepYE5fsA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1tMElT-0000000Foan-399T;
	Sat, 14 Dec 2024 00:08:08 +0100
Message-ID: <689539526e48a2648134bb8de463c3bf68724993.camel@sipsolutions.net>
Subject: Re: [PATCH v5] um: switch to regset API and depend on XSTATE
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Brian Norris <briannorris@chromium.org>
Cc: linux-um@lists.infradead.org, johannes@sipsolutions.net
Date: Sat, 14 Dec 2024 00:08:04 +0100
In-Reply-To: <Z1ySXmjZm-xOqk90@google.com>
References: <20241023094120.4083426-1-benjamin@sipsolutions.net>
		 <Z1ySXmjZm-xOqk90@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 (3.54.2-1.fc41) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241213_150834_338389_A32291F6 
X-CRM114-Status: GOOD (  34.58  )
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

Hi Brian,

outch. It is doing a memcpy of init_task. Now, struct task_struct is
variably sized, but init_struct is statically allocated, which could
explain why the memcpy is not permitted to read the larger memory (for
the FP register space).
I can reproduce it with the kunit.py script, but didn't run into it
with my own configuration.

Now, this patch works around the problem:

diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
index 30bdc0a87dc8..7748df822d30 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -191,7 +191,10 @@ void initial_thread_cb(void (*proc)(void *), void
*arg)
 int arch_dup_task_struct(struct task_struct *dst,
                         struct task_struct *src)
 {
-       memcpy(dst, src, arch_task_struct_size);
+       if (src =3D=3D &init_task)
+               memcpy(dst, src, sizeof(init_task));
+       else
+               memcpy(dst, src, arch_task_struct_size);
        return 0;
 }
=20

However, that cannot really be correct. I believe what should be
happening is that init_task is loaded into init_stack (see
INIT_TASK_DATA in vmlinux.lds.h). I am assuming that if this was the
case, then KASAN would be happy with it. However, I see the following
addresses
  __start_init_stack: 0x606dc000
  __end_init_stack: 0x606e0000
  init_task: 0x606e2ec0
and I am not sure why the linker script is not placing init_task into
the stack here.

Also note that commit 2f681ba4b352 ("um: move thread info into task")
may be part of a correct fix here.

Benjamin

On Fri, 2024-12-13 at 12:00 -0800, Brian Norris wrote:
> Hi Benjamin,
>=20
> On Wed, Oct 23, 2024 at 11:41:20AM +0200, Benjamin Berg wrote:
> > From: Benjamin Berg <benjamin.berg@intel.com>
> >=20
> > The PTRACE_GETREGSET API has now existed since Linux 2.6.33. The
> > XSAVE
> > CPU feature should also be sufficiently common to be able to rely
> > on it.
> >=20
> > With this, define our internal FP state to be the hosts XSAVE data.
> > Add
> > discovery for the hosts XSAVE size and place the FP registers at
> > the end
> > of task_struct so that we can adjust the size at runtime.
> >=20
> > Next we can implement the regset API on top and update the signal
> > handling as well as ptrace APIs to use them. Also switch coredump
> > creation to use the regset API and finally set HAVE_ARCH_TRACEHOOK.
> >=20
> > This considerably improves the signal frames. Previously they might
> > not
> > have contained all the registers (i386) and also did not have the
> > sizes and magic values set to the correct values to permit
> > userspace to
> > decode the frame.
> >=20
> > As a side effect, this will permit UML to run on hosts with newer
> > CPU
> > extensions (such as AMX) that need even more register state.
> >=20
> > Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
>=20
> This patch seems to trip up KASAN. Or at least, KUnit tests fail when
> I
> enable CONFIG_KASAN, and 'git bisect' points me here:
>=20
> $ git bisect run ./tools/testing/kunit/kunit.py run
> stackinit.test_user --kconfig_add CONFIG_KASAN=3Dy
> [...]
> 3f17fed2149192c7d3b76a45a6a87b4ff22cd586 is the first bad commit
> commit 3f17fed2149192c7d3b76a45a6a87b4ff22cd586
> Author: Benjamin Berg <benjamin.berg@intel.com>
> Date:=C2=A0=C2=A0 Wed Oct 23 11:41:20 2024 +0200
>=20
> =C2=A0=C2=A0=C2=A0 um: switch to regset API and depend on XSTATE
> [...]
>=20
> If I run at Linus's latest:
>=20
> =C2=A0 243f750a2df0 Merge tag 'gpio-fixes-for-v6.13-rc3' of
> git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux
>=20
> I get a KASAN warning and panic [1]. I tried this fix for fun, but it
> doesn't help:
> Subject: [PATCH] um: add back support for FXSAVE registers
> https://lore.kernel.org/linux-um/20241204074827.1582917-1-benjamin@sipsol=
utions.net/
>=20
> I'm not very familiar with this area, but let me know if there's more
> I
> can help with on tracking the issue down. Hopefully, it's as easy as
> running these same commands for you to reproduce.
>=20
> Brian
>=20
> [1]
> $ ./tools/testing/kunit/kunit.py run stackinit.test_user --
> kconfig_add CONFIG_KASAN=3Dy --raw_output=3Dall
> [...]
> <3>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> <3>BUG: KASAN: global-out-of-bounds in arch_dup_task_struct+0x4b/0x70
> <3>Read of size 4616 at addr 0000000060b1aec0 by task swapper/0
> <3>
> <3>CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 6.13.0-rc2-00194-
> g6787126c27ef #61
> <3>Stack:
> <4> 00000000 00000000 ffffff00 60acc428
> <4> 60ad2ffc 9f225db0 00000001 6008b7fb
> <4> 60b17aa0 6003fbf5 60b1aec0 6004c654
> <3>Call Trace:
> <3> [<60038c0e>] ? show_stack.cold+0x64/0xf3
> <3> [<6008b7fb>] ? dump_stack_lvl+0x8b/0xa7
> <3> [<6003fbf5>] ? _printk+0x0/0x103
> <3> [<6004c654>] ? print_report+0x145/0x519
> <3> [<60090f2b>] ? arch_dup_task_struct+0x4b/0x70
> <3> [<6031f854>] ? kasan_report+0x114/0x160
> <3> [<60090f2b>] ? arch_dup_task_struct+0x4b/0x70
> <3> [<60320830>] ? kasan_check_range+0x0/0x1e0
> <3> [<603209a0>] ? kasan_check_range+0x170/0x1e0
> <3> [<6032135d>] ? __asan_memcpy+0x2d/0x80
> <3> [<60090f2b>] ? arch_dup_task_struct+0x4b/0x70
> <3> [<600b9381>] ? copy_process+0x3e1/0x7390
> <3> [<600af1a0>] ? block_signals+0x0/0x20
> <3> [<603bb46e>] ? vfs_kern_mount.part.0+0x6e/0x140
> <3> [<601b48d6>] ? stack_trace_save+0x86/0xa0
> <3> [<6063ef2c>] ? stack_depot_save_flags+0x2c/0xa80
> <3> [<601b4850>] ? stack_trace_save+0x0/0xa0
> <3> [<6031e919>] ? kasan_save_stack+0x49/0x60
> <3> [<603bb46e>] ? vfs_kern_mount.part.0+0x6e/0x140
> <3> [<6031e919>] ? kasan_save_stack+0x49/0x60
> <3> [<600b8fa0>] ? copy_process+0x0/0x7390
> <3> [<600c04b3>] ? kernel_clone+0xd3/0x8c0
> <3> [<600c03e0>] ? kernel_clone+0x0/0x8c0
> <3> [<60038743>] ? arch_irqs_disabled_flags+0x0/0x9
> <3> [<60038700>] ? arch_local_save_flags+0x0/0x43
> <3> [<600c107d>] ? user_mode_thread+0x9d/0xc0
> <3> [<600c0fe0>] ? user_mode_thread+0x0/0xc0
> <3> [<60926934>] ? kernel_init+0x0/0x18c
> <3> [<6003875e>] ? arch_local_irq_disable+0x0/0xc
> <3> [<60038743>] ? arch_irqs_disabled_flags+0x0/0x9
> <3> [<60038700>] ? arch_local_save_flags+0x0/0x43
> <3> [<603bb69d>] ? kern_mount+0x3d/0xb0
> <3> [<6003875e>] ? arch_local_irq_disable+0x0/0xc
> <3> [<60926831>] ? rest_init+0x2d/0x130
> <3> [<6003875e>] ? arch_local_irq_disable+0x0/0xc
> <3> [<60038743>] ? arch_irqs_disabled_flags+0x0/0x9
> <3> [<60038700>] ? arch_local_save_flags+0x0/0x43
> <3> [<60002679>] ? do_one_initcall+0x0/0x450
> <3> [<60005c97>] ? start_kernel_proc+0x0/0x1d
> <3> [<60005cb0>] ? start_kernel_proc+0x19/0x1d
> <3> [<600904fa>] ? new_thread_handler+0xca/0x130
> <3>
> <3>The buggy address belongs to the variable:
> <3> 0x60b1aec0
> <3>
> <3>The buggy address belongs to the physical page:
> <4>page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0
> pfn:0xb1a
> <4>flags: 0x2000(reserved|zone=3D0)
> <4>raw: 0000000000002000 000000009f225db8 000000009f225db8
> 0000000000000000
> <4>raw: 0000000000000000 0000000000000000 00000001ffffffff
> <4>page dumped because: kasan: bad access detected
> <3>
> <3>Memory state around the buggy address:
> <3> 0000000060b1b600: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> <3> 0000000060b1b680: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> <3>>0000000060b1b700: 00 00 00 00 00 00 00 00 f9 f9 f9 f9 00 00 00 00
> <3>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^
> <3> 0000000060b1b780: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> <3> 0000000060b1b800: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> <3>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> <4>Disabling lock debugging due to kernel taint
> <4>
> <6>Pid: 0, comm: swapper Tainted: G=C2=A0=C2=A0=C2=A0 B=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 6.13.0-rc2-
> 00194-g6787126c27ef
> <6>RIP: 0033:copy_namespaces+0x104/0x2b0
> <6>RSP: 0000000060b17b70=C2=A0 EFLAGS: 00010246
> <6>RAX: 0000000000000001 RBX: 00000000610a8000 RCX: 0000000060133d7f
> <6>RDX: 0000000000000001 RSI: 0000000000000004 RDI: 0000000000000000
> <6>RBP: 0000000000000000 R08: 0000000000000001 R09: 0000100000000000
> <6>R10: 0000000000000003 R11: ffffffffffffffff R12: 0000000000800300
> <6>R13: 000000006102a000 R14: 00000000610a84d8 R15: 0000000060b31ba0
> <0>Kernel panic - not syncing: Segfault with no mm
> <4>CPU: 0 UID: 0 PID: 0 Comm: swapper Tainted: G=C2=A0=C2=A0=C2=A0 B=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> 6.13.0-rc2-00194-g6787126c27ef #61
> <4>Tainted: [B]=3DBAD_PAGE
> <4>Stack:
> <4> 00000000 60321286 61070380 0c162f92
> <4> 00000000 60b1aec0 61070110 610a8000
> <4> 610a8498 600bae85 61001400 60b17ed0
> <4>Call Trace:
> <4> [<60321286>] ? __asan_memset+0x26/0x50
> <4> [<600bae85>] ? copy_process+0x1ee5/0x7390
> <4> [<600af1a0>] ? block_signals+0x0/0x20
> <4> [<6063ef2c>] ? stack_depot_save_flags+0x2c/0xa80
> <4> [<601b4850>] ? stack_trace_save+0x0/0xa0
> <4> [<6031e919>] ? kasan_save_stack+0x49/0x60
> <4> [<603bb46e>] ? vfs_kern_mount.part.0+0x6e/0x140
> <4> [<6031e919>] ? kasan_save_stack+0x49/0x60
> <4> [<600b8fa0>] ? copy_process+0x0/0x7390
> <4> [<600c04b3>] ? kernel_clone+0xd3/0x8c0
> <4> [<600c03e0>] ? kernel_clone+0x0/0x8c0
> <4> [<60038743>] ? arch_irqs_disabled_flags+0x0/0x9
> <4> [<60038700>] ? arch_local_save_flags+0x0/0x43
> <4> [<600c107d>] ? user_mode_thread+0x9d/0xc0
> <4> [<600c0fe0>] ? user_mode_thread+0x0/0xc0
> <4> [<60926934>] ? kernel_init+0x0/0x18c
> <4> [<6003875e>] ? arch_local_irq_disable+0x0/0xc
> <4> [<60038743>] ? arch_irqs_disabled_flags+0x0/0x9
> <4> [<60038700>] ? arch_local_save_flags+0x0/0x43
> <4> [<603bb69d>] ? kern_mount+0x3d/0xb0
> <4> [<6003875e>] ? arch_local_irq_disable+0x0/0xc
> <4> [<60926831>] ? rest_init+0x2d/0x130
> <4> [<6003875e>] ? arch_local_irq_disable+0x0/0xc
> <4> [<60038743>] ? arch_irqs_disabled_flags+0x0/0x9
> <4> [<60038700>] ? arch_local_save_flags+0x0/0x43
> <4> [<60002679>] ? do_one_initcall+0x0/0x450
> <4> [<60005c97>] ? start_kernel_proc+0x0/0x1d
> <4> [<60005cb0>] ? start_kernel_proc+0x19/0x1d
> <4> [<600904fa>] ? new_thread_handler+0xca/0x130
> [11:56:56] Elapsed time: 6.794s total, 0.001s configuring, 5.513s
> building, 1.280s running
>=20
>=20


