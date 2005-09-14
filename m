Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EFVkX-0007tk-QC	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 14 Sep 2005 04:48:25 -0700
Received: from dgate1.fujitsu-siemens.com ([217.115.66.35])
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1EFVkW-0006GT-Hx
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 14 Sep 2005 04:48:26 -0700
Message-ID: <43280E00.6030707@fujitsu-siemens.com>
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] SYSEMU getting merged - but I'm in doubt
References: <200509041702.18506.blaisorblade@yahoo.it>
	<20050906161032.GA6157@ccure.user-mode-linux.org>
	<43270396.5050102@fujitsu-siemens.com>
	<200509132023.10959.blaisorblade@yahoo.it>
	<432732E5.5010303@fujitsu-siemens.com>
In-Reply-To: <432732E5.5010303@fujitsu-siemens.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
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
Date: Wed, 14 Sep 2005 13:48:16 +0200
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>, "Charles P. Wright" <cwright@cs.sunysb.edu>

Bodo Stroesser wrote:
> 
> If we talk about using a new ptrace code for the new API, old UML 
> binaries running
> on a host supporting the new API will recognize that there is no SYSEMU 
> they can
> use. So /proc/sysemu will not allow to switch on or off anything (IIRC, 
> the file
> will not even be created). That means, that an old binary will run safe 
> but slow
> in this case. One could argue, that this is a changed behaviour of the 
> old binary.
> 
> OTOH, if the new API would reuse the same ptrace code, check_sysemu of 
> the old
> binaries will fail on i386 (and I hope on x86_64, too). That means, 
> sysemu again
> will be disabled. AFAICS, it will not refuse to run at all. (Not tested, 
> taken from
> the code only)
> On s390 the check even might succeed accidentally, but that's no 
> problem, as s390
> isn't mainline yet, we can change check_sysemu() to avoid problems. 
> There will
> never be an old binary for s390.
> 
> Resume: it doesn't matter if a new ptrace code is used or the old one is 
> reused.
> Usage of sysemu will be restricted to "new UML on new host" or "old UML 
> on old host"
> as long as host doesn't support _both_ APIs (selectable by two separate 
> ptrace codes
> or by a new flag to PTRACE_SETOPTIONS). AFAICS, there is no reason to 
> change
> /proc/sysemu at all, right?

Some more points:

The new API must have PTRACE_SYSEMU _and_ PTRACE_SYSEMU_SINGLESTEP.
While with the old API SYSEMU_SINGLESTEP was inserted to improve security,
with the new one it will be necessary to allow singlestepping of processes
in UML-SKAS at all. Suppose a singlestepped userspace is stopped at a
syscall interception. Now UML needs to restart it with SYSEMU for syscall
emulation, but also wants to proceed with singlestepping. PTRACE_SYSEMU wouldn't
do the job, as it starts userspace in "normal" mode, no singlestepping.

Also, in tt new API's PTRACE_SYSEMU behaves as PTRACE_SYSCALL does, because tracer
uses PTRACE_CONT after syscall interception. So tt (do_syscall(), ...) needs to be
changed. PTRACE_SYSEMU_SINGLESTEP still should be used, as if it's name were
PTRACE_SYSCALL_SINGLESTEP.

	Bodo


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
