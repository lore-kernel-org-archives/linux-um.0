Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JPS7w-0001pI-Nk for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 13 Feb 2008 16:39:00 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JPS7v-0002Lo-5M
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 13 Feb 2008 16:39:00 -0800
Date: Wed, 13 Feb 2008 19:38:53 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080214003853.GA15952@c2.user-mode-linux.org>
References: <47B34BA0.30006@club-internet.fr>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <47B34BA0.30006@club-internet.fr>
Subject: Re: [uml-devel] g_timeout_add
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
To: clowncoder <vincent-perrier@club-internet.fr>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Wed, Feb 13, 2008 at 08:57:20PM +0100, clowncoder wrote:
> It seems that g_timeout_add glib timeouts are not accurate
> when there is no gtk activity on an uml target.
> 
> This may be a glib problem since I cannot check
> that it does not occur on my host.
> 
> When gtk events occur through mouse moves, then
> the timeout is good (a 5 sec timeout) if no graphical
> activity exists, the timeout takes an average of 12 sec,
> even if there is console activity on the uml machine.

You're going to need to tell me what's happening at the system call
level - i.e. strace it and see what is doing something it shouldn't.

				Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
