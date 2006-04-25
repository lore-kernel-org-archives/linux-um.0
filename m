Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.93] (helo=sc8-sf-list1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FYQsc-0003m3-5A for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 25 Apr 2006 09:59:14 -0700
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FYQsc-0001ms-Br for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 25 Apr 2006 09:59:14 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FYQsa-0004Lx-BE
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 25 Apr 2006 09:59:14 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Re: [RFC] PATCH 3/4 - Time virtualization :
	PTRACE_SYSCALL_MASK
Message-ID: <20060425155942.GA22807@ccure.user-mode-linux.org>
References: <200604131720.k3DHKqdr004720@ccure.user-mode-linux.org>
	<20060420090514.GA9452@osiris.boeblingen.de.ibm.com>
	<200604212016.36859.blaisorblade@yahoo.it>
	<20060422070610.GA9459@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060422070610.GA9459@osiris.boeblingen.de.ibm.com>
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
Date: Tue, 25 Apr 2006 11:59:42 -0400
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Blaisorblade <blaisorblade@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Sat, Apr 22, 2006 at 09:06:10AM +0200, Heiko Carstens wrote:
> > The flags could be:
> > 
> > MASK_DEFAULT_TRACE (set the default to 1 for remaining bits)
> > MASK_DEFAULT_IGNORE (set the default to 0 for remaining bits)
> > MASK_STRICT_VERIFY (return -EINVAL for bits exceeding NR_syscalls and set 
> > differently than the default).

I'd prefer (given that there aren't any unused ptrace arguments) using
the operation for this - PTRACE_SYSCALL_MASK_TRACE,
PTRACE_SYSCALL_MASK_IGNORE.  We'd need better names than these
horribly over-long ones, though.

> You might as well introduce yet another ptrace call which returns the number
> of system calls and for this ptrace call force user space to pass a complete
> bitmap. Sounds easier to me.

I think that's just building in fragility whenever userspace doesn't
happen to match the kernel.  Both UML and strace will know what system
calls they are interested in.  Having the kernel 1- or 0-extend the
mask will automatically do the right thing.  If userspace is newer
than the kernel, and asks for special treatment for system calls that
don't exist, then it should get a -EINVAL.

				Jeff


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
