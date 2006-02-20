Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FBJlf-00044a-6u for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 20 Feb 2006 14:44:31 -0800
Received: from smtp008.mail.ukl.yahoo.com ([217.12.11.62])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1FBJlc-0005bA-RZ
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 20 Feb 2006 14:44:31 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200602202343.29478.blaisorblade@yahoo.it>
Subject: [uml-devel] Usermode-utilities (unofficial?) release 20060216
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
Date: Mon, 20 Feb 2006 23:43:28 +0100
To: user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, stefano.melchior@openlabs.it, Jeff Dike <jdike@addtoit.com>, Antoine Martin <antoine@nagafix.co.uk>

I've decided to get my act together. Last week I finally debugged (as I 
reported) the COW problem on 64-bit platform and this week I've finally 
released the whole thing.

It's on my homepage, _now_ (I had forgot to add the link) - the archives are 
at this URL (a different one than for patches):

http://www.user-mode-linux.org/~blaisorblade/uml-utilities

the link is on the homepage. On the "NEWS" page there's a more detailed 
description of changes.

I'd like testing on:
*) honeypot.pl (I had find it relatively usable)
*) uml_moo on 32-bit files.
*) uml_moo applying on COW files from 64-bit UMLs - it should correctly read 
them and warn about their wrong format.

I'm going also to publish the patches for 64-bit UMLs to use the correct 
format (the 32-bit one).

I've included various other cleanups, also...

I'd also like people with RPM-based distros to build (with, IIRC, rpmbuild -tb 
tarballName.tar.bz2) RPMs and to test & contribute it.

After a few people will have reported it works, I (or Jeff, we'll see) will 
upload it to the main site to be on Sourceforge.net and other mirrors.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

		
___________________________________ 
Yahoo! Messenger with Voice: chiama da PC a telefono a tariffe esclusive 
http://it.messenger.yahoo.com



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
