Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ArIhZ-0003dV-JQ
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 12 Feb 2004 07:24:29 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1ArIeH-0007ha-8o
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 12 Feb 2004 07:21:05 -0800
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20040212154958.GB2834@ccure.user-mode-linux.org>
References: <20040208185334.H9021@almesberger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040208185334.H9021@almesberger.net>
Subject: [uml-devel] Re: patch/RFC: add bypass for "debug" parameter
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Thu, 12 Feb 2004 10:49:58 -0500
To: Werner Almesberger <werner@almesberger.net>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Sun, Feb 08, 2004 at 06:53:34PM -0300, Werner Almesberger wrote:
> Since UML ursurps the "debug" parameter, we can't make the kernel
> more verbose before user space runs. This patch adds a new option
> "kernel" that has the same effect as the original "debug".

Hummm, that was some bad planning on my part.

Would there be any loud screams of horror if I were to change the UML
'debug' switch to 'gdb' or something?  That would get rid of this clash
and eliminate the need for this patch.

If I don't hear sufficiently loud objections, I think I will go ahead and
do it.

				Jeff


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
