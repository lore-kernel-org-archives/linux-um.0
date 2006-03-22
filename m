Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FM5UZ-000514-C1 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 22 Mar 2006 07:43:23 -0800
Received: from smtp009.mail.ukl.yahoo.com ([217.12.11.63])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1FM5UZ-0001TC-05
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 22 Mar 2006 07:43:23 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] memory option crashes the uml bootstrap phase
References: <20060321142624.GA18505@SteX>
	<200603211954.08891.blaisorblade@yahoo.it>
	<20060322110400.GA6861@SteX>
In-Reply-To: <20060322110400.GA6861@SteX>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603221643.15217.blaisorblade@yahoo.it>
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
Date: Wed, 22 Mar 2006 16:43:14 +0100
To: user-mode-linux-devel@lists.sourceforge.net, stefano.melchior@openlabs.it
Cc: user-mode-linux-user@lists.sourceforge.net

On Wednesday 22 March 2006 12:04, Stefano Melchior wrote:
> On Tue, Mar 21, 2006 at 07:54:08PM +0100, Blaisorblade wrote:
> Dear all,
>
> > No, that crash is likely a race condition and the code treats
> > mem=256{m,M} the same way.
> > Verified in arch/um/kernel/physmem.c:uml_mem_setup and
> > lib/cmdline.c:memparse.
> >
> > However, test increasing /proc/sys/vm/max_map_count and disabling
> > CONFIG_MODE_TT as suggested by Jeff, I've already seen this to fix this
> > problem.
>
> thus the point is if you need to disable TT mode by default, isn't it?
> Now user-mode-linux is in debian "unstable" [1] and I need to provide a
> config file as default configuration for the pkg: you suggested me to act
> this way

> #
> # UML-specific options
> #
> CONFIG_MODE_TT=n
> ^^^^^^^^^^^^^^^^
> # CONFIG_HOST_2G_2G is not set
> CONFIG_KERNEL_HALF_GIGS=1
> CONFIG_MODE_SKAS=y

> and rebuild the bin, didn't you?

Almost yes, but that's not the correct syntax - it's a common pitfall:

# CONFIG_MODE_TT is not set

> [1] http://packages.qa.debian.org/u/user-mode-linux.html

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

		
___________________________________ 
Yahoo! Messenger with Voice: chiama da PC a telefono a tariffe esclusive 
http://it.messenger.yahoo.com



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
