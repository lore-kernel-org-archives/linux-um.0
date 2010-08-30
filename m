Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <sakari.ailus@iki.fi>) id 1OqCuT-0000x5-Ma
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 30 Aug 2010 22:33:01 +0000
Received: from smtp-68.nebula.fi ([83.145.220.68])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OqCuS-0001DL-0r for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 30 Aug 2010 22:33:01 +0000
Received: from hillosipuli.localdomain (nblzone-241-231.nblnetworks.fi
	[83.145.241.231])
	by smtp-68.nebula.fi (Postfix) with ESMTP id 3094043F0A2E
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 31 Aug 2010 01:17:08 +0300 (EEST)
Received: from [192.168.1.1] (masiina.localdomain [192.168.1.1])
	by hillosipuli.localdomain (Postfix) with ESMTP id F2E704A02C
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 31 Aug 2010 01:17:07 +0300 (EEST)
Message-ID: <4C7C2DE4.3090203@iki.fi>
Date: Tue, 31 Aug 2010 01:17:08 +0300
From: Sakari Ailus <sakari.ailus@iki.fi>
MIME-Version: 1.0
Subject: [uml-devel] UML development, anyone?
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net

Hello all,

I'm a long-time UML user and lately I've become a bit worried on the 
state of the UML. This list, as well as the -user one, is very quiet 
these days. Is there someone still actively developing the UML? I have 
to say I really like it! Running Linux on Linux reliably and 
efficiently, just what I need! :-)

I'm currently running three UML virtual machines on an server using 
Athlon XP-M. The host is running 2.6.31 and the guests are 2.6.27.

I cannot upgrade neither host nor guests due to these problems:

- SKAS 3 patches available up to 2.6.31 only. Merging this to current 
kernel might not be a problem, just some work, but:

- Severe data corruption on guest on recent guest kernel versions. I'm 
using a few hard disk partitions directly for UML guests. Something 
after 2.6.27 guest breaks this quite badly. Even for small data sets 
like 100 MiB, copying a file to a different location on guest and then 
running md5sum on both often produces a different result.

Do I have any options than to switch to Qemu and suffer the performance 
penalty from emulation (kqemu is obsolete, too) or to switch to newer 
hardware that supports kvm? Qemu performance is somewhat less than 10 % 
of the native (or UML) performance.

I also found something called lguest but haven't given it a try yet. 
Looks the most interesting but that doesn't seem to have much list 
activity either. So it works perfectly for almost everyone or has few 
users... ;)

How are others coping in the current situation? Or is it just me who has 
these troubles...?

Best regards,

-- 
Sakari Ailus
sakari.ailus@iki.fi

------------------------------------------------------------------------------
This SF.net Dev2Dev email is sponsored by:

Show off your parallel programming skills.
Enter the Intel(R) Threading Challenge 2010.
http://p.sf.net/sfu/intel-thread-sfd
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

