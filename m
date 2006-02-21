Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FBbAU-0001tj-T5 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 21 Feb 2006 09:19:18 -0800
Received: from mta2.adelphia.net ([68.168.78.178])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FBbAT-0007ev-DA
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 21 Feb 2006 09:19:18 -0800
From: Matt Zimmerman <mdz@debian.org>
Subject: Re: [uml-devel] "Configuring network interfaces...execvp of 'uml_net'
	failed - errno = 2" error msg
Message-ID: <20060221170134.GF28322@alcor.net>
References: <20060217115152.GA17278@SteX>
	<200602171307.51262.blaisorblade@yahoo.it>
	<20060217134755.GA17720@SteX>
	<200602171505.29505.blaisorblade@yahoo.it>
	<20060221110240.GA8285@SteX> <20060221161450.GZ28322@alcor.net>
	<20060221165108.GD9131@SteX>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060221165108.GD9131@SteX>
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
Date: Tue, 21 Feb 2006 09:01:34 -0800
To: Stefano Melchior <stefano.melchior@openlabs.it>
Cc: Andreas Schuldei <andreas@schuldei.org>, pkg-uml-devel@lists.alioth.debian.org, user-mode-linux-devel@lists.sourceforge.net

On Tue, Feb 21, 2006 at 05:51:08PM +0100, Stefano Melchior wrote:
> The same with uml_switch, isn't it?

uml_switch is more of a daemon, and those generally live in a bin directory.
Again, see FHS for details.



-- 
 - mdz


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
