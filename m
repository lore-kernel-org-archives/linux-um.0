Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ES2mA-0001kW-EK	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 18 Oct 2005 18:29:54 -0700
Received: from pool-71-245-228-58.bstnma.fios.verizon.net ([71.245.228.58]
	helo=ccure.user-mode-linux.org)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)	id 1ES2m9-000369-2E
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 18 Oct 2005 18:29:54 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] [PATCH] build fix for uml/amd64
Message-ID: <20051019012232.GA12072@ccure.user-mode-linux.org>
References: <20051018214517.GD7992@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051018214517.GD7992@ftp.linux.org.uk>
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
Date: Tue, 18 Oct 2005 21:22:32 -0400
To: Linus Torvalds <torvalds@osdl.org>, Al Viro <viro@ftp.linux.org.uk>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Tue, Oct 18, 2005 at 10:45:17PM +0100, Al Viro wrote:
> 	Missing half of the [PATCH] uml: Fix sysrq-r support for skas mode
> We need to remove these (UPT_[DEFG]S) from the read side as well as the
> write one - otherwise it simply won't build.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ----
> 
> IMO it should go in before 2.6.14.  Jeff, could you ACK that?

Yup.

Acked-by: Jeff Dike <jdike@addtoit.com>


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
