Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FAAoo-0001E9-W3 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 17 Feb 2006 10:59:02 -0800
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1FAAom-0007xh-Jg
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 17 Feb 2006 10:59:03 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] "Configuring network interfaces...execvp of 'uml_net'
	failed - errno = 2" error msg
References: <20060217115152.GA17278@SteX>
	<200602171505.29505.blaisorblade@yahoo.it>
	<20060217142923.GA18017@SteX>
In-Reply-To: <20060217142923.GA18017@SteX>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602171958.58435.blaisorblade@yahoo.it>
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
Date: Fri, 17 Feb 2006 19:58:57 +0100
To: user-mode-linux-devel@lists.sourceforge.net, stefano.melchior@openlabs.it
Cc: user-mode-linux-user@lists.sourceforge.net

On Friday 17 February 2006 15:29, Stefano Melchior wrote:
> On Fri, Feb 17, 2006 at 03:05:28PM +0100, Blaisorblade wrote:
> Ciao Paolo,
>

> > # ls -l /usr/bin/uml_net
> > -rws--x--x  1 root root 22856 16 feb 18:49 /usr/bin/uml_net
>
> damn, it drived me crazy!!!
Yep, we found the thing by accident - I would never have asked "where is 
uml_net?"

> now it works, and I am going to provide the 
> solution in debian.

> What it sounds strange is that:

Indeed it's correct as long as you support actively UML - the user never runs 
uml_net so it should be under /usr/lib.

However, if the uml_utilities package provides both locations it's better for 
people rolling their own kernels (i.e. everyone on Debian, for now).

Btw, I've just released a new uml_utilities version - see my homepage.

> stex@landini{~}$ ll /usr/bin/uml*
> -rwxr-xr-x 1 root root 10296 2006-02-17 03:39 /usr/bin/uml_mconsole
> -rwxr-xr-x 1 root root  9784 2006-02-17 03:39 /usr/bin/uml_mkcow
> -rwxr-xr-x 1 root root 12356 2006-02-17 03:39 /usr/bin/uml_moo
> lrwxrwxrwx 1 root root    20 2006-02-17 12:13 /usr/bin/uml_net ->
> /usr/lib/uml/uml_net
> -rwxr-xr-x 1 root root 15624 2006-02-17 03:39 /usr/bin/uml_switch
> -rwxr-xr-x 1 root root  4168 2006-02-17 03:39 /usr/bin/uml_watchdog
>
> (I temporarily linked uml_net from the current position)
> all the other uml_* files resides on /usr/bin.
> I am going to fix this.
>
> Thanks Paolo for your usual good suggestions :))

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
