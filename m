Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Aitw0-0005xC-NO for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 20 Jan 2004 03:20:40 -0800
Received: from house2.arach.net.au ([203.30.44.85] helo=house.arach.net.au)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1Aitw0-0003q5-10 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 20 Jan 2004 03:20:40 -0800
Received: from unknown (HELO wrath.worlds.end) (202.89.168.12)
	by house2.arach.net.au with SMTP
	for <user-mode-linux-devel@lists.sourceforge.net>;
	20 Jan 2004 11:23:29 -0000
From: nsb034@lostrealm.com
Message-ID: <20040120112042.GA2916@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [uml-devel] skas mode panic - ltrace strace
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
Date: Tue, 20 Jan 2004 19:20:42 +0800
To: user-mode-linux-devel@lists.sourceforge.net

Hi

I have a reproducible kernel panic running the ltrace program.  The
panic only occurs when running the uml kernel in skas mode.  mode=tt
does not panic.

Running as a normal (non root) user:
   $ ltrace strace ls
results in:
   Kernel panic: Kernel mode signal 5

Is anyone else able to reproduce this?


Details:

UML is debian woody, running vanilla kernel 2.4.22 with
uml-patch-2.4.22-5.bz2.  Also tested is vanilla kernel 2.4.23 with
uml-patch-2.4.23-1.bz2.  The kernel panic occures on both of these
setups.

Host is debian woody 2.4.22 with preemt, lowlatency and skas3 patches
applied.

The panic occurs because the syscall number gets set to -1.  I have not
been able to track down exactly where this occurs, and any help on this
would be warmly received.

Dion.

-- 
Dion's Maxim:  If you are ever surprised at just how stupid people can be,
               then you haven't understood Dion's Maxim.


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
