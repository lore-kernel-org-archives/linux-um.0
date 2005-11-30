Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EhVjq-00080v-Ta for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 30 Nov 2005 09:27:26 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1EhVjp-0005DQ-By
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 30 Nov 2005 09:27:26 -0800
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] 2.6.15-rc2
References: <12276.1133324450@sandelman.ottawa.on.ca>
	<200511300739.46148.rob@landley.net>
	<31479.1133368473@sandelman.ottawa.on.ca>
In-Reply-To: <31479.1133368473@sandelman.ottawa.on.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511301127.13494.rob@landley.net>
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
Date: Wed, 30 Nov 2005 11:27:13 -0600
To: Michael Richardson <mcr@sandelman.ottawa.on.ca>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Wednesday 30 November 2005 10:34, Michael Richardson wrote:
> What was the fix?

A quick check through the past few pages of:
http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=shortlog

Finds these four commits:
http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=aa1a64ee12ae130706f3fc0007841ce9b0ddf9c2
http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=17d469715c6453e4994e6617e8f644bf10f38584
http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=e23181deec0d2a8be576faf9d71211abb84d5ccc
http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=39d730ab87f07592e3a3794353f097d5184cae7a

Click "commitdiff" and then right click on "plain" and save as.

> Are you using a cramfs initrd?

Nope.  Squashfs.  (Last time I tried cramfs it had some _serious_ size 
limitations.)

And for testing, I just go:

./linux rootfstype=hostfs rw init=/bin/sh

No special setup required at all, just borrow the host system's root 
directory.  (You probably want to "mount -t proc /proc /proc" and "mount -t 
tmpfs /dev/shm", and "mount -t devpts /dev/pts" before doing anything _too_ 
fancy.)

Getting ctrl-C to work took a bit of doing, but I posted a oneit.c file I made 
that does it, a while back...

> I built against the v2.6.15-rc3 tag in GIT, and I saw the same failure.
> I'm going to make clean again (the rm -rf way) and try again to be
> sure...

Yeah, neither make ARCH=um clean nor make ARCH=um distclean seem to actually 
delete all the files a UML build makes.  I may do something about that one of 
these days...

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
