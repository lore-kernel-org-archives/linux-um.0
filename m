Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EOnAP-0004Xf-P6	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 09 Oct 2005 19:13:29 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1EOnAU-0002Ng-34
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 09 Oct 2005 19:13:35 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Blank process command lines in 2.6.13.2?
Message-ID: <20051010020617.GC10677@ccure.user-mode-linux.org>
References: <200510091623.34322.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510091623.34322.rob@landley.net>
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
Date: Sun, 9 Oct 2005 22:06:17 -0400
To: Rob Landley <rob@landley.net>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Sun, Oct 09, 2005 at 04:23:34PM -0500, Rob Landley wrote:
> 19874 pts/1    T+     0:00
> 19968 pts/1    T+     0:00
> 19979 pts/1    T+     0:00
> 19981 pts/1    T+     0:04
> 19983 pts/2    R+     0:00 ps ax
> 
> *boggle*
> 
> This expected?

Yeah, it's not unexpected.  The host tasks for UML processes inherit the
arglist address from UML, but UML has completely redone their address spaces,
so those addresses don't point at arguments any more.

				Jeff


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
