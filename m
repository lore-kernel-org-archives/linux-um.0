Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EOysA-0006HG-Hm	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 10 Oct 2005 07:43:26 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1EOysJ-0007tQ-To
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 10 Oct 2005 07:43:37 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Blank process command lines in 2.6.13.2?
Message-ID: <20051010143615.GA3448@ccure.user-mode-linux.org>
References: <200510091623.34322.rob@landley.net>
	<20051010020617.GC10677@ccure.user-mode-linux.org>
	<200510100010.10951.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510100010.10951.rob@landley.net>
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
Date: Mon, 10 Oct 2005 10:36:15 -0400
To: Rob Landley <rob@landley.net>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Mon, Oct 10, 2005 at 12:10:10AM -0500, Rob Landley wrote:
> Any likelihood that at some point in the future it could accidentally point to 
> something it would be a bad idea to display?

I think the worst case is skas3 with no stack randomization, where that
page will point somewhere into the process stack.  There is some slight 
possibility that something could store a password on its stack, and have that
end up in the area that the host ps looks for arguments.  This would make the
password visible on the host for the time that this process in context.

With stack randomization, the UML process stacks will be located
elsewhere almost all the time, so with skas3, there is a smaller
chance that there will be a visible password there.

With skas0, that page is the stub signal stack, which contains no sensitive
information.

				Jeff


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
