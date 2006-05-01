Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Facio-0001h8-Bc for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 01 May 2006 11:02:10 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Facim-0004QO-SU
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 01 May 2006 11:02:10 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] [RFC] PATCH 3/4 - Time virtualization :
	PTRACE_SYSCALL_MASK
Message-ID: <20060501170233.GC4592@ccure.user-mode-linux.org>
References: <200604131720.k3DHKqdr004720@ccure.user-mode-linux.org>
	<200604261747.54660.blaisorblade@yahoo.it>
	<20060426154607.GA8628@ccure.user-mode-linux.org>
	<200604282228.46681.blaisorblade@yahoo.it>
	<20060429084907.GD9463@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060429084907.GD9463@osiris.boeblingen.de.ibm.com>
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
Date: Mon, 1 May 2006 13:02:33 -0400
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Blaisorblade <blaisorblade@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, Bodo Stroesser <bstroesser@fujitsu-siemens.com>

On Sat, Apr 29, 2006 at 10:49:07AM +0200, Heiko Carstens wrote:
> IMHO this is way too complicated. Introducing a ptrace call that returns
> the number of syscalls and forcing user space to pass a complete bitmask
> is much easier. Also the semantics are much easier to understand.

This sounds more complicated than what we are proposing.  

This would make the process care about the number of system calls
implemented by the kernel, which is something that doesn't even come
up in the normal case with the current interface.  You only care about
it if you get a -EINVAL and want to figure out exactly why.

From a practical point of view, you would want code that looks like
this:
	n = nsyscalls();
	mask = malloc((n + 7)/8);
	if(mask == NULL)
		return;

	/* Zero mask, set bits, call ptrace */

	free(mask);

rather than code like this:

	int mask[(BIGGEST_SYSCALL_I_CARE_ABOUT + 7) / 8];

	/* Zero mask, set bits, call ptrace */

That doesn't seem like an improvement to me.

The second case would be more complicated if it wanted to figure out
what the problem was if ptrace returned -EINVAL.  However, some users
won't care, so that complexity is optional.  For example, UML will
already know by other means what system calls are implemented on the
host, so it won't bother looking at the mask in the case of a
failure.  I'm not sure what the right thing for strace is.

> In addition your proposal would already introduce a rather complicated
> interface to figure out how many syscalls the kernel has. I'm sure this
> will be (mis)used sooner or later.

How?  And, if so, why is that a problem?

There are already complicated ways to figure out what system calls the
kernel has, and I don't recall them causing problems.

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
