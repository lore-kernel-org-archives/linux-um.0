Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CUaBd-0001lt-Bx for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 17 Nov 2004 16:30:09 -0800
Received: from pool-151-203-245-3.bos.east.verizon.net ([151.203.245.3]
	helo=ccure.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41) id 1CUaBc-0003V9-30
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 17 Nov 2004 16:30:09 -0800
Message-Id: <200411180243.iAI2hgQ3006959@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] Debian bug 271069, gdb startup fails 
In-Reply-To: Your message of "Sat, 13 Nov 2004 16:14:44 EST."
	<20041113211443.GA27963@nevyn.them.org> 
References: <20041113211443.GA27963@nevyn.them.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
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
Date: Wed, 17 Nov 2004 21:43:42 -0500
To: Daniel Jacobowitz <dan@debian.org>
Cc: 271069-submitter@bugs.debian.org, 271069@bugs.debian.org, user-mode-linux-devel@lists.sourceforge.net

dan@debian.org said:
> - GDB forks
> - the child issues TRACEME
> - GDB waits for it, successfully now that EINTR is handled
> - GDB issues PTRACE_SETOPTIONS (returns -EINVAL because the proxy
>   does not support it)
> - GDB decides that the feature isn't available (good so far; it isn't)
> - GDB tries to clean up.  It sends PTRACE_KILL to the child it forked.
> - GDB waits for the child to exit.  Which it never does.

From your description above (I haven't seen this personally), there are a
couple of things I don't understand.

First, I don't see how a PTRACE_KILL can be going to the wrong process.  I see
only one child under ptrace.

Second, it would seem that, even if this was successful, the end result is
'./linux debug' just dropping you back to a shell prompt.  This may be better
than the current hang, but it's not the desired result.

				Jeff



-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
