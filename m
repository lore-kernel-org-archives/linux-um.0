Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FMX7T-0004K3-Ef for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 23 Mar 2006 13:13:23 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FMX7P-0001Uy-UR
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 23 Mar 2006 13:13:23 -0800
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20060323211424.GA6130@ccure.user-mode-linux.org>
References: <200603230317.48384.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603230317.48384.blaisorblade@yahoo.it>
Subject: [uml-devel] Re: TLS support - status - need for re-testing
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
Date: Thu, 23 Mar 2006 16:14:24 -0500
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Antoine Martin <antoine@nagafix.co.uk>

On Thu, Mar 23, 2006 at 03:17:45AM +0100, Blaisorblade wrote:
> Jeff, I've looked at all other patches _names_ and they're patches which I 
> already have, so I shouldn't have lost any other changes.

I think I didn't change any of your patches - any changes I made got
their own patches, so you should be safe.

> Plus, I've just done a couple of other cleanups of the TLS code, removing dead 
> code which was there for experiments; I've implemented 2.4 host detection (I 
> hope I've not forgot to check the host_supports_tls variable anywhere), and 
> I'm ripping out global-ldt-sem which I longly hated (and which isn't easy to 
> avoid).

Do you have a set of patches which are candidates for akpm?  I'm
looking at 
	http://www.user-mode-linux.org/~blaisorblade/patches/guest/uml-2.6.15-bb6/broken-out/series

and that seems unsuitable, as some patches seem to reverse earlier
ones.

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
