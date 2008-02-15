Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JQ30x-00077y-Ec for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 15 Feb 2008 08:02:15 -0800
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JQ30v-0008KP-PO
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 15 Feb 2008 08:02:15 -0800
Date: Fri, 15 Feb 2008 11:02:05 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080215160205.GA6082@c2.user-mode-linux.org>
References: <47B34BA0.30006@club-internet.fr>
	<20080214003853.GA15952@c2.user-mode-linux.org>
	<47B4BDCD.4080605@club-internet.fr>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <47B4BDCD.4080605@club-internet.fr>
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

On Thu, Feb 14, 2008 at 11:16:45PM +0100, clowncoder wrote:
> With strace, when I do nothing on the gtk screen, we get
> what is under, it seems that the poll has a 5000 milli-sec
> timeout, but takes 10 sec to wake.

Can you show that with timestamps (strace -ttt)?

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
