Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AX9VL-0000xr-Vw
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 18 Dec 2003 17:32:35 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.24)
	id 1AX9VK-0001Wh-4k
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 18 Dec 2003 17:32:34 -0800
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Re: Bug#224431: user-mode-linux: Hangs
Message-ID: <20031219014756.GC4945@ccure.user-mode-linux.org>
References: <1071789754.763978.973.nullmailer@nietzsche.wgtn.cat-it.co.nz> <20031219002949.GX18100@alcor.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031219002949.GX18100@alcor.net>
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
Date: Thu, 18 Dec 2003 20:47:56 -0500
To: user-mode-linux-devel@lists.sourceforge.net, Srdjan <srdjan@catalyst.net.nz>, 224431-forwarded@bugs.debian.org

On Thu, Dec 18, 2003 at 04:29:49PM -0800, Matt Zimmerman wrote:
> Apparently, tt mode is broken.  I use skas, which is working fine in
> 2.4.22-7um-1, but I can reproduce your failure with mode=tt.

Hmmm, I can't.  It seems fine here.

Can you run it with 'debug' and get a stack trace from the hang?

				Jeff


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
