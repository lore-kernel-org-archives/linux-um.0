Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1ADdQE-0006KV-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Sat, 25 Oct 2003 22:26:38 -0700
Received: from ns1.stral.net ([64.213.75.2])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.24)
	id 1ADdKQ-0005ZP-NX
	for user-mode-linux-devel@lists.sourceforge.net; Sat, 25 Oct 2003 22:20:39 -0700
Reply-To: <ralston@stral.net>
From: "Michael Ralston" <ralston@stral.net>
Message-ID: <000001c39b80$e011fbe0$3d4bd540@celery>
In-Reply-To: <20031026043958.GN6350@dijkstra.csh.rit.edu>
Subject: [uml-devel] Problem with Real-Time Scheduling
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Sun, 26 Oct 2003 16:20:30 +1100
To: user-mode-linux-devel@lists.sourceforge.net

I've come across a problem with running a user-mode-linux instance with
RR-Scheduling. When I attempt to start a server with chrt the host
system panics. I can start a uml in normal (other) scheduling, and then
change it to RR-Scheduling and it works fine, until I try to stop the
uml... then I get the same kernel panic.

I'm using the skas-3 patch on a 2.4.21 kernel, and 2.4.21-6um. If you
need the specific output of the kernel panic, I can get it...

Just as a related question... how would different scheduling the
different 'threads' of the UML effect performance? As far as I know..
the first 'linux' process actually does all the work and the extra
processes are for the different IO the UML does, eg network, block
devices etc? Would increasing the priority of the IO over the priority
of the main process have an effect on network performance for example?

Michael Ralston




-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
