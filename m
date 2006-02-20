Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FB24f-0005tW-Mk for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 19 Feb 2006 19:50:57 -0800
Received: from main.gmane.org ([80.91.229.2] helo=ciao.gmane.org)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FB24e-0000ml-HI
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 19 Feb 2006 19:50:57 -0800
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1FB24X-0002CC-CF for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 20 Feb 2006 04:50:49 +0100
Received: from adsl-065-013-029-145.sip.asm.bellsouth.net ([65.13.29.145])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 20 Feb 2006 04:50:49 +0100
Received: from lunz by adsl-065-013-029-145.sip.asm.bellsouth.net with local
	(Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 20 Feb 2006 04:50:49 +0100
From: Jason Lunz <lunz@falooley.org>
Subject: Re: [uml-user] Re: [uml-devel] "Configuring network
	interfaces...execvp of 'uml_net' failed - errno = 2" error msg
Message-ID: <dtbe46$j4m$1@sea.gmane.org>
References: <20060217115152.GA17278@SteX>
	<20060217154425.GA3823@ccure.user-mode-linux.org>
	<200602171948.29509.blaisorblade@yahoo.it>
	<200602191704.03527.rob@landley.net>
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
Date: Mon, 20 Feb 2006 03:47:18 +0000 (UTC)
To: user-mode-linux-devel@lists.sourceforge.net
Cc: user-mode-linux-user@lists.sourceforge.net

rob@landley.net said:
> I'm confused, why would you have executables in a shared library directory 
> instead of /usr/bin or some such?  (These are runnable elf binaries, not 
> shared libraries, correct?)

The FHS says "/usr/lib includes object files, libraries, and internal
binaries that are not intended to be executed directly by users or shell
scripts".

http://www.pathname.com/fhs/pub/fhs-2.3.html#USRLIBLIBRARIESFORPROGRAMMINGANDPA

Jason



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
