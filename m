Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K3cFB-0000pR-9M for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 03 Jun 2008 12:32:29 -0700
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1K3cFA-0006fj-Uk
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 03 Jun 2008 12:32:29 -0700
Date: Tue, 3 Jun 2008 12:32:11 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Message-Id: <20080603123211.e129c222.akpm@linux-foundation.org>
In-Reply-To: <20080603190235.GA9511@c2.user-mode-linux.org>
References: <20080603190235.GA9511@c2.user-mode-linux.org>
Mime-Version: 1.0
Subject: Re: [uml-devel] [PATCH 1/6] UML - Deal with host time going backwards
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
To: Jeff Dike <jdike@addtoit.com>
Cc: nix@esperi.org.uk, akpm@linuxfoundation.org, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Tue, 3 Jun 2008 15:02:35 -0400
Jeff Dike <jdike@addtoit.com> wrote:

> Protection against the host's time going backwards - keep track of the
> time at the last tick and if it's greater than the current time, keep
> time stopped until the host catches up.

Strange.  What would cause the host's time (or at least UML's perception
of it) to go backwards?

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
