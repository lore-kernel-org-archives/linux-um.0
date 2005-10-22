Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ET9uG-0002SE-QM	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 21 Oct 2005 20:18:52 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1ET9uG-0003ej-DE
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 21 Oct 2005 20:18:52 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Strange behaviour of hwrng
Message-ID: <20051022031136.GA13689@localhost.localdomain>
References: <1129919051.27787.42.camel@localhost.localdomain>
	<200510212042.29634.blaisorblade@yahoo.it>
	<1129921606.27787.61.camel@localhost.localdomain>
	<200510220252.00871.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510220252.00871.blaisorblade@yahoo.it>
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
Date: Fri, 21 Oct 2005 23:11:36 -0400
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: Gerd Stolpmann <info@gerd-stolpmann.de>, user-mode-linux-devel@lists.sourceforge.net

On Sat, Oct 22, 2005 at 02:52:00AM +0200, Blaisorblade wrote:
> Proper solution: use a separate _host_ thread, which either sits blocked in a 
> blocking read or calls poll() on the host /dev/random, and have it do the 
> work. 

Yeah, unfortunately.  The real right thing to do is give the host random
driver fasync support (I'm not sure how possible this is, however, given the
nature of the hardware).  Then we could register an IRQ for having some 
randomness and do this right.

> It's not easy however.

It's fairly trivial.  Look at the SIGIO workaround thread - this is essentially
the same thing.

> The ubd driver works currently this way, but the thing is not trivial to get 
> right (and the UBD rewrite in the works has shown that).

The complexity there is due to entirely different causes, namely making sure
that requests are sent out in order and that pieces of the bitmap are written
out when they should be, and not before.

				Jeff


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
