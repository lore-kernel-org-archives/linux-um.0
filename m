Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-user] Re: [uml-devel] memory option crashes the uml
	bootstrap phase
Message-ID: <20060322153923.GB3975@ccure.user-mode-linux.org>
References: <20060321142624.GA18505@SteX> <20060321145054.GB18505@SteX>
	<200603211954.08891.blaisorblade@yahoo.it>
	<20060322110400.GA6861@SteX>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060322110400.GA6861@SteX>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Wed, 22 Mar 2006 10:39:23 -0500
To: Stefano Melchior <stefano.melchior@openlabs.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net

On Wed, Mar 22, 2006 at 12:04:00PM +0100, Stefano Melchior wrote:
> thus the point is if you need to disable TT mode by default, isn't it?
> Now user-mode-linux is in debian "unstable" [1] and I need to provide a
> config file as default configuration for the pkg: you suggested me to act
> this way 
> 
> #
> # UML-specific options
> #
> CONFIG_MODE_TT=n
> ^^^^^^^^^^^^^^^^
> # CONFIG_HOST_2G_2G is not set
> CONFIG_KERNEL_HALF_GIGS=1
> CONFIG_MODE_SKAS=y
> 
> and rebuild the bin, didn't you?

For anything recent (2.6.14 or later), yes.

				Jeff


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
