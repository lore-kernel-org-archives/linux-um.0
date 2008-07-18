Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KJwzU-0001A9-Sc for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 18 Jul 2008 13:55:49 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KJwzT-0004H6-Cc
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 18 Jul 2008 13:55:48 -0700
Date: Fri, 18 Jul 2008 16:55:32 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080718205532.GG13572@c2.user-mode-linux.org>
References: <804dabb00807181222r2e80126fp75bf7bdd9c4cac73@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <804dabb00807181222r2e80126fp75bf7bdd9c4cac73@mail.gmail.com>
Subject: Re: [uml-devel] Kernel panic - not syncing: do_syscall_stub
	:	PTRACE_SETREGS failed, errno = 5
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
To: Peter Teoh <htmldeveloper@gmail.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Sat, Jul 19, 2008 at 03:22:58AM +0800, Peter Teoh wrote:
> Next I checkout the 2.6.26 branch (current master), and generated a
> UML guest for it.  Now the guest have the same version as the host -
> 2.6.26.   But bootup with errors:
> 
> EXT3-fs: mounted filesystem with ordered data mode.
> VFS: Mounted root (ext3 filesystem) readonly.
> Registers -
>         0       0x0
>         1       0x0
>         2       0x0
>         3       0x0
>         4       0x0
>         5       0x0
>         6       0x0
>         7       0x0
>         8       0x0
>         9       0x0
>         10      0x0
>         11      0x0
>         12      0x0
>         13      0x0
>         14      0x0
>         15      0x0
>         16      0x0
> Kernel panic - not syncing: do_syscall_stub : PTRACE_SETREGS failed, errno = 5

I'm working on it - so far no big clues yet...

    	       	    Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
