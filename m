Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ebk2M-0001nF-2E for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 14 Nov 2005 11:30:42 -0800
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1Ebk2A-0004ZD-3a
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 14 Nov 2005 11:30:35 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Making UML Single Threader
References: <200511061723.32848.rob@landley.net>
	<20051108154618.GB4131@ccure.user-mode-linux.org>
	<87lkzrwcs3.fsf@amaterasu.srvr.nix>
In-Reply-To: <87lkzrwcs3.fsf@amaterasu.srvr.nix>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511142037.56022.blaisorblade@yahoo.it>
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
Date: Mon, 14 Nov 2005 20:37:55 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Nix <nix@esperi.org.uk>, Jeff Dike <jdike@addtoit.com>, Rob Landley <rob@landley.net>, Can Sar <csar@stanford.edu>

On Monday 14 November 2005 14:59, Nix wrote:
> On Tue, 8 Nov 2005, Jeff Dike prattled cheerily:
> > On Tue, Nov 08, 2005 at 01:09:06AM -0600, Rob Landley wrote:
> >> > So I don't care about systemcall interception or anything like that,
> >>
> >> *blink*  *blink*
> >>
> >> Ok, you want user mode linux, but you don't want it to actually run user
> >> processes, nor do want it to be able to intercept system calls.
> >>
> >> Um...  What's left?
> >
> > Only all of Linux.  It so happens that I want exactly the same thing for
> > libUML, except I haven't had time to do anything about it.

> I've long wanted to do the same sort of thing,

I guess you would like to run userspace processes or at least to call libUML 
to configure something (but I don't think you can ask a kernel to do so much, 
without allowing it to run userspace processes)...

> to do with a UML the same 
> sort of thing you can do with a real Linux box: that is, set up
> networking and a bridging firewall, 

> then halt it: 

I.e. "shutdown now" without -h? Halt without poweroff?

> the kernel keeps 
> processing network packets and firewalling and bridging them perfectly
> well, but attackers now have *real* trouble changing the configuration.

_BLINK_ _BLINK_

Is this a _documented_ feature 8-() ?

> You stop it with kill() on the host, or mconsole; as it's halted and all
> fsen are unmounted and so on, you're safe from filesystem corruption.
>
> When combined with CONFIG_NETCONSOLE, you can even keep an eye on it. :)
>
> The necessary hack looks quite simple: I just haven't got around to it.

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
