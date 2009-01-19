Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jdike@addtoit.com>) id 1LOvwo-0004aS-Na
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 Jan 2009 15:21:54 +0000
Received: from saraswathi.solana.com ([198.99.130.12])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1LOvwf-0000ua-GS
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 Jan 2009 15:21:54 +0000
Date: Mon, 19 Jan 2009 10:21:04 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20090119152104.GC6432@c2.user-mode-linux.org>
References: <20090115194033.GA10926@hack.private>
	<20090116124158.4364e269.akpm@linux-foundation.org>
	<200901170328.15178.rob@landley.net>
	<dc84318c0901172223p57872a8cr227d940b1c0a908a@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <dc84318c0901172223p57872a8cr227d940b1c0a908a@mail.gmail.com>
Subject: Re: [uml-devel] [Patch] uml: fix a link error
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
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Daolong Wang <ahlongxp@gmail.com>
Cc: Am?rico Wang <xiyou.wangcong@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, user-mode-linux-devel@lists.sourceforge.net, Rob Landley <rob@landley.net>, linux-kernel@vger.kernel.org

On Sun, Jan 18, 2009 at 02:23:46PM +0800, Daolong Wang wrote:
> I can confirm this link error. 

In what environment?  I see no problems here.

> And this patch works for me.

Maybe it fixes the link failure.  But I really doubt that sigprocmask works.

				Jeff

-- 
Work email - jdike at linux dot intel dot com

------------------------------------------------------------------------------
This SF.net email is sponsored by:
SourcForge Community
SourceForge wants to tell your story.
http://p.sf.net/sfu/sf-spreadtheword
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
