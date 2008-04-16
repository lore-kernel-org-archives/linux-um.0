Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JmDZ0-0008Tn-Bt for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 16 Apr 2008 12:45:02 -0700
Received: from 41-052.adsl.zetnet.co.uk
	([194.247.41.52] helo=mail.esperi.org.uk ident=user21505)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JmDYy-0001mY-82
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 16 Apr 2008 12:45:01 -0700
References: <87k5jcqmh8.fsf@hades.wkstn.nix>
	<20080414144052.GA7186@c2.user-mode-linux.org>
	<87y77elx37.fsf@hades.wkstn.nix>
From: Nix <nix@esperi.org.uk>
Date: Wed, 16 Apr 2008 20:44:44 +0100
In-Reply-To: <87y77elx37.fsf@hades.wkstn.nix> (nix@esperi.org.uk's message of
	"Tue, 15 Apr 2008 20:47:08 +0100")
Message-ID: <87ve2hfutv.fsf@hades.wkstn.nix>
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

On 15 Apr 2008, nix@esperi.org.uk said:
> OK, trying that. (I'll extend the instrumentation patch to watch for
> zero cycle_interval as well, and see what happens. With luck nothing
> will happen except that the crashes will stop... except that they
> already *have* stopped for me. Annoying.)

Hard-spinning again, inside gettimeofday() inside os_nsecs(). (The stack
above that point is corrupt, or at least gdb 6.7.1 won't show
it. Nonetheless if it's not stuck inside idle_sleep() I'll eat my
hat. Note that I am *not* running CONFIG_NO_HZ because, hah, I thought
that as rather new code it might be unstable...)

This *is* a change in behaviour: the backtrace is different! Yay! :)

-- 
`The rest is a tale of post and counter-post.' --- Ian Rawlings
                                                   describes USENET

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
