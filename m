Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EM8g0-00044Q-MB	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 02 Oct 2005 11:35:08 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1EM8fw-0002zN-LQ
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 02 Oct 2005 11:35:08 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Clearing kmalloc_ok during shutdown is broken -
	malloc will clear our data.
Message-ID: <20051002182755.GB26063@ccure.user-mode-linux.org>
References: <200509281346.23592.blaisorblade@yahoo.it>
	<200509291614.03229.blaisorblade@yahoo.it>
	<20051002010812.GB4778@localhost.localdomain>
	<200510021231.05260.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510021231.05260.blaisorblade@yahoo.it>
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
Date: Sun, 2 Oct 2005 14:27:55 -0400
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Allan Graves <allan.graves@oracle.com>

On Sun, Oct 02, 2005 at 12:31:04PM +0200, Blaisorblade wrote:
> > Yeah, it's bad.  The other way to do it is to explictly save the registers
> > in the thread struct, which is effectively the reimplementing setjmp option
> > which you mentioned.
> At least, if we save them separately from the jmpbuf_t, we can use them for 
> sysrq t, without reimplementing setjmp() and longjmp(). Not nice, wastes 24 
> bytes, but would work.

Yup.

> I have the doubt that the location of those registers is part of the ABI, 

I think they are probably not.

> Probably, however, it's just better to test on, say, a Slackware 8.1, and hope 
> for the best and go doing a fix when things change.

Yeah, I agree.  On the positive side, I think that jmp_buf has probably been
unchanged for a long time, and will remain so.

				Jeff


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
