Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ArOjl-000090-ON
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 12 Feb 2004 13:51:09 -0800
Received: from [69.93.28.254] (helo=unix.easyadmin ident=qmailr)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1ArOiP-0008Dz-SI
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 12 Feb 2004 13:49:45 -0800
Subject: Re: [uml-devel] /dev/anon without /dev/anon ?
From: Matt Ayres <matta@tektonic.net>
In-Reply-To: <024601c3f1b0$41648270$0600a8c0@objexcel>
References: <1076598155.20064.12.camel@wopr.tektonic.net>
	 <01ee01c3f1a9$06424800$0600a8c0@objexcel>
	 <20040212215154.GC4168@ccure.user-mode-linux.org>
	 <024601c3f1b0$41648270$0600a8c0@objexcel>
Content-Type: text/plain
Message-Id: <1076622582.20064.17.camel@wopr.tektonic.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
Date: Thu, 12 Feb 2004 16:49:43 -0500
To: Peter <support@rimuhosting.com>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net

Yes, that will work.  I forgot to mknod /dev/anon the first time I
tested it and the UML's did not use it.

I'm still perplexed as to my situation though :)

On Thu, 2004-02-12 at 16:28, Peter wrote:
> I don't go near tt UMLs.  This these are all using skas UMLs.  Is there anyway I can disable /dev/anon without rebuilding the kernel. rm /dev/anon?
> 
> Regards, Peter
> ----- Original Message ----- 
> From: "Jeff Dike" <jdike@addtoit.com>
> To: "Peter" <support@rimuhosting.com>
> Cc: <user-mode-linux-devel@lists.sourceforge.net>
> Sent: Friday, February 13, 2004 10:51 AM
> Subject: Re: [uml-devel] /dev/anon without /dev/anon ?
> 
> 
> > On Fri, Feb 13, 2004 at 09:43:09AM +1300, Peter wrote:
> > > This may just be noise, but I also had a host server with 2.4.24 + skas3 + /dev/anon that crashed yesterday after a day or so of running.  Not using ubd=mmap.
> > 
> > Yeah, the patch is not quite kosher.  I've had no problems whatsoever running
> > skas UMLs, but tt UMLs won't boot with devanon.
> > 
> > Jeff
> > 
> 
> 
> -------------------------------------------------------
> SF.Net is sponsored by: Speed Start Your Linux Apps Now.
> Build and deploy apps & Web services for Linux with
> a free DVD software kit from IBM. Click Now!
> http://ads.osdn.com/?ad_id56&alloc_id438&op=click
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
-- 
Matt Ayres <matta@tektonic.net>
TekTonic



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
