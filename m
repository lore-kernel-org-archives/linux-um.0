Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EKhMI-0005d5-BW	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 28 Sep 2005 12:12:50 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1EKhME-0000fx-G3
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 28 Sep 2005 12:12:49 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] a question about sigsetjmp() in copy_from/to_user()
Message-ID: <20050928184358.GA15224@ccure.user-mode-linux.org>
References: <3524bf1f050927070645b999bd@mail.gmail.com>
	<200509281359.48449.blaisorblade@yahoo.it>
	<20050928160946.GB12888@ccure.user-mode-linux.org>
	<200509281926.44813.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509281926.44813.blaisorblade@yahoo.it>
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
Date: Wed, 28 Sep 2005 14:43:58 -0400
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Young Koh <young.koh@gmail.com>

On Wed, Sep 28, 2005 at 07:26:43PM +0200, Blaisorblade wrote:
> I'm not sure that would help anyway - if the host memory is full, it's full. 
> It's just matter of waiting and retrying.

This isn't a matter of waiting and retrying.  We use pages that are already
known to be good, and the rest go on a "bad pages" list and not freed, so
no one will try to use them again.

> I don't think the host would SIGBUS again on the same page specifically - or 
> better, I'm almost sure this is not done.
> So, I don't see the reason for that. Catching SIGSEGV/SIGBUS is ok, taking 
> another page is bad.

Catching SIGSEGV/SIGBUS at some random place in the kernel after it kmalloced
a bad page is OK?  I don't think so.

The only way to keep the kernel running at that point is to get another
page and hope that it's OK.  And if it's not, you try again.

				Jeff


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
