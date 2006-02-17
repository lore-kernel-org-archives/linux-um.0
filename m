Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FA4P5-0004LG-B3 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 17 Feb 2006 04:08:03 -0800
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1FA4P3-0004Oc-8s
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 17 Feb 2006 04:08:03 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] "Configuring network interfaces...execvp of 'uml_net'
	failed - errno = 2" error msg
References: <20060217115152.GA17278@SteX>
In-Reply-To: <20060217115152.GA17278@SteX>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602171307.51262.blaisorblade@yahoo.it>
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
Date: Fri, 17 Feb 2006 13:07:50 +0100
To: user-mode-linux-devel@lists.sourceforge.net, stefano.melchior@openlabs.it
Cc: user-mode-linux-user@lists.sourceforge.net

On Friday 17 February 2006 12:51, Stefano Melchior wrote:
> Hi all,
> I am trying to integrate 2.6.x support to debian and I encountered a
> blocking issue on networking configuration.
> If you use the 2.4.x uml kernel the UML image work fine with network, but
> if you use an available 2.6.x uml image or a 2.6.x image of mine the uml
> bootstrap phase hangs with the following error message:

Indeed on the same machine and with same config? It's strange, I never saw 
this incompatibility, and I can't find bugs in the code able to produce this 
(with a quick look). Could you check on your part?

> Setting up networking...done.
> * /etc/network/options is deprecated.
> Setting up IP spoofing protection...done (rp_filter).
> Configuring network interfaces...execvp of 'uml_net' failed - errno = 2

> From previous messages I read that this concerns uml_net and its
> permissions.

Which are them? It should be setuid root and executable...

However, since:

# perror 2
OS error code   2:  No such file or directory

Uml is saying it didn't find uml_net, or some of its libraries, not that 
there's a permission problem.

Possibly it's lying and printing the wrong code, dunno. But from current code:

arch/um/os-Linux/helper.c:helper_child
        execvp(argv[0], argv);
        errval = errno;
        printk("execvp of '%s' failed - errno = %d\n", argv[0], errno);

it seems not (that source file was somewhere else, guess in arch/um/kernel, 
until 2.6.14, but I think the content was the same).

> Do you have an idea how to work around this issue?
> I also need it to apply to the future debian uml support.

> Thank you in advance

> Cheers

> SteX

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
