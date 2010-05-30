MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <AANLkTimYeMO_fc8C5MQedwF646_au4lvEbXkBPmQSxb9@mail.gmail.com>
References: <201005271944.09541.toralf.foerster@gmx.de>
	<AANLkTimYeMO_fc8C5MQedwF646_au4lvEbXkBPmQSxb9@mail.gmail.com>
Date: Sun, 30 May 2010 13:57:05 +0200
Message-ID: <AANLkTimKwxYxM_PExplIDK1WPTQ9e_-CHn5SnIvfjfUg@mail.gmail.com>
Subject: Re: current git kernel crashes UML system during boot
From: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?Q?Toralf_F=C3=B6rster?= <toralf.foerster@gmx.de>, Borislav Petkov <borislav.petkov@amd.com>, "H. Peter Anvin" <hpa@zytor.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Sun, May 30, 2010 at 13:39, Geert Uytterhoeven <geert@linux-m68k.org> wr=
ote:
> 2010/5/27 Toralf F=C3=B6rster <toralf.foerster@gmx.de>:
>> I bisected it to this :

> After fixing the missing/superfluous slab inclusion issues, I bisected
> it further to
>
> commit d61931d89be506372d01a90d1755f6d0a9fafe2d
> Author: Borislav Petkov <borislav.petkov@amd.com>
> Date: =C2=A0 Fri Mar 5 17:34:46 2010 +0100
>
> =C2=A0 =C2=A0x86: Add optimized popcnt variants
>
> =C2=A0 =C2=A0Add support for the hardware version of the Hamming weight f=
unction,
> =C2=A0 =C2=A0popcnt, present in CPUs which advertize it under CPUID, Func=
tion
> =C2=A0 =C2=A00x0000_0001_ECX[23]. On CPUs which don't support it, we fall=
back to the
> =C2=A0 =C2=A0default lib/hweight.c sw versions.
>
> =C2=A0 =C2=A0A synthetic benchmark comparing popcnt with __sw_hweight64 s=
howed almost
> =C2=A0 =C2=A0a 3x speedup on a F10h machine.
>
> =C2=A0 =C2=A0Signed-off-by: Borislav Petkov <borislav.petkov@amd.com>
> =C2=A0 =C2=A0LKML-Reference: <20100318112015.GC11152@aftab>
> =C2=A0 =C2=A0Signed-off-by: H. Peter Anvin <hpa@zytor.com>
>
> I reverted that commit on top of current mainline (and fixed up the
> conflicts), and now
> it boots again.

I tried adding

config ARCH_HWEIGHT_CFLAGS
        string
        default "-fcall-saved-ecx -fcall-saved-edx" if !64_BIT
        default "-fcall-saved-rdi -fcall-saved-rsi -fcall-saved-rdx
-fcall-saved-rcx -fcall-saved-r8 -fcall-saved-r9 -fcall-saved-r10
-fcall-saved-r11" if 64_BIT

to arch/um/Kconfig.x86. Now it got a bit further, but it still crashes:

Core dump limits :
	soft - 0
	hard - NONE
Checking that ptrace can change system call numbers...OK
Checking syscall emulation patch for ptrace...OK
Checking advanced syscall emulation patch for ptrace...OK
Checking for tmpfs mount on /dev/shm...OK
Checking PROT_EXEC mmap in /dev/shm/...OK
Checking for the skas3 patch in the host:
  - /proc/mm...not found: No such file or directory
  - PTRACE_FAULTINFO...not found
  - PTRACE_LDT...not found
UML running in SKAS0 mode
Adding 22290432 bytes to physical memory to account for exec-shield gap
Linux version 2.6.34-08406-g52b0ace-dirty (geert@ayla) (gcc version
4.4.3 (Ubuntu 4.4.3-4ubuntu5) ) #41 Sun May 30 13:54:35 CEST 2010
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 70007
Kernel command line: ubd0=3D/home/uml/rootfs-amd64
eth0=3Dslirp,,slirp-fullbolt mem=3D256M root=3D98:0
PID hash table entries: 2048 (order: 2, 16384 bytes)
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
Memory: 250720k available
Hierarchical RCU implementation.
	Verbose stalled-CPUs detection is disabled.
