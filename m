Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FU6Ox-0001Nt-Sk for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 13 Apr 2006 11:18:43 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FU6Ov-0000rN-7o
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 13 Apr 2006 11:18:43 -0700
Message-Id: <200604131719.k3DHJcZG004674@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [RFC] PATCH 0/4 - Time virtualization
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
Date: Thu, 13 Apr 2006 13:19:36 -0400
To: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

This set of patches implements 
	time virtualization by creating a time namespace
	an interface to it through unshare
	a ptrace extension to allow UML to take advantage of this
	UML support

The guts of the namespace is just an offset from the system time.  Within
the container, gettimeofday adds this offset to the system time.  settimeofday
changes the offset without touching the system time.  As such, within a 
namespace, settimeofday is unprivileged.

The interface to it is through unshare(CLONE_TIME).  This creates the new
namespace, initialized with a zero offset from the system time.

The advantage of this for UML is that it can create a time namespace for itself
and subsequently let its process' gettimeofday run on the host, without
being intercepted and run inside UML.  As such, it should basically run at
native speed.

In order to allow this, we need selective system call interception.  The
third patch implements PTRACE_SYSCALL_MASK, which specifies, through a 
bitmask, which system calls are intercepted and which aren't.

Finally, the UML support is straightforward.  It calls unshare(CLONE_TIME)
to create the new namespace, sets gettimeofday to run without being 
intercepted, and makes settimeofday call the host's settimeofday instead
of maintaining the time offset itself.

As expected, a gettimeofday loop runs basically at native speed.  The two
quick tests I did had it running inside UML at 98.8 and 99.2 % of native.

BUG - as I was writing this, I realized that refcounting of the time_ns
structures is wrong - they need to be incremented at process creation and
decremented at process exit.

				Jeff



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
