Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DbWKZ-0005sC-US	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 26 May 2005 21:20:19 -0700
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252] ident=93)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)	id 1DbWKX-0004oj-Ka
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 26 May 2005 21:20:19 -0700
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Message-ID: <20050527042041.GC29811@parcelfarce.linux.theplanet.co.uk>
References: <20050527004024.606961AEE9A@zion.home.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050527004024.606961AEE9A@zion.home.lan>
Subject: [uml-devel] Re: [patch 4/4] uml: make it link in tt mode against NPTL
	glibc
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
Date: Fri, 27 May 2005 05:20:41 +0100
To: blaisorblade@yahoo.it
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Fri, May 27, 2005 at 02:40:24AM +0200, blaisorblade@yahoo.it wrote:
> 
> To make sure switcheroo() can execute when we remap all the executable image,
> we used a trick to make it use a local copy of errno... this trick does not
> work with NPTL glibc, only with LinuxThreads, so use another (simpler) one to
> make it work anyway.
> 
> Might need compile testing on different host archs, since it changes
> __syscall_return from <asm/unistd.h>.

For one thing, it's broken since mmap2() doesn't exist on amd64.  This stuff
*is* low-level - as low-level as it gets.  It's clearly per-architecture.
See ftp.linux.org.uk/pub/people/viro/UM14-unmap-RC12-rc4 for a fix...


-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
