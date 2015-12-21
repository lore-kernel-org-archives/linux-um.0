Return-Path: <linux-kernel-owner@vger.kernel.org>
References: <1450656209-2676-1-git-send-email-mic@digikod.net>
 <1450656209-2676-2-git-send-email-mic@digikod.net> <567745E3.1030509@nod.at>
 <5677BD23.4060602@digikod.net> <5677BFBD.3090200@nod.at>
From: =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <5677C526.5070803@digikod.net>
Date: Mon, 21 Dec 2015 10:23:50 +0100
MIME-Version: 1.0
In-Reply-To: <5677BFBD.3090200@nod.at>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="4D5nbhGxWpCLo44TQCPe2lxCqdhclsRDj"
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH v1 1/4] um: Fix ptrace GETREGS/SETREGS bugs
To: Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>, Jeff Dike <jdike@addtoit.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Kees Cook <keescook@chromium.org>, Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, Shuah Khan <shuahkh@osg.samsung.com>, Chris Metcalf <cmetcalf@ezchip.com>, Michael Ellerman <mpe@ellerman.id.au>, Andrew Morton <akpm@linux-foundation.org>, James Hogan <james.hogan@imgtec.com>, Thomas Meyer <thomas@m3y3r.de>, Nicolas Iooss <nicolas.iooss_linux@m4x.org>, Anton Ivanov <aivanov@brocade.com>, linux-doc@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, linux-api@vger.kernel.org, Meredydd Luff <meredydd@senatehouse.org>, David Drysdale <drysdale@google.com>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4D5nbhGxWpCLo44TQCPe2lxCqdhclsRDj
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


On 21/12/2015 10:00, Richard Weinberger wrote:
> [sending the mail again, Thunderbird crashed :-\]
>=20
> Am 21.12.2015 um 09:49 schrieb Micka=C3=ABl Sala=C3=BCn:
>>
>> On 21/12/2015 01:20, Richard Weinberger wrote:
>>> Am 21.12.2015 um 01:03 schrieb Micka=C3=ABl Sala=C3=BCn:
>>>> diff --git a/arch/um/kernel/skas/syscall.c b/arch/um/kernel/skas/sys=
call.c
>>>> index 1683b8e..65f0d1a 100644
>>>> --- a/arch/um/kernel/skas/syscall.c
>>>> +++ b/arch/um/kernel/skas/syscall.c
>>>> @@ -7,6 +7,7 @@
>>>>  #include <linux/ptrace.h>
>>>>  #include <kern_util.h>
>>>>  #include <sysdep/ptrace.h>
>>>> +#include <sysdep/ptrace_user.h>
>>>>  #include <sysdep/syscalls.h>
>>>>  #include <os.h>
>>>> =20
>>>> @@ -16,12 +17,16 @@ void handle_syscall(struct uml_pt_regs *r)
>>>>  	long result;
>>>>  	int syscall;
>>>> =20
>>>> +	/* Save the syscall register. */
>>>> +	UPT_SYSCALL_NR(r) =3D PT_SYSCALL_NR(r->gp);
>>>> +
>>>>  	if (syscall_trace_enter(regs)) {
>>>>  		result =3D -ENOSYS;
>>>>  		goto out;
>>>>  	}
>>>> =20
>>>> -	syscall =3D get_syscall(r);
>>>> +	/* Get the syscall after being potentially updated with ptrace. */=

>>>> +	syscall =3D UPT_SYSCALL_NR(r);
>>>
>>> Doesn't this break the support for changing syscall numbers using PTR=
ACE_SETREGS?
>>
>> The logic is unchanged except updating the UPT_SYSCALL_NR before sysca=
ll_trace_enter(). I did my last tests with the x86_32 subarchitecture and=
 all tests (from selftest/seccomp), including PTRACE_SETREGS for syscall =
numbers tests, passed. However, 2 of this tests still fail for x86_64 (on=
ly).
>=20
> No, the logic is different.
> syscall_trace_enter(regs) enters the ptrace() path and here registers c=
an be changed.
> Hence "syscall =3D UPT_SYSCALL_NR(r);" will see the old syscall number.=

> UPT_SYSCALL_NR() returns the syscall number before the ptrace() path...=


The thing is, PTRACE_SETREGS give access to *orig_ax* in the user_regs_st=
ruct from arch/x86/include/asm/user_*.h and selftest/seccomp only update =
this (virtual) register, not the EAX/RAX. Am I missing something?

 Micka=C3=ABl


--4D5nbhGxWpCLo44TQCPe2lxCqdhclsRDj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJWd8UnAAoJECLe/t9zvWqV4scIAJVJe6FwebC//iEIFe4Kc7hZ
YpXJyMIzjfdALnwqrXZwHaNvT2PtUCTTv9/Us4g/tPm3zNNO0OMl5bWsV7E4UbxV
q084cdNUa9y882fXn6jfLDvO2sA7Z+nh/F7yXqLbRmOmSbR3GmpwmXgjvttEmEIX
gY4Z/CTDY5vPBckArQkg0ikMKQBiNJobi+PNgIsMwfRzdgVzxggd5w/p7Sv1mOTk
/J99QI/SOxt16GcWMhb2RaeM9lAQPiwm1u1qaauIzlaj3G8HXpNX9OBgCiV/fDeI
rsgWSlWIWpqguutExkEq0GOcDPGwteq7Zq8SNtBWX+rJ66z4ey9RHTZP+aM7Jnk=
=Bcug
-----END PGP SIGNATURE-----

--4D5nbhGxWpCLo44TQCPe2lxCqdhclsRDj--
