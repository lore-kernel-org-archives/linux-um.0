Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DY6JQ-0000oF-LB	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 17 May 2005 10:57:00 -0700
Received: from rproxy.gmail.com ([64.233.170.199])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DY6JN-00044b-6t	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 17 May 2005 10:57:00 -0700
Received: by rproxy.gmail.com with SMTP id j1so1203451rnf
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 17 May 2005 10:56:55 -0700 (PDT)
Message-ID: <3524bf1f050517105676c6c051@mail.gmail.com>
From: Young Koh <young.koh@gmail.com>
Reply-To: Young Koh <young.koh@gmail.com>
Subject: Re: [uml-devel] Explaination of system call function flow in TT mode
In-Reply-To: <200505170217.23138.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
References: <003e01c503b3$f3e46cb0$ac655e0a@sha.st.com>
	 <200505162324.37749.blaisorblade@yahoo.it>
	 <3524bf1f0505161709476c4940@mail.gmail.com>
	 <200505170217.23138.blaisorblade@yahoo.it>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Tue, 17 May 2005 13:56:55 -0400
Content-Transfer-Encoding: quoted-printable
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

Well, i got another question/suggestion.=20

the tracer (UML kernel) saves and restores the tracee's registers
using ptrace() in order to get syscall paramaters and save the return
value. while doing this, the tracer would need to care about only six
registers(eax, ebx, ecx, edx, esi, and edi) used for the syscall
parameter passing. I think, the tracer doesn't have to save all the
registers of the tracee, because the tracer will execute the syscall
for the tracee and the context of tracee will not be affected.

but, in arch/um/kernel/skas/process.c, move_registers() function gets
and sets even floating point registers, which i don't think will be
affected by the system call execution.
i tested and ran a UML kernel with the second ptrace() (used for
floating point registers) commented out, it seems to work. (probably
only for SKAS mode)

what do you think?

Thanks,

static int move_registers(int pid, int int_op, int fp_op,=20
			  union uml_pt_regs *regs, unsigned long *fp_regs)
{
	if(ptrace(int_op, pid, 0, regs->skas.regs) < 0)
		return(-errno);
#if 0 // for test
	if(ptrace(fp_op, pid, 0, fp_regs) < 0)
		return(-errno);
#endif
	return(0);
}

On 5/16/05, Blaisorblade <blaisorblade@yahoo.it> wrote:
> On Tuesday 17 May 2005 02:09, Young Koh wrote:
> > Ok, now i'm getting close. Thanks a lot!!!
> > but i have two more :)
> >
> > 1) in SKAS mode, the tracer (UML kernel) will execute a system call
> > for the tracee (the user process). But what if the system call blocks?
> > then, the tracer, the UML kernel, will be blocked, too, right? it
> > means the whole UML system will be blocked?
> Good question. However the tracee is one of the threads running inside UM=
L,
> i.e. switch_to_skas switches between the different tracees. However, that=
's
> done only on timer interrupts, and possibly those interrupts are blocked =
by
> the syscall execution.
>=20
> Indeed, I remember that when the UBD I/O is run by the UML kernel and not=
 by a
> separate thread (this has been removed) the whole system becomes *really*
> slow, so probably the answer to your question is "Yes, but UML tries to a=
void
> this".
>=20
> > 2) in TT mode, what if the user process (tracee) installs its own
> > signal handler for SIGUSR2?
> The syscall is intercepted so it can't install signal handlers; the one it
> installs are handled inside the UML kernel.
> --
> Paolo Giarrusso, aka Blaisorblade
> Skype user "PaoloGiarrusso"
> Linux registered user n. 292729
> http://www.user-mode-linux.org/~blaisorblade
>=20
>


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_idt12&alloc_id=16344&op=CCk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
