Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ArbAK-0007Kc-FJ
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 13 Feb 2004 03:07:24 -0800
Received: from 10fwd.cistron-office.nl
	([62.216.29.197] helo=smtp.cistron-office.nl ident=mail)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1Arb5r-0006XF-MC
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 13 Feb 2004 03:02:47 -0800
From: Miquel van Smoorenburg <miquels@cistron.nl>
Subject: Re: [uml-devel] mconsole telinit design, worry about init standards?
Message-ID: <20040213110341.GA14554@traveler.cistron.net>
References: <20040206003759.GY4203@erizo.shearer.org> <200402120114.i1C1E5ip008500@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200402120114.i1C1E5ip008500@ccure.user-mode-linux.org> (from jdike@addtoit.com on Thu, Feb 12, 2004 at 02:14:05 +0100)
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
Date: Fri, 13 Feb 2004 12:03:41 +0100
To: Jeff Dike <jdike@addtoit.com>
Cc: Dan Shearer <dan@shearer.org>, Cameron Patrick <cameron@patrick.wattle.id.au>, BlaisorBlade <blaisorblade_spam@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net, miquels@cistron.nl

On 2004.02.12 02:14, Jeff Dike wrote:
> dan@shearer.org said:
> > I've got a rough implementation of an mcsonole telinit command, where
> > mconsole_kern opens /dev/initctl and sends a command to change
> > runlevels.
> 
> cameron@patrick.wattle.id.au said:
> > How about having some kind of generic interface to allow the host to
> > access files, send signals, etc inside the VM?
> 
> Sorry, but none of these handy things are going into the kernel.  If you want
> to run processes, open files, etc, you can do all that from userspace.
> 
> I see the following possibilities:
> 
> 	Log in and run the command - some people don't like to write scripts
> to go through the login process, so you can
> 	Have a dedicated console which just has a root shell running on it.  I
> think there will be people who object to parsing shell prompts, so they can
> 	Send the command through /proc/mconsole to a script which does
> 
> 	while true; do cmd=read < /proc/mconsole; `$cmd >& /proc/mconsole`; done

Why not use IP. There is network connectivity in an UML instance, right? You can
run some deamon on the host that accepts commands from the UML instance.
You need to make it secure (local networking only, priviliged ports, secret
key) but that would be a generic interface to talk from/to the host without
any kernel hacking.

Then just run "telinit" or "shutdown" from the daemon.

Mike.


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
