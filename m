Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CzREV-00013y-NC for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 10 Feb 2005 19:12:39 -0800
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CzREU-0007Bk-0U for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 10 Feb 2005 19:12:39 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502110411.35438.blaisorblade@yahoo.it>
Subject: [uml-devel] SKAS-v8: RC2 released against 2.6.7 - 2.6.11-rc3-bk6
	kernels
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
Date: Fri, 11 Feb 2005 04:11:34 +0100
To: user-mode-linux-devel@lists.sourceforge.net, Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Cc: user-mode-linux-user@lists.sourceforge.net, Gerd Knorr <kraxel@bytesex.org>, Michael Richardson <mcr@sandelman.ottawa.on.ca>, Henrik Nordstrom <hno@marasystems.com>

This time, I've announced this on my homepage, since I'd like to get some more 
testing.

Things I've forgot:
* make it apply easily on Fedora kernels.

This should simply mean moving the TIF_SYSCALL_EMU to place no.8, to leave a 
slot free for _DB7, needed for 4g4g or something like that and using testw 
instead of testb for testing against it.

Summary of changes against -V7 (also put in the "ChangeLog" page):

* for kernels >=2.6.10, in the splitout, various patches were folded together.

* rename-modify-ldt-to-avoid-conflicts.patch: fix the reported ATI module 
compile problem by renaming modify_ldt to __modify_ldt.

* ptrace_ldt-reload-smp-fix.patch: fix a SMP-host bug noticed by Bodo 
Stroesser.

* skas-add-locking-for-mm-switch.patch: from me, add correct locking to 
PTRACE_SWITCH_MM to avoid races. Someone please test with SMP hosts / with 
spinlock debugging enabled, to check for any possible deadlock. I'll do this 
in next days, too.

* skas-reorganize and skas-add-SYSEMU_SINGLESTEP: from Bodo Stroesser, they 
add the SYSEMU_SINGLESTEP mode. For 2.6.9 and beyond, I've cleaned up a lot 
the second one to ease porting to 2.6.10.

* sysaudit-singlestep-umlhost.patch: for host >= 2.6.9, it fixes a bad 
interaction between syscall auditing and ptracing. A version of this must 
also go in 2.6.11.

* fix-dumpable-handling.patch: this implemented a feature / bug fix requested 
by Michael Richardson <mcr@sandelman.ottawa.on.ca>. I.e., with this, in 
normal cases, UML *is* allowed to dump core and be seen inside /proc - (until 
now it was treated as if it was a setuid process or one which changed UID / 
GID). If I did any error, however, it could allow privilege escalation. Well, 
I've thought a bit about this, however I'll think even more before putting it 
into a release (I wrote this more than one month ago).

-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
