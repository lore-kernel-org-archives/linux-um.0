Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Message-Id: <200404130458.i3D4wKsf024793@ccure.user-mode-linux.org>
In-Reply-To: Your message of "Sun, 11 Apr 2004 16:51:20 +0200."
	<200404111651.20256.blaisorblade_spam@yahoo.it> 
References: <40686E7D.2080600@unclewebster.com>
	<200403300217.i2U2HKxc026892@ccure.user-mode-linux.org>
	<200404111651.20256.blaisorblade_spam@yahoo.it> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] Re: [uml-user] one drawback to using cows commercially...
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
Date: Tue, 13 Apr 2004 00:58:20 -0400
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: tim doyle <tim@unclewebster.com>, UML <user-mode-linux-user@lists.sourceforge.net>, user-mode-linux-devel@lists.sourceforge.net

blaisorblade_spam@yahoo.it said:
> Have you heard of the discussion about COWlinks? I.e. creating a Copy
> - On -  Write functionality for hard links? Or do you want to rewrite
> files one page  at a time (i.e. if I change one byte inside a file,
> only the "page"  containing that byte is copied and changed)? 

COWlinks sound like they would be useful for doing file-level COWing for
UML.

I'm considering that, plus block-level COWing within a file, using the standard
COW format we have today.  This would be necessary if we do block devices
by loop-mounting a rootfs from humfs and using that as the root device.

				Jeff



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
