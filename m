Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B2XIy-0000Y2-09 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 14 Mar 2004 07:13:32 -0800
Received: from main.gmane.org ([80.91.224.249])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1B2XIw-0002Re-HY for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 14 Mar 2004 07:13:30 -0800
Received: from list by main.gmane.org with local (Exim 3.35 #1 (Debian))
	id 1B2XIu-0003rN-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 14 Mar 2004 16:13:28 +0100
Received: from pd9e58e3c.dip.t-dialin.net ([217.229.142.60])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 14 Mar 2004 16:13:28 +0100
Received: from skoehler by pd9e58e3c.dip.t-dialin.net with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 14 Mar 2004 16:13:28 +0100
From: =?ISO-8859-15?Q?Sven_K=F6hler?= <skoehler@upb.de>
Message-ID: <c31sqm$ett$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] plenty of "/proc/mm map failed" in syslog
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
Date: Sun, 14 Mar 2004 16:11:56 +0100
To: user-mode-linux-devel@lists.sourceforge.net

Hi,

i wrote a simple test-program to stress-test UML.

#!/usr/bin/perl
while (true)
{
   push @a, "a";
}

While executing it, i got plenty of thos messages in syslog:
Mar 14 15:59:01 localhost kernel:  12
Mar 14 15:59:01 localhost kernel: map : /proc/mm map failed, err = 12
Mar 14 15:59:02 localhost last message repeated 1321 times
Mar 14 15:59:02 localhost kernel:  12
Mar 14 15:59:02 localhost kernel: map : /proc/mm map failed, err = 12
Mar 14 15:59:02 localhost last message repeated 3216 times
Mar 14 15:59:02 localhost kernel:  12
Mar 14 15:59:02 localhost kernel: map : /proc/mm map failed, err = 12
Mar 14 15:59:02 localhost last message repeated 786 times
Mar 14 15:59:03 localhost kernel:  12
Mar 14 15:59:03 localhost kernel: map : /proc/mm map failed, err = 12

I expected perl to get killed or get an "out of memory"-error, cause the 
UML didn't have swap and only 128MB memory.

So are those errors normal?
I'm using 2.6.4-um1 in SKAS-mode running on 2.6.4 host patched with 
BlaisorBlades's 2.6.3-skas3 patch.

If i run the script on the host-machine, perl get's killed as expected.
(the new "kill best process"-stuff is not turned on in the host's 
kernel-config)

Thx
   Sven



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
