Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C5Ag0-0001L0-1P for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 08 Sep 2004 15:12:28 -0700
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.34) id 1C5Afx-0004FR-NV
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 08 Sep 2004 15:12:27 -0700
Message-Id: <200409082315.i88NFKBP015893@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] uml-patch-2.6.7-2 
In-Reply-To: Your message of "Sun, 05 Sep 2004 21:35:54 +0200."
	<200409051844.13906.blaisorblade_spam@yahoo.it> 
References: <200408190301.i7J30xek004150@ccure.user-mode-linux.org>
	<20040827041056.A3753@almesberger.net>
	<200409051844.13906.blaisorblade_spam@yahoo.it> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
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
Date: Wed, 08 Sep 2004 19:15:20 -0400
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Werner Almesberger <wa@almesberger.net>

blaisorblade_spam@yahoo.it said:
> In fact, I'm not able to see the opening with strace (don't ask me why
> - I  attach to the kernel thread, but I don't get the opening of the
> file; I got  it only once, maybe ), but externfs_lookup calls
> init_inode which calls  host_open_file! That's simply brain-damaged! 

Maybe, but it's mighty useful in testing the file descriptor reclaiming code.

> - Also (maybe related with calling iget(..., 0) ) I get this message
> on every  unmount:

The iget(..., 0) thing has been fixed.

> VFS: Busy inodes after unmount. Self-destruct in 5 seconds.  Have a
> nice  day... 

I'm not seeing that any more.

> -Finally, for some reasons, the dev and rdev field returned by stat
> are  screwed; when listing a device node on hostfs, it prints always
> the maj and  min of the device containing the filesystem; i.e., file->
> rdev = host_stat ->  dev instead of rdev. And I'm not able to see
> where the exchange happens. 

It's here -
	copy_stat:

		.ust_major   = MAJOR(src->st_dev),     /* device */
		.ust_minor   = MINOR(src->st_dev),

	do_stat_file:
		      .rdev		= MKDEV(buf.ust_major, buf.ust_minor),

Now that I have externfs_inode_info, either it or uml_stat looks redundant.
One more thing to clean up...

				Jeff



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