NR_IRQS:15
Calibrating delay loop... 419.43 BogoMIPS (lpj=3D2097152)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 256
Checking that host ptys support output SIGIO...Yes
Checking that host ptys support SIGIO on close...No, enabling workaround
Using 2.6 host AIO
NET: Registered protocol family 16
bio: create slab <bio-0> at 0
Switching to clocksource itimer
NET: Registered protocol family 2
IP route cache hash table entries: 4096 (order: 3, 32768 bytes)
TCP established hash table entries: 16384 (order: 6, 262144 bytes)
TCP bind hash table entries: 16384 (order: 5, 131072 bytes)
TCP: Hash tables configured (established 16384 bind 16384)
TCP reno registered
UDP hash table entries: 256 (order: 1, 8192 bytes)
UDP-Lite hash table entries: 256 (order: 1, 8192 bytes)
NET: Registered protocol family 1
mconsole (version 2) initialized on /home/geert/.uml/z9aGEj/mconsole
Checking host MADV_REMOVE support...OK
VFS: Disk quotas dquot_6.5.2
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
msgmni has been set to 489
io scheduler noop registered
io scheduler deadline registered
io scheduler cfq registered (default)
TCP cubic registered
NET: Registered protocol family 17
Initialized stdio console driver
Console initialized on /dev/tty0
console [tty0] enabled
Initializing software serial port version 1
Choosing a random ethernet address for device eth0
Netdevice 0 (1e:a2:ad:7c:43:91) : SLIRP backend - command line: 'slirp-full=
bolt'
console [mc-1] enabled
 ubda:
Modules linked in:
Pid: 0, comm: swapper Not tainted 2.6.34-08406-g52b0ace-dirty
RIP: 0033:[<0000000060110675>]
RSP: 0000000060235810  EFLAGS: 00010297
RAX: 0000000000000000 RBX: 0000000071371800 RCX: 000000000000000a
RDX: 00000000ffff8aed RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000060235820 R08: 0000000000000000 R09: 000000000000001e
R10: 0000000000000001 R11: 00000000602b8c48 R12: 00000000713c4e80
R13: 00000000713c4e80 R14: 0000000071375958 R15: 0000000000000001
Call Trace:
60235308:  [<60014a79>] segv+0x70/0x212
60235318:  [<60110675>] cfq_close_cooperator+0x39/0x160
602353e8:  [<60014c7a>] segv_handler+0x5f/0x65
60235418:  [<60021698>] sig_handler_common+0x84/0x98
602354a0:  [<60110675>] cfq_close_cooperator+0x39/0x160
60235548:  [<600217de>] sig_handler+0x30/0x3b
60235568:  [<60021a10>] handle_signal+0x6d/0xa3
602355b8:  [<600233c8>] hard_handler+0x10/0x14
60235678:  [<60110675>] cfq_close_cooperator+0x39/0x160
60235708:  [<60040bb3>] autoremove_wake_function+0x11/0x34
60235728:  [<60040bfe>] wake_bit_function+0x28/0x2e
60235738:  [<600276db>] __wake_up_common+0x44/0x7a
60235778:  [<60075913>] kmem_cache_free+0x54/0x5f
602357b8:  [<60057f6e>] mempool_free_slab+0x12/0x14
602357c8:  [<6005803c>] mempool_free+0x6f/0x76
602357f8:  [<6009ae62>] bio_free+0x4d/0x52
60235808:  [<6011066c>] cfq_close_cooperator+0x30/0x160
60235828:  [<60110bae>] cfq_completed_request+0x375/0x4db
60235888:  [<601053ee>] elv_completed_request+0x4e/0xaf
602358a8:  [<601068be>] __blk_put_request+0x37/0xbd
602358d8:  [<60106acf>] blk_finish_request+0x18b/0x198
60235918:  [<60106d85>] blk_end_bidi_request+0x38/0x4b
60235948:  [<60106dca>] blk_end_request+0xb/0xd
60235958:  [<6001cf86>] ubd_intr+0x55/0xd7
60235998:  [<600527a2>] handle_IRQ_event+0x20/0x9a
602359c8:  [<60052889>] __do_IRQ+0x6d/0xb0
602359f8:  [<6001217f>] do_IRQ+0x27/0x3f
60235a28:  [<6001234f>] sigio_handler+0x4b/0x5f
60235a48:  [<60021698>] sig_handler_common+0x84/0x98
60235a68:  [<60021745>] real_alarm_handler+0x3c/0x3e
60235af0:  [<60095b01>] copy_fs_struct+0xc/0x76
60235b78:  [<600217de>] sig_handler+0x30/0x3b
60235b98:  [<60021a10>] handle_signal+0x6d/0xa3
60235be8:  [<600233c8>] hard_handler+0x10/0x14

