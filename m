Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-list2-b.sourceforge.net ([10.3.1.8] helo=sc8-sf-list2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AZT0I-0001Kf-Ee
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 25 Dec 2003 02:46:06 -0800
From: Christoph Hellwig <hch@infradead.org>
Message-ID: <20031225104559.A23615@infradead.org>
References: <200312242019.23335.blaisorblade_work@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200312242019.23335.blaisorblade_work@yahoo.it>; from blaisorblade_work@yahoo.it on Wed, Dec 24, 2003 at 08:19:23PM +0100
Subject: [uml-devel] Re: [kbuild-devel] Needed help for UML kbuild.
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
Date: Thu, 25 Dec 2003 10:45:59 +0000
To: BlaisorBlade <blaisorblade_work@yahoo.it>
Cc: kbuild-devel@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net

On Wed, Dec 24, 2003 at 08:19:23PM +0100, BlaisorBlade wrote:
> Makefile.build change is just cosmetic(changing the shown tag; I must change 
> it more to fix the filename alignment; but why don't you use a tab for 
> this?). The Makefile.lib, instead, is the core change: objects listed in 
> UML_USER_OBJS get completely different CFLAGS.

Please don't use shouting names..

> The list always contains, in the arch/um subfolders, all objects whose name 
> matches %_user.o(as it has always been for UML).

This doesn't sound like a good heuristic, imagine a driver using e.g.
foo_user.c for the chardev user interface.  In general I'd suggest adding
parallel infrastructure for user-$(CONFIG_FOO) variables in addition to
the current obj-* and host-*.  The only problem you could get with that
is that you need to take special care of the link order.



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
