Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1I41FR-0003Qm-Oa for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 28 Jun 2007 14:09:53 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1I41FQ-0003V2-8J
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 28 Jun 2007 14:09:53 -0700
Date: Thu, 28 Jun 2007 17:09:43 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070628210943.GA10683@c2.user-mode-linux.org>
References: <9604cc9f0706281104l7f10e0bbu9ce89514a10a106d@mail.gmail.com>
	<20070628195713.GA9754@c2.user-mode-linux.org>
	<9604cc9f0706281326x148fd378n9165ce9ccdc587ca@mail.gmail.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9604cc9f0706281326x148fd378n9165ce9ccdc587ca@mail.gmail.com>
Subject: Re: [uml-devel] [uml-user] unlock_kernel symbol
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
To: kototama kototama <kototamo@gmail.com>
Cc: UML-user <user-mode-linux-devel@lists.sourceforge.net>

On Thu, Jun 28, 2007 at 09:26:05PM +0100, kototama kototama wrote:
> >
> >I don't see any evidence on i386 that lock_kernel is available to
> >modules, so it looks like this is a case of a module needing to be
> >updated.
> 
> 
> sure but the strange thing is that the module works well on the host.

What versions of the host kernel and UML?

				Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
