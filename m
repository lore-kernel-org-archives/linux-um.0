Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ar8ca-00039y-T1
	for user-mode-linux-devel@lists.sourceforge.net; Wed, 11 Feb 2004 20:38:40 -0800
Received: from erizo.shearer.org ([210.10.97.33] helo=shearer.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:RC4-SHA:128)
	(Exim 4.30)
	id 1Ar8bf-0000kM-3g
	for user-mode-linux-devel@lists.sourceforge.net; Wed, 11 Feb 2004 20:37:43 -0800
From: Dan Shearer <dan@shearer.org>
Subject: Re: [uml-devel] mconsole telinit design, worry about init standards?
Message-ID: <20040212044015.GZ4203@erizo.shearer.org>
References: <20040206003759.GY4203@erizo.shearer.org> <200402120114.i1C1E5ip008500@ccure.user-mode-linux.org> <20040212014725.GV4203@erizo.shearer.org> <200402120349.i1C3nFip009121@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <200402120349.i1C3nFip009121@ccure.user-mode-linux.org>
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
Date: Thu, 12 Feb 2004 15:10:15 +1030
To: Jeff Dike <jdike@addtoit.com>
Cc: Cameron Patrick <cameron@patrick.wattle.id.au>, BlaisorBlade <blaisorblade_spam@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net, miquels@cistron.nl

On Wed, Feb 11, 2004 at 10:49:15PM -0500, Jeff Dike wrote:
> dan@shearer.org said:
> > Could you tell us what the rules are?
> 
> The rule is - if it can be done in userspace, it is.  And if it can't be done
> in userspace, you implement as little as possible in the kernel, and export
> an interface that lets the rest be done in userspace.  C-A-D is a good example -
> you need to have the basic handler in the kernel, but the actual reaction to
> it is in init, and specified by inittab.
> 
> So, the stuff that I'm willing to stick in the mconsole driver are things like
> diagnosing a sick UML (where you may not be able to start processes - mconsole
> proc, which barely passed muster with Al Viro) and pulling hardware in and
> out.

There is very little overlap between this and what I'm looking for,
which is a way of interacting with an unmodified Linux, initially a way
of getting it to do a clean init-style shutdown without introducing any
specific new tools.

What about the ability to inject ACPI commands to the kernel? So long as
the user has installed whatever standard tools their distro uses to
listen on /proc/acpi (2.4.x) or /sys/power (2.6.x) then there is a
reasonable chance we can run externally imposed shutdown/resume/halt
events. APM would perhaps be simpler but presumably support for APM will
reduce over time.

This would integrate nicely with swsuspend for UML.

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
