Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JbJOB-0004rh-H7 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 17 Mar 2008 10:44:47 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JbJOA-0007en-2w
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 17 Mar 2008 10:44:47 -0700
Date: Mon, 17 Mar 2008 13:44:34 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080317174434.GB10838@c2.user-mode-linux.org>
References: <alpine.LFD.1.00.0803151255530.24311@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.00.0803151255530.24311@localhost.localdomain>
Subject: Re: [uml-devel] [PATCH] UML:  Use newer,
	non-deprecated	__SPIN_LOCK_UNLOCKED macro.
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
To: "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Sat, Mar 15, 2008 at 12:57:29PM -0400, Robert P. J. Day wrote:
>   not compile tested, it seems pretty straightforward.

Looks good to me...

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
