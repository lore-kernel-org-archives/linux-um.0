Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AfvqG-00057C-32 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 11 Jan 2004 22:46:28 -0800
Received: from mta9.adelphia.net ([68.168.78.199])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1AfvqF-0004AH-OZ for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 11 Jan 2004 22:46:27 -0800
From: Matt Zimmerman <mdz@debian.org>
Message-ID: <20040112064620.GU1436@alcor.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [uml-devel] [inkblot@movealong.org: Bug#224215: incorrect /proc
	timestamp]
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
Date: Sun, 11 Jan 2004 22:46:20 -0800
To: user-mode-linux-devel@lists.sourceforge.net
Cc: 224215-forwarded@bugs.debian.org

----- Forwarded message from Nate Riffe <inkblot@movealong.org> -----

Date: Tue, 16 Dec 2003 19:17:10 -0600
From: Nate Riffe <inkblot@movealong.org>
Resent-From: Nate Riffe <inkblot@movealong.org>
To: submit@bugs.debian.org
Subject: Bug#224215: incorrect /proc timestamp

Package: user-mode-linux

The timestamp of /proc after mounting the proc filesystem is fixed at
Jan 1, 1970 (likely initialized to 0 in Unix time and then never set).
This causes problems for some distributions running as UML systems
using the user-mode-linux kernel, including Debian, which relies on the
timestamp of /proc to clear out the contents of /var/run and
/var/lock.  Comments in the "bootmisc.sh" initscript indicate that the
/proc timestamp is normally the time at which /proc is mounted.

I have also seen this issue with every other UML kernel to which I
have access, and so I believe it is probably an upstream bug.

-- 
--< ((\))< >----< inkblot@movealong.org >----< http://www.movealong.org/ >--
pub  1024D/05A058E0 2002-03-07 Nate Riffe (06-Mar-2002) <inkblot@movealong.org>
     Key fingerprint = 0DAC F5CB D182 3165 D757  C466 CD42 12A8 05A0 58E0

----- End forwarded message -----

-- 
 - mdz


-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
