Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KH05L-0007tQ-5M for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 10 Jul 2008 10:37:39 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KH05K-0001TX-K1
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 10 Jul 2008 10:37:39 -0700
Date: Thu, 10 Jul 2008 13:37:30 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080710173730.GE18429@c2.user-mode-linux.org>
References: <486FC187.6010802@gmx.de>
	<20080707203912.GB7648@c2.user-mode-linux.org>
	<48737664.3000608@gmx.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <48737664.3000608@gmx.de>
Subject: Re: [uml-devel] hostfs oddities
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
To: Ingo van Lil <inguin@gmx.de>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Tue, Jul 08, 2008 at 04:15:00PM +0200, Ingo van Lil wrote:
> The call stack for truncating the file:
> 
>   - sys_open (fs/open.c)
>   - do_sys_open (fs/open.c)
>   - do_filp_open (fs/open.c)
>   - open_namei (fs/namei.c)
>   - may_open (fs/namei.c)
>   - do_truncate (fs/open.c)
> 
> And the call stack for actually opening the file:
> 
>   - sys_open (fs/open.c)
>   - do_sys_open (fs/open.c)
>   - do_filp_open (fs/open.c)
>   - nameidata_to_filp (fs/open.c)
>   - __dentry_open (fs/open.c)
> 
> Maybe that helps.

Yeah, I was suspecting that something was causing operations on the
file before hostfs was asked to actually open it.  Hmm.

     	    	       Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
