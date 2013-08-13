Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <rjones@redhat.com>) id 1V9BxW-0007GB-QV
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 13 Aug 2013 10:36:14 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1V9BxV-0003JV-RG for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 13 Aug 2013 10:36:14 +0000
Date: Tue, 13 Aug 2013 11:36:03 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20130813103603.GA27173@redhat.com>
References: <20130811174831.GD10864@redhat.com>
	<CAFLxGvxsdsjJ9LZs4-NFpGYYvRbEQ_YK2D=5W1S6uGCaWcgzSw@mail.gmail.com>
	<CAFLxGvz-PVQvKcs8cKZ8bpEfRj6Hw5h4-qNYrSRSq5Ga1axRvw@mail.gmail.com>
	<20130812085300.GV5918@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20130812085300.GV5918@redhat.com>
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
To: richard -rw- weinberger <richard.weinberger@gmail.com>
Cc: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

On Mon, Aug 12, 2013 at 09:53:00AM +0100, Richard W.M. Jones wrote:
> On Mon, Aug 12, 2013 at 10:15:24AM +0200, richard -rw- weinberger wrote:
> > Found the root cause, patch is on the way.
> 
> I can test patches if you CC me on them.

I'm still available to test patches :-)  Didn't see anything on
this list nor on LKML.

In particular I'm having a problem where it looks as if vmlinux is
sending a signal to its parent process on shutdown.

I can reliably reproduce this, although not with anything very
minimal.  But if you run the libguestfs test suite like this you'll
see it:

  make -C tests/regressions check TESTS=rhbz914931

The parent process (a C program which for unrelated reasons is called
'rhbz914931') receives a SIGTERM.  I checked the siginfo struct for
this signal, and it appears to come from the vmlinux main process,
which should not be happening.

So .. possibly there's something awry with how vmlinux delivers
signals to its child processes on shutdown which is causing it both to
miss out some children, and to kill other unrelated processes.  Or
maybe this is just a coincidence.

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming blog: http://rwmj.wordpress.com
Fedora now supports 80 OCaml packages (the OPEN alternative to F#)

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

