Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v3 0/4] um: Add seccomp support
References: <1451421347-9468-1-git-send-email-mic@digikod.net>
From: Richard Weinberger <richard@nod.at>
Message-ID: <5692BC92.1010605@nod.at>
Date: Sun, 10 Jan 2016 21:18:26 +0100
MIME-Version: 1.0
In-Reply-To: <1451421347-9468-1-git-send-email-mic@digikod.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>, linux-kernel@vger.kernel.org
Cc: Jeff Dike <jdike@addtoit.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Kees Cook <keescook@chromium.org>, Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, Shuah Khan <shuahkh@osg.samsung.com>, Chris Metcalf <cmetcalf@ezchip.com>, Michael Ellerman <mpe@ellerman.id.au>, Andrew Morton <akpm@linux-foundation.org>, James Hogan <james.hogan@imgtec.com>, Thomas Meyer <thomas@m3y3r.de>, Nicolas Iooss <nicolas.iooss_linux@m4x.org>, Anton Ivanov <aivanov@brocade.com>, user-mode-linux-devel@lists.sourceforge.net, Meredydd Luff <meredydd@senatehouse.org>, David Drysdale <drysdale@google.com>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Am 29.12.2015 um 21:35 schrieb Mickaël Salaün:
> This series add seccomp support to User-mode Linux (i386 and x86_64
> subarchitectures) and fix ptrace issues. This apply on v4.4-rc7 and pass all
> the 48 tests from selftest/seccomp plus the UML ptsc test.
> 
> Changes since v2:
> * remove get_syscall() from os.h and don't include it in syscall.c [1/4]
> * rebase to v4.4-rc7
> 
> Changes since v1; addressed Richard Weinberger's comments:
> * fix a new PTRACE_SETREGS bug on x86_64 [1/4]
> * fix an old PTRACE_SETREGS bug when updating orig_ax on i386 [1/4]
> 
> Regards,
>  Mickaël
> 
> Mickaël Salaün (4):
>   um: Fix ptrace GETREGS/SETREGS bugs
>   selftests/seccomp: Remove the need for HAVE_ARCH_TRACEHOOK
>   um: Add full asm/syscall.h support
>   um: Add seccomp support

Applied!

Thanks,
//richard

