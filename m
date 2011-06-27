Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <randy.dunlap@oracle.com>) id 1QbFC2-0007EG-5e
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 27 Jun 2011 17:01:50 +0000
Received: from rcsinet10.oracle.com ([148.87.113.121])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1QbFC1-00016W-DL
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 27 Jun 2011 17:01:50 +0000
Date: Mon, 27 Jun 2011 10:01:19 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
Message-Id: <20110627100119.9bebaa5b.randy.dunlap@oracle.com>
In-Reply-To: <20110627164259.GF11013@ZenIV.linux.org.uk>
References: <20110627161656.688820b9.sfr@canb.auug.org.au>
	<20110627082733.75e58ae4.randy.dunlap@oracle.com>
	<201106271830.43698.richard@nod.at>
	<20110627164259.GF11013@ZenIV.linux.org.uk>
Mime-Version: 1.0
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
Subject: Re: [uml-devel] linux-next: Tree for June 27 (uml)
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, Stephen Rothwell <sfr@canb.auug.org.au>, user-mode-linux-devel@lists.sourceforge.net, Jeff, Richard Weinberger <richard@nod.at>, Dike <jdike@addtoit.com>, LKML <linux-kernel@vger.kernel.org>, linux-next@vger.kernel.org

On Mon, 27 Jun 2011 17:42:59 +0100 Al Viro wrote:

> On Mon, Jun 27, 2011 at 06:30:43PM +0200, Richard Weinberger wrote:
> > Am Montag 27 Juni 2011, 17:27:33 schrieb Randy Dunlap:
> > > On Mon, 27 Jun 2011 16:16:56 +1000 Stephen Rothwell wrote:
> > > > Hi all,
> > > 
> > > > Changes since 20110624:
> > > uml defconfig builds on x86 (32-bit and 64-bit) fail with:
> > > 
> > > fs/hostfs/hostfs_kern.c:756: error: 'mask' undeclared (first use in this
> > > function)
> > 
> > Hmm, "->permission() sanitizing: don't pass flags to ->permission()" is the evil doer.
> > Al?
> 
> Gyah... s/mask/desired/ in that line.  Will fold...

Ack, that works, thanks.

---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***

------------------------------------------------------------------------------
All of the data generated in your IT infrastructure is seriously valuable.
Why? It contains a definitive record of application performance, security 
threats, fraudulent activity, and more. Splunk takes this data and makes 
sense of it. IT sense. And common sense.
http://p.sf.net/sfu/splunk-d2d-c2
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

