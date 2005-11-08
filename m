Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EZUnr-0008Ih-V2 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 08 Nov 2005 06:50:27 -0800
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1EZUnp-0001ww-O0
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 08 Nov 2005 06:50:28 -0800
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Making UML Single Threader
Message-ID: <20051108154310.GA4131@ccure.user-mode-linux.org>
References: <200511061723.32848.rob@landley.net>
	<91A93A3A-FE83-4002-A004-E8FD4AFBAA3C@stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91A93A3A-FE83-4002-A004-E8FD4AFBAA3C@stanford.edu>
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
Date: Tue, 8 Nov 2005 10:43:10 -0500
To: Can Sar <csar@stanford.edu>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Mon, Nov 07, 2005 at 09:13:19PM -0800, Can Sar wrote:
> Do the other threads (particularly the user thread) ever  
> do something else that would be important?

The user thread doesn't.  The IO thread does, if you wish to do IO.
And you can easily dispense with the sigio emulation thread.

> Furthermore is the actual kernel process multi threaded?

It does what amounts to user-level threads - i.e. there are multiple
execution contexts in it, implemented with setjmp/longjmp, but that's
not visible from the outside.

				Jeff


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
