Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EFbgw-0001bH-68	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 14 Sep 2005 11:09:06 -0700
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1EFbgv-0002e9-Ga
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 14 Sep 2005 11:09:06 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] SYSEMU getting merged - but I'm in doubt
References: <200509041702.18506.blaisorblade@yahoo.it>
	<432732E5.5010303@fujitsu-siemens.com> <43280E00.6030707@fujitsu-siemens.com>
In-Reply-To: <43280E00.6030707@fujitsu-siemens.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509142001.14318.blaisorblade@yahoo.it>
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
Date: Wed, 14 Sep 2005 20:01:13 +0200
To: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>, "Charles P. Wright" <cwright@cs.sunysb.edu>

On Wednesday 14 September 2005 13:48, Bodo Stroesser wrote:
> Bodo Stroesser wrote:
> > OTOH, if the new API would reuse the same ptrace code, check_sysemu of
> > the old
> > binaries will fail on i386

> > (and I hope on x86_64, too). 
Nobody implemented sysemu for x86_64, at least to my knowledge.

I hoped to finish skas first, but stopped on that problem.
> > That means, 
> > sysemu again
> > will be disabled. AFAICS, it will not refuse to run at all. (Not tested,
> > taken from
> > the code only)
> > On s390 the check even might succeed accidentally, but that's no
> > problem, as s390
> > isn't mainline yet, we can change check_sysemu() to avoid problems.
> > There will
> > never be an old binary for s390.

> Some more points:

> The new API must have PTRACE_SYSEMU _and_ PTRACE_SYSEMU_SINGLESTEP.
Granted.
> While with the old API SYSEMU_SINGLESTEP was inserted to improve security,
> with the new one it will be necessary to allow singlestepping of processes
> in UML-SKAS at all. Suppose a singlestepped userspace is stopped at a
> syscall interception. Now UML needs to restart it with SYSEMU for syscall
> emulation, but also wants to proceed with singlestepping. PTRACE_SYSEMU
> wouldn't do the job, as it starts userspace in "normal" mode, no
> singlestepping.
Hmm, I hadn't looked at this detail...
> Also, in tt new API's PTRACE_SYSEMU behaves as PTRACE_SYSCALL does, because
> tracer uses PTRACE_CONT after syscall interception. So tt (do_syscall(),
> ...) needs to be changed. PTRACE_SYSEMU_SINGLESTEP still should be used, as
> if it's name were PTRACE_SYSCALL_SINGLESTEP.
Ok, I think it's enough to warrant keeping the current behaviour and adding 
later an option, and/or removing it for now and merging it later.

Unless somebody manages to fix all this in time. I don't think I'm likely to 
accomplish this, sorry.
> 	Bodo

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
