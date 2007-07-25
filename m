Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IDjPg-00060n-OX for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 25 Jul 2007 09:08:37 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IDjOH-0007Sb-Ua
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 25 Jul 2007 09:07:10 -0700
Date: Wed, 25 Jul 2007 12:07:00 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070725160700.GA7607@c2.user-mode-linux.org>
References: <20070725143227.GO5115@pintsize>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070725143227.GO5115@pintsize>
Subject: Re: [uml-devel] [RFC PATCH] vde network backend
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
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Luca Bigliardi <shammash@artha.org>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Wed, Jul 25, 2007 at 04:32:27PM +0200, Luca Bigliardi wrote:
> Hi,
> I've written a new network backend for user-mode-linux using libvdeplug to
> connect to a vde_switch. In the following lines I've made a little
> description of what VDE is and I've written a couple of examples to give
> you an idea of the benefits you can have using this backend.
> 
> Please tell me what do you think about vde-transport and its first
> implementation I'm attaching in this mail (It's a patch developed on
> 2.6.22.1 vanilla).

Looks reasonable (and useful).  Do you want me to drop it in my tree
and forward it to mainline?  If so, I'll need a changelog and a
Signed-off-by:.

Some comments -
	style violations :
		there are some cases of return(x) which should be
return x
		if( blah ){ should be if(blah) {
		if(foo) return bar - the return should be on the next
line
		the indentation of multi-line function calls is whacked
	
	I would leave out the likely()s.  Unless you can show a
noticable performance difference, they only clutter the code.
	printks should have severity specified (in userspace code,
they are available as UM_KERN_*)
	um_kmalloc is gone - use kmalloc with UM_GFP_KERNEL

I realize that you probably copied many of the above problems from the
existing code.  All I can say is that I'm gradually fixing them, and
I'd rather not add new instances.

				Jeff	

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
