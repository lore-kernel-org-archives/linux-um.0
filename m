Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JwNpM-0007Wp-5J for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 14 May 2008 13:43:56 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JwNpI-0001ZF-KW
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 14 May 2008 13:43:54 -0700
Date: Wed, 14 May 2008 16:43:41 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080514204341.GA12452@c2.user-mode-linux.org>
References: <20080502195720.GB10369@c2.user-mode-linux.org>
	<87k5ic47is.fsf@hades.wkstn.nix>
	<20080503005631.GA12599@c2.user-mode-linux.org>
	<877ieb4s4n.fsf@hades.wkstn.nix>
	<20080509151604.GC10169@c2.user-mode-linux.org>
	<1210353202.31648.8.camel@localhost>
	<20080514172347.GA10283@c2.user-mode-linux.org>
	<1210789757.25724.3.camel@localhost>
	<20080514193912.GA11531@c2.user-mode-linux.org>
	<87r6c4y7ab.fsf@hades.wkstn.nix>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87r6c4y7ab.fsf@hades.wkstn.nix>
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

On Wed, May 14, 2008 at 09:12:12PM +0100, Nix wrote:
> Oh, and, it's pedantic of me, I know, but what does this do if time goes
> backwards in the NO_HZ case? (Or is handling that a 2.6.26 thing?)

In all cases, it holds time steady until the host catches up with what
the guest thinks the time should be.

I noticed you wrapped last_tick business in one of the ifdefs - I
didn't look carefully to see whether that would explain the behavior
difference.  I just made it unconditional.

	       	    	 Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft 
Defy all challenges. Microsoft(R) Visual Studio 2008. 
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
