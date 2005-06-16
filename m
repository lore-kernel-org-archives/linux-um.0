Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Dj2wg-0001Qy-R1	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 16 Jun 2005 15:34:46 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1Dj2wf-0005sq-9j	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 16 Jun 2005 15:34:46 -0700
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20050616221615.GE9792@ccure.user-mode-linux.org>
References: <Pine.LNX.4.63.0506161543280.6638@sparrow>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0506161543280.6638@sparrow>
Subject: [uml-devel] Re: x86_64, TT mode, no tmpfs - steadily growing number
	of threads
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
Date: Thu, 16 Jun 2005 18:16:15 -0400
To: William Stearns <wstearns@pobox.com>
Cc: ML-uml-devel <user-mode-linux-devel@lists.sourceforge.net>

On Thu, Jun 16, 2005 at 03:49:43PM -0400, William Stearns wrote:
> Good afternoon, all,
> 	With a FC2 x86_64 host with no skas patch (stock RH kernel) and no 
> tmpfs, I find that a 2.6.6 uml vm (happens to be i386 slackware) keeps 
> getting more and more pids out on the host.  By mounting /tmp as tmpfs, 
> this effect goes away; the vm stays around 140 pids and doesn't appear 
> to grow any further.

From the usage of an x86 filesystem, I gather that this is the 2.6.4 UML
that has the compatibility code in it.  No idea why it's leaking processes
(nor am I too interested in figuring it out unless it's still happening :-).

> 	The reason why I didn't have tmpfs mounted on that host was that 
> uml.ctl ends up there and for some reason I could not get networking to 
> work on x86_64 when /tmp was mounted tmpfs.  By convincing uml_switch and 
> the vm itself to use /var/tmp/uml_ctl, networking worked again.

You can specify the sockets you want uml_switch to use.  /tmp is just the
default.

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
