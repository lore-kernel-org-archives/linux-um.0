Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-list2-b.sourceforge.net ([10.3.1.8]
	helo=sc8-sf-list2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bs5fY-0003ow-HT for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 03 Aug 2004 13:13:56 -0700
Message-ID: <410FF1C3.9060509@enterasys.com>
From: "D. Bahi" <dbahi@enterasys.com>
MIME-Version: 1.0
Subject: Re: [Valgrind-users] Re: [uml-devel] Re: UML and valgrind
References: <C28780ABC637504896EB86B4FB75FFBFA26E5E@MAANDMBX1.ets.enterasys.com>
	<410EFCDB.8080404@enterasys.com>
	<200408030517.i735HZUE026250@ccure.user-mode-linux.org>
	<Pine.LNX.4.60.0408031028541.22157@hermes-1.csi.cam.ac.uk>
	<200408031450.i73EoEvv002040@ccure.user-mode-linux.org>
	<Pine.LNX.4.60.0408031527320.22157@hermes-1.csi.cam.ac.uk>
	<200408031750.i73HoMvv002966@ccure.user-mode-linux.org>
	<410FCC70.1050902@enterasys.com>
	<200408031931.i73JVkvv003367@ccure.user-mode-linux.org>
In-Reply-To: <200408031931.i73JVkvv003367@ccure.user-mode-linux.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig49C6DFD94F2F78D25973C4E0"
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
Date: Tue, 03 Aug 2004 16:12:51 -0400
To: Jeff Dike <jdike@addtoit.com>
Cc: Nicholas Nethercote <njn25@cam.ac.uk>, user-mode-linux-devel@lists.sourceforge.net, valgrind-users@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig49C6DFD94F2F78D25973C4E0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

trying to find a way to wedge the old patch into
the new code... i don't think it applies anymore.

alright, i don't read assembly (head hung low) but
valgrind 2.1.2/coregrind/vg_syscall.S has something
that makes me ask why i'm getting the 'clone() not
supported message'

does this need some kind of tie-in code in vg_syscalls.c?

.globl VG_(clone)
VG_(clone):
#define FSZ	(4+4+4)			/* frame size = retaddr+ebx+edi */
	push	%ebx
	push	%edi
	/* set up child stack with function and arg */
	movl	 4+FSZ(%esp), %ecx	/* child stack */
	movl	12+FSZ(%esp), %ebx	/* fn arg */
	movl	 0+FSZ(%esp), %eax	/* fn */
	lea	-8(%ecx), %ecx		/* make space on stack */
	movl	%ebx, 4(%ecx)		/*   fn arg */
	movl	%eax, 0(%ecx)		/*   fn */

	/* get other args to clone */
	movl	 8+FSZ(%esp), %ebx	/* flags */
	movl	20+FSZ(%esp), %edx	/* parent tid * */
	movl	16+FSZ(%esp), %edi	/* child tid * */
	movl	$__NR_clone, %eax
	int	$0x80
	testl	%eax, %eax
	jnz	1f

	/* CHILD - call thread function */
	popl	%eax
	call	*%eax

	/* exit with result */
	movl	%eax, %ebx
	movl	$__NR_exit, %eax
	int	$0x80

	/* Hm, exit returned */
	ud2
		
1:	/* PARENT or ERROR */
	pop	%edi
	pop	%ebx
	ret


Jeff Dike wrote:

> dbahi@enterasys.com said:
> 
>>ugh, so close - it bails - stopped by clone() !?!!?? : 
> 
> 
> OK, there were a bunch of problems that were fixed when me, Jeremy, and Julian
> were working on this.  The clone one seems to have not made it.  I've lost the
> patches I had, but I dug this out of a piece of email.  It applies to 
> coregrind/vg_syscalls.c:
> 
> 
>>@@ -39,6 +40,10 @@
>> # code which copies from baseBlock before the call, into
>> # m_state_static, and back afterwards.
>> 
>>+.section .data
>>+save_ip:
>>+        .long   0
>>+
>> VG_(do_syscall):
>>        # Save all the int registers of the real machines state on the
>>        # simulators stack.
>>@@ -80,10 +85,27 @@
>>        movl    VG_(m_state_static)+48, %esi
>>        movl    VG_(m_state_static)+52, %edi
>> 
>>+       cmpl    $__NR_clone, %eax
>>+       jne     not_clone
>>+
>>+       pushl   %eax
>>+       movl    VG_(m_state_static)+60, %eax
>>+       movl    %eax, save_ip
>>+       popl    %eax
>>+
>>+       int     $0x80
>>+
>>+       cmpl    $0, %eax
>>+       jne     parent_finish
>>+
>>+       jmp     *save_ip
>>+
>>+not_clone:
>>        # esp now refers to the simulatees stack
>>        # Do the actual system call
>>        int     $0x80
> 
> 
> It handles the clone by calling clone itself, creating a new valgrind thread
> which will go on grinding the new UML thread.
> 
> Also, I saw this:
> 
> 
>>	valgrind: the `impossible' happened:
>>	   Unhandled REPE case
> 
> 
> If you see this, check that you have
> 	http://www.goop.org/~jeremy/valgrind/76-repe-scas.patch
> and apply if not.
> 
> 				Jeff
> 

-- 
There are two kinds of people in this world: Those that enter a room and 
turn the television set on, and those that enter a room and turn the 
television set off. -- Raymond Shaw, The Manchurian Candidate (1962).

--------------enig49C6DFD94F2F78D25973C4E0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (MingW32)

iD8DBQFBD/HH3XQ4zakZ3z4RAteaAJ0cedoQbvshrhloLEg+fabIDPW7ygCdEihs
JnMm7WxqK0AaRMy/RYAy1Vw=
=De/g
-----END PGP SIGNATURE-----

--------------enig49C6DFD94F2F78D25973C4E0--


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
