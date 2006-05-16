Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Fg3zG-0006Ly-Dx for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 16 May 2006 11:09:38 -0700
Received: from 213-140-2-71.ip.fastwebnet.it ([213.140.2.71]
	helo=aa004msg.fastwebnet.it)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Fg3zF-0000au-16
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 16 May 2006 11:09:38 -0700
From: Mattia Dongili <malattia@linux.it>
Subject: Re: [Pkg-uml-pkgs] Bug#366915: [uml-devel] Re: Bug#366915:
	user-mode-linux: fails when host kernel is linux-image-2.6.16-1-k7
Message-ID: <20060516180939.GF29744@inferi.kami.home>
References: <20060512035019.18151.73446.reportbug@doof.home>
	<20060512200806.GA27800@inferi.kami.home>
	<20060515034427.GE21383@ccure.user-mode-linux.org>
	<58990.217.33.203.18.1147687738.squirrel@picard.linux.it>
	<20060515123954.GA3337@ccure.user-mode-linux.org>
	<20060515195508.GP27800@inferi.kami.home>
	<20060516012319.GE7206@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060516012319.GE7206@ccure.user-mode-linux.org>
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
Date: Tue, 16 May 2006 20:09:39 +0200
To: Jeff Dike <jdike@addtoit.com>
Cc: 366915@bugs.debian.org, UML-devel <user-mode-linux-devel@lists.sourceforge.net>, Paul Dwerryhouse <paul@dwerryhouse.com.au>

On Mon, May 15, 2006 at 09:23:19PM -0400, Jeff Dike wrote:
> On Mon, May 15, 2006 at 09:55:09PM +0200, Mattia Dongili wrote:
> > Does this mean that UML will run on a non-standard-vm-split _only_ if
> > the host has CONFIG_VMSPLIT_2G=y ?
> 
> The question is not clear.  The host will only have a nonstandard
> split if it has CONFIG_VMSPLIT_2G or equivalent enabled.
> 
> Do you instead mean whether UML will run on a nonstandard split host
> if IT (not the host) has CONFIG_HOST_2G_2G (not CONFIG_VMSPLIT_2G)
> enabled?
> 
> If so, the answer for now is yes.

Aah! thanks for clarifing and sorry for the confusion on my side..

> 
> > If so is this considered a bug or a feature? :)
> 
> More a bug.  We are considering ways of detecting the host vmsplit at
> run time and adapting to it, but added back the CONFIG_HOST_2G_2G as
> an interim measure.

Thanks, will enable it in the .17 release of the debian package.

-- 
mattia
:wq!


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
