Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
From: William Stearns <wstearns@pobox.com>
Reply-To: William Stearns <wstearns@pobox.com>
Message-ID: <Pine.LNX.4.44.0403120222160.2524-100000@sparrow>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [uml-devel] 2.6.4 UML kernel available
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
Date: Fri, 12 Mar 2004 02:27:13 -0500 (EST)
To: ML-uml-user <User-mode-linux-user@lists.sourceforge.net>, ML-uml-devel <user-mode-linux-devel@lists.sourceforge.net>
Cc: William Stearns <wstearns@pobox.com>

Good day, all,
	First - many thanks to Jeff and all the other kernel/uml hackers 
for all their work!

	I've put up a 2.6.4 UML kernel at http://www.stearns.org/uml/ .  
With the exception of the missing system call needed to run rh9+, I'm not 
aware of any kernel issues with this kernel *.  17 of the 29 Zaphod vm's 
are running it successfully.  Latency on the game server dropped from 
90-110ms down to 45-75 ms with nothing more than a kernel upgrade to 2.6.
	This one's highly recommended.
	Cheers,
	- Bill

* I'm having trouble finding the right command line to get Debian 3.0's 
init to hook up to the console devices, but that's most certainly my 
problem, and not the kernel's.

---------------------------------------------------------------------------
	"Nynex.  Iroquois for Moron"
	-- A well-known Linux kernel hacker.
--------------------------------------------------------------------------
William Stearns (wstearns@pobox.com).  Mason, Buildkernel, freedups, p0f,
rsync-backup, ssh-keyinstall, dns-check, more at:   http://www.stearns.org
--------------------------------------------------------------------------



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
