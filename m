Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Al0FV-0001Op-Tv for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 25 Jan 2004 22:29:29 -0800
Received: from 101.24.177.216.inaddr.g4.net ([216.177.24.101]
	helo=sparrow.stearns.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1Aktli-0003ra-Jl for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 25 Jan 2004 15:34:18 -0800
From: William Stearns <wstearns@pobox.com>
Reply-To: William Stearns <wstearns@pobox.com>
Message-ID: <Pine.LNX.4.44.0401251827030.2766-100000@sparrow>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [uml-devel] Swapping directly to host swap area?
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
Date: Sun, 25 Jan 2004 18:34:12 -0500 (EST)
To: ML-uml-devel <user-mode-linux-devel@lists.sourceforge.net>
Cc: William Stearns <wstearns@pobox.com>

Good evening, Jeff, all,
	Please feel free to file this in the "Damn, I wish Bill would 
read kernel source and get a clue" category if appropriate... :-)

	When a VM needs to swap out, is there some way the UML kernel
could send that sector directly to the host swap area instead of running
its own swap?  In the current setup, the host kernel sees this as a normal
write to an open file, caching it in the process and so not truly freeing
up the ram for a bit.  If the UML swapout routine handed the sector to the
host swapout routine, it might get freed faster.
	I don't _see_ this as a security concern; only root on the host 
could read the host swap directly; if anything this looks more secure than 
the swap file readable by the user under which uml runs on the host.

	Again, my apologies if my random ravings have no value in the real 
world.  Feel free to respond with nothing more than "not useful".  :-)
	Cheers,
	- Bill

---------------------------------------------------------------------------
        "Got me an office; I'm there late at night.
        Just send me e-mail, maybe I'll write."
        -- Joe Walsh for the 21st Century
(Courtesy of Bruce Tong <zztong@laxmi.ev.net>)
--------------------------------------------------------------------------
William Stearns (wstearns@pobox.com).  Mason, Buildkernel, freedups, p0f,
rsync-backup, ssh-keyinstall, dns-check, more at:   http://www.stearns.org
--------------------------------------------------------------------------



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
