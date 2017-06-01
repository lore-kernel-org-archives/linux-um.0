Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <1496352322.9072.1.camel@m3y3r.de>
Subject: Re: [PATCH v2] um: Avoid longjmp/setjmp symbol clashes with
 libpthread.a
From: Thomas Meyer <thomas@m3y3r.de>
Date: Thu, 01 Jun 2017 23:25:22 +0200
In-Reply-To: <e53ebfee-0b8a-0fe6-c2d3-eb6fb4aa9e2c@nod.at>
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
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Weinberger <richard@nod.at>, Florian Fainelli <f.fainelli@gmail.com>, linux-kernel@vger.kernel.org
Cc: Jeff Dike <jdike@addtoit.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, "open list:USER-MODE LINUX (UML)" <user-mode-linux-devel@lists.sourceforge.net>, "open list:USER-MODE LINUX (UML)" <user-mode-linux-user@lists.sourceforge.net>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Am Donnerstag, den 01.06.2017, 22:58 +0200 schrieb Richard Weinberger:
> 
> Sorry, I thought you are CC'ed.
> Thomas please speak up. AFAIR UML fails to boot on one of your new
> Laptops.

Hi,

yes, the first userspace process failes here:

void userspace(struct uml_pt_regs *regs)
{
        int err, status, op, pid = userspace_pid[0];
        /* To prevent races if using_sysemu changes under us.*/
        int local_using_sysemu;
        siginfo_t si;

        /* Handle any immediate reschedules or signals */
        interrupt_end();

        while (1) {

                /*
                 * This can legitimately fail if the process loads a
                 * bogus value into a segment register.  It will
                 * segfault and PTRACE_GETREGS will read that value
                 * out of the process.  However, PTRACE_SETREGS will
                 * fail.  In this case, there is nothing to do but
                 * just kill the process.
                 */
                if (ptrace(PTRACE_SETREGS, pid, 0, regs->gp))
                        fatal_sigsegv();

                if (put_fp_registers(pid, regs->fp))
->                        fatal_sigsegv();

the put_fp_registers fails with errno 4 if I recall correctly.

I didn't investigate yet further, why the the xstate ptrace call fails.

kind regards
thomas


> Thanks,
> //richard

