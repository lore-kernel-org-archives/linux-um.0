Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IzyhO-0005Hu-C0 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 05 Dec 2007 10:10:18 -0800
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IzyhM-0000Qw-SN
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 05 Dec 2007 10:10:18 -0800
Date: Wed, 5 Dec 2007 13:09:59 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20071205180959.GA7934@c2.user-mode-linux.org>
References: <20071205163024.GA7241@c2.user-mode-linux.org>
	<20071205164816.GB25641@elte.hu>
Mime-Version: 1.0
Content-Disposition: attachment
In-Reply-To: <20071205164816.GB25641@elte.hu>
Subject: Re: [uml-devel] [PATCH] UML - change sigcontext fields to match x86
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
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, "H. Peter Anvin" <hpa@zytor.com>

On Wed, Dec 05, 2007 at 05:48:16PM +0100, Ingo Molnar wrote:
> thanks, we indeed missed those. Should we carry this in x86.git, or 
> would you like to carry this in your UML tree?

Probably better for it to go in x86.git - that way it travels with
your sigcontext patch.

				Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
SF.Net email is sponsored by: The Future of Linux Business White Paper
from Novell.  From the desktop to the data center, Linux is going
mainstream.  Let it simplify your IT future.
http://altfarm.mediaplex.com/ad/ck/8857-50307-18918-4
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
