Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <1496525157.10119.3.camel@m3y3r.de>
Subject: Re: [PATCH v2] um: Avoid longjmp/setjmp symbol clashes with
 libpthread.a
From: Thomas Meyer <thomas@m3y3r.de>
Date: Sat, 03 Jun 2017 23:25:57 +0200
In-Reply-To: <0effc7cf-7a86-bed6-58cf-d8fd6d3febd6@nod.at>
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
         <0effc7cf-7a86-bed6-58cf-d8fd6d3febd6@nod.at>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Weinberger <richard@nod.at>, Florian Fainelli <f.fainelli@gmail.com>, linux-kernel@vger.kernel.org
Cc: Jeff Dike <jdike@addtoit.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, "open list:USER-MODE LINUX (UML)" <user-mode-linux-devel@lists.sourceforge.net>, "open list:USER-MODE LINUX (UML)" <user-mode-linux-user@lists.sourceforge.net>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Am Freitag, den 02.06.2017, 09:38 +0200 schrieb Richard Weinberger:
> Thomas,
> 
> Am 02.06.2017 um 07:49 schrieb Florian Fainelli:
> > > the put_fp_registers fails with errno 4 if I recall correctly.
> > > 
> > > I didn't investigate yet further, why the the xstate ptrace call
> > > fails.
> > 
> > Which of the branches is put_fp_registers() taking? The
> > restore_fpx_registers() or restore_fp_registers()? 4 would be
> > EINTR...
> > What kernel version is used on your host running the UML binary?
> 
> Another question, is this x86_64 UML on a x86_64 host?
yes,

and strace shows this:

ptrace(PTRACE_CONT, 21664, NULL, SIG_0) = 0
--- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_TRAPPED, si_pid=21664, si_uid=1000, si_status=SIGTRAP, si_utime=0, si_stime=0} ---
wait4(21664, [{WIFSTOPPED(s) && WSTOPSIG(s) == SIGTRAP}], WSTOPPED|__WALL, NULL) = 21664
ptrace(PTRACE_SETREGS, 21664, NULL, 0x60f7fa20) = 0
ptrace(PTRACE_CONT, 21664, NULL, SIG_0) = 0
--- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_TRAPPED, si_pid=21664, si_uid=1000, si_status=SIGTRAP, si_utime=0, si_stime=0} ---
wait4(21664, [{WIFSTOPPED(s) && WSTOPSIG(s) == SIGTRAP}], WSTOPPED|__WALL, NULL) = 21664
ptrace(PTRACE_SETREGS, 21664, NULL, 0xb18bc4e0) = 0 
ptrace(PTRACE_SETREGSET, 21664, NT_X86_XSTATE, [{iov_base=0xb18bc5b8, iov_len=832}]) = -1 EFAULT (Bad address)
ioctl(1, TCGETS, {B38400 -opost -isig -icanon -echo ...}) = 0

don't know why gdb shows errno as 4...

> Or i386 on x86_64, i386 on i386?
> 
> Thanks,
> //richard

