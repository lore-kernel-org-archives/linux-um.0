Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HjH1L-0004ky-Dt for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 02 May 2007 08:45:35 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HjH1K-0001Yx-Ux
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 02 May 2007 08:45:35 -0700
Date: Wed, 2 May 2007 11:41:31 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070502154131.GE6752@c2.user-mode-linux.org>
References: <20070501182158.GA8358@c2.user-mode-linux.org>
	<4637FC1D.4040300@yahoo.com.au>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4637FC1D.4040300@yahoo.com.au>
Subject: Re: [uml-devel] [PATCH 4/6] UML - free() wrapper should call libc free
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: akpm@osdl.org, LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

On Wed, May 02, 2007 at 12:49:01PM +1000, Nick Piggin wrote:
> I want to get rid of PG_reserved eventually. Is it possible to use PG_arch_1
> for this?

Yup.

Andrew - Feel free to drop this or just sit on it until I send a
replacement.  Whichever is easier.

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
