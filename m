Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20040401195425.GA3674@ccure.user-mode-linux.org>
References: <40686E7D.2080600@unclewebster.com>
	<200403300217.i2U2HKxc026892@ccure.user-mode-linux.org>
	<200404011953.43255.blaisorblade_spam@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404011953.43255.blaisorblade_spam@yahoo.it>
Subject: [uml-devel] Re: [uml-user] Hostfs and Humfs
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
Date: Thu, 1 Apr 2004 14:54:25 -0500
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-user@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>

On Thu, Apr 01, 2004 at 06:53:43PM +0100, BlaisorBlade wrote:
> Al Viro said you that ubd=mmap won't work, right? Would you give me the magic
> words to search on the LKML or forward the messages to the -devel list?

It was on IRC.

> Also, I've started writing a little patch for 2.6 to hostfs to generalize it 
> like you said (which I attached). It is just 2-3 hours of work, since I had 
> some doubt: do you like adding a hostfs_user_operations stored into 
> super_block->s_fs_info and calling all the functions of hostfs_user.c 
> indirectly (the trivial and long part I did not do yet)?
> 
> Would it be useful for your "humfs", as it seems to me?

Yup, and I've already done this, with allowing any number of userspace plugins
to the hostfs kernel interface, calling the ops through the operations 
structure, and changing hostfs and and humfs to use it.

I have humfs booting UML now, so it's close to being releasable.

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
