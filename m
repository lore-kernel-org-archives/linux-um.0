Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BVJeD-0000QL-Oc for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 01 Jun 2004 17:30:25 -0700
Received: from smtp-out6.xs4all.nl ([194.109.24.7])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BVJeB-0008BF-Ut for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 01 Jun 2004 17:30:24 -0700
Received: from eskarina.meek (meek.xs4all.nl [80.126.80.32])
	by smtp-out6.xs4all.nl (8.12.10/8.12.10) with ESMTP id i520UMew032790
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 2 Jun 2004 02:30:22 +0200 (CEST)
Received: from arjen by eskarina.meek with local (Exim 3.35 #1 (Debian))
	id 1BVJe5-0005kb-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 02 Jun 2004 02:30:17 +0200
Message-ID: <20040602003017.GB21966@meek.xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
From: Arjen Meek <arjen@meek.xs4all.nl>
Subject: [uml-devel] Trapping SIGTERM with C+A+D?
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
Date: Wed, 2 Jun 2004 02:30:17 +0200
To: user-mode-linux-devel@lists.sourceforge.net

Hello,

I'm running UML under Runit, a clone of DJB's daemontools. In that
situation (and probably many others) it would be very convenient if a
running UML would do a full clean shutdown when the main host process
recieves a SIGTERM, such as what happens when sending the "cad" command
through mconsole.

I first used a shell script that traps SIGTERM with either "ssh $UMLIP
shutdown -h now" or "echo cad | mconsole" and executes the kernel in the
background followed by a "wait", but that was a really ugly and
unacceptable solution for lots of reasons, so now I'm looking for a
cleaner solution.

I'm not exactly a talented or experienced programmer and my attempts to
hack a ctrl_alt_del trap in myself failed miserably even though it
seemed quite easy at first. So is this really easy to do, and if so,
could anyone give me a hand?

Arjen



-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
From Windows to Linux, servers to mobile, InstallShield X is the one
installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
