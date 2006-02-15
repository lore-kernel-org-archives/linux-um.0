Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1F9W4X-0003ee-GN for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 15 Feb 2006 15:28:33 -0800
Received: from smtp010.mail.ukl.yahoo.com ([217.12.11.79])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1F9W4U-00021O-WC
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 15 Feb 2006 15:28:33 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200602160028.25865.blaisorblade@yahoo.it>
Subject: [uml-devel] Fixed the uml_moo 64-bit COW bug
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
Date: Thu, 16 Feb 2006 00:28:24 +0100
To: user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, Joel Palmius <joel.palmius@miun.se>, Antoine Martin <antoine@nagafix.co.uk>, Jeff Dike <jdike@addtoit.com>

Ok, here we are. uml_moo was not portable to 64-bit AMD for some portability 
bugs.

1) I fixed bug one, SIGFPE at startup of uml_moo or at boot of UML kernel 
("Kernel mode signal 8"), time ago. The resulting binary completed the merge, 
but the results were wrong, compared with the results from a 32-bit binary.

The SIGFPE bug at boot meant another issue too - 64-bit binaries of uml_mkcow 
and of kernel binaries use a different format than 32-bit ones.

2) Today I discovered the 2nd bug, tested the result, and got everything 
working - it produced the correct results even on a 500Mb UBD with a 270 Mb 
COW file (I had done a dist-upgrade with months of security updates).

This second bug, luckily, doesn't affect the kernel - otherwise 64-bit kernel 
would have corrupted data in COW files.

After refining the code and preparing for release, I'll publish the complete 
fixes, and a new uml-utilities release. I expect to do this in this week.
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
