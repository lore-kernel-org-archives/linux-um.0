Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DYBRe-0006OJ-Vu	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 17 May 2005 16:25:50 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DYBRb-0001jl-B5	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 17 May 2005 16:25:50 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Explaination of system call function flow in TT mode
Message-ID: <20050517220053.GA10144@ccure.user-mode-linux.org>
References: <003e01c503b3$f3e46cb0$ac655e0a@sha.st.com>
	<200505162324.37749.blaisorblade@yahoo.it>
	<3524bf1f0505161709476c4940@mail.gmail.com>
	<200505170217.23138.blaisorblade@yahoo.it>
	<3524bf1f050517105676c6c051@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3524bf1f050517105676c6c051@mail.gmail.com>
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
Date: Tue, 17 May 2005 18:00:53 -0400
To: Young Koh <young.koh@gmail.com>
Cc: Blaisorblade <blaisorblade@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net

On Tue, May 17, 2005 at 01:56:55PM -0400, Young Koh wrote:
> the tracer (UML kernel) saves and restores the tracee's registers
> using ptrace() in order to get syscall paramaters and save the return
> value. while doing this, the tracer would need to care about only six
> registers(eax, ebx, ecx, edx, esi, and edi) used for the syscall
> parameter passing. I think, the tracer doesn't have to save all the
> registers of the tracee, because the tracer will execute the syscall
> for the tracee and the context of tracee will not be affected.

This is true, but it's easier to get all of the GP registers than it is to
selectively grab the syscall-related ones.

> but, in arch/um/kernel/skas/process.c, move_registers() function gets
> and sets even floating point registers, which i don't think will be
> affected by the system call execution.
> i tested and ran a UML kernel with the second ptrace() (used for
> floating point registers) commented out, it seems to work. (probably
> only for SKAS mode)

Yeah, this is reasonable.  You have to be careful that you save and restore
any registers that might be used by one of the stubs, but they don't use
FP.

				Jeff


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
