Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m2g2z-005Pr5-TI
 for linux-um@lists.infradead.org; Sun, 11 Jul 2021 20:27:31 +0000
Received: by mail-pj1-x102f.google.com with SMTP id
 b8-20020a17090a4888b02901725eedd346so9243892pjh.4
 for <linux-um@lists.infradead.org>; Sun, 11 Jul 2021 13:27:28 -0700 (PDT)
MIME-Version: 1.0
References: <a6188b0422c2a8fe1b5e9f164bfa1796@codeaurora.org>
In-Reply-To: <a6188b0422c2a8fe1b5e9f164bfa1796@codeaurora.org>
From: YiFei Zhu <zhuyifei1999@gmail.com>
Date: Sun, 11 Jul 2021 15:27:17 -0500
Message-ID: <CABqSeAQpb+wEM03knfmDHwtpM6vdfrpuaTwDHA35KY0PHa92cw@mail.gmail.com>
Subject: Re: UML kernel panic on initialization
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
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: subashab@codeaurora.org
Cc: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-um@lists.infradead.org, Johannes Berg <johannes.berg@intel.com>

On Sat, Jul 10, 2021 at 4:00 PM <subashab@codeaurora.org> wrote:
> Run /sbin/init as init process
> init[1]: segfault at 0 ip 0000000040000af0 sp 0000007fbfb0be40 error 0
> in ld-2.13.so[40000000+20000]

I haven't tried to reproduce this, but it looks like it failed in the
dynamic loader. Do you know what instruction it is failing at? It
should be at offset 1af0 in objdump -d `ld-2.13.so` assuming the first
instruction in objdump is 1000.

Could you also check if this instruction that is segfaulting is the
entry point address? If so, it could be that there's some sort of
failure in mapping the VMA, so if you could check the /proc/[pid]/maps
of the userspace traced process that would be great. You can identify
the traced process in that it has a different VSZ than the other UML
threads.

> Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
> CPU: 0 PID: 1 Comm: init Not tainted 5.13.1 #10
> Stack:
>   60462043 60462043 62037bc0 6202a000
>   60537f9b 60462043 62045b01 6004191f
>   62037bd0 6046f12c 62037cf0 60461d67
> Call Trace:
>   [<60462043>] ? printk+0x0/0x94
>   [<600251ee>] show_stack+0x101/0x14e
>   [<60462043>] ? printk+0x0/0x94
>   [<60462043>] ? printk+0x0/0x94
>   [<60462043>] ? printk+0x0/0x94
>   [<6004191f>] ? exit_mm+0x0/0x2b0
>   [<6046f12c>] dump_stack+0x34/0x36
>   [<60461d67>] panic+0x18c/0x3d3
>   [<60037322>] ? set_signals+0x28/0x40
>   [<60461bdb>] ? panic+0x0/0x3d3
>   [<60098bba>] ? acct_collect+0x0/0x1ff
>   [<60037322>] ? set_signals+0x28/0x40
>   [<6047651b>] ? _raw_spin_unlock_irq+0x1c/0x1e
>   [<600372fa>] ? set_signals+0x0/0x40
>   [<60037322>] ? set_signals+0x28/0x40
>   [<6004aba1>] ? percpu_up_read.constprop.46+0x74/0x79
>   [<6004ab2d>] ? percpu_up_read.constprop.46+0x0/0x79
>   [<6004d59e>] ? exit_signals+0xa2/0x180
>   [<6004191f>] ? exit_mm+0x0/0x2b0
>   [<6004259c>] do_exit+0x27c/0x99a
>   [<60043c8f>] do_group_exit+0x94/0x127
>   [<6004e8e0>] get_signal+0x8cf/0x8fe
>   [<60476406>] ? _raw_spin_lock_irq+0x0/0x2a
>   [<6004dc20>] ? force_sig_info_to_task+0xd7/0xe9
>   [<60024f9c>] do_signal+0x21/0x109
>   [<6004e00f>] ? force_sig_fault+0x21/0x23
>   [<600241ba>] interrupt_end+0x5c/0xc7
>   [<6003a18c>] userspace+0x546/0x554
>   [<6002415e>] ? interrupt_end+0x0/0xc7
>   [<6003c6d5>] ? get_fp_registers+0x0/0x12
>   [<60462043>] ? printk+0x0/0x94
>   [<600223b8>] ? run_init_process+0xc2/0xca
>   [<600223c0>] ? try_to_run_init_process+0x0/0x44
>   [<600223d6>] ? try_to_run_init_process+0x16/0x44
>   [<600223c0>] ? try_to_run_init_process+0x0/0x44
>   [<60023ec6>] new_thread_handler+0xb0/0xb2
> Aborted (core dumped)
>
> After doing a git bisect, the first bad commit is listed as-
>
> commit 84b2789d61156db0224724806b20110c0d34b07c
> Author: Johannes Berg <johannes.berg@intel.com>
> Date:   Wed Jan 13 22:09:42 2021 +0100
>
>      um: separate child and parent errors in clone stub
>
>      If the two are mixed up, then it looks as though the parent
>      returned an error if the child failed (before) the mmap(),
>      and then the resulting process never gets killed. Fix this
>      by splitting the child and parent errors, reporting and
>      using them appropriately.
>
>      Signed-off-by: Johannes Berg <johannes.berg@intel.com>
>      Signed-off-by: Richard Weinberger <richard@nod.at>
>
> I have reverted the following patches (to allow for a clean revert)
> and I don't see the panic anymore -
>
> bfc58e2b98e99737409cd9f4d86a79677c5b887c
> dc01a3b9db43abf95b801c9694980777a329e303
> 9f0b4807a44ff81cf59421c8a86641efec586610
> 84b2789d61156db0224724806b20110c0d34b07c
>
> Let me know if more information is needed to debug this.
>
> The startup arguments I have been using are the following and is working
> upto Linux 5.11 -
>
> ./linux ubda=<full_path_to_rootfs> mem=512M
> eth0=daemon,00:18:8b:75:1d:e1
>
> UML is compiled using the following arguments -
>
> make -j32 linux ARCH=um SUBARCH=x86_64 CROSS_COMPILE=
>
>
> _______________________________________________
> linux-um mailing list
> linux-um@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-um

YiFei Zhu

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

