Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CNY6n-0001Nw-UQ for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 29 Oct 2004 07:52:05 -0700
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CNY6l-00050m-An for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 29 Oct 2004 07:52:05 -0700
From: Blaisorblade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Re: Why UML often does not build (was: Re: [PATCH]
	UML: Build fix for TT w/o SKAS)
References: <20041027053602.GB30735@taniwha.stupidest.org>
	<20041029002831.GD12434@taniwha.stupidest.org>
	<20041029034444.A24523@almesberger.net>
In-Reply-To: <20041029034444.A24523@almesberger.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410291653.02985.blaisorblade_spam@yahoo.it>
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
Date: Fri, 29 Oct 2004 16:53:02 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Werner Almesberger <wa@almesberger.net>, Chris Wedgwood <cw@f00f.org>, LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>, Jeff Dike <jdike@addtoit.com>

On Friday 29 October 2004 08:44, Werner Almesberger wrote:
> Chris Wedgwood wrote:
> > the problem here is that ptrace semantics are not well defined to
> > anything subtle can and will break from time to time
>
> I wonder what the "correct" solution for this would be: write a
> specification for Linux ptrace, or try to get the POSIX folks
> interested ?

> Given that we get subtle ptrace breakages quite regularly, it
> would be nice to see this eventually get resolved. "The
> implementation is the specification" doesn't seem to work well
> in this case.
Well, you are quite right - Linux is aimed at never breaking existing 
binaries, and ptrace() does not follow that.

However, the problem here is that UML was not behaving correctly. Instead of 
using the documented way, PTRACE_KILL, we just sent a SIGKILL and that 
happened to work (and since PTRACE_KILL implementation just sends a SIGKILL, 
you would still expect it to work).

In fact, I fixed the Gerd Knorr test program to use PTRACE_KILL and it works 
on 2.6.9.

> BTW, things have improved around UML quite a bit recently, and I
> think this is to no small amount due to Paolo's work.
Thanks a lot for that, it's something very important for me, but I'm not the 
only one deserving such recognition. See the amount of work done by Bodo 
Stroesser in a few weeks - he solved lots of problems which I fought against 
without success.

Besides that, I need to do a lot of janitorial work, while holding on more 
advanced stuff - so I think that anybody could be able to help here.
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
