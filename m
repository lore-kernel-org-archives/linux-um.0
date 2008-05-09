Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JuUKk-0007z9-NT for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 09 May 2008 08:16:30 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JuUKh-0004cy-Bd
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 09 May 2008 08:16:30 -0700
Date: Fri, 9 May 2008 11:16:04 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080509151604.GC10169@c2.user-mode-linux.org>
References: <20080428164443.GB9628@c2.user-mode-linux.org>
	<871w4n9fo8.fsf@hades.wkstn.nix>
	<20080501151351.GA6303@c2.user-mode-linux.org>
	<87prs57g4h.fsf@hades.wkstn.nix>
	<20080502163020.GB7843@c2.user-mode-linux.org>
	<87bq3o5yeo.fsf@hades.wkstn.nix>
	<20080502195720.GB10369@c2.user-mode-linux.org>
	<87k5ic47is.fsf@hades.wkstn.nix>
	<20080503005631.GA12599@c2.user-mode-linux.org>
	<877ieb4s4n.fsf@hades.wkstn.nix>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <877ieb4s4n.fsf@hades.wkstn.nix>
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

On Sat, May 03, 2008 at 11:08:24AM +0100, Nix wrote:
> >>From a quick look, this seems right.  And this would be the gold
> > standard of preventing UML from seeing time going backwards.
> 
> Oh. And it still doesn't work. Damn.

Is it possible for me to get my hands on a UML which is doing this?

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
