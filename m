Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1As7Ip-0003Wd-KF
	for user-mode-linux-devel@lists.sourceforge.net; Sat, 14 Feb 2004 13:26:19 -0800
Received: from 101.24.177.216.inaddr.g4.net ([216.177.24.101] helo=sparrow.stearns.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1As7GJ-0002sz-FN
	for user-mode-linux-devel@lists.sourceforge.net; Sat, 14 Feb 2004 13:23:43 -0800
From: William Stearns <wstearns@pobox.com>
Reply-To: William Stearns <wstearns@pobox.com>
Subject: Re: [uml-devel] UML kernel 2.6.3-rc2-1 available
In-Reply-To: <Pine.LNX.4.44.0402141543200.3225-100000@sparrow>
Message-ID: <Pine.LNX.4.44.0402141556470.3225-100000@sparrow>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Sat, 14 Feb 2004 16:23:42 -0500 (EST)
To: ML-uml-devel <user-mode-linux-devel@lists.sourceforge.net>
Cc: William Stearns <wstearns@pobox.com>

Good day, all,

On Sat, 14 Feb 2004, William Stearns wrote:

> 	I have a compiled 2.6.3-rc2-uml1 kernel available at 
> http://www.stearns.org/uml/ .  It has some of the netfilter patch-o-matic 
> modules available (see the associated config to see which ones).
> 	At the moment, it suffers from "sleeping process NNNNN got 
> unexpected signal : 11" from time to time; I've seen it on startup just as 
> the gettys get going, and at shutdown after "System halted", both on the 
> stock rh-7.3 filesystem.  Other than that, it seems to run reasonably 
> well.  I'd suggest against trusting production systems to it at the 
> moment.

	Oops, forgot to mention:
	- The host on which this is running (2.6.3-rc1) has no skas patch,
so these errors showed up in tt mode.  On skas mode on a 2.4.23-rc3 host,
the error has not shown up at all in 2 complete startup-to-shutdown
cycles.  In skas mode, this _appears at first glance_ to be reasonably 
stable.
	- After kill -HUP'ing the tt mode "linux" from the host to kill it
off, the only uml process left was "linux [/sbin/update]"; any chance that
was the "sleeping process"?
	Cheers,
	- Bill

---------------------------------------------------------------------------
	Last week TechWeb reported that Eric S. Raymond was invited to
speak to a Microsoft Research Group. Given Raymond's status in the Open
Source Community, this is somewhat akin to the Vatican asking Martin
Luther to pay a visit in 1517 and chat about the note that he left.
	-- Joe "Zonker" Brockmeier
--------------------------------------------------------------------------
William Stearns (wstearns@pobox.com).  Mason, Buildkernel, freedups, p0f,
rsync-backup, ssh-keyinstall, dns-check, more at:   http://www.stearns.org
--------------------------------------------------------------------------



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
