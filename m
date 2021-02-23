Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lEVH5-0002wp-V3
 for linux-um@lists.infradead.org; Tue, 23 Feb 2021 10:50:41 +0000
Subject: Re: linux uml segfault
References: <3448a70e7a39b9c3202aeefa7858ace265b8a978.camel@debian.org>
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Message-ID: <6d37b5aa-36f2-1fce-b70b-8faa0ff882e0@kot-begemot.co.uk>
Date: Tue, 23 Feb 2021 10:50:35 +0000
MIME-Version: 1.0
In-Reply-To: <3448a70e7a39b9c3202aeefa7858ace265b8a978.camel@debian.org>
Content-Language: en-US
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: rrs@debian.org, "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>



On 23/02/2021 08:06, Ritesh Raj Sarraf wrote:
> Hi,
> 
> Recently, with the Linux 5.10 release, I have run into the following
> segfault on UML. I was a little disappointed in myself that this
> slipped my regular set of tests, before being pushed to Debian. It is
> right now part of Debian Testing too and I'd hate to have it removed
> from the Bullseye release.
> 
> What is worse is that (to do some quick tests) I reverted to an older
> UML (5.9) which I recollect to have working, and that too failed on the
> setups.
> 
> In regard to setups, I tried and reproduced the issue on 3 different
> machines, but all running Intel hardware. And all running 5.10 host
> kernel
> 
> 
> It would really help if others on this mailing list can check and
> validate if they run into this problem. So far I have had 1 report of
> being able to reproduce this bug other than me. I have also had 1
> report of not being able to reproduce this bug.

Confirmed. This is the asprintf issue. It is usually just a warning, but for your config it causes a guaranteed segfault.

You need 97be7ceaf7fea68104824b6aa874cff235333ac1 um: Remove use of asprinf in umid.c

In the patchset for the debian package.

