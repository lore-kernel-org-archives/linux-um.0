Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AxxL9-0003fG-Ly for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 01 Mar 2004 16:00:51 -0800
Received: from stclair.eecs.umich.edu ([141.213.8.40])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30) id 1Axx99-00063u-EF
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 01 Mar 2004 15:48:27 -0800
Received: from stclair.eecs.umich.edu (localhost.eecs.umich.edu [127.0.0.1])
	by stclair.eecs.umich.edu (8.12.8/8.12.8) with ESMTP id i21NmLA4022623
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 1 Mar 2004 18:48:21 -0500
Received: from localhost (dunlapg@localhost)
	by stclair.eecs.umich.edu (8.12.8/8.12.8/Submit) with ESMTP id
	i21NmLUk022619 for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 1 Mar 2004 18:48:21 -0500
From: George Washington Dunlap III <dunlapg@umich.edu>
Message-ID: <Pine.LNX.4.44.0403011824040.19252-100000@stclair.eecs.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [uml-devel] Overhead of UML-skas
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
Date: Mon, 1 Mar 2004 18:48:21 -0500 (EST)
To: user-mode-linux-devel@lists.sourceforge.net

Hey Jeff (and any other interested parties) -- this is George Dunlap, from
the CoVirt group at U of M.  I've been testing the overhead of running
workloads under UML compared to on the bare host, and we're getting some
unexpectedly slow numbers -- for the particular benchmark we're using,
about 105% overhead;  I was wondering if you could shed any light on the
subject: has anyone had similar experiences, and are there any obvious 
optimizations we're missing.

We're using 2.4.20-7um, on a 2.4.18 host with the skas patch.  UML has 
raw access to its own disk (via 'raw /dev/raw/raw1 /dev/hdc'), and is 
given 256M (out of 1Gig host memory).  Asyncronous I/O is enabled via the 
helper process.  COW disk mode is off.

The workload we're running is a "kernel build" benchmark, which consists
of the following commands:
  make clean ; make dep ; make bzImage.
This benchmark is run four times: once to warm up the cache, and thrice to 
get "warm cache" numbers.  All runs are taken immediately after booting 
the host kernel and then (if appropriate) the guest kernel.

We're comparing this against a 2.4.20 vanilla kernel using a copy of the 
same disk image, on the same disk.

Host 2.4.20 average:	 93 seconds
UML 2.4.20 average:	192 seconds (105% overhead)

All numbers were run on a P4 3GHz processor.

Two years ago for our ReVirt paper, we did the same test with UMLinux (now
FAUMAchine) (with some optimizations to make it not-dog-slow) on a 1.2GHz
AMD box and got a 70% overhead for that benchmark.  Similar tests at that
time with VMWare got about 30% overhead.

Has anyone else had a similar experience?  Are there any obvious reasons 
why it would be so much slower?

I realize that it's different hardware as well, so I'm not really 
comparing apples to apples.

The "kernel make" benchmark is sort of a wost-case of our "realistic 
workloads" because it makes a lot of system calls and forks a lot of 
processes.  

The numbers are for a RedHat 6.2 kernel image with ext2 FS, but we've
gotten similar ratio for a RedHat 9.0 installation with ext3.  (The
absolute time for both is increased, we think because the newer version of
gcc does more work.)

Any help would be appreciated.

-George Dunlap
PhD Candidate at the University of Michigan

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
