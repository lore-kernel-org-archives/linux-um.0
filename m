Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AWNre-0000rP-W5
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 16 Dec 2003 14:40:26 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.24)
	id 1AWNra-0000VV-8K
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 16 Dec 2003 14:40:22 -0800
Message-Id: <200312162255.hBGMtYkS003408@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] uml-patch-2.4.22-7 
In-Reply-To: Your message of "Tue, 16 Dec 2003 14:16:05 EST."
             <1071602165.3374.23.camel@wopr.tektonic.net> 
References: <Pine.LNX.4.44.0312161250240.3476-100000@sparrow>  <1071602165.3374.23.camel@wopr.tektonic.net> 
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
Date: Tue, 16 Dec 2003 17:55:34 -0500
To: Matt Ayres <matta@tektonic.net>
Cc: William Stearns <wstearns@pobox.com>, ML-uml-devel <user-mode-linux-devel@lists.sourceforge.net>

matta@tektonic.net said:
> Well, when reboot/shutdown -r is run from within a UML it shuts down
> and then states "INIT: no more processes in this runlevel" running
> 2.4.22-um6.

Does it halt?

Where did you get your filesystem image?

I saw this a while back, and it turned out to be the filesystem.  The script
that finally shuts the system down wasn't running, and the reason was that
the running rc script called it through a link, and the link wasn't there.

> Is there a thread that I can be pointed to or a brief explanation of
> how this is a benefit? 

The benefit is that when something does a 'sleep 1' inside UML, it will
sleep for 1 second, and not 2 or 3 seconds.  There have been various complaints
about this on the lists.

> ubd-mmap is new behavior that doesn't need to be enabled? (meaning,
> just upgrade to -7 and we'll seen some better performance using the
> block device) ?  

No, you have to turn it on (by adding ubd=mmap to the command line).

> Do you know how much performance is gained from
> ubd-mmap and /dev/anon individually? 

It's not performance of an individual UML per se (the testing I've done shows
that the performance is about the same), it's lower memory consumption on
the host.  ubd-mmap eliminates the duplicate copies of data on the host (in
the host page cache and the UML page cache) by mapping the host page cache
directly into UML physical memory.  /dev/anon completes the picture by
releasing the overmapped physical memory pages back to the host.

So, it'll increase your hosting capacity, and if the host is swapping, improve
performance by keeping more UMLs in memory.

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
