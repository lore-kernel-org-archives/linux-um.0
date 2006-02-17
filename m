Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FA6F5-0000Pj-D9 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 17 Feb 2006 06:05:51 -0800
Received: from smtp009.mail.ukl.yahoo.com ([217.12.11.63])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1FA6Ey-0005o7-MQ
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 17 Feb 2006 06:05:47 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] "Configuring network interfaces...execvp of 'uml_net'
	failed - errno = 2" error msg
References: <20060217115152.GA17278@SteX>
	<200602171307.51262.blaisorblade@yahoo.it>
	<20060217134755.GA17720@SteX>
In-Reply-To: <20060217134755.GA17720@SteX>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602171505.29505.blaisorblade@yahoo.it>
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
Date: Fri, 17 Feb 2006 15:05:28 +0100
To: user-mode-linux-devel@lists.sourceforge.net, stefano.melchior@openlabs.it
Cc: user-mode-linux-user@lists.sourceforge.net

On Friday 17 February 2006 14:47, Stefano Melchior wrote:
> On Fri, Feb 17, 2006 at 01:07:50PM +0100, Blaisorblade wrote:
> Hi Paolo,
>
> > > If you use the 2.4.x uml kernel the UML image work fine with network,
> > > but if you use an available 2.6.x uml image or a 2.6.x image of mine
> > > the uml bootstrap phase hangs with the following error message:
> >
> > Indeed on the same machine and with same config? It's strange, I never
> > saw

> yes, first I tried my own configuration, then I downloaded a prebuild uml
> kernel from http://uml.nagafix.co.uk/ and I tried with this one. Same
> error again.
> Then I extracted the configuration from that image and I rebuild with that
> config, same error for the same problem.

> ste@etinarcadiaego{~}$ ll /usr/lib/uml/uml_net
> -rwsr-x---  1 root uml-net 19836 2004-04-15 03:03 /usr/lib/uml/uml_net

Ok, thanks for this informative info. This is the solution.

In short, echo $PATH | grep  /usr/lib/uml, and if needed man 3 execvp, could 
enlighten you... or even the fact that I do:

# ls -l /usr/bin/uml_net
-rws--x--x  1 root root 22856 16 feb 18:49 /usr/bin/uml_net

if you want the full story, instead, IOW:

Debian has his own very non-standard packaging for uml_utilities, and patches 
UML to cope with it. For instance, uml_switch has different defaults on UML 
(the socket goes into /var/run instead of /tmp, in UML).

And (but this is the first time I hear this) you have uml_net in /usr/lib/uml 
rather than /usr/bin. Which would be a better choice, btw... but isn't 
implemented in mainline (we maybe should).

> Another info: I used either the kernel.org sources and the debian's
> linux-source(s).

But you're using a vanilla UML without the forward ports of all 2.4 patches 
(you're using linux-source(s), not a possible uml-linux-source(s)).

For the future packaging: I do believe that Debian's defaults have been 
actually planned while uml_utilities haven't, so I like the idea of switching 
to Debian paths as defaults, and possibly using the current ones as 
fallbacks.
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
