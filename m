Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Jp8CS-0001cw-I3 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 24 Apr 2008 13:37:48 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Jp8CQ-0005Ao-VD
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 24 Apr 2008 13:37:48 -0700
Date: Thu, 24 Apr 2008 16:37:32 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080424203732.GA11688@c2.user-mode-linux.org>
References: <87k5jcqmh8.fsf@hades.wkstn.nix>
	<20080414144052.GA7186@c2.user-mode-linux.org>
	<87y77elx37.fsf@hades.wkstn.nix> <87ve2hfutv.fsf@hades.wkstn.nix>
	<87bq3z81q5.fsf@hades.wkstn.nix>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87bq3z81q5.fsf@hades.wkstn.nix>
Subject: Re: [uml-devel] Lockups with the fixed timer code :/
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
Cc: Thomas Gleixner <tglx@timesys.com>, user-mode-linux-devel@lists.sourceforge.net

On Thu, Apr 24, 2008 at 08:57:54PM +0100, Nix wrote:
> On 16 Apr 2008, nix@esperi.org.uk stated:
> > This *is* a change in behaviour: the backtrace is different! Yay! :)
> 
> I upgraded the guest to 2.6.25 a week ago and it stopped happening.
> There is hope.  (Mind you it's stopped going wrong for week-long periods
> before...)

OK, yell if it starts happening again...

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
