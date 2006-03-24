Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FMbUE-0003kS-T1 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 23 Mar 2006 17:53:10 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FMbUD-0006xd-Ly
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 23 Mar 2006 17:53:11 -0800
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Real fix for rejected patch uaccess-warning
Message-ID: <20060324015429.GB8104@ccure.user-mode-linux.org>
References: <200603072031.18574.blaisorblade@yahoo.it>
	<200603101622.41518.blaisorblade@yahoo.it>
	<20060323205845.GA6109@ccure.user-mode-linux.org>
	<200603240052.11189.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603240052.11189.blaisorblade@yahoo.it>
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
Date: Thu, 23 Mar 2006 20:54:29 -0500
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Fri, Mar 24, 2006 at 12:52:09AM +0100, Blaisorblade wrote:
> We could even do without __private_ptr, and that's surely easier to do. 
> Actually I think that it could be done like for i386:

We can, but I'm looking for a safe patch to quiet the warnings.  I did
strip down __get_user and __put_user with no apparent ill effects, but
I'm not happy sending something like that off to Andrew with 5 minutes
of testing.  I'll put the cleanup patch in my development tree and if
I don't see any problems, then I'll send it off.

> However, I think that get_user doesn't guarantee a "full copy" semantic - 
> include/asm-i386/uaccess.h says it zeroes the dest var on error, so we're 
> safe.

Yeah, I think so.  In which case, these become pretty thin wrappers
around copy_{to,from}_user.

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
