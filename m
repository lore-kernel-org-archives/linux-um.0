Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <malattia@linux.it>) id 1bgOGL-0002Iv-2a
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 04 Sep 2016 03:38:29 +0000
Received: from picard.linux.it ([213.254.12.146])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bgOGK-0004Cl-0p
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 04 Sep 2016 03:38:29 +0000
Date: Sat, 3 Sep 2016 20:38:15 -0700
From: Mattia Dongili <malattia@linux.it>
Message-ID: <20160904033812.GB8364@taihen.jp>
References: <20160713030256.GA26654@taihen.jp>
	<CAFLxGvyhO87SvLn5ofPMGobT6Y27vA-yzC7KxdVe_h6GPB+6Pg@mail.gmail.com>
	<20160714030836.GA1538@taihen.jp> <57874E5D.9030906@nod.at>
	<20160714150731.GB11969@taihen.jp>
	<20160714151709.GC11969@taihen.jp>
	<20160728143220.GA21216@taihen.jp>
	<a335d8cf-dc4a-09f6-cbf1-93657f6c9530@nod.at>
	<20160817170225.GA9261@parts.user-mode-linux.org>
	<4fc897e7-bbc9-1594-faa8-f8cc0918ea2d@landley.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4fc897e7-bbc9-1594-faa8-f8cc0918ea2d@landley.net>
Subject: Re: [uml-devel] UML tools anywhere?
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
To: Rob Landley <rob@landley.net>
Cc: Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

On Fri, Aug 26, 2016 at 02:35:55PM -0500, Rob Landley wrote:
> On 08/17/2016 12:02 PM, Jeff Dike wrote:
> > Hi Richard,
> > 
> >> But let's ask Jeff first.
> >> Jeff, do you have a more recent SCM repo of uml-utilities?
> > 
> > No, I don't believe so.  Everything I have is out there somewhere.
> > You might check with Matt Zimmerman - he might have been doing some
> > maintenance on them.
> > 
> > 				Jeff
> 
> With this reminder, I added a quick and dirty tunctl to toybox (since I
> used it in http://landley.net/lxc/02-networking.html with kvm a while
> back). I see busybox already has one. I'm reading the kernel tuntap
> documentation file to see how to add tap support.

I think it's just a matter of a different flag (IFF_TAP instead of
IFF_TUN) to the ioctl.

-- 
mattia
:wq!

------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

