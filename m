Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1As6ql-0003ko-2W
	for user-mode-linux-devel@lists.sourceforge.net; Sat, 14 Feb 2004 12:57:19 -0800
Received: from 101.24.177.216.inaddr.g4.net ([216.177.24.101] helo=sparrow.stearns.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1As6oF-0006xB-IJ
	for user-mode-linux-devel@lists.sourceforge.net; Sat, 14 Feb 2004 12:54:43 -0800
From: William Stearns <wstearns@pobox.com>
Reply-To: William Stearns <wstearns@pobox.com>
Message-ID: <Pine.LNX.4.44.0402141543200.3225-100000@sparrow>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [uml-devel] UML kernel 2.6.3-rc2-1 available
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
Date: Sat, 14 Feb 2004 15:53:55 -0500 (EST)
To: ML-uml-devel <user-mode-linux-devel@lists.sourceforge.net>
Cc: William Stearns <wstearns@pobox.com>

Good day, all,
	I have a compiled 2.6.3-rc2-uml1 kernel available at 
http://www.stearns.org/uml/ .  It has some of the netfilter patch-o-matic 
modules available (see the associated config to see which ones).
	At the moment, it suffers from "sleeping process NNNNN got 
unexpected signal : 11" from time to time; I've seen it on startup just as 
the gettys get going, and at shutdown after "System halted", both on the 
stock rh-7.3 filesystem.  Other than that, it seems to run reasonably 
well.  I'd suggest against trusting production systems to it at the 
moment.
	Cheers,
	- Bill

---------------------------------------------------------------------------
	"Gartner recommends that enterprises hit by both Code Red and
Nimda immediately investigate alternatives to IIS, including moving Web
applications to Web server software from other vendors, such as iPlanet
and Apache. Although these Web servers have required some security
patches, they have much better security records than IIS and are not
under active attack by the vast number of virus and worm writers.
Gartner remains concerned that viruses and worms will continue to attack
IIS until Microsoft has released a completely rewritten, thoroughly and
publicly tested, new release of IIS."
	-- The Gartner Group
	http://www.gartner.com/DisplayDocument?doc_cd=101034
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
