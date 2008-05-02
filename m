Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Js1Np-0003j1-SU for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 02 May 2008 12:57:29 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Js1No-0003ke-DG
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 02 May 2008 12:57:29 -0700
Date: Fri, 2 May 2008 15:57:20 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080502195720.GB10369@c2.user-mode-linux.org>
References: <877iel7ljp.fsf@hades.wkstn.nix> <87ve256146.fsf@hades.wkstn.nix>
	<871w4sqxgv.fsf@hades.wkstn.nix>
	<20080428164443.GB9628@c2.user-mode-linux.org>
	<871w4n9fo8.fsf@hades.wkstn.nix>
	<20080501151351.GA6303@c2.user-mode-linux.org>
	<87prs57g4h.fsf@hades.wkstn.nix>
	<20080502163020.GB7843@c2.user-mode-linux.org>
	<87bq3o5yeo.fsf@hades.wkstn.nix>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87bq3o5yeo.fsf@hades.wkstn.nix>
Subject: Re: [uml-devel] actually useful backtrace from a CPU-chewing hang
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
To: Nix <nix@esperi.org.uk>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Fri, May 02, 2008 at 07:55:11PM +0100, Nix wrote:
> No behavioural change :(

Oh well.

> I'm trying something else now, arranging for os_nsecs() itself to do the
> never-backwards stuff on the assumption that something depends on
> monotonic timers not skipping backwards which presently they might
> (there are callers of os_nsecs() outside of os-Linux/time.c, notably in
> kernel/time.c, and currently they see an unadjusted time, jumping
> backwards and forwards and whatever).

This sounds like a reasonable idea.

Another thing you might try is the following:
	get two extra windows
	in one, get a "strace -p uml-pid -o strace.out -tt" ready
	in two, get a "date ; sudo date -s "now-5 sec" ; date" ready
	hit return in one, then in two, then in your UML window
	when the UML gives you another prompt (or you've decided it's
hung), ^C the strace

Look at the times reported by the dates, find the time change in the
strace log, and send the section following that (and a bit before) to
me.

			Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