Kernel panic - not syncing: Segfault with no mm
Call Trace:
60235218:  [<6018fadb>] panic+0xe4/0x14f
60235278:  [<6004db6b>] is_module_text_address+0x9/0x11
60235288:  [<6003ecdc>] __kernel_text_address+0x65/0x6b
60235290:  [<600233c8>] hard_handler+0x10/0x14
602352a8:  [<60013a12>] show_trace+0x8e/0x95
602352d8:  [<60026e34>] show_regs+0x2b/0x2f
60235308:  [<60014b03>] segv+0xfa/0x212
60235318:  [<60110675>] cfq_close_cooperator+0x39/0x160
602353e8:  [<60014c7a>] segv_handler+0x5f/0x65
60235418:  [<60021698>] sig_handler_common+0x84/0x98
602354a0:  [<60110675>] cfq_close_cooperator+0x39/0x160
60235548:  [<600217de>] sig_handler+0x30/0x3b
60235568:  [<60021a10>] handle_signal+0x6d/0xa3
602355b8:  [<600233c8>] hard_handler+0x10/0x14
60235678:  [<60110675>] cfq_close_cooperator+0x39/0x160
60235708:  [<60040bb3>] autoremove_wake_function+0x11/0x34
60235728:  [<60040bfe>] wake_bit_function+0x28/0x2e
60235738:  [<600276db>] __wake_up_common+0x44/0x7a
60235778:  [<60075913>] kmem_cache_free+0x54/0x5f
602357b8:  [<60057f6e>] mempool_free_slab+0x12/0x14
602357c8:  [<6005803c>] mempool_free+0x6f/0x76
602357f8:  [<6009ae62>] bio_free+0x4d/0x52
60235808:  [<6011066c>] cfq_close_cooperator+0x30/0x160
60235828:  [<60110bae>] cfq_completed_request+0x375/0x4db
60235888:  [<601053ee>] elv_completed_request+0x4e/0xaf
602358a8:  [<601068be>] __blk_put_request+0x37/0xbd
602358d8:  [<60106acf>] blk_finish_request+0x18b/0x198
60235918:  [<60106d85>] blk_end_bidi_request+0x38/0x4b
60235948:  [<60106dca>] blk_end_request+0xb/0xd
60235958:  [<6001cf86>] ubd_intr+0x55/0xd7
60235998:  [<600527a2>] handle_IRQ_event+0x20/0x9a
602359c8:  [<60052889>] __do_IRQ+0x6d/0xb0
602359f8:  [<6001217f>] do_IRQ+0x27/0x3f
60235a28:  [<6001234f>] sigio_handler+0x4b/0x5f
60235a48:  [<60021698>] sig_handler_common+0x84/0x98
60235a68:  [<60021745>] real_alarm_handler+0x3c/0x3e
60235af0:  [<60095b01>] copy_fs_struct+0xc/0x76
60235b78:  [<600217de>] sig_handler+0x30/0x3b
60235b98:  [<60021a10>] handle_signal+0x6d/0xa3
60235be8:  [<600233c8>] hard_handler+0x10/0x14


