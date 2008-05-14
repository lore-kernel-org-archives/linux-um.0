Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JwP3Z-0007F6-RE for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 14 May 2008 15:02:42 -0700
Received: from 41-052.adsl.zetnet.co.uk
	([194.247.41.52] helo=mail.esperi.org.uk ident=user31156)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JwP3V-0003yB-3o
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 14 May 2008 15:02:41 -0700
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
	<20080514204341.GA12452@c2.user-mode-linux.org>
From: Nix <nix@esperi.org.uk>
Date: Wed, 14 May 2008 23:02:23 +0100
In-Reply-To: <20080514204341.GA12452@c2.user-mode-linux.org> (Jeff Dike's
	message of "Wed, 14 May 2008 16:43:41 -0400")
Message-ID: <87iqxgy26o.fsf@hades.wkstn.nix>
MIME-Version: 1.0
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
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On 14 May 2008, Jeff Dike verbalised:

> On Wed, May 14, 2008 at 09:12:12PM +0100, Nix wrote:
>> Oh, and, it's pedantic of me, I know, but what does this do if time goes
>> backwards in the NO_HZ case? (Or is handling that a 2.6.26 thing?)
>
> In all cases, it holds time steady until the host catches up with what
> the guest thinks the time should be.

Yeah, that's what I was doing too: but mine didn't work. Odd.

> I noticed you wrapped last_tick business in one of the ifdefs - I
> didn't look carefully to see whether that would explain the behavior
> difference.  I just made it unconditional.

The only reason I wrapped it in the ifdefs was because the !NO_HZ case
had to keep the skew calculations up to date, while the NO_HZ case
didn't have to bother. It shouldn't have affected anything else.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft 
Defy all challenges. Microsoft(R) Visual Studio 2008. 
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
