Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AYDds-0000xD-Mn
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 21 Dec 2003 16:09:48 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.24)
	id 1AYDdq-0000MS-Q2
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 21 Dec 2003 16:09:47 -0800
Message-Id: <200312220025.hBM0PlFI012918@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] 2.4.22-[67] problems 
In-Reply-To: Your message of "Sun, 21 Dec 2003 15:16:38 PST."
             <20031221231638.GR9354@alcor.net> 
References: <20031220011323.GW18100@alcor.net> <20031220171450.GB10692@ccure.user-mode-linux.org> <20031221004742.GE9354@alcor.net> <200312211658.44353.blaisorblade_spam@yahoo.it> <20031221224001.GO9354@alcor.net>  <20031221231638.GR9354@alcor.net> 
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
Date: Sun, 21 Dec 2003 19:25:47 -0500
To: Matt Zimmerman <mdz@debian.org>
Cc: user-mode-linux-devel@lists.sourceforge.net, 224431@bugs.debian.org, 224502@bugs.debian.org, debian-glibc@lists.debian.org

mdz@debian.org said:
> I have just verified this myself.  Building user-mode-linux
> 2.4.22-7um-1 on woody works fine (even when running on unstable), but
> building it on unstable does not.

Conversely, does a unstable-built UML run on woody?

> The one built on unstable randomly sees ENOSYS from certain system
> calls, such as select, read and mmap.

Only those, or are there others that you can tell are failing?  Offhand, I
don't see any commonality between those three, in terms of their interactions
with the host.

> I would appreciate any suggestions for how to track this problem down
> further.

The randomness is strange.  It suggests that somehow interrupts are getting
in the way.  One possibility would be host system calls returning ENOSYS
instead of EINTR.  I don't see much possibility that that's what's actually
happening, but that's the sort of thing I'd think about.

				Jeff



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
