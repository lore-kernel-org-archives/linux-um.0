Return-Path: <linux-kernel-owner@vger.kernel.org>
References: <1450656209-2676-1-git-send-email-mic@digikod.net>
 <1450656209-2676-2-git-send-email-mic@digikod.net>
From: Richard Weinberger <richard@nod.at>
Message-ID: <567745E3.1030509@nod.at>
Date: Mon, 21 Dec 2015 01:20:51 +0100
MIME-Version: 1.0
In-Reply-To: <1450656209-2676-2-git-send-email-mic@digikod.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH v1 1/4] um: Fix ptrace GETREGS/SETREGS bugs
To: =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>, linux-kernel@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>, Jeff Dike <jdike@addtoit.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Kees Cook <keescook@chromium.org>, Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, Shuah Khan <shuahkh@osg.samsung.com>, Chris Metcalf <cmetcalf@ezchip.com>, Michael Ellerman <mpe@ellerman.id.au>, Andrew Morton <akpm@linux-foundation.org>, James Hogan <james.hogan@imgtec.com>, Thomas Meyer <thomas@m3y3r.de>, Nicolas Iooss <nicolas.iooss_linux@m4x.org>, Anton Ivanov <aivanov@brocade.com>, linux-doc@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, linux-api@vger.kernel.org, Meredydd Luff <meredydd@senatehouse.org>, David Drysdale <drysdale@google.com>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Am 21.12.2015 um 01:03 schrieb Micka=C3=ABl Sala=C3=BCn:
> This fix two related bugs:
> * PTRACE_GETREGS doesn't get the right orig_ax (syscall) value
> * PTRACE_SETREGS can't set the orig_ax value (erased by initial value=
)
>=20
> Remove the now useless and error-prone get_syscall().
>=20
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> Cc: Jeff Dike <jdike@addtoit.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Andy Lutomirski <luto@amacapital.net>
> Cc: Will Drewry <wad@chromium.org>
> Cc: Thomas Meyer <thomas@m3y3r.de>
> Cc: Nicolas Iooss <nicolas.iooss_linux@m4x.org>
> Cc: Anton Ivanov <aivanov@brocade.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: user-mode-linux-devel@lists.sourceforge.net
> Cc: user-mode-linux-user@lists.sourceforge.net
> Cc: Meredydd Luff <meredydd@senatehouse.org>
> Cc: David Drysdale <drysdale@google.com>
> ---
>  arch/um/kernel/skas/syscall.c   | 7 ++++++-
>  arch/um/os-Linux/skas/process.c | 7 -------
>  2 files changed, 6 insertions(+), 8 deletions(-)
>=20
> diff --git a/arch/um/kernel/skas/syscall.c b/arch/um/kernel/skas/sysc=
all.c
> index 1683b8e..65f0d1a 100644
> --- a/arch/um/kernel/skas/syscall.c
> +++ b/arch/um/kernel/skas/syscall.c
> @@ -7,6 +7,7 @@
>  #include <linux/ptrace.h>
>  #include <kern_util.h>
>  #include <sysdep/ptrace.h>
> +#include <sysdep/ptrace_user.h>
>  #include <sysdep/syscalls.h>
>  #include <os.h>
> =20
> @@ -16,12 +17,16 @@ void handle_syscall(struct uml_pt_regs *r)
>  	long result;
>  	int syscall;
> =20
> +	/* Save the syscall register. */
> +	UPT_SYSCALL_NR(r) =3D PT_SYSCALL_NR(r->gp);
> +
>  	if (syscall_trace_enter(regs)) {
>  		result =3D -ENOSYS;
>  		goto out;
>  	}
> =20
> -	syscall =3D get_syscall(r);
> +	/* Get the syscall after being potentially updated with ptrace. */
> +	syscall =3D UPT_SYSCALL_NR(r);

Doesn't this break the support for changing syscall numbers using PTRAC=
E_SETREGS?

Thanks,
//richard
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

