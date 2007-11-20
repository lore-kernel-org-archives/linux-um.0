Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IuWZO-00073t-Gq for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 20 Nov 2007 09:07:31 -0800
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IuWZM-0008KQ-UP
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 20 Nov 2007 09:07:30 -0800
Date: Tue, 20 Nov 2007 12:07:26 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20071120170726.GC7211@c2.user-mode-linux.org>
References: <4742F40B.1030508@quatravaux.org>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4742F40B.1030508@quatravaux.org>
Subject: Re: [uml-devel] [uml-user] [PATCH] Fixed hostfs tv_usec / tv_nsec
	conversion in 2.6.22.9
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
To: Dominique Quatravaux <dominique@quatravaux.org>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Tue, Nov 20, 2007 at 03:49:47PM +0100, Dominique Quatravaux wrote:
> The attached patch against Linux 2.6.22.9 fixes an issue with
> emulating the utimes() and futimes() system calls, that used to cause
> - -EINVAL to be returned from such.

Whoa.

Can I get a Signed-off-by: from you?

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
