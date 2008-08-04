Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KQ8Ct-0000eD-Ul for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 04 Aug 2008 15:07:11 -0700
Received: from mail.gmx.net ([213.165.64.20])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1KQ8Cs-0000EL-8a
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 04 Aug 2008 15:07:11 -0700
Message-ID: <48977D85.8050505@gmx.de>
Date: Tue, 05 Aug 2008 00:07:01 +0200
From: Ingo van Lil <inguin@gmx.de>
MIME-Version: 1.0
References: <48970AEC.6020503@meduna.org>	<20080804203319.GA14732@c2.user-mode-linux.org>	<48976DB8.3020001@meduna.org>
	<20080804214731.GA18697@c2.user-mode-linux.org>
In-Reply-To: <20080804214731.GA18697@c2.user-mode-linux.org>
Subject: Re: [uml-devel] sysconf(_SC_NPROCESSORS_CONF) returning zero
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
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

Jeff Dike schrieb:

>> Hmmm... so I have cpu0 similar to yours. What version
>> of UML and libc do you have?
> 
> UML 2.6.26 and an older libc:
> 
> % ls -l /lib/libc.so.6
> lrwxrwxrwx 1 root root 11 Jun  2  2007 /lib/libc.so.6 -> libc-2.5.so
> 
> Looking through libc at
> 
> http://www.google.com/codesearch?hl=en&q=file:\.c%24+\"/stat\"+package:http://su-se.lunar-linux.org/lunar/mirrors/glibc-2.3.3-cvs-20040708.tar.bz2+show:m1O9RV1wlw4:qbkros5194A:MbxD3_8dUHU&sa=N&cd=1&ct=rc&cs_p=http://su-se.lunar-linux.org/lunar/mirrors/glibc-2.3.3-cvs-20040708.tar.bz2&cs_f=glibc-2.3.3-cvs-20040708/sysdeps/unix/sysv/linux/getsysstats.c
> 
> I see it counting cpu<n> lines in /proc/stat, which is what I'm
> seeing.  It will also look at /proc/cpuinfo.  Can you strace your
> version and see if it's looking there at all?

More recent versions of glibc (here: 2.8 on Fedora 9) seem to look at 
the contents of /sys/devices/system/cpu instead. That directory is empty 
in UML, which might explain the odd result from Stanislav's program.

Cheers,
Ingo

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
