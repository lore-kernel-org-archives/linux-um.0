Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-list2-new-b.sourceforge.net ([10.3.1.94]
	helo=sc8-sf-list2-new.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JA5XG-0004ac-18 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 02 Jan 2008 07:29:38 -0800
Date: Wed, 2 Jan 2008 10:28:38 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080102152838.GA5629@c2.user-mode-linux.org>
References: <4773F11D.7060803@BitWagon.com> <477AAFA1.9060807@BitWagon.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <477AAFA1.9060807@BitWagon.com>
Subject: Re: [uml-devel] running UserModeLinux under Valgrind(memcheck)
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
To: John Reiser <jreiser@BitWagon.com>
Cc: valgrind-developers@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net

On Tue, Jan 01, 2008 at 01:24:49PM -0800, John Reiser wrote:
> The web page  http://bitwagon.com/valgrind+uml/index.html
> now exists with news, history, commentary, scripts, links
> on getting User Mode Linux for i686 to run under memcheck on i686.

You refer to kmalloc and kfree as keeping object state intact between
kfree and kmalloc, thus not being semantically the same as malloc and
free.  However, this is true of kmem_cache_alloc and kmem_cache_free,
not kmalloc and kfree.

Object contents are destroyed between kfree and kmalloc.

As far as kmem_cache_alloc and kmem_cache_free are concerned, would it
work to say that they are like malloc and free, except that if there's
a constructor, it is always called before kmem_cache_alloc returns?

				Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
