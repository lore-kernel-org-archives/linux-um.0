Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BKki0-0003ng-1m for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 03 May 2004 14:10:40 -0700
Received: from slartibartfast.pa.net ([66.59.111.182])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BKkhV-0000uO-Fp for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 03 May 2004 14:10:09 -0700
From: William Stearns <wstearns@pobox.com>
Reply-To: William Stearns <wstearns@pobox.com>
Message-ID: <Pine.LNX.4.58.0405031721560.4536@sparrow>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [uml-devel] Fedora Core 2 test3 root filesystem
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
Date: Mon, 3 May 2004 17:27:14 -0400 (EDT)
To: ML-uml-devel <user-mode-linux-devel@lists.sourceforge.net>
Cc: William Stearns <wstearns@pobox.com>

Good afternoon, all,
	I've got a first pass at a Fedora core 2 test3 root filesystem up 
at http://www.stearns.org/uml-root/ .  I haven't even tried to boot it 
yet, and assume it's probably going to need a good bit of work, not the 
least of which is renaming the /lib/tls directory so UML kernels can boot 
it at all.  This is _only_ for developers willing to get their hands 
dirty; it's not ready for general use yet.
	Bug reports welcome.  Bug reports with suggested fixes encouraged!  
I'll generally not add new rpm's to the build unless they're something so
critical that one can't even install new rpm's without them (damn, I
forgot the rpm rpm again? ;-)
	Cheers,
	- Bill

---------------------------------------------------------------------------
	Overheard at a party:
	Dr. Steve: "Solitaire is by far the most frequently-used Windows
program."
	Chris: "Huh, I would've guessed it was Scandisk."
(Courtesy of Marion Bates <Marion.Bates@Dartmouth.edu>)
--------------------------------------------------------------------------
William Stearns (wstearns@pobox.com).  Mason, Buildkernel, freedups, p0f,
rsync-backup, ssh-keyinstall, dns-check, more at:   http://www.stearns.org
--------------------------------------------------------------------------


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE. 
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
