Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <1496390649.2047.2.camel@m3y3r.de>
Subject: Re: [PATCH v2] um: Avoid longjmp/setjmp symbol clashes with
 libpthread.a
From: Thomas Meyer <thomas@m3y3r.de>
Date: Fri, 02 Jun 2017 10:04:09 +0200
In-Reply-To: <3672f56d-da81-1114-f06a-ac99d3680661@gmail.com>
References: <20170524003232.14319-1-f.fainelli@gmail.com>
         <e2c13a8b-d0c3-74d1-dd1b-53a56f609c76@nod.at>
         <9f58b41d-ebe4-62a6-1aa4-e9222372ce86@gmail.com>
         <408132c9-6d55-7cba-e09a-f532d7fb9c6f@gmail.com>
         <9617f203-cee2-96cf-aa76-8f42b1a4a9f6@nod.at>
         <2c362d49-9907-7a66-67ef-e196dddea32a@gmail.com>
         <85f8b8c0-cf0e-3c67-c237-be4b045c617b@nod.at>
         <f57b5906-30cc-0fdf-893c-39e4f5202d1b@gmail.com>
         <07b61d6a-33af-be0a-b57c-843196d0d151@nod.at>
         <8dd50867-312d-8af9-0993-4b5d5c181a58@gmail.com>
         <e53ebfee-0b8a-0fe6-c2d3-eb6fb4aa9e2c@nod.at>
         <1496352322.9072.1.camel@m3y3r.de>
         <3672f56d-da81-1114-f06a-ac99d3680661@gmail.com>
Content-Type: text/plain; charset="utf-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
To: Florian Fainelli <f.fainelli@gmail.com>, Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org
Cc: Jeff Dike <jdike@addtoit.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, "open list:USER-MODE LINUX (UML)" <user-mode-linux-devel@lists.sourceforge.net>, "open list:USER-MODE LINUX (UML)" <user-mode-linux-user@lists.sourceforge.net>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Am Donnerstag, den 01.06.2017, 22:49 -0700 schrieb Florian Fainelli:
> 
> On 06/01/2017 02:25 PM, Thomas Meyer wrote:
> > Am Donnerstag, den 01.06.2017, 22:58 +0200 schrieb Richard
> > Weinberger:
> > > 
> > > Sorry, I thought you are CC'ed.
> > > Thomas please speak up. AFAIR UML fails to boot on one of your
> > > new
> > > Laptops.
> > 
> > Hi,
> > 
> > yes, the first userspace process failes here:
> > 
> > void userspace(struct uml_pt_regs *regs)
> > {
> >         int err, status, op, pid = userspace_pid[0];
> >         /* To prevent races if using_sysemu changes under us.*/
> >         int local_using_sysemu;
> >         siginfo_t si;
> > 
> >         /* Handle any immediate reschedules or signals */
> >         interrupt_end();
> > 
> >         while (1) {
> > 
> >                 /*
> >                  * This can legitimately fail if the process loads
> > a
> >                  * bogus value into a segment register.  It will
> >                  * segfault and PTRACE_GETREGS will read that value
> >                  * out of the process.  However, PTRACE_SETREGS
> > will
> >                  * fail.  In this case, there is nothing to do but
> >                  * just kill the process.
> >                  */
> >                 if (ptrace(PTRACE_SETREGS, pid, 0, regs->gp))
> >                         fatal_sigsegv();
> > 
> >                 if (put_fp_registers(pid, regs->fp))
> > ->                        fatal_sigsegv();
> > 
> > the put_fp_registers fails with errno 4 if I recall correctly.
> > 
> > I didn't investigate yet further, why the the xstate ptrace call
> > fails.
> 
> Which of the branches is put_fp_registers() taking?

#0  restore_fp_registers (pid=2226, fp_regs=0xafcbf738) at arch/x86/um/os-Linux/registers.c:57
#1  0x0000000060084c80 in put_fp_registers (pid=<optimized out>, regs=<optimized out>) at arch/x86/um/os-Linux/registers.c:124
#2  0x00000000600814e1 in userspace (regs=0xafcbf660) at arch/um/os-Linux/skas/process.c:329
#3  0x0000000060070fc1 in new_thread_handler () at arch/um/kernel/process.c:134
#4  0x0000000000000000 in ?? ()

>  The restore_fpx_registers() or restore_fp_registers()?

> 4 would be EINTR...
Yes, strange, indeed.

> What kernel version is used on your host running the UML binary?

It's a VirtualBox with Fedora 25 and "Linux localhost.localdomain 4.10.15-200.fc25.x86_64 #1 SMP Mon May 8 18:46:06 UTC 2017 x86_64 x86_64 x86_64 GNU/Linux"

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 142
model name	: Intel(R) Core(TM) i7-7500U CPU @ 2.70GHz
stepping	: 9
cpu MHz		: 2904.002
cache size	: 4096 KB
physical id	: 0
siblings	: 2
core id		: 0
cpu cores	: 2
apicid		: 0
initial apicid	: 0
fpu		: yes
fpu_exception	: yes
cpuid level	: 22
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr
pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx rdtscp
lm constant_tsc rep_good nopl xtopology nonstop_tsc pni pclmulqdq ssse3
cx16 sse4_1 sse4_2 x2apic movbe popcnt aes xsave avx rdrand hypervisor
lahf_lm abm 3dnowprefetch rdseed clflushopt
bugs		:
bogomips	: 5808.00
clflush size	: 64
cache_alignment	: 64
address sizes	: 39 bits physical, 48 bits virtual
power management:

I see this in the kernel log:

[    0.000000] ------------[ cut here ]------------
[    0.000000] WARNING: CPU: 0 PID: 0 at arch/x86/kernel/fpu/xstate.c:595 fpu__init_system_xstate+0x4d0/0x877
[    0.000000] XSAVE consistency problem, dumping leaves
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 4.10.15-200.fc25.x86_64 #1
[    0.000000] Call Trace:
[    0.000000]  dump_stack+0x63/0x86
[    0.000000]  __warn+0xcb/0xf0
[    0.000000]  warn_slowpath_fmt+0x5f/0x80
[    0.000000]  ? xfeature_size+0x5a/0x78
[    0.000000]  fpu__init_system_xstate+0x4d0/0x877
[    0.000000]  ? msr_clear_bit+0x3a/0xa0
[    0.000000]  ? 0xffffffffa3000000
[    0.000000]  fpu__init_system+0x194/0x1be
[    0.000000]  early_cpu_init+0xf7/0xf9
[    0.000000]  setup_arch+0xba/0xcf0
[    0.000000]  ? printk+0x57/0x73
[    0.000000]  ? early_idt_handler_array+0x120/0x120
[    0.000000]  start_kernel+0xb2/0x48a
[    0.000000]  ? early_idt_handler_array+0x120/0x120
[    0.000000]  x86_64_start_reservations+0x24/0x26
[    0.000000]  x86_64_start_kernel+0x14d/0x170
[    0.000000]  start_cpu+0x14/0x14
[    0.000000] ---[ end trace d5213d72358dda94 ]---
[    0.000000] CPUID[0d, 00]: eax=00000007 ebx=00000440 ecx=00000440 edx=00000000

[...]

[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: Enabled xstate features 0x7, context size is 1088 bytes, using 'standard' format.

UML kernel is:
v4.12-rc3-69-g9ea15a5

CONFIG_UML_X86=y
CONFIG_64BIT=y
# CONFIG_X86_32 is not set
CONFIG_X86_64=y

> Thanks

