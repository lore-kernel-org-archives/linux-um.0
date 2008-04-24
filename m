Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Jp9mk-0003dO-IX for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 24 Apr 2008 15:19:23 -0700
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]
	helo=mail.esperi.org.uk)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Jp9mi-0005bC-PW
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 24 Apr 2008 15:19:22 -0700
References: <87k5jcqmh8.fsf@hades.wkstn.nix>
	<20080414144052.GA7186@c2.user-mode-linux.org>
	<87y77elx37.fsf@hades.wkstn.nix> <87ve2hfutv.fsf@hades.wkstn.nix>
	<87bq3z81q5.fsf@hades.wkstn.nix>
	<20080424203732.GA11688@c2.user-mode-linux.org>
From: Nix <nix@esperi.org.uk>
Date: Thu, 24 Apr 2008 23:18:59 +0100
In-Reply-To: <20080424203732.GA11688@c2.user-mode-linux.org> (Jeff Dike's
	message of "Thu, 24 Apr 2008 16:37:32 -0400")
Message-ID: <87y7727v70.fsf@hades.wkstn.nix>
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

On 24 Apr 2008, Jeff Dike uttered the following:
> OK, yell if it starts happening again...

I tempted fate, and lo, it happens within the hour...

(gdb) bt
#0  0x08083e3a in getnstimeofday ()

I will now do what I should have done long since and turn on frame
pointers and debugging info so I can get a damn backtrace. (I really
thought that was on, but apparently not...)


One 2.6.25 improvement: in 2.6.24, whenever this happened the TUN/TAP
driver seemed to get some sort of nasty lock taken out, all future
packets sent over it vanished into the aether rather than going over the
(virtual) ether(net), and I had to reboot the host to fix it. No
longer. :)

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
