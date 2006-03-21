Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] memory option crashes the uml bootstrap phase
Message-ID: <20060321205127.GA22808@ccure.user-mode-linux.org>
References: <20060321142624.GA18505@SteX> <20060321145054.GB18505@SteX>
	<200603211954.08891.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603211954.08891.blaisorblade@yahoo.it>
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
Date: Tue, 21 Mar 2006 15:51:27 -0500
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, stefano.melchior@openlabs.it, user-mode-linux-user@lists.sourceforge.net

On Tue, Mar 21, 2006 at 07:54:08PM +0100, Blaisorblade wrote:
> However, test increasing /proc/sys/vm/max_map_count 

This only bites you when you have large UML processes - I don't think it
can cause a crash on boot.

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
