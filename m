Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FBGFh-0003b5-MX for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 20 Feb 2006 10:59:17 -0800
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1FBGFd-0001U4-7B
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 20 Feb 2006 10:59:17 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602201958.10554.blaisorblade@yahoo.it>
Subject: [uml-devel] Using partially SKAS3 on x86_64 - news
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
Date: Mon, 20 Feb 2006 19:58:09 +0100
To: user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, Antoine Martin <antoine@nagafix.co.uk>, Jeff Dike <jdike@addtoit.com>

Talking about 32-bit UMLs on AMD64 hosts: I've just discovered that on a 
x86_64 platform you can use at least partially the SKAS3 patch.

Instead of adding "skas0" to the command line, to get a running UML it 
suffices to use "noprocmm", if it's accepted by UML (I don't remember when 
the patch was merged).

I've tested this with a Debian Sarge root_fs - as you already know, Slackware 
root_fs already work in full SKAS3 mode.

As you can see at the beginning of the boot log, it won't use /proc/mm but it 
will use PTRACE_FAULTINFO, which is the other part of SKAS3. Since this 
addresses the biggest slowdown of SKAS0 (Jeff said SKAS0 is slightly slower 
than TT for page fault handling), I expect the difference to be significant.

I've not done any benchmark yet, however.

Example startup:

$ kernels/vmlinux-2.6.15.3-bs2 
ubd0=Root_images/Sarge-norm.rootfs.cow,Root_images/Sarge-norm.rootfs 
rootfs=/dev/ubda noprocmm

Checking that ptrace can change system call numbers...OK
Checking syscall emulation patch for ptrace...missing
Checking PROT_EXEC mmap in /tmp...OK
Checking for the skas3 patch in the host:
  - /proc/mm...found but disabled on command line
  - PTRACE_FAULTINFO...found
  - PTRACE_LDT...found
UML running in SKAS0 mode
....
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
