Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FtWlB-0002nl-4F for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 22 Jun 2006 14:30:45 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FtWlA-0004hN-Lj
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 22 Jun 2006 14:30:45 -0700
Date: Thu, 22 Jun 2006 17:30:37 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20060622213037.GC6848@ccure.user-mode-linux.org>
References: <CA52872BEA6FD41182A50008C724B23003F2FFD2@corp01uk.bordersgroupinc.com>
	<20060621231649.25378.qmail@web25225.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20060621231649.25378.qmail@web25225.mail.ukl.yahoo.com>
Subject: Re: [uml-devel] Another cause for UML
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Paolo Giarrusso <blaisorblade@yahoo.it>
Cc: "Carl Radford (DC0854-IT)" <CRADFORD@bordersgroupinc.com>, Jeff Dike <jdike@addtoit.com>, Laurent@lvivier.info, UML-devel <user-mode-linux-devel@lists.sourceforge.net>, for@gmx.de

On Thu, Jun 22, 2006 at 01:16:49AM +0200, Paolo Giarrusso wrote:
> Start posting some of these errors and we'll look at how trivial it
> is (unless the compiler is flooding you). If they look trivial to us
> we may try it...

I agree.

> But my 1st question is: does OpenMosix currently support anything
> else than x86? If not a little compatibility layer may be needed and
> this may hinder significantly the porting - however they'll have to
> fix this anyway to support x86_64 at the very least.

My recollection is that OM dropped stuff directly into arch.

				Jeff

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
