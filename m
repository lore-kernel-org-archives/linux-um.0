Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JCtpL-00052U-Dy for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 10 Jan 2008 01:35:55 -0800
Received: from mx2.mail.elte.hu ([157.181.151.9])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JCtpL-0003Oj-2X
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 10 Jan 2008 01:35:55 -0800
Date: Thu, 10 Jan 2008 10:35:36 +0100
From: Ingo Molnar <mingo@elte.hu>
Message-ID: <20080110093536.GA17808@elte.hu>
References: <E1JCi3M-0006hO-7i@pomaz-ex.szeredi.hu>
	<20080110073215.GA11506@elte.hu>
	<E1JCtMI-0007jw-5U@pomaz-ex.szeredi.hu>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <E1JCtMI-0007jw-5U@pomaz-ex.szeredi.hu>
Subject: Re: [uml-devel] uml and -regparm=3
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
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: jdike@addtoit.com, akpm@linux-foundation.org, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org


* Miklos Szeredi <miklos@szeredi.hu> wrote:

> Thanks.  Patch works, but needed to add asmregparm to the definitions 
> as well, plus added default define into <linux/linkage.h> (updated 
> patch below).

thanks, applied.

	Ingo

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
