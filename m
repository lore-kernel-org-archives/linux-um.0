Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <rjones@redhat.com>) id 1VBLeh-0000pr-Vc
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 Aug 2013 09:21:44 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VBLee-0003o3-7T for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 Aug 2013 09:21:43 +0000
Date: Mon, 19 Aug 2013 10:21:31 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20130819092130.GY5918@redhat.com>
References: <1376825409-18570-1-git-send-email-richard@nod.at>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1376825409-18570-1-git-send-email-richard@nod.at>
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
Subject: Re: [uml-devel] [PATCH 1/4] um: ubd: Add REQ_FLUSH suppport
To: Richard Weinberger <richard@nod.at>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Sun, Aug 18, 2013 at 01:30:06PM +0200, Richard Weinberger wrote:
> UML's block device driver does not support write barriers,
> to support this this patch adds REQ_FLUSH suppport.
> Every time the block layer sends a REQ_FLUSH we fsync() now
> our backing file to guarantee data consistency.
> 
> Cc: rjones@redhat.com
> Reported-by: Richard W.M. Jones <rjones@redhat.com>
> Signed-off-by: Richard Weinberger <richard@nod.at>

Tested-by: Richard W.M. Jones <rjones@redhat.com>

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

