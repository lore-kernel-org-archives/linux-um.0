Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CT5p1-0003sa-Cl for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 13 Nov 2004 13:52:39 -0800
Received: from nevyn.them.org ([66.93.172.17] ident=Debian-exim)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:RC4-SHA:128)
	(Exim 4.41) id 1CT5ox-0006mI-Oo
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 13 Nov 2004 13:52:39 -0800
From: Daniel Jacobowitz <dan@debian.org>
Message-ID: <20041113215233.GA31209@nevyn.them.org>
References: <20041113211443.GA27963@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041113211443.GA27963@nevyn.them.org>
Subject: [uml-devel] Re: Debian bug 271069, gdb startup fails
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
Date: Sat, 13 Nov 2004 16:52:33 -0500
To: 271069-submitter@bugs.debian.org, 271069@bugs.debian.org, user-mode-linux-devel@lists.sourceforge.net

On Sat, Nov 13, 2004 at 04:14:43PM -0500, Daniel Jacobowitz wrote:
> History:
>   http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=271069
> 
> I've been looking at this bug.  I've already fixed the EINTR problem;
> I didn't see your patch (not sure why the BTS didn't forward it to me).
> But 2.6.10-rc1 does the same thing outside of UML, so I needed to fix
> it anyway.
> 
> However, GDB startup still fails in UML using './linux debug'.  Here's
> what happens:
> 
> - GDB forks
> - the child issues TRACEME
> - GDB waits for it, successfully now that EINTR is handled
> - GDB issues PTRACE_SETOPTIONS (returns -EINVAL because the proxy
>   does not support it)
> - GDB decides that the feature isn't available (good so far; it isn't)
> - GDB tries to clean up.  It sends PTRACE_KILL to the child it forked.
> - GDB waits for the child to exit.  Which it never does.
> 
> I imagine the proxy is just not able to cope with this.  It certainly
> doesn't look as if it can.  For instance, arg2 is completely ignored
> except for PTRACE_ATTACH; I think what has happened is that the
> PTRACE_KILL was sent to the wrong process.  And the waitpids are
> probably waiting for the wrong process too.
> 
> I think the only way to fix this is to teach the UML proxy to get out
> of the way if the pid is not the expected one, for at least PTRACE_KILL
> and waitpid; but it should probably continue to return failure for
> PTRACE_SETOPTIONS.

Actually, while the proxy probably should be fixed anyway, I've worked
around this in GDB.  It will be in the Debian 6.3-2 packages, which I'm
working on right now.

Should "kill" work from the GDB prompt?  If so, that does need some
work in the proxy.

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
