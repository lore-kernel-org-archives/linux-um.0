Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AxyNs-0001pE-1S for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 01 Mar 2004 17:07:44 -0800
Received: from stclair.eecs.umich.edu ([141.213.8.40])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30) id 1AxxuG-00042o-VP
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 01 Mar 2004 16:37:09 -0800
From: George Washington Dunlap III <dunlapg@umich.edu>
Subject: Re: [uml-devel] Overhead of UML-skas
In-Reply-To: <Pine.LNX.4.44.0403011908090.2524-100000@sparrow>
Message-ID: <Pine.LNX.4.44.0403011920310.23055-100000@stclair.eecs.umich.edu>
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
Date: Mon, 1 Mar 2004 19:55:16 -0500 (EST)
To: William Stearns <wstearns@pobox.com>
Cc: ML-uml-devel <user-mode-linux-devel@lists.sourceforge.net>

On Mon, 1 Mar 2004, William Stearns wrote:
> 	Do the boot time messages say it's actually going into skas mode?
> 	Do you have tmpfs mounted on /tmp, with enough potential space for 
> all virtual machines?  
> http://www.stearns.org/slartibartfast/uml-coop.current.html#host
[snip]
> 	Helper process?
> 	BTW, any chance you have Synchronous mode turned on for ubd?  
> Please make sure that's off in your kernel compile.

Thanks for the quick response.

* SKAS mode: I didn't look specifically at the post messages in those
runs, but I'm using the same scripts and HD image (and getting similar
numbers for UML) for the last 3-4 months.  Plus, TT mode is disabled in
the config.  The most recent run (on a different benchmark) did say:
 Checking for the skas3 patch in the host...found
 Checking for /proc/mm...found

I've been getting those kinds of numbers for awhile; I was only shocked 
when I finally ran numbers on the host and found out how much faster it 
was. =)

* /tmp: I wasn't using tmpfs, but I had ramfs mounted on /tmp/uml, and the
TMP environment variable set to it.  Again, I didn't verify it for this
particular run, but I had verified it some time ago when I set my
environment up.  I may try tmpfs at some point and see if there's any
performance difference.

Hm, it appears that one of my co-workers changed the scripts, and it
wasn't actually making things in /tmp/uml anymore!  Stand-by while I do a
quick test run with ramfs and see what we get...well, there doesn't seem
to be much difference, but I'll do some more controlled tests later
tonight.

* Async I/O: In order to do asyncronous I/O without a kernel that supports
asyncronous I/O, UML forks off a "helper process" that does the blocking
(i.e., guest kernel sends it a command; it does a read() and blocks; when
the read returns, it sends a message to the guest kernel that the data's
been read).

Our standard mode of operation is to have ayncronous I/O turned off by
default, because of the extra process that's created.  (It has to do with
the research we're doing right now.)  I explicitly enabled it for this
build, and verified that the helper process was being created. It resulted
in a marked speed increase (about 6% for this benchmark, if you're
interested).

Thanks for your time,
 -George

-- 
+-------------------+----------------------------------------
| dunlapg@umich.edu | http://www-personal.umich.edu/~dunlapg 
+-------------------+----------------------------------------
| "An empty life of luxury is still an empty life"
|    -- everybodyduck, "Walk the Plank"
+------------------------------------------------------------
| Outlaw Junk Email! Support HR 1748 (www.cauce.org)





-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
