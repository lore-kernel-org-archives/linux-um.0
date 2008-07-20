Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KKZa4-0005nE-Ep for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 20 Jul 2008 07:08:08 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KKZa2-0001hw-U8
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 20 Jul 2008 07:08:08 -0700
Date: Sun, 20 Jul 2008 10:07:56 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080720140756.GA4577@c2.user-mode-linux.org>
References: <804dabb00807181222r2e80126fp75bf7bdd9c4cac73@mail.gmail.com>
	<20080718205532.GG13572@c2.user-mode-linux.org>
	<804dabb00807200215n32b5171do97d344f2f954c490@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <804dabb00807200215n32b5171do97d344f2f954c490@mail.gmail.com>
Subject: Re: [uml-devel] Kernel panic - not syncing: do_syscall_stub
	:	PTRACE_SETREGS failed, errno = 5
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Peter Teoh <htmldeveloper@gmail.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Sun, Jul 20, 2008 at 05:15:16PM +0800, Peter Teoh wrote:
> And ptrace_setregs() calling ptrace() seemed to returned -errno almost
> immediately:
> 
> (gdb) s
> ptrace_setregs (pid=19131, regs=0x820aae0) at
> /mnt/hd0/download/linux-2.6-latest/arch/um/sys-i386/ptrace_user.c:18
> 18              if (ptrace(PTRACE_SETREGS, pid, 0, regs) < 0)
> (gdb) s
> 19                      return -errno;
> (gdb) s
> 
> Why is it so?

Because the registers are all zero.

	    	      	  Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
