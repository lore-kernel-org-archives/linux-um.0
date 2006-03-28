Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FOK6v-0008MS-QD for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 28 Mar 2006 11:44:13 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FOK6u-0000IX-IH
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 28 Mar 2006 11:44:13 -0800
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20060328194527.GB21540@ccure.user-mode-linux.org>
References: <20060320210659.GB6474@ccure.user-mode-linux.org>
	<200603280032.31190.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603280032.31190.blaisorblade@yahoo.it>
Subject: [uml-devel] Re: SMP skas requirements
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
Date: Tue, 28 Mar 2006 14:45:27 -0500
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Tue, Mar 28, 2006 at 12:32:30AM +0200, Blaisorblade wrote:
> There are tons of places where spinlocks are used improperly. We need 
> stricter locking, however that is complicated by the addition of atomic 
> sections where UML can't sleep.
> 
> For instance, sigio_lock needs to be irqsave (I'll test the patch for this 
> shortly). On the other side, uml_console_write shouldn't take any lock, it 
> seems (see Documentation/tty.txt).

Yeah, the locking needs work.  We just need to make an SMP pass over
the arch to clean this up.

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