Modules linked in:
Pid: 0, comm: swapper Not tainted 2.6.34-08406-g52b0ace-dirty
RIP: 0000:[<0000000000000000>]
RSP: 0000000000000000  EFLAGS: 00000000
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
Call Trace:
602351a8:  [<60014de7>] panic_exit+0x2f/0x45
602351b0:  [<600233c8>] hard_handler+0x10/0x14
602351c8:  [<600441ea>] notifier_call_chain+0x32/0x5e
60235208:  [<60044230>] atomic_notifier_call_chain+0xf/0x11
60235218:  [<6018faf6>] panic+0xff/0x14f
60235278:  [<6004db6b>] is_module_text_address+0x9/0x11
60235288:  [<6003ecdc>] __kernel_text_address+0x65/0x6b
60235290:  [<600233c8>] hard_handler+0x10/0x14
602352a8:  [<60013a12>] show_trace+0x8e/0x95
602352d8:  [<60026e34>] show_regs+0x2b/0x2f
60235308:  [<60014b03>] segv+0xfa/0x212
60235318:  [<60110675>] cfq_close_cooperator+0x39/0x160
602353e8:  [<60014c7a>] segv_handler+0x5f/0x65
60235418:  [<60021698>] sig_handler_common+0x84/0x98
602354a0:  [<60110675>] cfq_close_cooperator+0x39/0x160
60235548:  [<600217de>] sig_handler+0x30/0x3b
60235568:  [<60021a10>] handle_signal+0x6d/0xa3
602355b8:  [<600233c8>] hard_handler+0x10/0x14
60235678:  [<60110675>] cfq_close_cooperator+0x39/0x160
60235708:  [<60040bb3>] autoremove_wake_function+0x11/0x34
60235728:  [<60040bfe>] wake_bit_function+0x28/0x2e
60235738:  [<600276db>] __wake_up_common+0x44/0x7a
60235778:  [<60075913>] kmem_cache_free+0x54/0x5f
602357b8:  [<60057f6e>] mempool_free_slab+0x12/0x14
602357c8:  [<6005803c>] mempool_free+0x6f/0x76
602357f8:  [<6009ae62>] bio_free+0x4d/0x52
60235808:  [<6011066c>] cfq_close_cooperator+0x30/0x160
60235828:  [<60110bae>] cfq_completed_request+0x375/0x4db
60235888:  [<601053ee>] elv_completed_request+0x4e/0xaf
602358a8:  [<601068be>] __blk_put_request+0x37/0xbd
602358d8:  [<60106acf>] blk_finish_request+0x18b/0x198
60235918:  [<60106d85>] blk_end_bidi_request+0x38/0x4b
60235948:  [<60106dca>] blk_end_request+0xb/0xd
60235958:  [<6001cf86>] ubd_intr+0x55/0xd7
60235998:  [<600527a2>] handle_IRQ_event+0x20/0x9a
602359c8:  [<60052889>] __do_IRQ+0x6d/0xb0
602359f8:  [<6001217f>] do_IRQ+0x27/0x3f
60235a28:  [<6001234f>] sigio_handler+0x4b/0x5f
60235a48:  [<60021698>] sig_handler_common+0x84/0x98
60235a68:  [<60021745>] real_alarm_handler+0x3c/0x3e
60235af0:  [<60095b01>] copy_fs_struct+0xc/0x76
60235b78:  [<600217de>] sig_handler+0x30/0x3b
60235b98:  [<60021a10>] handle_signal+0x6d/0xa3
60235be8:  [<600233c8>] hard_handler+0x10/0x14

Kernel panic - not syncing: Kernel mode signal 4
Call Trace:
71040128:  [<6018fadb>] panic+0xe4/0x14f
71040218:  [<600146ee>]Terminated

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
							    -- Linus Torvalds

