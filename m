Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C69za-0002km-DU for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 11 Sep 2004 08:40:46 -0700
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.34)
	id 1C69zY-0002MJ-LA for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 11 Sep 2004 08:40:46 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] [smcc@CSAIL.MIT.EDU: Bug#271069: gdb startup fails in
	tracefork check]
References: <20040910222635.GA5690@alcor.net>
In-Reply-To: <20040910222635.GA5690@alcor.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409111737.22563.blaisorblade_spam@yahoo.it>
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
Date: Sat, 11 Sep 2004 17:37:22 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Matt Zimmerman <mdz@debian.org>, Stephen McCamant <smcc@CSAIL.MIT.EDU>, 271069-forwarded@bugs.debian.org

On Saturday 11 September 2004 00:26, Matt Zimmerman wrote:
> ----- Forwarded message from Stephen McCamant <smcc@CSAIL.MIT.EDU> -----
>
> Date: Fri, 10 Sep 2004 18:09:07 -0400
> From: Stephen McCamant <smcc@CSAIL.MIT.EDU>
> Resent-From: Stephen McCamant <smcc@CSAIL.MIT.EDU>
> To: submit@bugs.debian.org
> Subject: Bug#271069: gdb startup fails in tracefork check
>
> Package: user-mode-linux
> Version: 2.4.26-2um-1
>
> With the current versions of UML and GDB in sarge, with a 2.4.x host
> kernel (no SKAS support, so this is in tt mode), gdb runs into an
> error when UML tries to start it as requested by a "debug" option. For
> instance, given the invocation

> where the line 1 the error refers to is "att 1". Despite the message,
> though, I don't think the error comes from the init file, but rather
> from part of GDB's startup process: linux_test_for_tracefork(), from
> the file linux-nat.c in the GDB source, is used to check whether the
> kernel supports various options to ptrace which, if present, allow GDB
> to follow children that fork. To do this, GDB forks a child process,
> waits for the child to stop itself, then sets some ptrace options and
> has the child fork. When run on its own, the test executes without
> problems, but when gdb is started by UML, the waitpid call that gdb
> uses to wait for the first child to call PTRACE_TRACEME is
> unexpectedly interrupted; the EINTR return value is what makes gdb
> error out.

Well, when gdb receives EINTR, it should just retry the failed call. It's a 
general rule. In fact, in these days we are applying a lot of such patches to 
fix such bugs for UML.
So, file a bug-report to gdb developers.

UML may have his part in triggering this bug, so we may fix it, too.

> If I edit the source to gdb so that the function immediately returns a
> "not-available" result without actually doing the test, and use that
> modified gdb instead of the regular one, debugging the UML kernel
> works as I would expect.

Try fixing it as I suggest above. I.e., when call fails and errno == EINTR, 
retry the same identical call (without changing *anything*).

Bye
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
