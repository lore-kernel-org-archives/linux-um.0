Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <rjones@redhat.com>) id 1V9CRM-0007Ms-99
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 13 Aug 2013 11:07:04 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1V9CRK-0004mj-Pg for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 13 Aug 2013 11:07:04 +0000
Date: Tue, 13 Aug 2013 12:06:51 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20130813110651.GX5918@redhat.com>
References: <20130811174831.GD10864@redhat.com>
	<CAFLxGvxsdsjJ9LZs4-NFpGYYvRbEQ_YK2D=5W1S6uGCaWcgzSw@mail.gmail.com>
	<CAFLxGvz-PVQvKcs8cKZ8bpEfRj6Hw5h4-qNYrSRSq5Ga1axRvw@mail.gmail.com>
	<20130812085300.GV5918@redhat.com>
	<20130813103603.GA27173@redhat.com> <520A0F35.8000905@nod.at>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <520A0F35.8000905@nod.at>
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
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] How to reliably kill all vmlinux processes for a
 single VM?
To: Richard Weinberger <richard@nod.at>
Cc: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

On Tue, Aug 13, 2013 at 12:49:25PM +0200, Richard Weinberger wrote:
> Am 13.08.2013 12:36, schrieb Richard W.M. Jones:
> > In particular I'm having a problem where it looks as if vmlinux is
> > sending a signal to its parent process on shutdown.
> 
> Really?
> If so, why does it not kill my shell if I run it directly?

I've no idea.  Perhaps you never send SIGTERM to the vmlinux process,
or maybe this is just a very strange bug.  Although it happens
reliably in two tests from the test suite, it doesn't happen in any of
the other tests (about 100 of them).

Perhaps I'm wrong about the nature of the bug and the signal is coming
from somewhere else.  Is there a way that a process inside the guest
could send a signal to a process on the host?  (I would hope not, but
have to ask in case something in the guest is going rogue).

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Fedora Windows cross-compiler. Compile Windows programs, test, and
build Windows installers. Over 100 libraries supported.
http://fedoraproject.org/wiki/MinGW

------------------------------------------------------------------------------
Get 100% visibility into Java/.NET code with AppDynamics Lite!
It's a free troubleshooting tool designed for production.
Get down to code-level detail for bottlenecks, with <2% overhead. 
Download for free and get started troubleshooting in minutes. 
http://pubads.g.doubleclick.net/gampad/clk?id=48897031&iu=/4140/ostg.clktrk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