A.
> 
> 
> Thanks,
> Ritesh
> 
> 
> ```
> rrs@priyasi:~$ linux ubd0=~/rrs-home/Libvirt-Images/uml.img
> vec0:transport=tap,ifname=tap0,gro=1 mem=1024M rw
> Core dump limits :
>          soft - 0
>          hard - NONE
> Checking that ptrace can change system call numbers...OK
> Checking syscall emulation patch for ptrace...OK
> Checking advanced syscall emulation patch for ptrace...OK
> Checking environment variables for a tempdir...none found
> Checking if /dev/shm is on tmpfs...OK
> Checking PROT_EXEC mmap in /dev/shm...OK
> Adding 5906432 bytes to physical memory to account for exec-shield gap
> kmsg_dump:
> <5>Linux version 5.10.5 (buildd@x86-conova-01) (gcc (Debian 10.2.1-6)
> 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1) #1 Mon Jan 11
> 20:40:53 UTC 2021
> <6>Zone ranges:
> <6>  Normal   [mem 0x0000000000000000-0x00000000a05a1fff]
> <6>Movable zone start for each node
> <6>Early memory node ranges
> <6>  node   0: [mem 0x0000000000000000-0x00000000405a1fff]
> <6>Initmem setup node 0 [mem 0x0000000000000000-0x00000000405a1fff]
> <7>On node 0 totalpages: 263586
> <7>  Normal zone: 4119 pages used for memmap
> <7>  Normal zone: 0 pages reserved
> <7>  Normal zone: 263586 pages, LIFO batch:63
> <7>pcpu-alloc: s0 r0 d32768 u32768 alloc=1*32768
> <7>pcpu-alloc: [0] 0
> <6>Built 1 zonelists, mobility grouping on.  Total pages: 259467
> <5>Kernel command line: ubd0=/home/rrs/rrs-home/Libvirt-Images/uml.img
> vec0:transport=tap,ifname=tap0,gro=1 mem=1024M rw root=98:0
> <6>Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes,
> linear)
> <6>Inode-cache hash table entries: 65536 (order: 7, 524288 bytes,
> linear)
> <6>mem auto-init: stack:off, heap alloc:off, heap free:off
> <6>Memory: 1016464K/1054344K available (5830K kernel code, 1535K
> rwdata, 1744K rodata, 191K init, 225K bss, 37880K reserved, 0K cma-
> reserved)
> <6>SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
> <6>NR_IRQS: 24
> <6>clocksource: timer: mask: 0xffffffffffffffff max_cycles:
> 0x1cd42e205, max_idle_ns: 881590404426 ns
> <6>Calibrating delay loop... 5731.94 BogoMIPS (lpj=28659712)
> <6>pid_max: default: 32768 minimum: 301
> <6>LSM: Security Framework initializing
> <6>Yama: disabled by default; enable with sysctl kernel.yama.*
> <6>SELinux:  Initializing.
> <6>TOMOYO Linux initialized
> <6>Mount-cache hash table entries: 2048 (order: 2, 16384 bytes, linear)
> <6>Mountpoint-cache hash table entries: 2048 (order: 2, 16384 bytes,
> linear)
> <4>
> <4>Modules linked in:
> <6>Pid: 0, comm: swapper Not tainted 5.10.5
> <6>RIP: 0033:[<00000000604d4201>]
> <6>RSP: 00007ffca56a8890  EFLAGS: 00010206
> <6>RAX: 0000000600000000 RBX: 0000000000000059 RCX: 00007ffca56a8000
> <6>RDX: 0000000000000035 RSI: 0000000060b69a71 RDI: 0000000060d8ac3b
> <6>RBP: 0000000000000000 R08: 0000000060b69a72 R09: 0000000060d8abe2
> <6>R10: 0000000080000000 R11: 3d74696e695f676e R12: 0000000000000002
> <6>R13: 0000000000000005 R14: 0000000000000000 R15: 0000000000000001
> <0>Kernel panic - not syncing: Segfault with no mm
> <4>CPU: 0 PID: 0 Comm: swapper Not tainted 5.10.5 #1
> <4>Stack:
> <4> 61335b50 8000000000000000 7fae69465908 7fae69465ae5
> <4> 7fae698ae9e8 00000000 7ffca56a88d0 00000400
> <4> 7fae6985bf20 7fae698ae9e8 00000000 00000000Call Trace:
> <4> [<604d4fa3>] ? __printk_safe_enter+0x0/0x35
> <4> [<604d154a>] ? arch_local_irq_save+0x0/0x22
> <4> [<604d46f5>] ? vprintk_emit+0x9d/0x185
> <4> [<604d49d3>] ? vprintk_deferred+0x1d/0x32
> <4> [<60a26ee2>] ? printk_deferred+0x93/0x9b
> <4> [<6088f79f>] ? bucket_table_alloc.isra.0+0x115/0x13d
> <4> [<60a26e4f>] ? printk_deferred+0x0/0x9b
> <4> [<6049cddb>] ? set_signals+0x0/0x38
> <4> [<60589588>] ? arch_local_irq_save+0x0/0x22
> <4> [<6055c928>] ? kvmalloc_node+0x56/0x96
> <4> [<6058d3c0>] ? __kmalloc+0x1e2/0x1f9
> <4> [<608e3d32>] ? ___ratelimit+0xd0/0xde
> <4> [<6088f79f>] ? bucket_table_alloc.isra.0+0x115/0x13d
> <4> [<60901485>] ? _warn_unseeded_randomness+0x60/0x8f
> <4> [<6090295b>] ? get_random_u32+0x29/0x98
> <4> [<6088f79f>] ? bucket_table_alloc.isra.0+0x115/0x13d
> <4> [<6088f68a>] ? bucket_table_alloc.isra.0+0x0/0x13d
> <4> [<6088ff7a>] ? rhashtable_init+0x175/0x1ca
> <4> [<607ef317>] ? ipc_init_ids+0x4e/0x6f
> <4> [<600153bd>] ? sem_init+0x17/0x45
> <4> [<6049d0e5>] ? start_ptraced_child+0x0/0x180
> <4> [<604a0ce0>] ? kernel_longjmp+0x0/0x20
> <4> [<6049cc3d>] ? set_handler+0x123/0x15b
> <4> [<6049c9ee>] ? hard_handler+0x0/0xcd
> <4> [<604a0ce0>] ? kernel_longjmp+0x0/0x20
> <4> [<6049c3a6>] ? openpty_cb+0x22/0x3b
> <4> [<6049fb4b>] ? start_idle_thread+0x66/0x116
> <4> [<60004613>] ? linux_main+0x2e7/0x2f9
> <4> [<6049cc86>] ? change_sig+0x0/0x6a
> <4> [<6000565e>] ? main+0x230/0x2dc
> <4> [<60a256b0>] ? __libc_csu_init+0x0/0x60
> <4> [<604827d0>] ? _start+0x0/0x30
> <4> [<6000542e>] ? main+0x0/0x2dc
> <4> [<604827d0>] ? _start+0x0/0x30
> <4> [<604827d0>] ? _start+0x0/0x30
> <4> [<604827fa>] ? _start+0x2a/0x30
> <4> [<604827d0>] ? _start+0x0/0x30
> Aborted (core dumped)
> ```
> 
> 
> _______________________________________________
> linux-um mailing list
> linux-um@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-um
> 

-- 
Anton R. Ivanov
https://www.kot-begemot.co.uk/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

