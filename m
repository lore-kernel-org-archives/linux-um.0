Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B4wDK-0004MZ-H3 for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 20 Mar 2004 22:13:38 -0800
Received: from vs1.netexcel.net.au ([210.11.200.2] helo=mail.xceltek.net.au)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1B4wDJ-0001GB-KL for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 20 Mar 2004 22:13:37 -0800
Reply-To: <ralston@stral.net>
From: "Michael Ralston" <ralston@stral.net>
Message-ID: <000001c40f0b$9039a3d0$6401a8c0@vmwinxp>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Problems with Bind9 on UML 2.6.4
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
Date: Sun, 21 Mar 2004 17:12:36 +1100
To: user-mode-linux-devel@lists.sourceforge.net

I'm running UML Version 2.6.4-1um with a 2.6.4 skas3 host.

I'm using Debian Unstable and I've mved /lib/tls to /lib/notls to
disable the NPTL problem...

When running Bind, version 9.2.3 one of the Bind threads decides it want
all the CPU time... When I strace the process it is performing the
following system call indefinetly...

kill(5960, SIGRTMIN)                    = 0

Where '5960' is the PID of the process which is using all CPU time.

From what I've been able to figure out... SIGRTMIN is one of the
real-time linux threading signals... Something implemented in libc6,
version 2.3?

Would I be better of compiling libc6 from source with NPTL/TLS disabled?
Would it resolve this problem? Or is it a matter of this syscall not
being implemented in UML?

Michael Ralston
Stral.net



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
