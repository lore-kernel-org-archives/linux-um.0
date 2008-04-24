Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Jp7aU-0006D6-LN for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 24 Apr 2008 12:58:34 -0700
Received: from 41-052.adsl.zetnet.co.uk
	([194.247.41.52] helo=mail.esperi.org.uk ident=user6037)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Jp7aN-0007PR-R7
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 24 Apr 2008 12:58:29 -0700
References: <87k5jcqmh8.fsf@hades.wkstn.nix>
	<20080414144052.GA7186@c2.user-mode-linux.org>
	<87y77elx37.fsf@hades.wkstn.nix> <87ve2hfutv.fsf@hades.wkstn.nix>
From: Nix <nix@esperi.org.uk>
Date: Thu, 24 Apr 2008 20:57:54 +0100
In-Reply-To: <87ve2hfutv.fsf@hades.wkstn.nix> (nix@esperi.org.uk's message of
	"Wed, 16 Apr 2008 20:44:44 +0100")
Message-ID: <87bq3z81q5.fsf@hades.wkstn.nix>
MIME-Version: 1.0
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
To: Jeff Dike <jdike@addtoit.com>
Cc: Thomas Gleixner <tglx@timesys.com>, user-mode-linux-devel@lists.sourceforge.net

On 16 Apr 2008, nix@esperi.org.uk stated:
> This *is* a change in behaviour: the backtrace is different! Yay! :)

I upgraded the guest to 2.6.25 a week ago and it stopped happening.
There is hope.  (Mind you it's stopped going wrong for week-long periods
before...)

-- 
`If you are having a "ua luea luea le ua le" kind of day, I can only
 assume that you are doing no work due [to] incapacitating nausea caused 
 by numerous lazy demons.' --- Frossie

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
