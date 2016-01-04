Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1451421347-9468-1-git-send-email-mic@digikod.net>
References: <1451421347-9468-1-git-send-email-mic@digikod.net>
Date: Mon, 4 Jan 2016 12:13:39 -0800
Message-ID: <CAGXu5jLsEzacZ23Gw2moTdomvDc4ZRHieu_Yi=qpf1NHb2EXzA@mail.gmail.com>
From: Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH v3 0/4] um: Add seccomp support
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>, Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, Shuah Khan <shuahkh@osg.samsung.com>, Chris Metcalf <cmetcalf@ezchip.com>, Michael Ellerman <mpe@ellerman.id.au>, Andrew Morton <akpm@linux-foundation.org>, James Hogan <james.hogan@imgtec.com>, Thomas Meyer <thomas@m3y3r.de>, Nicolas Iooss <nicolas.iooss_linux@m4x.org>, Anton Ivanov <aivanov@brocade.com>, user-mode-linux-devel@lists.sourceforge.net, Meredydd Luff <meredydd@senatehouse.org>, David Drysdale <drysdale@google.com>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Tue, Dec 29, 2015 at 12:35 PM, Micka=C3=ABl Sala=C3=BCn <mic@digikod=
=2Enet> wrote:
> This series add seccomp support to User-mode Linux (i386 and x86_64
> subarchitectures) and fix ptrace issues. This apply on v4.4-rc7 and p=
ass all
> the 48 tests from selftest/seccomp plus the UML ptsc test.
>
> Changes since v2:
> * remove get_syscall() from os.h and don't include it in syscall.c [1=
/4]
> * rebase to v4.4-rc7
>
> Changes since v1; addressed Richard Weinberger's comments:
> * fix a new PTRACE_SETREGS bug on x86_64 [1/4]
> * fix an old PTRACE_SETREGS bug when updating orig_ax on i386 [1/4]

Thanks for working on this!

Acked-by: Kees Cook <keescook@chromium.org>

=46eel free to pull this through the uml tree.

Thanks!

-Kees

>
> Regards,
>  Micka=C3=ABl
>
> Micka=C3=ABl Sala=C3=BCn (4):
>   um: Fix ptrace GETREGS/SETREGS bugs
>   selftests/seccomp: Remove the need for HAVE_ARCH_TRACEHOOK
>   um: Add full asm/syscall.h support
>   um: Add seccomp support
>
>  .../seccomp/seccomp-filter/arch-support.txt        |   2 +-
>  arch/um/Kconfig.common                             |   1 +
>  arch/um/Kconfig.um                                 |  16 +++
>  arch/um/include/asm/syscall-generic.h              | 138 +++++++++++=
++++++++++
>  arch/um/include/asm/thread_info.h                  |   2 +
>  arch/um/include/shared/os.h                        |   1 -
>  arch/um/kernel/skas/syscall.c                      |  31 +++--
>  arch/um/os-Linux/skas/process.c                    |   7 --
>  arch/x86/um/asm/syscall.h                          |   1 +
>  arch/x86/um/ptrace_32.c                            |   8 +-
>  tools/testing/selftests/seccomp/seccomp_bpf.c      |  27 +++-
>  11 files changed, 205 insertions(+), 29 deletions(-)
>  create mode 100644 arch/um/include/asm/syscall-generic.h
>
> --
> 2.6.4
>



--=20
Kees Cook
Chrome OS & Brillo Security
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

