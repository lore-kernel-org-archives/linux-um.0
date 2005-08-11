Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E3Dp0-00043M-5t	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 11 Aug 2005 07:14:14 -0700
Received: from ns.theshore.net ([67.18.92.50] helo=www.theshore.net)
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1E3Doy-0002I9-Ot
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 11 Aug 2005 07:14:14 -0700
Message-ID: <42FB5D26.5020703@theshore.net>
From: "Christopher S. Aker" <caker@theshore.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Possible SKAS3 >= v8 bug
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
Date: Thu, 11 Aug 2005 09:13:58 -0500
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Blaisorblade <blaisorblade@yahoo.it>, Jeff Dike <jdike@addtoit.com>

For many months now, I've been dealing with host machine instability. 
Essentially, I'm rebooting at least one host a week (see 
http://www.linode.com/forums/viewforum.php?f=25 for details).  The 
affected machines are all running a kernel patched with skas3 at least 
version 8.  Only my more recent boxes seem to be affected by this bug, 
however the only difference between the boxes that crash and the ones 
that don't are processor speed (faster ones crash).  Identical hardware, 
otherwise.  Slower boxes running the identical kernel have great uptimes 
(> 120 days).  Boxes running skas3 v7 or less have uptimes of over 400 
days (!).

Yesterday another box crashed.  Due to my crappy remote console unit 
requiring me to be connected at the time of a panic to actually capture 
it, I had my datacenter plug in a monitor and write down by hand some of 
the panic output.  There's not much here, but this is what they provided me:

<quote>
(hoangvo-08/10/2005 10:28:22):
Your server has been rebooted and verified to respond to SSH requests. 
The error messages I recorded from the console are as follows:

========================================
EFLAGS: 00010292 (2.6.11.11-1-bigmem)
EIP is at 0x0
========================================

I skipped over the information here as I did not feel it would be useful 
to you. This is more useful, however:

========================================
Call Trace
[<c0106fd7>] do_syscall_trace+0x97/0x10e
[<c0104934>] math_state_restore+0x24/0x40
[<c0102639>] syscall_trace_entry_+0x11/0x2a

Code: Bad EIP value.
</quote>

Source tree and vmlinux file:
http://www.theshore.net/~caker/uml/2.6.11.11-1-bigmem.tar.bz2 (38M)
http://www.theshore.net/~caker/uml/vmlinux.bz2 (2M)

Built source tree:
http://www.theshore.net/~caker/uml/2.6.11.11-1-bigmem.tar.gz (77M)

Jeff took a look at this yesterday, but I didn't really expect him to 
get very far with such little information.  I just wanted to get this 
out into the open in case anyone else has experienced something similar. 
  Next host that panics, I'll make sure that the datacenter copies down 
the entire panic output.

-Chris


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
