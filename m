Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AxxjC-0000ox-AT for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 01 Mar 2004 16:25:42 -0800
Received: from 101.24.177.216.inaddr.g4.net ([216.177.24.101]
	helo=sparrow.stearns.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1AxxXB-0001VG-8k for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 01 Mar 2004 16:13:17 -0800
From: William Stearns <wstearns@pobox.com>
Reply-To: William Stearns <wstearns@pobox.com>
Subject: Re: [uml-devel] Overhead of UML-skas
In-Reply-To: <Pine.LNX.4.44.0403011824040.19252-100000@stclair.eecs.umich.edu>
Message-ID: <Pine.LNX.4.44.0403011908090.2524-100000@sparrow>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
Date: Mon, 1 Mar 2004 19:13:05 -0500 (EST)
To: George Washington Dunlap III <dunlapg@umich.edu>
Cc: ML-uml-devel <user-mode-linux-devel@lists.sourceforge.net>, William Stearns <wstearns@pobox.com>

Good evening, George,

On Mon, 1 Mar 2004, George Washington Dunlap III wrote:

> Hey Jeff (and any other interested parties) -- this is George Dunlap, from
> the CoVirt group at U of M.  I've been testing the overhead of running
> workloads under UML compared to on the bare host, and we're getting some
> unexpectedly slow numbers -- for the particular benchmark we're using,
> about 105% overhead;  I was wondering if you could shed any light on the
> subject: has anyone had similar experiences, and are there any obvious 
> optimizations we're missing.

	Do the boot time messages say it's actually going into skas mode?
	Do you have tmpfs mounted on /tmp, with enough potential space for 
all virtual machines?  
http://www.stearns.org/slartibartfast/uml-coop.current.html#host


> 
> We're using 2.4.20-7um, on a 2.4.18 host with the skas patch.  UML has 
> raw access to its own disk (via 'raw /dev/raw/raw1 /dev/hdc'), and is 
> given 256M (out of 1Gig host memory).  Asyncronous I/O is enabled via the 
> helper process.  COW disk mode is off.

	Helper process?
	BTW, any chance you have Synchronous mode turned on for ubd?  
Please make sure that's off in your kernel compile.
	Cheers,
	- Bill

---------------------------------------------------------------------------
        "According to the study, the three-year cost of a 100,000-hit
processing unit was significantly different among the systems: 
Solaris: $561,520
Windows: $190,662
Linux: $74,475"
	(A processing unit is the number of servers that would be
required to process 100,000 hits per day)
http://techupdate.zdnet.com/techupdate/stories/main/0,14179,2907876-3,00.html
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
