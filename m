Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KQ0a3-0004DU-SN for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 04 Aug 2008 06:58:36 -0700
Received: from ip-212-081-022-089.static.nextra.sk ([212.81.22.89]
	helo=meduna.org) by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1KQ0a2-0007AM-F9 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 04 Aug 2008 06:58:35 -0700
Received: from [192.168.130.27] (lnxtleo01004.meduna.lan [192.168.130.27])
	by meduna.org (Postfix) with ESMTP id 3A15E9C434
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon,  4 Aug 2008 16:06:19 +0200 (CEST)
Message-ID: <48970AEC.6020503@meduna.org>
Date: Mon, 04 Aug 2008 15:58:04 +0200
From: Stanislav Meduna <stano@meduna.org>
MIME-Version: 1.0
Subject: [uml-devel] sysconf(_SC_NPROCESSORS_CONF) returning zero
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
To: user-mode-linux-devel@lists.sourceforge.net

Hi,

the following program

===
#include <unistd.h>
#include <stdio.h>

main()
{
   printf("Number of processors: %d\n", sysconf(_SC_NPROCESSORS_CONF));
}
===

produces

   Number of processors: 0

on my system.


# uname -a
Linux dirk 2.6.26 #1 Wed Jul 30 10:56:10 CEST 2008 i686 GNU/Linux

# cat /proc/cpuinfo
processor       : 0
vendor_id       : User Mode Linux
model name      : UML
mode            : skas
host            : Linux seldon-base 2.6.23.17 #2 SMP Sat Jun 21 15:04:22 CEST 2008 i686
bogomips        : 4771.02

# ls -l /lib/libc.so.6
lrwxrwxrwx 1 root root 11 2008-07-17 17:16 /lib/libc.so.6 -> libc-2.7.so


The monit monitoring tool (http://www.tildeslash.com/monit/)
crashes because of this. I don't know whose fault it is, but
I suspect the UML - otherwise I'd expect many more instances
of this problem when googling for it.


Regards
-- 
                                 Stano

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
