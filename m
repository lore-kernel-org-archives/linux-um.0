Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] compile errors for UMLPPC
Message-ID: <20050720225324.GA24232@ccure.user-mode-linux.org>
References: <838f7c50050720115954d28b25@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <838f7c50050720115954d28b25@mail.gmail.com>
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
Date: Wed, 20 Jul 2005 18:53:24 -0400
To: ashwin tanugula <ashwin.tanugula@gmail.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net

On Wed, Jul 20, 2005 at 02:59:34PM -0400, ashwin tanugula wrote:
> Hi,
> I am working on the UML/PPC port and I got the following errors. Can
> anybody tell me how to solve the ptrace_link and ptrace_unlink errors
> in linux/ptrace.h file?

>   CC      arch/um/util/mk_task_kern.o
> In file included from include/asm/arch/user.h:7,
>                  from include/asm/processor-i386.h:20,
>                  from include/asm/processor-generic.h:17,
>                  from include/asm/processor.h:11,
>                  from include/asm/thread_info.h:11,
>                  from include/linux/thread_info.h:21,
>                  from include/linux/spinlock.h:12,
>                  from include/linux/capability.h:45,
>                  from include/linux/sched.h:7,
>                  from arch/um/util/mk_task_kern.c:1:

First of all, there's something very wrong when you're trying to build
UML/ppc and you're pulling in include/asm/processor-i386.h.  Somehow,
your pool is corrupted by a previous i386 build.

Second, this is caused by a recursive include, where include/asm-ppc
is including linux/ptrace.h, which is trying to include sched.h.
We're in the middle of sched.h, so the that include doesn't happen,
but the task struct hasn't been defined yet in the outer sched.h so
the references to it fail.

The fix is to break this include chain somehow (after fixing the
processor-i386 thing).  Find one of those includes which is unecessary
(hopefully in UML code) and remove it.

				Jeff


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
