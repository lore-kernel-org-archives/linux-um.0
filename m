Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AX6QO-0006bf-R2
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 18 Dec 2003 14:15:16 -0800
Received: from web10408.mail.yahoo.com ([216.136.130.110])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.24)
	id 1AX6QO-00019a-HX
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 18 Dec 2003 14:15:16 -0800
Message-ID: <20031218221508.75750.qmail@web10408.mail.yahoo.com>
From: Joydeep Sen Sarma <jsensarma@yahoo.com>
Subject: Re: [uml-devel] Debug uml kernel won't boot (VFS: Unable to mount root fs) 
In-Reply-To: <200312180115.hBI1FAkS007918@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
Date: Thu, 18 Dec 2003 14:15:08 -0800 (PST)
To: Jeff Dike <jdike@addtoit.com>, "James S. Johnson" <jjohnson@eclipse.ncsc.mil>
Cc: user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net

Well - somewhere between switching from the non-debug
to the debug kernel, my .config got completely hosed.
ubd driver was not enabled - neither was pty channel.
Ultimately i just copied over a fresh source tree and
then everything was fine.

I don't know how i got into this mess. perhaps i 
omitted ARCH=um one of the times on the make 
commandline. Don't know ..

thanks,

Joydeep



--- Jeff Dike <jdike@addtoit.com> wrote:
> jsensarma@yahoo.com said:
> > The regular uml kernel worked fine till i turned
> on the debug option.
> > Kernel version is 2.4.22 and I applied uml patch
> 2.4.22-6 to it.
> 
> jjohnson@eclipse.ncsc.mil said:
> > When I try to run a UML kernel as root, using a
> real partition as the
> > UML root  filesystem, it reports that the
> filesystem is corrupted and
> > goes into single  user mode.
> >
> > The UML kernel is 2.4.22 with uml-patch-2.4.22-6
> applied.
> 
> For grins, can you try 2.4.22-5 and see if it's any
> better?  Looking through
> my mail I see a couple of complaints about things
> newly broken in -6 and
> I'd like to see if these are some more.
> 
> 				Jeff
> 


__________________________________
Do you Yahoo!?
New Yahoo! Photos - easier uploading and sharing.
http://photos.yahoo.com/


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
