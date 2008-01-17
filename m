Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JFZ7K-0003Id-Ej for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Jan 2008 10:05:30 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JFZ7I-0003mE-Tn
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Jan 2008 10:05:30 -0800
Date: Thu, 17 Jan 2008 13:05:21 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080117180521.GD4385@c2.user-mode-linux.org>
References: <cfa94dc20801150845w5328dccfn40858663967884bd@mail.gmail.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cfa94dc20801150845w5328dccfn40858663967884bd@mail.gmail.com>
Subject: Re: [uml-devel] IA32_EMULATION support
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
To: Ryan Finnie <ryan@finnie.org>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Tue, Jan 15, 2008 at 08:45:37AM -0800, Ryan Finnie wrote:
> At the moment there is no 32-bit object
> support in x86_64 UML kernels, and of course knowing my luck, the day
> we introduce an x86_64 UML guest at work is the day it needs some
> 32-bit blob or something.  I believe you mentioned on IRC a few months
> ago that you once had a semi-working patch to add IA32_EMULATION a
> long time ago.  Would this be something you would be willing to work
> on again once things settle down?

I'm thinking about it - the 32-bit compat skas4 work has got me
thinking about how much work it is, and it might not be too bad.

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
