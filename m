Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Crzqm-0007tI-9A for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 21 Jan 2005 06:33:24 -0800
Received: from pool-151-203-197-142.bos.east.verizon.net ([151.203.197.142]
	helo=ccure.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41) id 1Crzqk-0000MZ-RF
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 21 Jan 2005 06:33:24 -0800
Message-Id: <200501211656.j0LGuVFH003504@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] SIGSEGV and SA_NODEFER 
In-Reply-To: Your message of "Fri, 21 Jan 2005 14:09:25 +0100."
	<200501211409.26232.blaisorblade@yahoo.it> 
References: <200501182128.j0ILSgxi013966@ccure.user-mode-linux.org>
	<200501200107.43159.blaisorblade@yahoo.it>
	<200501211409.26232.blaisorblade@yahoo.it> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
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
Date: Fri, 21 Jan 2005 11:56:30 -0500
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net


blaisorblade@yahoo.it said:
> Are we sure it is a compensation? I started having the doubt that
> enabling the  signal inside the handler is not the same thing...
> because otherwise we don't  understand why the patch in 2.4 makes
> difference in TT mode.

Well, it clearly does something very close to SA_NODEFER, so it's compensation
in that sense.

> Indeed, the blocking is done in the same way, but probably the timing
> is  different - i.e. we unblock the signal only after
> unprotect_kernel_mem() in  the new code, which somehow *makes* a
> difference.

Maybe.  If unprotect_kernel_mem has anything to do with it, then it can
only affect jail mode in tt, which I'm planning on doing away with anyway
at some point.

> I'm going to choose the SA_NODEFER instead of adding the explicit
> check, at  least for 2.4. I'd do it for 2.6 too, only that I'm not too
> sure. 

My preference would be SA_NODEFER.  Do we know who was having problems that
were fixed by this?  Maybe we could see what exactly SA_NODEFER does there.

				Jeff



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
