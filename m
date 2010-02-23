Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <rob0@gmx.co.uk>) id 1NjwwG-0003Va-R6
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 Feb 2010 15:44:44 +0000
Received: from cardinal.lizella.net ([216.23.247.74])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NjwwF-00023V-Lq
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 Feb 2010 15:44:44 +0000
Date: Tue, 23 Feb 2010 09:44:30 -0600
From: /dev/rob0 <rob0@gmx.co.uk>
Message-ID: <20100223154429.GB15849@minipax>
References: <20100220143359.GD3000@hack>
	<20100220150936.GP30031@ZenIV.linux.org.uk>
	<20100220151605.GQ30031@ZenIV.linux.org.uk>
	<20100220191051.GA19560@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20100220191051.GA19560@localhost.localdomain>
Subject: [uml-devel] future of UML,
 was: Re:  [Patch] um: tell git to ignore generated files
Reply-To: user-mode-linux-devel@lists.sourceforge.net,
        user-mode-linux@lists.sourceforge.net
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net, user-mode-linux@lists.sourceforge.net

[ user-mode-linux@lists.sourceforge.net added, CC: to be sent
  separately[1] ]

On Sat, Feb 20, 2010 at 02:10:51PM -0500, Jeff Dike wrote:
> TBH, I haven't done any real work in UML in the last year or so.
> The world has pretty much passed UML by, and it's beyond my
> capabilities and time to catch up and keep up.

Sad. I've seen supposed benchmarks showing the benefits of other
virtualization (FULL v12n) approaches over UML, but I've never
believed them. The default UML images opened up xterms as tty
devices. I didn't use those; I made ttys elsewhere, or even used a
system tty chown'ed.

I thought UML was a pretty nice idea. Makes more sense to me to run
Linux on Linux rather than having to do full hardware v12n. To me,
the subjective "feel" was fine. I ran servers in the UMLs. They
didn't seem sluggish.

My major UML project was a virtual DMZ. Really cool thing: boot up
one physical machine connected to the Internet, but it had no
services exposed to the Internet ... yet it was a full-service mail
and Web and VPN server, plus Samba and other services on the LAN.

My project died due to funding (it was sold to a customer without
proper consideration of development costs, and I declined to continue
development for free.)

Sometimes what the world chooses is not the best thing. This is not
the only occurrance of that happening in the computing world.

Thanks, Jeff; you were right, it *was* fun.



[1] I find that list servers tend to accept mail from me using this
    address, but since it's not sent through GMX facilities, it's
    commonly regarded as spam elsewhere. Thus I will send Jeff a CC:
    using an address which passes SPF et al, but is not subscribed.
-- 
    Offlist mail to this address is discarded unless
    "/dev/rob0" or "not-spam" is in Subject: header

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

