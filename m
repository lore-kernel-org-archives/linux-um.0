Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BYM5U-0000rv-Ja for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 10 Jun 2004 02:43:08 -0700
Received: from ns1.auto.ucl.ac.be ([130.104.239.135] helo=zlop.auto.ucl.ac.be)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BYM5T-0003yS-8M for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 10 Jun 2004 02:43:07 -0700
Received: from auto.ucl.ac.be (unknown [130.104.239.234])
	by zlop.auto.ucl.ac.be (Postfix) with ESMTP id AE8DA41224
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 10 Jun 2004 11:42:56 +0200 (CEST)
Message-ID: <40C8443B.8030809@auto.ucl.ac.be>
From: Vincent Guffens <guffens@auto.ucl.ac.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] making uml work with smp
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
Date: Thu, 10 Jun 2004 13:21:31 +0200
To: user-mode-linux-devel@lists.sourceforge.net

Hi,

I've tried UML+SMP with linux-2.4.24-um1. According to the project list 
on the uml site, this feature is ready but needs to be debugged.

I report here my attempt to start UML with smp with no success. However, 
as the code is already there, it would be very nice to have it work.

Would it be possible to have useful pointers toward architecture details 
that would help in understanding how to make it work. Useful techniques 
on how to debug uml+smp would also be very interesting as it looks like 
it is not going to be the trivial task of the day ...


The only changes that have to be made to compile with SMP is

*add the folowing to  arch/um/config.in

  define_bool CONFIG_SMP $CONFIG_UML_SMP
+int 'Number of CPUs' CONFIG_NR_CPUS 1

*change this line in arch/um/kernel/um_arch.c
-int ncpus = 1;
+int ncpus = 4;

*turn it on in the kernel config

When booting the machine, you can see the processors starting :
./linux-smp ubd0=cow0 umid=test devfs=nomount mode=tt
[...]
Starting up other processors:
         #1 - idle thread pid = 18502.. online
         #2 - idle thread pid = 18504.. online
         #3 - idle thread pid = 18506.. online
All CPUs are go!
Waiting on wait_init_idle (map = 0xe)
All processors have done init_idle
[..]

As expected problems occur when booting the UML machine,

1) a crash :
INIT: version 2.84 booting
Kernel panic: Kernel mode fault at addr 0x115, ip 0xa00c9066
  <6>Stopping all CPUs...CPU#0 stopping

but gdb gives the following:

Couldn't get registers: No such process.
(gdb) bt
Couldn't get registers: No such process.

but with only one processor, you can have gdb to tell you that the 
problem is in tty_open

2) sometimes there is a hang with the following backtrace

[...]
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
[hang here]

#0  0xa0181eb1 in nanosleep ()
#1  0xa00bc516 in idle_sleep (secs=10) at time.c:160
#2  0xa00b8161 in cpu_idle () at process_kern.c:210
#3  0xa000d542 in rest_init () at init/main.c:346
#4  0xa00025f9 in start_kernel () at init/main.c:440
#5  0xa00bf1ed in start_kernel_proc (unused=0x0) at process_kern.c:437
#6  0xa00c030f in signal_tramp (arg=0xa00bf1a4) at tracer.c:120









-- 
				Vincent Guffens
				PhD Student UCL/CESAME
				tel:   +32 10 47 80 30
Value your freedom, or you will lose it, teaches history.
"Don't bother us with politics," respond those who don't want to learn.
	      	-- Richard M. Stallman



-------------------------------------------------------
This SF.Net email is sponsored by: GNOME Foundation
Hackers Unite!  GUADEC: The world's #1 Open Source Desktop Event.
GNOME Users and Developers European Conference, 28-30th June in Norway
http://2004/guadec.org
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
