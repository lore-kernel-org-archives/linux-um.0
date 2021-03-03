Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by casper.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHNqP-0020Rv-Lg
 for linux-um@lists.infradead.org; Wed, 03 Mar 2021 09:31:03 +0000
Subject: Re: linux uml segfault
References: <3448a70e7a39b9c3202aeefa7858ace265b8a978.camel@debian.org>
 <6d37b5aa-36f2-1fce-b70b-8faa0ff882e0@kot-begemot.co.uk>
 <c8bb257c-1542-12f5-89f1-5c1f14b8a70a@collabora.com>
 <db40449e-6916-56bf-377c-01b042b9c890@kot-begemot.co.uk>
 <529cd4e2f39efffb18125dffab3058aeec3351ce.camel@debian.org>
 <573e256a-990b-ddf6-7965-367bb8b21229@kot-begemot.co.uk>
 <1bdedf3c60058e1ae242a2a7f16eee256b0be3e0.camel@debian.org>
 <6370b92a-84fa-aa21-4270-fcaf1bf42407@kot-begemot.co.uk>
 <02e348bbb13f0fac92f2147309fb1c006b4583b2.camel@debian.org>
 <5ee28b97-6111-e12c-d0e9-83a13f2151ce@kot-begemot.co.uk>
 <5e068447e2067fff8b21c0689f14d080b984f6e0.camel@debian.org>
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Message-ID: <3e230682-5bb8-4e86-123d-b157728d489b@kot-begemot.co.uk>
Date: Wed, 3 Mar 2021 09:30:56 +0000
MIME-Version: 1.0
In-Reply-To: <5e068447e2067fff8b21c0689f14d080b984f6e0.camel@debian.org>
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
To: rrs@debian.org, Christopher Obbard <chris.obbard@collabora.com>, "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>
Cc: 983379@bugs.debian.org



On 02/03/2021 17:27, Ritesh Raj Sarraf wrote:
> On Tue, 2021-03-02 at 17:05 +0000, Anton Ivanov wrote:
>>> So the best I can extract for you is to compile the kernel with as
>>> much
>>> information as possible.
>>
>> Can you try using one of the older kernels so we can verify if this
>> is indeed a 5.10 thing.
>>
> 
> That was the first thing I tried. I tested it with 5.10, 5.9 and 5.4.
> All 3 crashed. That's when I knew this one was going to be painful one
> to conclude.
> 
> The only other input I have is that I have one more user who's reported
> to be able to reproduce the issue.
> 
> OTOH, I have one more user (other than you) who's not been able to
> reproduce the issue.
> 
>> I will do a dissect the moment I figure out how to reproduce it. I
>> will try to do some more experiments on that tomorrow.

I tried to alter the userspace a bit, but it makes no difference.

Out of curiosity, what are you running it on?

