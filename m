Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Faopi-00081W-Sp for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 01 May 2006 23:58:06 -0700
Received: from mtagate3.de.ibm.com ([195.212.29.152])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Faopi-0007JR-7D
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 01 May 2006 23:58:07 -0700
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate3.de.ibm.com (8.13.6/8.13.6) with ESMTP id k426vue4025214
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 2 May 2006 06:57:56 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k426x7MP120320 for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 2 May 2006 08:59:07 +0200
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11/8.13.3) with ESMTP id
	k426vtdK009655 for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 2 May 2006 08:57:56 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [uml-devel] [RFC] PATCH 3/4 - Time virtualization :
	PTRACE_SYSCALL_MASK
Message-ID: <20060502065755.GB9482@osiris.boeblingen.de.ibm.com>
References: <200604131720.k3DHKqdr004720@ccure.user-mode-linux.org>
	<200604261747.54660.blaisorblade@yahoo.it>
	<20060426154607.GA8628@ccure.user-mode-linux.org>
	<200604282228.46681.blaisorblade@yahoo.it>
	<20060429084907.GD9463@osiris.boeblingen.de.ibm.com>
	<20060501170233.GC4592@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060501170233.GC4592@ccure.user-mode-linux.org>
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
Date: Tue, 2 May 2006 08:57:55 +0200
To: Jeff Dike <jdike@addtoit.com>
Cc: Blaisorblade <blaisorblade@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Bodo Stroesser <bstroesser@fujitsu-siemens.com>

> This sounds more complicated than what we are proposing.  
> 
> This would make the process care about the number of system calls
> implemented by the kernel, which is something that doesn't even come
> up in the normal case with the current interface.  You only care about
> it if you get a -EINVAL and want to figure out exactly why.
> 
> From a practical point of view, you would want code that looks like
> this:

Yes.

[1]
> 	n = nsyscalls();
> 	mask = malloc((n + 7)/8);
> 	if(mask == NULL)
> 		return;
> 
> 	/* Zero mask, set bits, call ptrace */
> 
> 	free(mask);
> 

[2]
> rather than code like this:
> 
> 	int mask[(BIGGEST_SYSCALL_I_CARE_ABOUT + 7) / 8];
> 
> 	/* Zero mask, set bits, call ptrace */


> That doesn't seem like an improvement to me.
> 
> The second case would be more complicated if it wanted to figure out
> what the problem was if ptrace returned -EINVAL.  However, some users

That is actually my point. If you're checking for errors you will end up
first doing [2] and later on doing something like [1] anyway...

> > In addition your proposal would already introduce a rather complicated
> > interface to figure out how many syscalls the kernel has. I'm sure this
> > will be (mis)used sooner or later.
> 
> How?  And, if so, why is that a problem?

From the proposal:

<snip>
> Semantics:
>
> in both cases, the mask is first zero-extended to the right (for syscalls not
> known to userspace), bits for syscall not known to the kernel are checked and
> the call fails if any of them is 1, and in the failure case E2BIG or
> EOVERFLOW is returned (I want to avoid EINVAL and ENOSYS to avoid confusion)
> and the part of the mask known to the kernel is 0-ed.
<snip>

So you just need to pass a large enough bitmask with all ones and the kernel
will put zeroes in the bitmask up to the bit number NR_sycalls - 1.
Counting the zeroes should work...


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
