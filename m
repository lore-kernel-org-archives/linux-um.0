Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1H4Dhw-0007zT-Ag for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 09 Jan 2007 01:55:52 -0800
Received: from smtp101.sbc.mail.mud.yahoo.com ([68.142.198.200])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1H4Dht-0007gO-Ru
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 09 Jan 2007 01:55:52 -0800
Date: Tue, 09 Jan 2007 01:55:26 -0800
From: pierrelaroche <pierre.laroche@sbcglobal.net>
Message-ID: <C1C8A68E.16BE8%pierre.laroche@sbcglobal.net>
Mime-version: 1.0
Subject: [uml-devel] Debian user mode linux 2.6.8 and supporting utils don't
	install
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net

These programs, as found in the Debian unstable tree, don't install properly
on my Debian system. Apt-get insists on first removing all my kernel images
claiming a conflict.

The installation succeeds however if the .deb files are downloaded first
before installation (the files are downloaded, and then installed using
dpkg).

Also, where can I find the source code and the instructions to recreate
these binaries? I would like to generate a debug version. I need to know the
system setup, and the uml patches used to create these binaries (2.6.8).

Thanks,

- Pierre.




-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
