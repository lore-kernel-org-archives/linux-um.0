Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19vesb-0005TQ-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Sat, 06 Sep 2003 08:21:37 -0700
Received: from hermes.dur.ac.uk ([129.234.4.9])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19vesa-0004x4-K9
	for user-mode-linux-devel@lists.sourceforge.net; Sat, 06 Sep 2003 08:21:36 -0700
Received: from mercury.dur.ac.uk (mercury.dur.ac.uk [129.234.4.40])
	by hermes.dur.ac.uk (8.11.7/8.11.7) with ESMTP id h86FLKL10651
	for <user-mode-linux-devel@lists.sourceforge.net>; Sat, 6 Sep 2003 16:21:20 +0100 (BST)
Received: from altair.dur.ac.uk (altair.dur.ac.uk [129.234.4.14])
	by mercury.dur.ac.uk (8.12.9+Sun/8.11.7) with ESMTP id h86FLHw3007717
	for <user-mode-linux-devel@lists.sourceforge.net>; Sat, 6 Sep 2003 16:21:17 +0100 (BST)
Received: from localhost (dit0may@localhost)
	by altair.dur.ac.uk (8.11.7+Sun/8.11.1) with ESMTP id h86FLHa01256
	for <user-mode-linux-devel@lists.sourceforge.net>; Sat, 6 Sep 2003 16:21:17 +0100 (BST)
From: M A Young <m.a.young@durham.ac.uk>
Message-ID: <Pine.GSO.4.53.0309061615180.816@altair.dur.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [uml-devel] Re: Child exit when booting uml 2.4.20 on 2.6.0-test4 host
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
Date: Sat, 6 Sep 2003 16:21:17 +0100 (BST)
To: user-mode-linux-devel@lists.sourceforge.net

> I have been running a UML kernel version 2.4.20 on a RH9
> host with kernel 2.4.20-8. Everything is working properly in
> that environment. Now that I've upgraded the host system to
> 2.6.0-test4 I can't boot that same UML kernel as before.
> I get the following error:
>
> Checking root filesystem
> /dev/ubd/0: clean, 43713/75520 files, 136981/151040 blocks
> [/sbin/fsck.ext3 (1) -- /] fsck.ext3 -a /dev/ubd/0
> [  OK  ]
> Remounting root filesystem in read-write mode:  [  OK  ]
> Activating swap partitions:  [  OK  ]
> Finding module dependencies:  [  OK  ]
> Checking filesystems
> Checking all file systems.
> [  OK  ]
> Mounting local filesystems:  Child 15433 exited with signal 11

It is almost certainly the same bug I spotted here
http://marc.theaimsgroup.com/?l=user-mode-linux-devel&m=106185906902629&w=2
The patch isn't the 'right' patch, but should fix the problem for the
moment.

	Michael Young


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