> 
> 
> Meanwhile, I enabled some debug info in the kernel. Here's what I have
> got so far:
> 
> ```
> (gdb) bt
> #0  0x00007f89908dc087 in kill () at ../sysdeps/unix/syscall-
> template.S:120
> #1  0x00000000604a3514 in uml_abort () at arch/um/os-Linux/util.c:94
> #2  0x00000000604a3791 in os_dump_core () at arch/um/os-
> Linux/util.c:149
> #3  0x000000006048d126 in panic_exit (self=0x2e66d5, unused1=6,
> unused2=0x0) at arch/um/kernel/um_arch.c:217
> #4  0x00000000604c725a in notifier_call_chain (nl=0x2e66d5, val=0,
> v=0x60d82f40 <buf>, nr_to_call=-1, nr_calls=0x0) at
> kernel/notifier.c:83
> #5  0x00000000604c72f6 in atomic_notifier_call_chain (nh=0x2e66d5,
> val=6, v=0x0) at kernel/notifier.c:217
> #6  0x0000000060a54607 in panic (fmt=0x60a55225 <printk>
> "UH\211\345H\201\354", <incomplete sequence \320>) at
> kernel/panic.c:272
> #7  0x000000006048cca3 in segv (fi=<incomplete type>, ip=1615717312,
> is_user=0, regs=0x60c2ee58 <cpu0_irqstack+11864>) at
> arch/um/kernel/trap.c:246
> #8  0x000000006048ce64 in segv_handler (sig=3040981, unused_si=0x6,
> regs=0x60c2ee58 <cpu0_irqstack+11864>) at arch/um/kernel/trap.c:190
> #9  0x00000000604a2556 in sig_handler_common (sig=11, si=0x60c2fbf0
> <cpu0_irqstack+15344>, mc=0x60c2fae8 <cpu0_irqstack+15080>) at
> arch/um/os-Linux/signal.c:48
> #10 0x00000000604a2aa2 in sig_handler (sig=3040981, si=0x6, mc=0x0) at
> arch/um/os-Linux/signal.c:81
> #11 0x00000000604a265f in hard_handler (sig=3040981, si=0x60c2fbf0
> <cpu0_irqstack+15344>, p=0x0) at arch/um/os-Linux/signal.c:180
> #12 <signal handler called>

The code here is:

static inline u32 printk_caller_id(void)
{
	return in_task() ? task_pid_nr(current) :
		0x80000000 + raw_smp_processor_id();
}


That is something which should not bomb out unless we have memory corruption or something along those lines - current being invalid.

A.

> #13 0x00000000604de3c0 in printk_caller_id () at
> kernel/printk/printk.c:1924
> #14 log_output (text_len=<optimized out>, text=<optimized out>,
> dev_info=<optimized out>, lflags=<optimized out>, level=<optimized
> out>, facility=<optimized out>) at kernel/printk/printk.c:1932
> #15 vprintk_store (facility=1624806843, level=5, dev_info=0x0, fmt=0x35
> <error: Cannot access memory at address 0x35>, args=0x1) at
> kernel/printk/printk.c:2004
> #16 0x00000000604de8b7 in vprintk_emit (facility=1624806843,
> level=1622768673, dev_info=0x35, fmt=0x1 <error: Cannot access memory
> at address 0x1>, args=0x60b97c22) at kernel/printk/printk.c:2029
> #17 0x00000000604debad in vprintk_deferred (fmt=0x1 <error: Cannot
> access memory at address 0x1>, args=0x60b97c21) at
> kernel/printk/printk.c:3079
> #18 0x0000000060a554de in printk_deferred (fmt=0x60d895bb <textbuf+91>
> "\n") at kernel/printk/printk.c:3091
> #19 0x000000006092680f in _warn_unseeded_randomness
> (previous=<optimized out>, caller=<optimized out>, func_name=<optimized
> out>) at drivers/char/random.c:1534
> #20 _warn_unseeded_randomness (func_name=0x60abf380 <__func__.38>
> "get_random_u32", caller=0x608b5f25 <bucket_table_alloc+287>,
> previous=0x35) at drivers/char/random.c:1516
> #21 0x0000000060927d47 in get_random_u32 () at
> drivers/char/random.c:2221
> #22 0x00000000608b5f25 in bucket_table_alloc (nbuckets=64, gfp=3264,
> ht=<optimized out>) at lib/rhashtable.c:203
> #23 0x00000000608b6733 in rhashtable_init (ht=0x60c60e30
> <init_ipc_ns+80>, params=0x608b5e06 <bucket_table_alloc>) at
> lib/rhashtable.c:1061
> #24 0x000000006080f234 in ipc_init_ids (ids=0x60c60de8 <init_ipc_ns+8>)
> at ipc/util.c:119
> #25 0x0000000060813c6d in sem_init_ns (ns=0x60d895bb <textbuf+91>) at
> ipc/sem.c:254
> #26 0x0000000060015b5d in sem_init () at ipc/sem.c:268
> #27 0x00007f89906d92f7 in ?? () from /lib/x86_64-linux-
> gnu/libcom_err.so.2
> #28 0x00007f8990ab8fb2 in call_init (l=<optimized out>,
> argc=argc@entry=5, argv=argv@entry=0x7ffe3e7a4c98,
> env=env@entry=0x7ffe3e7a4cc8) at dl-init.c:72
> #29 0x00007f8990ab90b9 in call_init (env=0x7ffe3e7a4cc8,
> argv=0x7ffe3e7a4c98, argc=5, l=<optimized out>) at dl-init.c:30
> #30 _dl_init (main_map=0x61497ea0, argc=5, argv=0x7ffe3e7a4c98,
> env=0x7ffe3e7a4cc8) at dl-init.c:119
> #31 0x00007f89909d82bd in __GI__dl_catch_exception
> (exception=exception@entry=0x0, operate=operate@entry=0x7f8990abc5a0
> <call_dl_init>, args=args@entry=0x7ffe3e7a1e80) at dl-error-
> skeleton.c:182
> #32 0x00007f8990abd028 in dl_open_worker (a=a@entry=0x7ffe3e7a2020) at
> dl-open.c:758
> #33 0x00007f89909d8260 in __GI__dl_catch_exception
> (exception=exception@entry=0x7ffe3e7a2000,
> operate=operate@entry=0x7f8990abcc70 <dl_open_worker>,
> args=args@entry=0x7ffe3e7a2020) at dl-error-skeleton.c:208
> #34 0x00007f8990abc8ca in _dl_open (file=0x7ffe3e7a22a0
> "libnss_nis.so.2", mode=-2147483646, caller_dlopen=0x7f89909bf3a6
> <nss_load_library+294>, nsid=-2, argc=5, argv=0x7ffe3e7a2000,
> env=0x7ffe3e7a4cc8)
>      at dl-open.c:837
> #35 0x00007f89909d76dd in do_dlopen (ptr=ptr@entry=0x7ffe3e7a2260) at
> dl-libc.c:96
> #36 0x00007f89909d8260 in __GI__dl_catch_exception
> (exception=exception@entry=0x7ffe3e7a21e0,
> operate=operate@entry=0x7f89909d76a0 <do_dlopen>,
> args=args@entry=0x7ffe3e7a2260) at dl-error-skeleton.c:208
> #37 0x00007f89909d831f in __GI__dl_catch_error
> (objname=objname@entry=0x7ffe3e7a2238,
> errstring=errstring@entry=0x7ffe3e7a2240,
> mallocedp=mallocedp@entry=0x7ffe3e7a2237,
>      operate=operate@entry=0x7f89909d76a0 <do_dlopen>,
> args=args@entry=0x7ffe3e7a2260) at dl-error-skeleton.c:227
> #38 0x00007f89909d77b7 in dlerror_run
> (operate=operate@entry=0x7f89909d76a0 <do_dlopen>,
> args=args@entry=0x7ffe3e7a2260) at dl-libc.c:46
> #39 0x00007f89909d7846 in __GI___libc_dlopen_mode
> (name=name@entry=0x7ffe3e7a22a0 "libnss_nis.so.2", mode=mode@entry=-
> 2147483646) at dl-libc.c:195
> #40 0x00007f89909bf3a6 in nss_load_library (ni=ni@entry=0x61497db0) at
> nsswitch.c:359
> #41 0x00007f89909bfc39 in __GI___nss_lookup_function (ni=0x61497db0,
> fct_name=<optimized out>, fct_name@entry=0x7f899089b020 "setgrent") at
> nsswitch.c:467
> #42 0x00007f899089554b in init_nss_interface () at nss_compat/compat-
> grp.c:83
> #43 init_nss_interface () at nss_compat/compat-grp.c:79
> #44 0x00007f8990895e35 in _nss_compat_getgrnam_r (name=0x7f8990a2a1e0
> "tty", grp=0x7ffe3e7a2910, buffer=0x7ffe3e7a24e0 "", buflen=1024,
> errnop=0x7f899089eb00) at nss_compat/compat-grp.c:486
> #45 0x00007f8990968b85 in __getgrnam_r (name=name@entry=0x7f8990a2a1e0
> "tty", resbuf=resbuf@entry=0x7ffe3e7a2910,
> buffer=buffer@entry=0x7ffe3e7a24e0 "", buflen=1024,
> result=result@entry=0x7ffe3e7a2908)
>      at ../nss/getXXbyYY_r.c:315
> #46 0x00007f89909d6b77 in grantpt (fd=fd@entry=5) at
> ../sysdeps/unix/grantpt.c:152
> #47 0x00007f8990a9394e in __GI_openpty (amaster=0x60c2bd94,
> aslave=0x60c2bd98, name=0x0, termp=0x0, winp=0x0) at openpty.c:103
> #48 0x00000000604a1f65 in openpty_cb (arg=0x60c2bd94) at arch/um/os-
> Linux/sigio.c:407
> #49 0x00000000604a58d0 in start_idle_thread (stack=0x60c28000
> <init_thread_info>, switch_buf=0x60c31e08 <init_task+4936>) at
> arch/um/os-Linux/skas/process.c:598
> #50 0x0000000060004a3d in start_uml () at
> arch/um/kernel/skas/process.c:45
> #51 0x00000000600047b2 in linux_main (argc=1624806843, argv=0x40709000)
> at arch/um/kernel/um_arch.c:334
> #52 0x000000006000574f in main (argc=5, argv=0x7ffe3e7a4c98, envp=0x35)
> at arch/um/os-Linux/main.c:144
> (gdb)
> 
> ```
> 
> 

-- 
Anton R. Ivanov
https://www.kot-begemot.co.uk/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

