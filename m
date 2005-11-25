Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EfaC9-00056o-Fu for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 25 Nov 2005 01:48:41 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1EfaC7-0007jA-5y
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 25 Nov 2005 01:48:41 -0800
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] When /tmp is not tmpfs.
References: <200511240611.02613.rob@landley.net>
	<20051125095502.GA32587@ccure.user-mode-linux.org>
In-Reply-To: <20051125095502.GA32587@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511250348.28123.rob@landley.net>
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
Date: Fri, 25 Nov 2005 03:48:27 -0600
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Friday 25 November 2005 03:55, Jeff Dike wrote:
> On Thu, Nov 24, 2005 at 06:11:01AM -0600, Rob Landley wrote:
> > So my question is, could system v shared memory be used in place of the
> > tmpfs mount?  (Can it be mapped in the right location and inherited
> > across fork()?)
>
> tmpfs and shmfs are two names for the same underlying code.

Yes, but when tmpfs is not configured into the kernel it isn't exposed to 
userspace as a mountable filesystem, so the only way to _access_ it is 
sometimes through the sysv shared memory API.

I agree that using the sysv API probably isn't worth the effort if we've got a 
good workaround.  I have a workaround, so I'm unlikely to code it up.

> I think the shmfs mount is for the benefit of things that use SysV shared
> memory. 

Yup, but it was standard practice to do this back in the 2.4 days, while 
mounting /tmp as tmpfs is _not_ done on such recent systems as ubuntu "horny 
hedgehog", which shipped earlier this year.

I'm not worried about 2.4 systems because they had the "deleted files don't 
get synced to disk" hack that got yanked in 2.6, so the pathological behavior 
I'm seeing shouldn't show up on them even though for them /tmp isn't usually 
tmpfs.

Instead, this pathological behavior only shows up when you do something that 
constantly dirties a lot of pages on a 2.6 system where /tmp isn't tmpfs.

> So, no.  Just use tmpfs on /tmp.

If I can guarantee that I have root access to all the systems my code is 
running on and can make that kind of administrative change, then there's not 
a whole lot of point in me bothering with UML in the first place.

Setting TMPDIR to point to /dev/shm seems to be a decent workaround, but I'm 
not sure how portable it is.  (Is there a system out there where /tmp is 
mounted tmpfs but /dev/shm isn't?  Right now I'm testing if /dev/shm exists 
and assuming it's tmpfs if so.)

But documenting that UML -skas0 performance is going to not only suck rocks 
but bog down the rest of your system very very noticeably when you run on 2.6 
and its temp file isn't on tmpfs might be a useful thing to do.

>     Jeff

Rob
-- 
Steve Ballmer: Innovation!  Inigo Montoya: You keep using that word.
I do not think it means what you think it means.


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
