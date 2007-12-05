Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IzxQN-0004hP-Dc for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 05 Dec 2007 08:48:39 -0800
Received: from mx3.mail.elte.hu ([157.181.1.138])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IzxQM-0003rd-27
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 05 Dec 2007 08:48:39 -0800
Date: Wed, 5 Dec 2007 17:48:16 +0100
From: Ingo Molnar <mingo@elte.hu>
Message-ID: <20071205164816.GB25641@elte.hu>
References: <20071205163024.GA7241@c2.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20071205163024.GA7241@c2.user-mode-linux.org>
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
To: Jeff Dike <jdike@addtoit.com>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, "H. Peter Anvin" <hpa@zytor.com>


* Jeff Dike <jdike@addtoit.com> wrote:

> git-x86, in commit 70aa1bd3839e3ec74ce65316528a82570e8de666, changed a 
> lot of the sigcontext field names.  This patch changes UML usage to 
> match.

thanks, we indeed missed those. Should we carry this in x86.git, or 
would you like to carry this in your UML tree?

	Ingo

-------------------------------------------------------------------------
SF.Net email is sponsored by: The Future of Linux Business White Paper
from Novell.  From the desktop to the data center, Linux is going
mainstream.  Let it simplify your IT future.
http://altfarm.mediaplex.com/ad/ck/8857-50307-18918-4
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
