Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D7bmE-0000J7-A1 for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 05 Mar 2005 08:05:14 -0800
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1D7bmB-0007aO-KO for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 05 Mar 2005 08:05:14 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Triage on the pending patches
References: <200503030822.j238MoBY016825@ccure.user-mode-linux.org>
	<200503031844.j23IhmDS003473@ccure.user-mode-linux.org>
	<200503032111.43966.rob@landley.net>
In-Reply-To: <200503032111.43966.rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503051657.59188.blaisorblade@yahoo.it>
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
Date: Sat, 5 Mar 2005 16:57:59 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Rob Landley <rob@landley.net>, Jeff Dike <jdike@addtoit.com>

On Friday 04 March 2005 03:11, Rob Landley wrote:
> On Thursday 03 March 2005 01:43 pm, Jeff Dike wrote:
> > rob@landley.net said:
> > > Well, just in case your job was too easy, here's one more.  Using the
> > > "quiet" option shows a couple of lines being printed out by printf
> > > that should be printed out by printk (so they'll _shut_up_ when you
> > > ask it to).
> >
> > Those are printfs for a reason.  Early boot mesages (before the kernel is
> > actually running) won't be seen if they are printk-d and the thing
> > crashes before the console is initialized.  The messages will be stuck in
> > the printk buffer, and you will be none the wiser.
>
> I suspected there was a reason, nice to know what it is.  It would be nice
> if they could be made quiet, because I'm in the process of doing a gross
> hack to run an independent process wrapped in UML.

> Basically, my nefarious scheme is to add the squashfs patch to UML, append
> a squashfs image to the end of the  UML executable, and have a cpio ramfs
> init script search through /proc/self/exe for the 32 bytes that were at the
> start of the squashfs (which includes a 4 byte magic signature thingy) to
> determine offset to pass to "losetup -o $OFFSET /dev/loop0 /proc/self/exe",
> and then mount /dev/loop0 / and run the executable I want out of that
> filesystem.
First, compliments.... we need such stuff going.

Please note that unless I'm mistaken the above scheme does not work 
since /proc/self/exe contains what you want on the host, not on the guest. If 
you use hostfs then it's ok, otherwise you'll have to pack the squashfs 
within the cpio image (if it's possible, the cpio image could not be ready to 
cope with so much data). Also, made sure adding stuff at the end of an exec. 
file is accepted without problems? Seems reasonable but not obvious.

No experience with such stuff, but isn't it a bit risky this way (a signature 
being there by mistake)? If you still go for grepping the exec. image, I 
would add a header in the end giving the size of the squashfs image, and 
parse it. With the -s option to losetup you can cut at the end the area 
seeing by the loop device.
> And there's a cheap and dirty way to get a self contained program running
> under UML.  (I hope to actually have an example working this evening using
> 2.6.11.)

> >
> > So, they can be made quiet if you really want, but that's not the way.
> The down side is that UML (even with the quiet option) just won't shut up
> about its init stuff.  Hence me looking into cleaning that up...
Add early_printk which is a printf but shuts down when the quiet option is 
used.
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
