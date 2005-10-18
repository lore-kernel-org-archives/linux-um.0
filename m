Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ERgRz-0006lx-FO	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 17 Oct 2005 18:39:35 -0700
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)	id 1ERgRx-0002yk-SO
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 17 Oct 2005 18:39:35 -0700
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] Starting uml with the debugger
References: <229e70f20510171009x103fe854ncb91021c3ce0e31e@mail.gmail.com>
	<20051017175328.GA8015@localhost.localdomain>
In-Reply-To: <20051017175328.GA8015@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510172038.34803.rob@landley.net>
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
Date: Mon, 17 Oct 2005 20:38:34 -0500
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>, Etay Meiri <etay.meiri@gmail.com>

On Monday 17 October 2005 12:53, Jeff Dike wrote:
> If this thing is new enough to have skas0, then just disable CONFIG_MODE_TT
> and gdb it normally.

I'm curious: now that skas0 mode works, when does tt mode start to go away?

(Obviously, making tls work might be nice first...)

Rob


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
