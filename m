Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C7Fs0-0003kV-JQ for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 14 Sep 2004 09:09:28 -0700
Received: from zrtps0kn.nortelnetworks.com ([47.140.192.55])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1C7Fry-0004in-UQ for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 14 Sep 2004 09:09:28 -0700
Message-ID: <414717A4.7070605@nortelnetworks.com>
From: Joe Marzot <gmarzot@nortelnetworks.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] handle_trap - failed to wait at end of syscall
References: <200408120541.i7C5faJd010923@ccure.user-mode-linux.org>
	<200409132139.33256.blaisorblade_spam@yahoo.it>
	<200409132214.i8DMEwL7003829@ccure.user-mode-linux.org>
	<200409141241.21480.blaisorblade_spam@yahoo.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
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
Date: Tue, 14 Sep 2004 12:09:08 -0400
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net, Joe Marzot <gmarzot@nortelnetworks.com>, "Smith, Paul [BL60:NP52:EXCH]" <pausmith@americasm01.nt.com>

BlaisorBlade wrote:

>>Figuring out why it is should point us at the correct fix.
> 

Agree...unfortunately I do not really understand where the SUGHUP is 
coming from exactly. It is being delivered to the userspace thread since 
the waitpid() in the kernel thread returns it in status.

In our case the UML is launched like this:

perl script
   my $pid = fork();
   if ($pid == 0) {
      setpgrp(); # give all UMLs the same group id so I can renice them
      exec($cmd);

where $cmd is something like:

'exec linux umid=foo ubd0=cow,rootfs mem=256M con0=xterm con=pts 
eth0=tuntap,tap0,02:00:00:04:00:01, fakehd fake_ide < /dev/null > 
/tmp/uml.log'

We have pretty well correlated the SUGHUP delivery with the exit of the 
parent perl script...although it occurs only about 10% of the time...if 
we put a delay before the script exits it still produces the same crash 
rate except delayed.

> 
> Well, I've a situation where I consistently get SIGSEGV instead of SIGHUP 
> here, but only on 2.6 host. The scenario is to do "echo 0 > /proc/sysemu". 
> You can test that with 2.6.9-rc2 or with 2.6.7-bb6 (both include /proc/sysemu 
> support).
> 
> The problem (at least in my scenario) is that the signal in 2.4 is delivered 
> only to the kernel thread, while on 2.6 (for some reason) it is delivered 
> first to the userspace thread. You too mentioned 2.6 signal delivery changes 
> as the reason for some fixes.

In my case I see the signal is being delivered to the userpsace process.

I am running a 2.4.18-19.8.0 RHish host with SKAS3 patch and a 2.4.22ish 
guest w/ 2.4.24-1um patch. No NPTL here anywhere that I know of.

> 
> So, Joe, since you can get this panic consistently, could you try reproducing 
> the scenario on a 2.4 host kernel? I guess you shouldn't be able, but I could 
> be wrong. Also, a 2.4 RH kernel does not qualify as a true 2.4 host kernel, 
> since it contains some NPTL code - if you can, try just a 2.4 vanilla + SKAS.

I am not sure I understand the request - I am already using a 2.4 host. 
Would like to help though if you can think of something I can do with 
the base I have. I have no /proc/sysemu on guest or host.

> 
> About the fix, most signals get delivered to all threads, so we can probably 
> safely ignore them when received through waitpid(). But Ulrich Drepper says 
> here:
>  
> http://people.redhat.com/drepper/posix-signal-model.xml

cool article - thanks.

> 
> that SIGSEGV should be delivered only to the generating thread; the document 
> lists changes to be done to Linux, so maybe this is implemented in 2.6 and 
> not in 2.4. However, OTOH, he also says that signal handlers are 
> process-wide, so we should be safe anyway. And anyway, the code works 
> perfectly on 2.4 hosts.





-------------------------------------------------------
This SF.Net email is sponsored by: thawte's Crypto Challenge Vl
Crack the code and win a Sony DCRHC40 MiniDV Digital Handycam
Camcorder. More prizes in the weekly Lunch Hour Challenge.
Sign up NOW http://ad.doubleclick.net/clk;10740251;10262165;m
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
