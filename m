Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BBPBq-0007ir-Qc for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 07 Apr 2004 19:22:50 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BBPBq-0006yu-C1 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 07 Apr 2004 19:22:50 -0700
Received: from ccure.user-mode-linux.org (lakshmi.solana.com [127.0.0.1])
	by lakshmi.solana.com (8.11.2/8.9.3) with ESMTP id i381wQK14076
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 7 Apr 2004 21:58:26 -0400
Received: from ccure.user-mode-linux.org (localhost.localdomain [127.0.0.1])
	by ccure.user-mode-linux.org (8.12.5/8.12.5) with ESMTP id
	i380U5be008776 for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 7 Apr 2004 20:30:06 -0400
Message-Id: <200404080030.i380U5be008776@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] uml-patch-2.4.24-2
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
Date: Wed, 07 Apr 2004 20:30:05 -0400
To: user-mode-linux-devel@lists.sourceforge.net

This long-awaited patch contains a lot of stuff.  

First the bug fixes:
	fixed some failed reboots by making sure that no signals can arrive
between the exec of the new instance and when it's ready to receive signals
	also fixed a similar skas-mode bug cause by enabling the timer before
a handler was established for it
	the COW header is more 64-bit clean now
	the klogd crash is fixed
	the real-time clock now uses gettimeofday rather than the tsc, 
improving portability, providing better behavior when the CPU slows or idles,
and fixes a crash caused by running UML in a chroot jail
	the 'tracing myself' bug on 2.6 hosts is now properly fixed

The functionality is two main things - humfs and aio support.

humfs is a new host filesystem which provides proper ownership support, which
hostfs sorely lacks.  It does this by separating the ownership information
from the file ala umsdos.  The immediate impetus for this was to allow file
data to be mmapped from the host, which, in conjunction with /dev/anon, will
provide nice memory savings.  There turn out to be a number of other benefits
which I describe on my diary page - 
	http://user-mode-linux.sourceforge.net/diary.html

In order to use humfs, you'll need to configure the filesystem on the host
properly.  There's a utility to do this in the uml_utilities, which will be
released shortly.  I'm also going to write up a description of how it works
and sending it to the lists, as well as putting something on the UML site.

I also added improved aio support.  There are two varieties, one is the 
ubd-style one-synchronous-request-at-a-time IO thread, and another which creates
a thread which uses the 2.6 aio interfaces to handle an arbitrary number of
pending requests.  This will hopefully start to fix the IO performance problems
that UML currently has.  The ubd driver will be converted over to use this,
giving it access to full aio when it's supported by the host.  humfs already
does use it.

There was also a restructuring of hostfs.  There is an abstract, pluggable 
interface between the kernel and user sides.  Both hostfs_user and humfs
are user modules which plug into this interface.  There are many more 
possibilities.  See the diary above for more details.

				Jeff



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
