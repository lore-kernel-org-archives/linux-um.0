Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FAAeo-0008OU-9H for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 17 Feb 2006 10:48:42 -0800
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1FAAej-0005V6-H8
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 17 Feb 2006 10:48:42 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-user] Re: [uml-devel] "Configuring network
	interfaces...execvp of 'uml_net' failed - errno = 2" error msg
References: <20060217115152.GA17278@SteX>
	<200602171505.29505.blaisorblade@yahoo.it>
	<20060217154425.GA3823@ccure.user-mode-linux.org>
In-Reply-To: <20060217154425.GA3823@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602171948.29509.blaisorblade@yahoo.it>
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
Date: Fri, 17 Feb 2006 19:48:25 +0100
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, stefano.melchior@openlabs.it, user-mode-linux-user@lists.sourceforge.net

On Friday 17 February 2006 16:44, Jeff Dike wrote:
> On Fri, Feb 17, 2006 at 03:05:28PM +0100, Blaisorblade wrote:
> > For the future packaging: I do believe that Debian's defaults have been
> > actually planned while uml_utilities haven't, so I like the idea of
> > switching to Debian paths as defaults, and possibly using the current
> > ones as fallbacks.
>
> Yup, as long as they are not too Debian-specific.

They tend to make more sense and adhere better to the 
FHS. /var/run/uml-utilities requires support from the distro, but having 
uml_net in /usr/lib is a correct idea, for instance.
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
