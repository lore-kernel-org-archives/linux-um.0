Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ArLtZ-0000v8-9p
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 12 Feb 2004 10:49:05 -0800
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1ArLq4-0007Ul-Kn
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 12 Feb 2004 10:45:28 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402121854.41130.blaisorblade_spam@yahoo.it>
Subject: [uml-devel] Hostfs bugs on strange situations
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Thu, 12 Feb 2004 18:54:41 +0100
To: user-mode-linux-devel@lists.sourceforge.net

While running a 2.6 kernel (2.6.2 with all my patches) on a 2.6 host (with the 
last version of host-skas) ls /mnt/host (with hostfs mounted) listed nothing; 
now instead (the same guest kernel ran onto 2.4) it works. Someone else 
reported, with a 2.4.23-2um onto 2.4, that after mounting hostfs the mount 
directory becomes hidden; here instead it works with 2.4.23-[12]um.

However, there seems to really be something strange going on. Has anyone a 
clue?
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
