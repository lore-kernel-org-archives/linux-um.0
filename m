Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] [Announce] mountlo 0.5 - Loopback mounting in
	userspace
Message-ID: <20060227170826.GA5481@ccure.user-mode-linux.org>
References: <E1FDk1G-0004S6-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1FDk1G-0004S6-00@dorka.pomaz.szeredi.hu>
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
Date: Mon, 27 Feb 2006 12:08:26 -0500
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: fuse-devel@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Feb 27, 2006 at 04:10:38PM +0100, Miklos Szeredi wrote:
> I'm proud to announce a new version of my pet project 'mountlo', a
> utility which works similarly to 'mount -o loop', but the filesystem
> runs entirely in userspace.
> 
> While arguably it is quite useless, I like it because it combines some
> of my favorite technologies (Linux, UML and FUSE) with very little
> additional glue code.

Very cute.  I'm in the process of doing something similar, except I'm
integrating a FUSE server into the UML kernel to export the UML
filesystem to the host.  So far, I can cd and ls inside the mount -
lookup and readdir are implemented.

				Jeff


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
