Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BqFff-0003iI-HF for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 29 Jul 2004 11:30:27 -0700
Received: from w218.z064002068.nyc-ny.dsl.cnc.net ([64.2.68.218])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.34)
	id 1BqFfe-0004TE-TM for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 29 Jul 2004 11:30:27 -0700
From: Allen Chan <alydar@users.sourceforge.net>
References: <200407280315.08207.alydar@users.sourceforge.net>
	<200407281722.i6SHM6eh002963@ccure.user-mode-linux.org>
In-Reply-To: <200407281722.i6SHM6eh002963@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407291430.18818.alydar@users.sourceforge.net>
Subject: [uml-devel] Re: Bug#260111: user-mode-linux: upgrade hangs at "NET4:
	Linux TCP/IP 1.0 for NET4.0 "
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
Date: Thu, 29 Jul 2004 14:30:16 -0400
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>, 260111@bugs.debian.org

I had no luck trying to get a better backtrace.  However, since this 
problem only showed up between 2.4.26-1um and 2.4.26-2um, I 
systematically backed out the CVS changes until the problem went 
away.

It turns out that the following changes caused the problem to show up:

arch/um/drivers/chan_kern.c 1.39 Fri 07-16-2004 02:27 PM EDT jdike Exp 
+65 -0
  Moved some non-userspace code from chan_user.c to chan_kern.c.
arch/um/drivers/chan_user.c 1.33 Fri 07-16-2004 02:27 PM EDT jdike Exp 
+0 -64
  Moved some non-userspace code from chan_user.c to chan_kern.c.

I cannot explain why simply moving a few functions from one file to 
another will have any real effect on the resulting kernel, but my 
2.4.26-2um guest kernel is now running fine without these changes.


On Wednesday 28 July 2004 01:22 pm, Jeff Dike wrote:
> alydar@users.sourceforge.net said:
> > #2  0xa014f091 in cpu_idle () at process_kern.c:212
> > #3  0xa000f635 in rest_init () at init/main.c:364
> > #4  0xa00025e6 in start_kernel () at init/main.c:458
>
> This is the problem stack.  One of the init functions is tripping
> over a semaphore, and no one has been able to tell me which init
> function it is or which semaphore.  Although the down isn't showing
> in this stack, which is a bit confusing.
>
> 				Jeff
>


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
