Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FXCCD-0002N3-6u for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 22 Apr 2006 00:06:21 -0700
Received: from mtagate1.de.ibm.com ([195.212.29.150])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FXCCB-0000wT-Kl
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 22 Apr 2006 00:06:21 -0700
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate1.de.ibm.com (8.13.6/8.13.6) with ESMTP id k3M76BFw035126
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 22 Apr 2006 07:06:11 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k3M77Dlh113290 for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 22 Apr 2006 09:07:13 +0200
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11/8.13.3) with ESMTP id
	k3M76AtR028499 for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 22 Apr 2006 09:06:10 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [uml-devel] Re: [RFC] PATCH 3/4 - Time virtualization :
	PTRACE_SYSCALL_MASK
Message-ID: <20060422070610.GA9459@osiris.boeblingen.de.ibm.com>
References: <200604131720.k3DHKqdr004720@ccure.user-mode-linux.org>
	<20060420090514.GA9452@osiris.boeblingen.de.ibm.com>
	<200604212016.36859.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200604212016.36859.blaisorblade@yahoo.it>
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
Date: Sat, 22 Apr 2006 09:06:10 +0200
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org

> For UML, instead, it's important to set that some peculiar syscalls are not 
> traced, that the mask is 1-extended and that errors are reported.
> 
> So, I suggest a "flags" parameter for this. Sadly, we're using the ptrace() 
> syscall and there's no 5th argument normally, we could either use it (IIRC 
> some calls use the 5th regs indeed), or pass as "data" a struct with flags 
> and the mask.
> 
> The flags could be:
> 
> MASK_DEFAULT_TRACE (set the default to 1 for remaining bits)
> MASK_DEFAULT_IGNORE (set the default to 0 for remaining bits)
> MASK_STRICT_VERIFY (return -EINVAL for bits exceeding NR_syscalls and set 
> differently than the default).
> 
> probably with a reasonable prefix to avoid namespace pollution (something like 
> "PT_SC_-").

You might as well introduce yet another ptrace call which returns the number
of system calls and for this ptrace call force user space to pass a complete
bitmap. Sounds easier to me.

> > The tracing process won't see 
> > any of the non existant syscalls it requested to see anyway.
> No, you misunderstood the code, it does the opposite very different - the loop 

Looks I missed a few "!"s :)


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
