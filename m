Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EKdPk-0000sy-0U	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 28 Sep 2005 08:00:08 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1EKdPh-0002YD-QS
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 28 Sep 2005 08:00:08 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Re: Uml showstopper bugs for 2.6.14
Message-ID: <20050928145250.GB11610@ccure.user-mode-linux.org>
References: <200509271846.51804.blaisorblade@yahoo.it>
	<20050927193055.GA30451@ccure.user-mode-linux.org>
	<200509281415.18586.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509281415.18586.blaisorblade@yahoo.it>
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
Date: Wed, 28 Sep 2005 10:52:50 -0400
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>

On Wed, Sep 28, 2005 at 02:15:18PM +0200, Blaisorblade wrote:
> Do you know when this was introduced, and the last working UML version?

It's always been broken, I think.  It results from the stub having to
sigreturn by hand because it has no access to the libc restorer, and thus 
needing to restore the stack pointer to where it was on entry.  I did this
by popping the requisite number of times.  Bodo fixed this for i386, and
I need to do something similar for x86_64.

				Jeff


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
