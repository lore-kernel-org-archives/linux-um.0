Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CUaT0-0003F8-KX for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 17 Nov 2004 16:48:06 -0800
Received: from nevyn.them.org ([66.93.172.17] ident=Debian-exim)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:RC4-SHA:128)
	(Exim 4.41) id 1CUaSx-0005h0-TG
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 17 Nov 2004 16:48:06 -0800
From: Daniel Jacobowitz <dan@debian.org>
Subject: Re: [uml-devel] Debian bug 271069, gdb startup fails
Message-ID: <20041118004739.GA25637@nevyn.them.org>
References: <20041113211443.GA27963@nevyn.them.org>
	<200411180243.iAI2hgQ3006959@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411180243.iAI2hgQ3006959@ccure.user-mode-linux.org>
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
Date: Wed, 17 Nov 2004 19:47:39 -0500
To: Jeff Dike <jdike@addtoit.com>
Cc: 271069-submitter@bugs.debian.org, 271069@bugs.debian.org, user-mode-linux-devel@lists.sourceforge.net

On Wed, Nov 17, 2004 at 09:43:42PM -0500, Jeff Dike wrote:
> dan@debian.org said:
> > - GDB forks
> > - the child issues TRACEME
> > - GDB waits for it, successfully now that EINTR is handled
> > - GDB issues PTRACE_SETOPTIONS (returns -EINVAL because the proxy
> >   does not support it)
> > - GDB decides that the feature isn't available (good so far; it isn't)
> > - GDB tries to clean up.  It sends PTRACE_KILL to the child it forked.
> > - GDB waits for the child to exit.  Which it never does.
> 
> >From your description above (I haven't seen this personally), there are a
> couple of things I don't understand.
> 
> First, I don't see how a PTRACE_KILL can be going to the wrong process.  I see
> only one child under ptrace.
> 
> Second, it would seem that, even if this was successful, the end result is
> './linux debug' just dropping you back to a shell prompt.  This may be better
> than the current hang, but it's not the desired result.

GDB isn't trying to kill UML; it's trying to kill a process that it
forked, for the express purpose of figuring out whether certain debug
facilities are available on the system.  So GDB is "attached" to both
UML and this new child.  It's trying to kill (as well as do other
things to) the new child; but UML's proxy layer assumes that anything
GDB does by ptrace is intended to go to UML instead.

-- 
Daniel Jacobowitz


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
