Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <rjones@redhat.com>) id 1VBLlA-0007Mc-4D
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 Aug 2013 09:28:24 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VBLl6-00048P-Ko for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 Aug 2013 09:28:24 +0000
Date: Mon, 19 Aug 2013 10:28:11 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20130819092811.GZ5918@redhat.com>
References: <1376825409-18570-1-git-send-email-richard@nod.at>
	<1376825409-18570-3-git-send-email-richard@nod.at>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1376825409-18570-3-git-send-email-richard@nod.at>
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
Subject: Re: [uml-devel] [PATCH 3/4] um: Cleanup SIGTERM handling
To: Richard Weinberger <richard@nod.at>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Sun, Aug 18, 2013 at 01:30:08PM +0200, Richard Weinberger wrote:
> Richard reported that some UML processes survive if the UML
> main process receives a SIGTERM.
> This issue was caused by a wrongly placed signal(SIGTERM, SIG_DFL)
> in init_new_thread_signals().
> It disabled the UML exit handler accidently for some processes.
> The correct solution is to disable the fatal handler for all
> UML helper threads/processes.
> Such that last_ditch_exit() does not get called multiple times
> and all processes can exit due to SIGTERM.
> 
> Cc: rjones@redhat.com
> Reported-by: Richard W.M. Jones <rjones@redhat.com>
> Signed-off-by: Richard Weinberger <richard@nod.at>

I tested this using the libguestfs UML backend, and the original
problem with not all processes being cleared up on exit has been fixed.

I also observed that the exit status has changed from "killed by
SIGTERM" to exit code 1.  Therefore:

Tested-by: Richard W.M. Jones <rjones@redhat.com>

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
virt-p2v converts physical machines to virtual machines.  Boot with a
live CD or over the network (PXE) and turn machines into KVM guests.
http://libguestfs.org/virt-v2v

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

