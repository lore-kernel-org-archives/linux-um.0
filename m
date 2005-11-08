Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EZUqo-0000A7-7d for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 08 Nov 2005 06:53:30 -0800
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1EZUqn-0002rJ-4o
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 08 Nov 2005 06:53:30 -0800
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Making UML Single Threader
Message-ID: <20051108154618.GB4131@ccure.user-mode-linux.org>
References: <200511061723.32848.rob@landley.net>
	<91A93A3A-FE83-4002-A004-E8FD4AFBAA3C@stanford.edu>
	<200511080109.06999.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511080109.06999.rob@landley.net>
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
Date: Tue, 8 Nov 2005 10:46:18 -0500
To: Rob Landley <rob@landley.net>
Cc: user-mode-linux-devel@lists.sourceforge.net, Can Sar <csar@stanford.edu>

On Tue, Nov 08, 2005 at 01:09:06AM -0600, Rob Landley wrote:
> > So I don't care about systemcall interception or anything like that,
> 
> *blink*  *blink*
> 
> Ok, you want user mode linux, but you don't want it to actually run user 
> processes, nor do want it to be able to intercept system calls.
> 
> Um...  What's left?

Only all of Linux.  It so happens that I want exactly the same thing for 
libUML, except I haven't had time to do anything about it.

Try to think a little before calling someone's project dumb.

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
