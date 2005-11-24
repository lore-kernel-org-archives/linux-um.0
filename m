Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EfFwd-0001l0-91 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 24 Nov 2005 04:11:19 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1EfFwb-0005DF-P9
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 24 Nov 2005 04:11:19 -0800
Received: from localhost.localdomain (localhost [127.0.0.1])
	by grelber.thyrsus.com (8.13.4/8.13.4) with ESMTP id jAODjfZi025746
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 24 Nov 2005 08:45:42 -0500
From: Rob Landley <rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511240611.02613.rob@landley.net>
Subject: [uml-devel] When /tmp is not tmpfs.
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
Date: Thu, 24 Nov 2005 06:11:01 -0600
To: user-mode-linux-devel@lists.sourceforge.net

So apparently, one reason for the pathological behavior of UML (pegging the 
hard drive, which I mentioned earlier) is that by default Ubuntu doesn't 
mount /tmpfs on /tmp.  This means it's part of /root, which is ext3, and 
every touched page gets scheduled for writeout after a few seconds.  (The 
optimization not to do that for deleted files was apparently taken out of 
2.6.)

There is a tmpfs mount, it's /dev/shm.  And apparently, even if tmpfs isn't 
exposed as a separate filesystem, system V shared memory will still use it.

So my question is, could system v shared memory be used in place of the tmpfs 
mount?  (Can it be mapped in the right location and inherited across fork()?)  
Or is this just a "systems that don't mount /tmpfs on /tmp are screwed, it's 
another prerequisite for running UML".

Rob
-- 
Steve Ballmer: Innovation!  Inigo Montoya: You keep using that word.
I do not think it means what you think it means.


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
