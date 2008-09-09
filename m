Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Kcqkq-0004cL-N0 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 08 Sep 2008 17:06:48 -0700
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Kcqkp-0008V5-7C
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 08 Sep 2008 17:06:48 -0700
Date: Mon, 8 Sep 2008 17:04:27 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Message-Id: <20080908170427.c8bf38f5.akpm@linux-foundation.org>
In-Reply-To: <48C51439.7000706@linux.vnet.ibm.com>
References: <48C51439.7000706@linux.vnet.ibm.com>
Mime-Version: 1.0
Subject: Re: [uml-devel] [PATCH 1/1] system call notification with self_ptrace
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
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Pierre Morel <pmorel@linux.vnet.ibm.com>
Cc: linux-arch@vger.kernel.org, sameske@linux.vnet.ibm.com, Michael Kerrisk <mtk.manpages@googlemail.com>, user-mode-linux-devel@lists.sourceforge.net, gregkh@suse.de, heicars2@linux.vnet.ibm.com, linux-kernel@vger.kernel.org, dave@linux.vnet.ibm.com, dlezcano@fr.ibm.com, clg@fr.ibm.com, schwidefsky@de.ibm.com, mingo@elte.hu, oleg@tv-sign.ru, roland@redhat.com

On Mon, 08 Sep 2008 14:02:01 +0200
Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:

> Subject: [PATCH] system call notification with self_ptrace
> 
> From: Pierre Morel <pmorel@fr.ibm.com>
> 
> 
> PTRACE SELF
> 
> This patch adds a new functionality to ptrace: system call notification to
> the current process.
> When a process requests self ptrace, with the new request PTRACE_SELF_ON:
> 
>  1.  the next system call performed by the process will not be executed
>  2.  self ptrace will be disabled for the process
>  3.  a SIGSYS signal will be sent to the process.
> 
> With an appropriate SIGSYS signal handler, the process can access its own
> data structures to
> 
>  1.  get the system call number from the siginfo structure
>  2.  get the system call arguments from the stack
>  3.  instrument the system call with other system calls
>  4.  emulate the system call with other system calls
>  5.  change the arguments of the system call
>  6.  perform the system call for good
>  7.  change the return value of the system call
>  8.  request self ptrace again before returning.
> 
> The new request PTRACE_SELF_OFF disables self ptrace.
> 

It sounds like it might be useful.

Are there any userspace tools available with which people can utilise
this new functionality?  Or plans to release them?

> arch/s390/kernel/ptrace.c     |   16 ++++++++++++++++
> arch/s390/kernel/signal.c     |    5 +++++
> arch/x86/kernel/ptrace.c      |   29 +++++++++++++++++++++++++++++
> arch/x86/kernel/signal_32.c   |    5 +++++
> arch/x86/kernel/signal_64.c   |    5 +++++

Maintainers of the other 30-odd architectures would appreciate a test
application which they can use to develop and test their ports, please.

Michael Kerrisk will no doubt be looking for manpage assistance. 
Please cc him on this material.

It would be good to get suitable testcases integrated into LTP (if LTP
has ptrace tests).

The patch title uses the term "self_ptrace", but the patch itself uses
the term "ptrace_self".  Let's get it consistent everywhere.

The patch adds a

+	u64	instrumentation;

to the task_struct but no explanation is provided as to why this was
added, why it is a 64-bit field, what its locking rules are, etc. 
Please fix this.



-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
