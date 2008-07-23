Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Date: Wed, 23 Jul 2008 12:14:30 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080723161430.GC15682@c2.user-mode-linux.org>
References: <20080721154658.GA6860@c2.user-mode-linux.org>
	<488599E1.50402@panasas.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <488599E1.50402@panasas.com>
Subject: Re: [uml-devel] [PATCH] Fix for 2.6.26 ptrace crash
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
To: Boaz Harrosh <bharrosh@panasas.com>
Cc: David Shane Holden <dpejesh@yahoo.com>, "david.r" <david.r@seznam.cz>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, uml-user <user-mode-linux-user@lists.sourceforge.net>, Peter Teoh <htmldeveloper@GMAIL.COM>

On Tue, Jul 22, 2008 at 11:27:13AM +0300, Boaz Harrosh wrote:
> I'm not sure I fully understand. Could you please explain what you
> found.

arch/um/include/init.h copies enough definitions from linux/compiler.h
and linux/init.h to implement initcall and exitcall et al.  It can't
include the kernel headers because it's included in userspace files,
and libc and kernel headers don't mix.

What happened was that I copied enough to make a distinction between
gcc 3.3 and higher vs lower than 3.3 (for the latter, the kernel
defines __used as attribute(__unused) for some reason).

However, since my ifdefs weren't looking at the major version, these
definitions also held for gcc 4.x.  And when I added unit-at-a-time,
the __unused started being taken seriously, and UML libc-side
initcalls were thrown out.

> Why is it that with same compiler, some systems had a problem and some
> did not? is it .config related?

I have no idea.  When Ulrich Drepper first hit this, he and I had the
same base system, same architecture, same toolchain, same config, and
I didn't see it.

I've upgraded since then, so I can't test in the same environment, but
when I add the bug back in such that it hits with gcc 4.3, I get the
crash.

So, this is very mysterious.

> Also I would prefer if the:
>    #define __used __attribute__((__used__))
> would get an #if ((__GNUC__* 100 + __GNUC_MINOR__) >= 303 )
> of its own because other wise this problem will return when
> gcc hits 5. Just as it returned now. 

I don't see the point - this is all wrapped in __GNUC__ == 3 or 4.  As
for gcc 5, linux/compiler has this to say:

#else
# error Sorry, your compiler is too old/not recognized.
#endif

So the kernel totally won't build with gcc 5.

			Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
