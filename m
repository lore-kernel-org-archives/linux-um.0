Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AEevu-0006jf-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Tue, 28 Oct 2003 17:15:34 -0800
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.24)
	id 1AEepY-0000Yb-QL
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 28 Oct 2003 17:09:01 -0800
Received: from ccure.karaya.com (lakshmi.solana.com [127.0.0.1])
	by lakshmi.solana.com (8.11.2/8.9.3) with ESMTP id h9T0uvj05585
	for <user-mode-linux-devel@lists.sourceforge.net>; Tue, 28 Oct 2003 19:56:58 -0500
Message-Id: <200310290115.h9T1F3LJ003833@ccure.karaya.com>
Subject: Re: [uml-devel] Kernel Panic 
In-Reply-To: Your message of "Tue, 28 Oct 2003 23:02:44 +0100."
             <20031028230244.0382a7e2.ddflatrate@web.de> 
References: <20031028230244.0382a7e2.ddflatrate@web.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Tue, 28 Oct 2003 20:15:03 -0500
To: Torsten Boob <ddflatrate@web.de>
Cc: user-mode-linux-devel@lists.sourceforge.net

ddflatrate@web.de said:
> Kernel panic: Kernel mode fault at addr 0x28, ip 0xa003d050 

Well, 'i sym *0xa003d050' will tell you where the segfault happened, at
least.

> And then the whole UML goes down. No chance to make a backtrace,
> because gdb is killed too. 

Hummm, that seems bad.  Any more info on that?

One thing I do when gdb isn't useful, and I know where I want to stop, is
put a 'printk("something\n"); while(1) ;' there, and just run UML with no 
debugger.

When it stops:
	if you're using skas mode, just attach gdb to it
	if you're using tt mode, do the following

		kill -STOP the 'R' UML process
		kill -9 the tracing thread
		attach gdb to the -STOPped process

Either way, you've got your stack trace.

				Jeff



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
