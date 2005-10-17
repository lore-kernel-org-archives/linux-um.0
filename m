Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ERZHv-0004BO-3a	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 17 Oct 2005 11:00:43 -0700
Received: from pool-71-245-228-238.bstnma.fios.verizon.net ([71.245.228.238]
	helo=localhost.localdomain)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)	id 1ERZHt-0004gH-R2
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 17 Oct 2005 11:00:43 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Starting uml with the debugger
Message-ID: <20051017175328.GA8015@localhost.localdomain>
References: <229e70f20510171009x103fe854ncb91021c3ce0e31e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <229e70f20510171009x103fe854ncb91021c3ce0e31e@mail.gmail.com>
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
Date: Mon, 17 Oct 2005 13:53:28 -0400
To: Etay Meiri <etay.meiri@gmail.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Mon, Oct 17, 2005 at 07:09:21PM +0200, Etay Meiri wrote:
> Hi,
> 
> I'm trying to start uml under the controller of gdb using the following
> command:

What version?

> ./vmlinux mem=128m ubda=root_fs.fc4_client ubdb=swap_client con=xterm
> eth0=tuntap,,,10.10.20.10 <http://10.10.20.10> debug

WTF is <http://10.10.20.10>?

If this thing is new enough to have skas0, then just disable CONFIG_MODE_TT
and gdb it normally.

				Jeff


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
