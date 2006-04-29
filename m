Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.93] (helo=sc8-sf-list1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FZl8i-0000Lk-Tu for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 29 Apr 2006 01:49:20 -0700
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FZl8j-0003BF-1e for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 29 Apr 2006 01:49:21 -0700
Received: from mtagate4.de.ibm.com ([195.212.29.153])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FZl8h-0001Gr-Eq
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 29 Apr 2006 01:49:21 -0700
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate4.de.ibm.com (8.13.6/8.13.6) with ESMTP id k3T8n84P082820
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 29 Apr 2006 08:49:08 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k3T8oHGg105856 for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 29 Apr 2006 10:50:17 +0200
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11/8.13.3) with ESMTP id
	k3T8n8e5023683 for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 29 Apr 2006 10:49:08 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [uml-devel] [RFC] PATCH 3/4 - Time virtualization :
	PTRACE_SYSCALL_MASK
Message-ID: <20060429084907.GD9463@osiris.boeblingen.de.ibm.com>
References: <200604131720.k3DHKqdr004720@ccure.user-mode-linux.org>
	<200604261747.54660.blaisorblade@yahoo.it>
	<20060426154607.GA8628@ccure.user-mode-linux.org>
	<200604282228.46681.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200604282228.46681.blaisorblade@yahoo.it>
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
Date: Sat, 29 Apr 2006 10:49:07 +0200
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, Bodo Stroesser <bstroesser@fujitsu-siemens.com>

> Ok, this gives us a definite proposal, which I finally like:
> 
> * to exclude sys_tee:
> 
> bitmask = 0;
> set_bit(__NR_tee, bitmask);
> ptrace(PTRACE_SET_NOTRACE, bitmask);
> 
> * to trace only sys_tee:
> 
> bitmask = 0;
> set_bit(__NR_tee, bitmask);
> ptrace(PTRACE_SET_TRACEONLY, bitmask);
> 
> Semantics:
> 
> in both cases, the mask is first zero-extended to the right (for syscalls not 
> known to userspace), bits for syscall not known to the kernel are checked and 
> the call fails if any of them is 1, and in the failure case E2BIG or 
> EOVERFLOW is returned (I want to avoid EINVAL and ENOSYS to avoid confusion) 
> and the part of the mask known to the kernel is 0-ed.
> 
> In case of success, for NOTRACE (which was DEFAULT_TRACE) the mask is reversed 
> before copying in the kernel syscall mask, for TRACEONLY it's copied there 
> directly.

IMHO this is way too complicated. Introducing a ptrace call that returns
the number of syscalls and forcing user space to pass a complete bitmask
is much easier. Also the semantics are much easier to understand.

In addition your proposal would already introduce a rather complicated
interface to figure out how many syscalls the kernel has. I'm sure this
will be (mis)used sooner or later.


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
