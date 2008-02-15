Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JQ5ad-0001Pu-0Q for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 15 Feb 2008 10:47:15 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JQ5aW-0007WG-HZ
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 15 Feb 2008 10:47:09 -0800
Date: Fri, 15 Feb 2008 13:46:50 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080215184650.GA8810@c2.user-mode-linux.org>
References: <47B34BA0.30006@club-internet.fr>
	<20080214003853.GA15952@c2.user-mode-linux.org>
	<47B4BDCD.4080605@club-internet.fr>
	<20080215160205.GA6082@c2.user-mode-linux.org>
	<47B5CE40.9000005@club-internet.fr>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <47B5CE40.9000005@club-internet.fr>
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

On Fri, Feb 15, 2008 at 06:39:12PM +0100, clowncoder wrote:
> By the way, do you use other very interresting tools such as strace?
> if so could you give me names?

strace is the major one.

> 1203096946.933947 poll([{fd=3, events=POLLIN}, {fd=4, events=POLLIN}], 
> 2, 4996) = 0
> 1203096958.157856 gettimeofday({1203096958, 158538}, NULL) = 0

The smoking gun - a poll that should have timed out in .5 sec slept
for 12.

Now, can you do it again, but strace UML on the host at the same time,
with -ttt?

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
