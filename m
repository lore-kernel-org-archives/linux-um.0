Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <rjones@redhat.com>) id 1V8nsG-0008Ix-7u
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 12 Aug 2013 08:53:12 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1V8nsE-0001r9-L1 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 12 Aug 2013 08:53:12 +0000
Date: Mon, 12 Aug 2013 09:53:00 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20130812085300.GV5918@redhat.com>
References: <20130811174831.GD10864@redhat.com>
	<CAFLxGvxsdsjJ9LZs4-NFpGYYvRbEQ_YK2D=5W1S6uGCaWcgzSw@mail.gmail.com>
	<CAFLxGvz-PVQvKcs8cKZ8bpEfRj6Hw5h4-qNYrSRSq5Ga1axRvw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAFLxGvz-PVQvKcs8cKZ8bpEfRj6Hw5h4-qNYrSRSq5Ga1axRvw@mail.gmail.com>
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

On Mon, Aug 12, 2013 at 10:15:24AM +0200, richard -rw- weinberger wrote:
> Found the root cause, patch is on the way.

I can test patches if you CC me on them.

> > Why do you need to kill UML?
> > Can't you shutdown it?

In the qemu/KVM case it's safe to kill the qemu process, as qemu
catches the signal and shuts down safely (in particular: it properly
flushes any writes in flight).  I just copied that same code from the
qemu backend to the UML backend.  The libguestfs test suite includes a
test to determine if data is flushed properly on shutdown.

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
virt-df lists disk usage of guests without needing to install any
software inside the virtual machine.  Supports Linux and Windows.
http://people.redhat.com/~rjones/virt-df/

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

