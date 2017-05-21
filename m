Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Date: Sun, 21 May 2017 22:30:29 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
Message-ID: <20170521213029.GB390@ZenIV.linux.org.uk>
References: <1495401543-6314-1-git-send-email-richard@nod.at>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1495401543-6314-1-git-send-email-richard@nod.at>
Subject: Re: [uml-devel] [RFC][PATCH] um: Remove proc command from mconsole
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
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Richard Weinberger <richard@nod.at>
Cc: hch@lst.de, user-mode-linux-user@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Sun, May 21, 2017 at 11:19:03PM +0200, Richard Weinberger wrote:
> This feature is another abuser of set_fs().
> Reading proc files from the host side is a debugging feature
> with no security checks at all. The path is not sanitized, therefore
> any file could be read.

ITYM "any file on procfs"

> Let's get rid of it.

Wait a sec - guest is not protected against anyone with mconsole access
anyway.

> Unless I miss something is feature is not ABI since it was addeded for
> debugging UML only. It is broken wrt. security and abuses set_fs().
> I think we can just remove it.

IDGI.  set_fs() abuses are trivial - just switch to kernel_read() and
be done with that...

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

