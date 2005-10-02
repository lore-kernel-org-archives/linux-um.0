Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EM9Cy-0006tB-VB	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 02 Oct 2005 12:09:12 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1ELsRk-0008Ln-6w
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 01 Oct 2005 18:15:21 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Clearing kmalloc_ok during shutdown is broken -
	malloc will clear our data.
Message-ID: <20051002010812.GB4778@localhost.localdomain>
References: <200509281346.23592.blaisorblade@yahoo.it>
	<20050928213125.GA16955@ccure.user-mode-linux.org>
	<200509291614.03229.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509291614.03229.blaisorblade@yahoo.it>
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
Date: Sat, 1 Oct 2005 21:08:12 -0400
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Allan Graves <allan.graves@oracle.com>

On Thu, Sep 29, 2005 at 04:14:02PM +0200, Blaisorblade wrote:
> I now even found (by chance) the original mail from Allan Graves - and the 
> changes in arch/um/include/sysdep-x86_64/ptrace.h weren't in his patch and 
> are unrelated.
> Plus, I think they're also bogus (those registers exist), but I may be wrong, 
The patch uses UPT_REG apparently for the first time.  Those registers exist,
but there are no defines for them in the x86_64 ptrace.h.  UPT_REG is never
called with any of those as its argument, so it's easy to just remove those
cases.

> On the bogus value: I'm more accustomed to 0xdeadbeef, since 0xbadbabe could 
> be valid while 0xdeadbeef not (it's in the last giga).

Yeah, that makes sense.

> The only problem I see is that we need to test it on a wide glibc range - 
> you're using an internal header detail, so glibc will break it at will.

Yeah, it's bad.  The other way to do it is to explictly save the registers
in the thread struct, which is effectively the reimplementing setjmp option
which you mentioned.

				Jeff



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
