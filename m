Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EJAgx-0000uV-Pt	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 24 Sep 2005 07:07:51 -0700
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1EJAgv-0002HC-V5
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 24 Sep 2005 07:07:51 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Any way to give /dev/console a controlling TTY?
References: <200509231135.27882.rob@landley.net>
	<200509232108.51050.blaisorblade@yahoo.it>
	<Pine.LNX.4.61.0509232229090.14136@filer.marasystems.com>
In-Reply-To: <Pine.LNX.4.61.0509232229090.14136@filer.marasystems.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509241603.53845.blaisorblade@yahoo.it>
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
Date: Sat, 24 Sep 2005 16:03:53 +0200
To: Henrik Nordstrom <uml@hno.marasystems.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, Rob Landley <rob@landley.net>

On Friday 23 September 2005 22:31, Henrik Nordstrom wrote:
> On Fri, 23 Sep 2005, Blaisorblade wrote:
> > So in this case he should use init=/sbin/ctty sh, right?
>
> But you can't.. init= takes a single path to the binary to use, no
> arguments.
init= doesn't take argument, yes, but IIRC unhandled arguments are 
automatically passed to init, like unhandled assignment are passed in env. 
vars. Or not?
> But it's trivial to modify ctty to autmatically start a shell 
> for you.
Yes, indeed.
> Regards
> Henrik

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
