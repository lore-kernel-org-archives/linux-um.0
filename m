Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D7bmD-0000J2-Qn for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 05 Mar 2005 08:05:13 -0800
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1D7bmB-0004PT-5X for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 05 Mar 2005 08:05:13 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] stdin lockup using con0=fd:0,fd:1 (guest 2.4.26-3um)
References: <422639E7.4080405@enterasys.com>
In-Reply-To: <422639E7.4080405@enterasys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503051652.06673.blaisorblade@yahoo.it>
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
Date: Sat, 5 Mar 2005 16:52:06 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: "D. Bahi" <dbahi@enterasys.com>

On Wednesday 02 March 2005 23:10, D. Bahi wrote:
> did i miss the console cleanup crew?
? Not understood, 2.4 didn't get the big cleanup.
> i have a UML guest command line that uses con0=fd:0,fd:1
> (or not, as this is the default for CONFIG_CON_ZERO_CHAN)
>
> i launch new xterms using -- xterm -e '<guest cmdline>' &
> (side note - can lock it w/o this too.)
Describe the other scenario please...
> and users leaning on 
> the keyboard (most notably <enter>) while the new xterms pop
> up and steal the window focus have experienced unresponsive
> UML prompts.
Hmm, can you exclude this is some X11 problem? I get problems in my Opera 
browser when a Java applet is started (which makes a Java progress window 
appear for a while). No, I'm not joking. Please try getting the same thing 
inside normal consoles, or getting the same thing with xterms and without 
UML.

> no further keyboard input is processed...
>
> uml_mconsole <id> reboot and things can be made better.
> so the UML isn't locked up just the stdin....
>
> i've tried to go thru stdio_init -> open_console -> line_open
> to see if there was a likely place to drop a 'flush' of stdin
? I don't think stdin is flushable (but I don't understand what you mean, so I 
could be wrong).
> before we try attaching 0 -> 1 and 1 -> 0 (line_setup_irq)...
Hmm, line_setup_irq makes sure that a IRQ is triggered when a event is 
received on the fd. That fd is provided by the channel driver (the one in 
con=xterm/pty/fd).
> but i don't understand it all enough <frown>.

> this is redhat 9 + SKAS - NPTL 2.4.20-31 host kernel
> linux 2.4.26-3um guest kernel.

> thank you.

-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade





-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
