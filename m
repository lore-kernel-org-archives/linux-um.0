Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CzkFq-0000qF-Bu for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 11 Feb 2005 15:31:18 -0800
Received: from ns1.inma.ucl.ac.be ([130.104.239.135] helo=zlop.auto.ucl.ac.be)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CzkFp-0007VQ-MB for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 11 Feb 2005 15:31:18 -0800
Received: from [192.168.0.18] (unknown [213.189.163.92])
	by zlop.auto.ucl.ac.be (Postfix) with ESMTP id D09A440126
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 12 Feb 2005 00:31:12 +0100 (CET)
Message-ID: <420D4040.5060301@auto.ucl.ac.be>
From: Vincent Guffens <guffens@auto.ucl.ac.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] SMP sworking in tt mode
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
Date: Sat, 12 Feb 2005 00:31:12 +0100
To: user-mode-linux-devel@lists.sourceforge.net

hi everyone,

I read on the UML kernel site that SMP might be broken, so I gave it a
try with linux-2.4.24-um1 to see how it would look like. I only try it
with tt mode.

In fact, the only modification that has to be done to get it to compile
is simply to add CONFIG_NR_CPUS in the config.in file (The very simple
patch is below).

And that was it, now I have a brand new 16 cpus machine, as shown below
(with four processes running)

  3:36pm  up 4 min,  4 users,  load average: 0.04, 0.02, 0.00
37 processes: 33 sleeping, 4 running, 0 zombie, 0 stopped
CPU0 states: 14.3% user,  7.3% system,  0.0% nice, 77.2% idle
CPU1 states: 15.3% user,  7.2% system,  0.0% nice, 76.3% idle
CPU2 states:  0.1% user,  0.1% system,  0.0% nice, 99.3% idle
CPU3 states: 18.1% user,  8.1% system,  0.0% nice, 73.1% idle
CPU4 states:  0.0% user,  0.0% system,  0.0% nice, 100.0% idle
CPU5 states:  0.0% user,  0.0% system,  0.0% nice, 100.0% idle
CPU6 states:  0.0% user,  0.0% system,  0.0% nice, 100.0% idle
CPU7 states:  0.0% user,  0.0% system,  0.0% nice, 100.0% idle
CPU8 states:  0.0% user,  0.0% system,  0.0% nice, 100.0% idle
CPU9 states:  0.0% user,  0.0% system,  0.0% nice, 100.0% idle
CPU10 states:  0.0% user,  0.0% system,  0.0% nice, 100.0% idle
CPU11 states:  0.0% user,  0.0% system,  0.0% nice, 100.0% idle
CPU12 states:  0.0% user,  0.0% system,  0.0% nice, 100.0% idle
CPU13 states:  0.0% user,  0.0% system,  0.0% nice, 100.0% idle
CPU14 states:  0.0% user,  0.0% system,  0.0% nice, 100.0% idle
CPU15 states:  0.0% user,  0.0% system,  0.0% nice, 100.0% idle
Mem:    28936K av,   28340K used,     596K free,       0K shrd,      32K
buff
Swap:       0K av,       0K used,       0K free                   22580K
cached

   PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
   156 root      14   0   376  376   316 R    14.4  1.2   0:01 md5sum
   155 root      11   0   376  376   316 R    12.6  1.2   0:01 md5sum
   154 root      13   0   376  376   316 R    12.2  1.2   0:01 md5sum
   153 root      10   0   920  920   728 R     0.1  3.1   0:00 top



I also tried with 32 processors, rebooted many times and let it run a
few hours. I had it hang and panic a few times but I think it was
because a make clean must be done before recompiling with SMP enable.

Also, all the interrupts seem to be handled by CPU0 (according to
/proc/interrupt), even after changing the prof_cpu_mask in /proc.

Is there something to do to make other processors handle interrupt ?


diff -ru linux-2.4.24-um1/arch/um/config.in
linux-2.4.24-um1-smp/arch/um/config.in
--- linux-2.4.24-um1/arch/um/config.in  Fri Feb 11 21:18:48 2005
+++ linux-2.4.24-um1-smp/arch/um/config.in      Fri Feb 11 21:47:25 2005
@@ -44,6 +44,9 @@
  bool '2G/2G host address space split' CONFIG_HOST_2G_2G
  bool 'Symmetric multi-processing support' CONFIG_UML_SMP
  define_bool CONFIG_SMP $CONFIG_UML_SMP
+if [ "$CONFIG_SMP" = "y" ]; then
+       int 'Maximum number of CPUs (2-32)' CONFIG_NR_CPUS 32
+fi
  int 'Nesting level' CONFIG_NEST_LEVEL 0
  int 'Kernel address space size (in .5G units)' CONFIG_KERNEL_HALF_GIGS 1
  bool 'Highmem support' CONFIG_HIGHMEM


-- 
				Vincent Guffens
				PhD Student UCL/CESAME
				tel:   +32 10 47 80 30
Value your freedom, or you will lose it, teaches history.
"Don't bother us with politics," respond those who don't want to learn.
	      	-- Richard M. Stallman



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
