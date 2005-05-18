Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DYOWv-0000Oo-IE	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 May 2005 06:24:09 -0700
Received: from rproxy.gmail.com ([64.233.170.207])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DYOWu-0003HX-4Z	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 May 2005 06:24:09 -0700
Received: by rproxy.gmail.com with SMTP id j1so101443rnf
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 18 May 2005 06:24:07 -0700 (PDT)
Message-ID: <3524bf1f050518062432e093d6@mail.gmail.com>
From: Young Koh <young.koh@gmail.com>
Reply-To: Young Koh <young.koh@gmail.com>
Subject: Re: [uml-devel] Explaination of system call function flow in TT mode
In-Reply-To: <428B0F2B.3060503@fujitsu-siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
References: <003e01c503b3$f3e46cb0$ac655e0a@sha.st.com>
	 <200505162324.37749.blaisorblade@yahoo.it>
	 <3524bf1f0505161709476c4940@mail.gmail.com>
	 <200505170217.23138.blaisorblade@yahoo.it>
	 <3524bf1f050517105676c6c051@mail.gmail.com>
	 <20050517220053.GA10144@ccure.user-mode-linux.org>
	 <428B0F2B.3060503@fujitsu-siemens.com>
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
Date: Wed, 18 May 2005 09:24:07 -0400
Content-Transfer-Encoding: quoted-printable
To: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Cc: Jeff Dike <jdike@addtoit.com>, Blaisorblade <blaisorblade@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net

> > Yeah, this is reasonable.  You have to be careful that you save and res=
tore
> > any registers that might be used by one of the stubs, but they don't use
> > FP.
> I also thought about not saving FP-regs on each kernel entry. But if you =
do
> this optimization, you need to save / restore FP-regs on switch_to. Also =
you
> need to get the FP-regs when setting up a signal-handler stackframe. And =
they
> have to be restored on sys_(rt_)sigreturn from the values found in the
> stackframe.
=20
Thanks for the replies. let me understand them. In a SKAS mode UML
kernel, the pseudo code of a system call invocation would be like the
following.

wait4(); // wait until a user process raises a syscall
save_registers(); // copy the user process' registers to UML kernel space
execute_syscall(); // execute the syscall in UML kernel context
restore_registers(); // copy the user registers back to the user process

but, during execute_syscall(), even if its stubs use all the registers
and/or it happens to invoke switch_to(), it will happen all in the UML
kernel's context. that means the user process's context will be
protected by host kernel's context switching mechanism. doesn't it?
because the host kernel will automatically save/restore a process'
registers when the process is stopped and resumed, all we care about
in the above routine should be to get system call parameters from the
tracee and save the return value to it. shouldn't it? (again, only for
SKAS)

Thanks a lot!



> As s390 can give me regs and FP-regs in one single ptrace call, I decided=
 to
> not do this optimization. Maybe for i386 and x86_64 it would be worth the=
 cost.
>=20
>        Bodo
> >
> >                               Jeff
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
