Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <viro@ftp.linux.org.uk>) id 1Rrwrb-0006wW-9r
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 30 Jan 2012 19:26:03 +0000
Received: from zeniv.linux.org.uk ([195.92.253.2])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1RrwrX-0007wT-1i
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 30 Jan 2012 19:26:03 +0000
Date: Mon, 30 Jan 2012 19:25:52 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
Message-ID: <20120130192552.GL23916@ZenIV.linux.org.uk>
References: <1327512234-22578-1-git-send-email-richard@nod.at>
	<20120130182333.GK23916@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20120130182333.GK23916@ZenIV.linux.org.uk>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] [PATCH 1/2] um: Use generic io.h
To: Richard Weinberger <richard@nod.at>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Mon, Jan 30, 2012 at 06:23:33PM +0000, Al Viro wrote:
> On Wed, Jan 25, 2012 at 06:23:53PM +0100, Richard Weinberger wrote:
> > There is no need to implement our own basic io functions.
> > All we need exists already in asm-generic/io.h
> 
> Then just do
> 
> git rm arch/um/include/asm/io.h
> echo 'generic-y += io.h' >>arch/um/include/asm/Kbuild
> git add arch/um/include/asm/Kbuild
> 
> and be done with that.  We are already using generic-y for a bunch of
> headers there...

While we are at it, param.h and pci.h appear to be candidates for the
same treatment, along with delay.h and auxvec.h.  mutex.h as well...
BTW, we probably can kill arch/um/include/asm/asm-offsets.h - everything
in there is using generated/asm-offsets.h directly.

FWIW, I'd probably kill current.h as well - replace get_current() in
arch/um/kernel/process.c with get_current_pid() (i.e. task_pid_nr(current)),
kill HOST_TASK_PID and switch arch/x86/um/bugs_32.c to use of get_current_pid()
and we can switch to asm-generic/current.h just fine.

------------------------------------------------------------------------------
Try before you buy = See our experts in action!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-dev2
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

