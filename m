Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.93] (helo=sc8-sf-list1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FZZaJ-00006C-W1 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 28 Apr 2006 13:29:03 -0700
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FZZaJ-0007S6-Uw for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 28 Apr 2006 13:29:04 -0700
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1FZZaH-0008Uf-9H
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 28 Apr 2006 13:29:04 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [RFC] PATCH 3/4 - Time virtualization :
	PTRACE_SYSCALL_MASK
References: <200604131720.k3DHKqdr004720@ccure.user-mode-linux.org>
	<200604261747.54660.blaisorblade@yahoo.it>
	<20060426154607.GA8628@ccure.user-mode-linux.org>
In-Reply-To: <20060426154607.GA8628@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200604282228.46681.blaisorblade@yahoo.it>
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
Date: Fri, 28 Apr 2006 22:28:46 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Bodo Stroesser <bstroesser@fujitsu-siemens.com>

On Wednesday 26 April 2006 17:46, Jeff Dike wrote:
> On Wed, Apr 26, 2006 at 05:47:54PM +0200, Blaisorblade wrote:

> Why not just zero out the bits that the kernel knows about?  Then, if
> we return -EINVAL, the process just looks at the remaining bits that
> are set to see what system calls the kernel didn't know about.

Good idea. When you're leaving the whole mask to 1 _except_ some bits set to 0 
what do you suggest? Setting everything to 1 so the process sees the invalid 
0 bits?

However, I've had a new idea for the API form - sigprocmask() is used to 
either enable or disable some bits in the _signal_ mask. But you pass in both 
cases the bits to toggle. Making the API more similar to this would be good.

Even if the semantics of both settings and clearing bits are unclear. 
Probably, simply making both calls _set_ the mask but one of them (i.e. 
MASK_DEFAULT_TRACE) reverse the mask before setting and after zero-extending 
it to the right.

Ok, this gives us a definite proposal, which I finally like:

* to exclude sys_tee:

bitmask = 0;
set_bit(__NR_tee, bitmask);
ptrace(PTRACE_SET_NOTRACE, bitmask);

* to trace only sys_tee:

bitmask = 0;
set_bit(__NR_tee, bitmask);
ptrace(PTRACE_SET_TRACEONLY, bitmask);

Semantics:

in both cases, the mask is first zero-extended to the right (for syscalls not 
known to userspace), bits for syscall not known to the kernel are checked and 
the call fails if any of them is 1, and in the failure case E2BIG or 
EOVERFLOW is returned (I want to avoid EINVAL and ENOSYS to avoid confusion) 
and the part of the mask known to the kernel is 0-ed.

In case of success, for NOTRACE (which was DEFAULT_TRACE) the mask is reversed 
before copying in the kernel syscall mask, for TRACEONLY it's copied there 
directly.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
