Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ar51e-0002vB-AU
	for user-mode-linux-devel@lists.sourceforge.net; Wed, 11 Feb 2004 16:48:18 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1Ar4zE-0000Li-16
	for user-mode-linux-devel@lists.sourceforge.net; Wed, 11 Feb 2004 16:45:48 -0800
Message-Id: <200402120114.i1C1E5ip008500@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] mconsole telinit design, worry about init standards? 
In-Reply-To: Your message of "Fri, 06 Feb 2004 11:07:59 +1030."
             <20040206003759.GY4203@erizo.shearer.org> 
References: <20040206003759.GY4203@erizo.shearer.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
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
Date: Wed, 11 Feb 2004 20:14:05 -0500
To: Dan Shearer <dan@shearer.org>, Cameron Patrick <cameron@patrick.wattle.id.au>, BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, miquels@cistron.nl

dan@shearer.org said:
> I've got a rough implementation of an mcsonole telinit command, where
> mconsole_kern opens /dev/initctl and sends a command to change
> runlevels.

cameron@patrick.wattle.id.au said:
> How about having some kind of generic interface to allow the host to
> access files, send signals, etc inside the VM?

Sorry, but none of these handy things are going into the kernel.  If you want
to run processes, open files, etc, you can do all that from userspace.

I see the following possibilities:

	Log in and run the command - some people don't like to write scripts
to go through the login process, so you can
	Have a dedicated console which just has a root shell running on it.  I
think there will be people who object to parsing shell prompts, so they can
	Send the command through /proc/mconsole to a script which does

	while true; do cmd=read < /proc/mconsole; `$cmd >& /proc/mconsole`; done

This last requires that /proc/mconsole be made bidirectional, plus it requires
that script running inside UML.  All of these require some amount of setup
beforehand (knowledge of the root password, inittab running a shell instead of
getting on one console, the /proc/mconsole script).  

All of them are also subject to interference by a hostile root inside the
UML.  However, the in-kernel proposals can be subverted by root as well (change
init to not obey initctl, move files around, etc).

				Jeff




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
