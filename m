Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DXjGR-0004WG-43	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 16 May 2005 10:20:23 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DXjGP-0008Ry-9m	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 16 May 2005 10:20:22 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] The UML scheduler
Message-ID: <20050516165830.GA6731@ccure.user-mode-linux.org>
References: <3524bf1f05051607306756dcfc@mail.gmail.com>
	<20050516150648.GB4977@ccure.user-mode-linux.org>
	<3524bf1f05051608377420ae37@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3524bf1f05051608377420ae37@mail.gmail.com>
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
Date: Mon, 16 May 2005 12:58:30 -0400
To: Young Koh <young.koh@gmail.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Mon, May 16, 2005 at 11:37:49AM -0400, Young Koh wrote:
> Thank you for your reply. I have one following question.
> 
> in native Linux, a timer tick goes to the kernel, which has the
> previliege to save the current context and switch the running process.
> But UML kernel is just another user level process, even though it is
> tracing the application processes. in UML case, when a timer tick goes
> to the UML kernel, how does it stop the running process, which is
> another process?

Look at switch_to_{skas,tt}.  In tt mode, it's one process waking another
by writing to a pipe, then sleeping by reading its own pipe.  In skas mode,
it's a longjmp and a memory switch.

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
