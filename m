Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ArbPV-0003nf-1C
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 13 Feb 2004 03:23:05 -0800
Received: from erizo.shearer.org ([210.10.97.33] helo=shearer.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:RC4-SHA:128)
	(Exim 4.30)
	id 1ArbL1-0000wn-3N
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 13 Feb 2004 03:18:27 -0800
From: Dan Shearer <dan@shearer.org>
Subject: Re: [uml-devel] mconsole telinit design, worry about init standards?
Message-ID: <20040213112343.GK4203@erizo.shearer.org>
References: <20040206003759.GY4203@erizo.shearer.org> <200402120114.i1C1E5ip008500@ccure.user-mode-linux.org> <20040213110341.GA14554@traveler.cistron.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20040213110341.GA14554@traveler.cistron.net>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Fri, 13 Feb 2004 21:53:43 +1030
To: Miquel van Smoorenburg <miquels@cistron.nl>
Cc: Jeff Dike <jdike@addtoit.com>, Cameron Patrick <cameron@patrick.wattle.id.au>, BlaisorBlade <blaisorblade_spam@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net

On Fri, Feb 13, 2004 at 12:03:41PM +0100, Miquel van Smoorenburg wrote:
> On 2004.02.12 02:14, Jeff Dike wrote:
> > dan@shearer.org said:
> > > I've got a rough implementation of an mcsonole telinit command, where
> > > mconsole_kern opens /dev/initctl and sends a command to change
> > > runlevels.
> > 
> > cameron@patrick.wattle.id.au said:
> > > How about having some kind of generic interface to allow the host to
> > > access files, send signals, etc inside the VM?
> > 
> > Sorry, but none of these handy things are going into the kernel.  If you want
> > to run processes, open files, etc, you can do all that from userspace.
> > 
> > I see the following possibilities:
> > 
> > 	Log in and run the command - some people don't like to write scripts
> > to go through the login process, so you can
> > 	Have a dedicated console which just has a root shell running on it.  I
> > think there will be people who object to parsing shell prompts, so they can
> > 	Send the command through /proc/mconsole to a script which does
> > 
> > 	while true; do cmd=read < /proc/mconsole; `$cmd >& /proc/mconsole`; done
> 
> Why not use IP. There is network connectivity in an UML instance, right? You can
> run some deamon on the host that accepts commands from the UML instance.
> You need to make it secure (local networking only, priviliged ports, secret
> key) but that would be a generic interface to talk from/to the host without
> any kernel hacking.
> 
> Then just run "telinit" or "shutdown" from the daemon.

Yes, this is very possible (and I do it myself) but doesn't help in some
cases. Sometimes it is important to map the UML simulation to the real
world as far as possible *at the same time* as providing facilities
which are in advance of what the real world offers, eg externally
imposed shutdowns via standard interfaces.

Take two cases: honeypots and commercially hosted UMLs. There are
risks/inconveniences/costs in providing extra new things inside the UML
just because it is a UML. So some special IP daemon is ruled out, and
redefiniting /etc/inittab is either risky or ruled out.

At least my (somewhat clumsy) idea of a UPS interface doesn't require
anything that might not be there in real life anyway. Similarly with the
idea of ACPI commands, which are triggered by external events anyway.
And similarly with the idea of having mconsole send signals.

Incidentally Mike, I have had a discussion with someone from the LSB who
suggests that a standard for init behaviour might be a good thing. But
that's another discussion in another forum :-)

-- 
Dan Shearer
dan@shearer.org


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
