Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <rjones@redhat.com>) id 1VBLni-0001Zk-Bo
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 Aug 2013 09:31:02 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VBLnf-0003tl-0o for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 Aug 2013 09:31:02 +0000
Date: Mon, 19 Aug 2013 10:30:49 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20130819093049.GA5918@redhat.com>
References: <1376825409-18570-1-git-send-email-richard@nod.at>
	<1376825409-18570-4-git-send-email-richard@nod.at>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1376825409-18570-4-git-send-email-richard@nod.at>
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
Subject: Re: [uml-devel] [PATCH 4/4] um: Run UML in it's own session.
To: Richard Weinberger <richard@nod.at>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Sun, Aug 18, 2013 at 01:30:09PM +0200, Richard Weinberger wrote:
> If UML is not run by a shell it can happen that UML
> will kill unrelated proceses upon a fatal exit because
> it issues a kill(0, ...).
> To prevent such oddities we create a new session in main().
> 
> Cc: rjones@redhat.com
> Reported-by: Richard W.M. Jones <rjones@redhat.com>
> Signed-off-by: Richard Weinberger <richard@nod.at>

I tested this using the "debug segv" test script that I previously
posted on the user-mode-linux mailing list, and this problem is now
fixed.  Therefore:

Tested-by: Richard W.M. Jones <rjones@redhat.com>

Thanks for these great fixes!

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

