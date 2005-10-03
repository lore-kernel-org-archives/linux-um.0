Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EMXgh-00088i-CA	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 03 Oct 2005 14:17:31 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1EMXgf-0002qn-EY
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 03 Oct 2005 14:17:31 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] a question about sigsetjmp() in copy_from/to_user()
Message-ID: <20051003203815.GA10745@ccure.user-mode-linux.org>
References: <3524bf1f050927070645b999bd@mail.gmail.com>
	<200510021223.15115.blaisorblade@yahoo.it>
	<20051002183123.GC26063@ccure.user-mode-linux.org>
	<200510032035.55254.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510032035.55254.blaisorblade@yahoo.it>
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
Date: Mon, 3 Oct 2005 16:38:15 -0400
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Young Koh <young.koh@gmail.com>

On Mon, Oct 03, 2005 at 08:35:54PM +0200, Blaisorblade wrote:
> /dev/anon - when the UML kernel frees a page, we ask the host to free it too.

Yeah, /dev/anon is a completely different story, but I thought we were talking
about normal tmpfs.

				Jeff


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
