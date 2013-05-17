Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <mcr@sandelman.ca>) id 1UdI8c-00018q-9i
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 17 May 2013 10:43:50 +0000
Received: from tuna.sandelman.ca ([209.87.252.184])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UdI8b-0005dh-AW for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 17 May 2013 10:43:50 +0000
Received: from sandelman.ca (desk.marajade.sandelman.ca [209.87.252.247])
	by tuna.sandelman.ca (Postfix) with ESMTP id A48C32016D
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 17 May 2013 06:55:32 -0400 (EDT)
Received: from sandelman.ca (localhost [127.0.0.1])
	by sandelman.ca (Postfix) with ESMTP id D05E963A5E
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 17 May 2013 06:43:03 -0400 (EDT)
From: Michael Richardson <mcr+osw@sandelman.ca>
Date: Fri, 17 May 2013 06:43:03 -0400
Message-ID: <9106.1368787383@sandelman.ca>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: [uml-devel] UML vs ptrace_scope
To: user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>


I have been trying to bring the openswan nightly build system up again
on a newish system.   I started these scripts back in 2002, and it has been running
on and off for many years, and many kernel revisions.  
I started this most recent effort work when 3.5 was stable, so my guest
kernel is a 3.5 kernel running on a debian squeeze host with a 2.6.26
kernel.   I compile things fine.
With 2.6.26, I got:

...
Checking that ptrace can change system call numbers...ptrace: Operation
not permitted
check_ptrace : expected SIGSTOP, got status = 9

I upgraded to wheezy (needed to be done anyway), and then felt that I
ran run into the ptrace_scope problem.  At least, that's what I thought.
I installed a 3.8 debian kernel tree, patched it to enable YAMA, and
booted that finally.  I set:
   kernel.yama.ptrace_scope = 0

but this does not affect the above error.  Is there something else I am
missing?    I tried adding the capability, but it doesn't help.

curley-[~] mcr 10001 %sudo /sbin/setcap cap_sys_ptrace+ep
/btmp/build/HEAD/2013_05_12/openswan-2/UMLPOOL/plain26/linux
[sudo] password for mcr: 
curley-[~] mcr 10002 %sudo /sbin/getcap
/btmp/build/HEAD/2013_05_12/openswan-2/UMLPOOL/plain26/linux
        
/btmp/build/HEAD/2013_05_12/openswan-2/UMLPOOL/plain26/linux =
cap_sys_ptrace+ep

No I suspect the problem is elsewhere.
Is there something else I am missing?

-- 
]               Never tell me the odds!                 | ipv6 mesh networks [ 
]   Michael Richardson, Sandelman Software Works        | network architect  [ 
]     mcr@sandelman.ca  http://www.sandelman.ca/        |   ruby on rails    [ 
	


------------------------------------------------------------------------------
AlienVault Unified Security Management (USM) platform delivers complete
security visibility with the essential security capabilities. Easily and
efficiently configure, manage, and operate all of your security controls
from a single console and one unified framework. Download a free trial.
http://p.sf.net/sfu/alienvault_d2d
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

