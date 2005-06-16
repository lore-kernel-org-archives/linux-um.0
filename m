Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Dj0NZ-0000Iq-LD	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 16 Jun 2005 12:50:21 -0700
Received: from slartibartfast.pa.net ([66.59.111.182])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1Dj0NV-0004ID-4i	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 16 Jun 2005 12:50:21 -0700
From: William Stearns <wstearns@pobox.com>
Reply-To: William Stearns <wstearns@pobox.com>
Message-ID: <Pine.LNX.4.63.0506161543280.6638@sparrow>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Subject: [uml-devel] x86_64, TT mode, no tmpfs - steadily growing number of
	threads
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
Date: Thu, 16 Jun 2005 15:49:43 -0400 (EDT)
To: ML-uml-devel <user-mode-linux-devel@lists.sourceforge.net>
Cc: Jeff Dike <jdike@addtoit.com>, William Stearns <wstearns@pobox.com>

Good afternoon, all,
 	With a FC2 x86_64 host with no skas patch (stock RH kernel) and no 
tmpfs, I find that a 2.6.6 uml vm (happens to be i386 slackware) keeps 
getting more and more pids out on the host.  By mounting /tmp as tmpfs, 
this effect goes away; the vm stays around 140 pids and doesn't appear 
to grow any further.
 	When the PID leakage(?) was happening, I would usually contact the 
owner of that VM once it was up around 8,000 host pid's and was occupying 
around 4G of ram so we could recover all of those.  :-)
 	The reason why I didn't have tmpfs mounted on that host was that 
uml.ctl ends up there and for some reason I could not get networking to 
work on x86_64 when /tmp was mounted tmpfs.  By convincing uml_switch and 
the vm itself to use /var/tmp/uml_ctl, networking worked again.
 	Cheers,
 	- Bill

---------------------------------------------------------------------------
 	"First rule: Never sweat the petty things, or pet the sweaty things."
(Courtesy of "Michael J. Dark" <darkmich@zebu.cvm.msu.edu>)
--------------------------------------------------------------------------
William Stearns (wstearns@pobox.com).  Mason, Buildkernel, freedups, p0f,
rsync-backup, ssh-keyinstall, dns-check, more at:   http://www.stearns.org
--------------------------------------------------------------------------


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
