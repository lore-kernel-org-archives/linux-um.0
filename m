Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1J1No9-00053j-1G for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 09 Dec 2007 07:11:05 -0800
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1J1No6-0006D3-VS
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 09 Dec 2007 07:11:04 -0800
Date: Sun, 9 Dec 2007 10:10:54 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20071209151054.GA4368@c2.user-mode-linux.org>
References: <475B6E19.6040200@BitWagon.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <475B6E19.6040200@BitWagon.com>
Subject: Re: [uml-devel] should there be os_clone() analogous to os_getpid() ?
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
To: John Reiser <jreiser@BitWagon.com>
Cc: uml-devel <user-mode-linux-devel@lists.sourceforge.net>

On Sat, Dec 08, 2007 at 08:24:57PM -0800, John Reiser wrote:
>In source file arch/um/os-Linux/process.c there is a warning:
>-----
>/* Don't use the glibc version, which caches the result in TLS. It misses some
> * syscalls, and also breaks with clone(), which does not unshare the TLS.
> */
> 
>int os_getpid(void)

AFAIK, there are two reasons that we make sure we call the system call
getpid -
	when we're testing ptrace, we want getpid to result in exactly
one system call
	there was a brief bug in libc where getpid returned the wrong
answer due to caching across a clone

This bug did get into the wild, and people did try to run UML on such
systems, so that's why the code is careful about making the system call.

> I see no os_clone(), yet the glibc clone() does the same caching of pid in
> ThreadLocalStorage [TLS], and the TLS still may be shared.  If nobody reads
> glibc's shared TLS slot for PID then an actual bug will be avoided.  However,
> it is unsafe to leave such a tempting pitfall.

What's the actual bug, exactly?  As long as libc's getpid gives us the
right answer, we're happy.

> Also, if you are ptrace()ing
> through a glibc clone(), then in many cases you will see syscall(__NR_getpid)
> *from glibc* immediately following!  There is an "extra" getpid()
> that the tracking logic might not expect.

Where do we care about how clone translates into a system call?

>    arch/um/drivers/ubd_user.c
>    arch/um/kernel/tt/tracer.c
>    arch/um/os/tt.c
>    arch/um/os/start_up.c
>    arch/um/os/skas/process.c

These guys all just want a new process - they don't care how it
happens.

Is something in here causing valgrind some trouble?

				Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
SF.Net email is sponsored by: 
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
