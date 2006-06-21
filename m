Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Fsquy-0000tH-5m for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 20 Jun 2006 17:50:04 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Fsqux-0002gi-E7
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 20 Jun 2006 17:50:04 -0700
Date: Tue, 20 Jun 2006 20:49:30 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20060621004930.GA8274@ccure.user-mode-linux.org>
References: <200606202225.k5KMP3U5006871@ccure.user-mode-linux.org>
	<20060620225522.GK22737@sequoia.sous-sol.org>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20060620225522.GK22737@sequoia.sous-sol.org>
Subject: Re: [uml-devel] [stable] [-stable PATCH] UML - fix uptime
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
To: Chris Wright <chrisw@sous-sol.org>
Cc: stable@kernel.org, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Tue, Jun 20, 2006 at 03:55:22PM -0700, Chris Wright wrote:
> * Jeff Dike (jdike@addtoit.com) wrote:
> > The use of unsigned instead of unsigned here broke the calculations on
>              ^^^^^^^^            ^^^^^^^^
> Hard to imagine how that would cause a problem ;-)

Heh, feel free to fix.

> Queued for -stable, thanks.

Thanks.

			Jeff


_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
