Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ETNwZ-0002bH-Tl	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 22 Oct 2005 11:18:11 -0700
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)	id 1ETNwY-000455-Fe
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 22 Oct 2005 11:18:11 -0700
Received: from localhost.localdomain (localhost [127.0.0.1])
	by grelber.thyrsus.com (8.13.4/8.13.4) with ESMTP id j9MJngkD021283
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 22 Oct 2005 15:49:42 -0400
From: Rob Landley <rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510221318.00565.rob@landley.net>
Subject: [uml-devel] Unassociated ubd in sysfs?
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
Date: Sat, 22 Oct 2005 13:18:00 -0500
To: user-mode-linux-devel@lists.sourceforge.net

I'm trying to play with a system that doesn't have any hardwired major/minors 
in it, just an initscript doing "find /sys -name dev", a bit of sed work, and 
mknod.  (Eventually I'll get the full udev up, but for now a dumb little 
shell script works pretty well.)

Unfortunately, it doesn't list any unassociated ubd devices when I do this.  I 
get loop devices, ttys, even /dev/zero and friends, but no ubd.  If I 
associate one with a file from the command line, it shows up in sys, but I 
was under the impression I could associate them from "mount" as well..?  I 
don't have any ubd nodes to associate anything with unless they show up in 
sysfs first...

By the way, on the 2.6.13 command line it wants ubd0=blah.img, which shows up 
as ubda inside UML.  (Was this fixed in 2.6.14 already?)

Rob


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
