Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DYDHl-0001Ml-0f	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 17 May 2005 18:23:45 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DYDHj-0002Rm-D1	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 17 May 2005 18:23:44 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] copy_from_user in SKAS mode
Message-ID: <20050518011827.GA13287@ccure.user-mode-linux.org>
References: <3524bf1f0505171633edddc7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3524bf1f0505171633edddc7@mail.gmail.com>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Tue, 17 May 2005 21:18:27 -0400
To: Young Koh <young.koh@gmail.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Tue, May 17, 2005 at 07:33:26PM -0400, Young Koh wrote:
> i'm trying to understand how copy_from_user (and copy_to_user) is
> working in SKAS mode. i started from copy_from_user_skas, and followed
> the functions. but i kinda got lost and couldn't get the intuition how
> data are transferred to the UML kernel, which is a different process.
> Could anyone explain how copy_from_user works in SKAS mode? i'd really
> appreciate it. Thank you!

Since UML has no direct access to the process userspace (i.e. process
virtual addresses are meaningless in the kernel), it has to translate
them to physical addresses.  So, each page containing a piece of the
incoming buffer is translated into a physical page, and the data copied
from there.

				Jeff


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
