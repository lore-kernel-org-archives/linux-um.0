Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B40w0-0003cE-LJ for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Mar 2004 09:03:56 -0800
Received: from goliath.nmsrv.com ([69.28.204.18] helo=mail.praize.com)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1B40w0-0002wE-72 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Mar 2004 09:03:56 -0800
Message-ID: <20040318170350.783.qmail@praize.com>
From: "gboutwel" <gboutwel@praize.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] Re: 2.6.4 UML kernel available
Content-Type: Text/Plain;
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
Date: 18 Mar 2004 17:03:50 -0000
To: user-mode-linux-devel@lists.sourceforge.net



> On Tue, 16 Mar 2004, Mike Snitzer wrote:



> > So Debian's init tries to spawn a getty on each and fails.
 I'm not using

> > devfs or anything; again the same debian testing FS works
great with a

> > 2.4.24 UML.



> Are you sure it is not a problem with the version of getty
used?



> Can you boot in singleuser mode?



> Do you get the console output while the system is booting?



It was determined that this is caused by the new thread system
in the new glibc (which is in Debian testing & Debain unstable,
but not in Dabin stable).  If you experience this problem the
easiest solution is to local-loopback the filesystem, go to it's
/lib/tls directory and move it.  Doing that solves the problem.



George



------------------------------------

Want to talk to other Christians?

Get the Christian Instant Messenger

http://www.praize.com/IM/ 





-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
