Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BPkHd-000708-91 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 17 May 2004 08:44:05 -0700
Received: from marasystems.com ([213.150.153.194] helo=filer.marasystems.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BPkHc-0000ER-Ke for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 17 May 2004 08:44:04 -0700
Received: from localhost (henrik@localhost)
	by filer.marasystems.com (8.11.6/8.11.6) with ESMTP id i4HFhxi17810
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 17 May 2004 17:43:59 +0200
From: Henrik Nordstrom <uml@hno.marasystems.com>
Message-ID: <Pine.LNX.4.44.0405171722530.17607-100000@filer.marasystems.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [uml-devel] 2.4.23(24?)-2 TT mode hangs on request_module
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
Date: Mon, 17 May 2004 17:43:59 +0200 (CEST)
To: user-mode-linux-devel@lists.sourceforge.net

On all our boxes not having the SKAS patch recent UML 2.4 kernels has
started hanging on the first request_module call from within the kernel.

It hangs quite hard, not responding to either gdb or mconsole.

Host: Various RedHat 7.x, 8.0, 9 and FC1 kernels.
Kernel: 2.4.26
UML: Current CVS (2.4.23-2)
Root: hostfs with the hostfs and aio patches sent earlier

Last known working before the last CVS update (2.4.23-1 CVS version 
works).

SKAS mode works, problem only seen in TT mode.

As there has been quite large changes from the earlier version and the
fact that the deugger also hangs I am not entirely sure where to look or
how to approach the problem. Trying to manually trace the kernel thread 
creation and execution to more exacly pinpoint where during the 
request_module or resulting modprobe thread the UML hangs has proven to be 
a little difficult and confusing..

I can very reliably reproduce the problem by

1. Boot in single user mode (/proc mounted etc.., but no other disturbing 
factors)
2. iptables -A INPUT -j REJECT

The sequence of events here is:

1. iptables modprobes the base modules (iptable_filter), then uploads the 
new iptable which referes to the REJECT match.

2. The kernel verifies the new iptable and triggers a request_module call
for the ipt_REJECT module and here the kernel gets completely stuck..

If all required modules are loaded manually avoiding the call to
request_module then there is no problem, but unfortunately this is not a
very feasible workaround here..

I do not think this is caused by any of our patches (plenty of netfilter
patches, upgraded to 2.4.26 etc etc..) but I will try building a "plain"  
UML kernel.  The earlier UML revision worked quite well except for that
klogd issue in SKAS mode which is a real pain as we have started to
migrate to SKAS in our development environment..

Ideas on how to approach problems like this are welcome.

Regards
Henrik



-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
