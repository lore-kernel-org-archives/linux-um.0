Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KFu2f-0001LX-JA for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 07 Jul 2008 09:58:21 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KFu2f-0000VW-32
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 07 Jul 2008 09:58:21 -0700
Date: Mon, 7 Jul 2008 12:58:02 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080707165802.GA7747@c2.user-mode-linux.org>
References: <1214488251-20927-1-git-send-email-bhalevy@panasas.com>
	<20080627162645.GC8381@c2.user-mode-linux.org>
	<7225594ED4A1304C9E43D030A886D221050BE1@daytona.int.panasas.com>
	<48673A9B.8050907@panasas.com>
	<20080630162201.GC6643@c2.user-mode-linux.org>
	<48690BC7.5060809@panasas.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <48690BC7.5060809@panasas.com>
Subject: Re: [uml-devel] [PATCH] fix extern inline errors with gcc 4.3.0
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
To: Benny Halevy <bhalevy@panasas.com>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Mon, Jun 30, 2008 at 07:37:27PM +0300, Benny Halevy wrote:
> This isn't exactly aligned with the comment above.
> Should be -lt 0400, as in 22eecde2f9034764a3fd095eecfa3adfb8ec9a98?

Oops, right.

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
