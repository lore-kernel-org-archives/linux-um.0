Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IUn9P-0000Bo-8X for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 10 Sep 2007 10:34:26 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IUn9O-00015H-9b
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 10 Sep 2007 10:34:18 -0700
Date: Mon, 10 Sep 2007 12:14:00 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070910161400.GF14112@c2.user-mode-linux.org>
References: <46E016D8.4000803@theshore.net>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <46E016D8.4000803@theshore.net>
Subject: Re: [uml-devel] init_new_context_skas - new_mm failed, errno = -24
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
To: "Christopher S. Aker" <caker@theshore.net>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Thu, Sep 06, 2007 at 11:03:52AM -0400, Christopher S. Aker wrote:
> 2.6.22.6-um
> 
> init_new_context_skas - new_mm failed, errno = -24
> init_new_context_skas - new_mm failed, errno = -24
> init_new_context_skas - new_mm failed, errno = -24
> Kernel panic - not syncing: switch_mm_skas - PTRACE_SWITCH_MM failed, 
> errno = 9

> Is this cause by a still-too-low max_map_count value?

Could be - what was the host's max_map_count?

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
