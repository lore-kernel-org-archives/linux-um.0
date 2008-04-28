Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JqWTp-0007tp-7O for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 28 Apr 2008 09:45:29 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JqWTW-00030N-0R
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 28 Apr 2008 09:45:14 -0700
Date: Mon, 28 Apr 2008 12:44:44 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080428164443.GB9628@c2.user-mode-linux.org>
References: <877iel7ljp.fsf@hades.wkstn.nix> <87ve256146.fsf@hades.wkstn.nix>
	<871w4sqxgv.fsf@hades.wkstn.nix>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <871w4sqxgv.fsf@hades.wkstn.nix>
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

On Sat, Apr 26, 2008 at 07:31:44PM +0100, Nix wrote:
> The cause of this is almost certainly time-skewing on the *host* via
> adjtimex(). I stopped ntpd and there were no problems for half a day: I
> restarted it, and as soon as ntpd had synched and begun slewing the time
> (within a second of slewing beginning, probably less than that), *wham*:

Can you try the patch below?  Time should definitely not go backwards
- it's a bug if it happens.  If you want more a more definite
indication about whether this is having an effect, stick a printk in
that test and see if it shows up.

     	      	  Jeff

-- 
Work email - jdike at linux dot intel dot com

Index: linux-2.6.22/arch/um/os-Linux/time.c
===================================================================
--- linux-2.6.22.orig/arch/um/os-Linux/time.c	2008-04-24 13:21:28.000000000 -0400
+++ linux-2.6.22/arch/um/os-Linux/time.c	2008-04-28 12:41:37.000000000 -0400
@@ -107,6 +107,10 @@ static void deliver_alarm(void)
 	unsigned long long this_tick = os_nsecs();
 	int one_tick = UM_NSEC_PER_SEC / UM_HZ;
 
+	/* Protection against the host's time going backwards */
+	if ((last_tick != 0) && (this_tick < last_tick))
+		this_tick = last_tick;
+
 	if (last_tick == 0)
 		last_tick = this_tick - one_tick;
 

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
