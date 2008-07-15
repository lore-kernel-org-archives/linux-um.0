Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KIqtu-0008Oa-8g for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 15 Jul 2008 13:13:30 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KIqtr-00058O-Mk
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 15 Jul 2008 13:13:30 -0700
Date: Tue, 15 Jul 2008 16:13:22 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080715201322.GA15836@c2.user-mode-linux.org>
References: <1214488251-20927-1-git-send-email-bhalevy@panasas.com>
	<g5g5vo$hok$1@ger.gmane.org>
	<20080715162400.GC12154@c2.user-mode-linux.org>
	<g5ir1u$14n$1@ger.gmane.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <g5ir1u$14n$1@ger.gmane.org>
Subject: Re: [uml-devel] [PATCH] fix extern inline errors with gcc 4.3.0
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: David Shane Holden <dpejesh@yahoo.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Tue, Jul 15, 2008 at 11:42:05AM -0700, David Shane Holden wrote:
> Jeff Dike wrote:
> > On Mon, Jul 14, 2008 at 11:30:15AM -0700, David Shane Holden wrote:
> >> I tried to build a UML 2.6.26 kernel on Debian (32-bit) and ran into the 
> >> same problem reported here http://marc.info/?t=121011533500002&r=1&w=2. 
> > 
> > It's really 2.6.26, and not something from a day or two earlier?  I
> > fixed the compilation bugs, supposedly, just before 2.6.26.
> 
> Yeah, it's a vanilla 2.6.26, and when comparing it to 2.6.26-rc9 the 
> only difference in arch/um was the change for no-unit-at-a-time.

OK, I misunderstood - I thought you were saying you got compilation
errors, rather than crashes.  Hence my incredulity, since that patch
was supposed to fix the compile errors.

> > 
> >>   If I use gcc 4.3 everything works fine, but if I use gcc 4.1 or 4.2, 
> >> UML crashes on startup.
> > 
> > If the crash says ptrace in it, then I'm currently trying to figure
> > out what's happening with that.
> 
> It's crashing in wait_stub_done just like the poster of the message was 
> having, it appears gcc 4.1 and 4.2 need -fno-unit-at-a-time.

Well, we need to figure out why the initcalls aren't happening with
-unit-at-a-time and some versions of gcc.

		    	 	  Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
