Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v2] um: Avoid longjmp/setjmp symbol clashes with
 libpthread.a
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
 <1496390649.2047.2.camel@m3y3r.de>
From: Richard Weinberger <richard@nod.at>
Message-ID: <f85d278d-0f10-163a-c289-a66254a1670c@nod.at>
Date: Fri, 2 Jun 2017 10:30:55 +0200
MIME-Version: 1.0
In-Reply-To: <1496390649.2047.2.camel@m3y3r.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Meyer <thomas@m3y3r.de>, Florian Fainelli <f.fainelli@gmail.com>, linux-kernel@vger.kernel.org
Cc: Jeff Dike <jdike@addtoit.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, "open list:USER-MODE LINUX (UML)" <user-mode-linux-devel@lists.sourceforge.net>, "open list:USER-MODE LINUX (UML)" <user-mode-linux-user@lists.sourceforge.net>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Thomas,

Am 02.06.2017 um 10:04 schrieb Thomas Meyer:
> Am Donnerstag, den 01.06.2017, 22:49 -0700 schrieb Florian Fainelli:
> I see this in the kernel log:
> 
> [    0.000000] ------------[ cut here ]------------
> [    0.000000] WARNING: CPU: 0 PID: 0 at arch/x86/kernel/fpu/xstate.c:595 fpu__init_system_xstate+0x4d0/0x877
> [    0.000000] XSAVE consistency problem, dumping leaves
> [    0.000000] Modules linked in:
> [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 4.10.15-200.fc25.x86_64 #1
> [    0.000000] Call Trace:
> [    0.000000]  dump_stack+0x63/0x86
> [    0.000000]  __warn+0xcb/0xf0
> [    0.000000]  warn_slowpath_fmt+0x5f/0x80
> [    0.000000]  ? xfeature_size+0x5a/0x78
> [    0.000000]  fpu__init_system_xstate+0x4d0/0x877
> [    0.000000]  ? msr_clear_bit+0x3a/0xa0
> [    0.000000]  ? 0xffffffffa3000000
> [    0.000000]  fpu__init_system+0x194/0x1be
> [    0.000000]  early_cpu_init+0xf7/0xf9
> [    0.000000]  setup_arch+0xba/0xcf0
> [    0.000000]  ? printk+0x57/0x73
> [    0.000000]  ? early_idt_handler_array+0x120/0x120
> [    0.000000]  start_kernel+0xb2/0x48a
> [    0.000000]  ? early_idt_handler_array+0x120/0x120
> [    0.000000]  x86_64_start_reservations+0x24/0x26
> [    0.000000]  x86_64_start_kernel+0x14d/0x170
> [    0.000000]  start_cpu+0x14/0x14
> [    0.000000] ---[ end trace d5213d72358dda94 ]---
> [    0.000000] CPUID[0d, 00]: eax=00000007 ebx=00000440 ecx=00000440 edx=00000000

Does this also happen with a mainline kernel? Also on KVM or bare metal?
Not that UML fails because of this and we're hunting a ghost...

Thanks,
//richard


