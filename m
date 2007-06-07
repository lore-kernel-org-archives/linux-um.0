Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HwCZI-0008TI-5p for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 07 Jun 2007 00:38:04 -0700
Received: from 42.mail-out.ovh.net ([213.251.189.42])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1HwCZH-0006xI-3G
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 07 Jun 2007 00:38:04 -0700
Date: Thu, 7 Jun 2007 09:37:57 +0200
From: Sylvain Beucler <beuc@beuc.net>
Message-ID: <20070607073757.GA11121@perso.beuc.net>
References: <20070523123435.GA5426@c2.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070523123435.GA5426@c2.user-mode-linux.org>
Subject: Re: [uml-devel] [uml-user] Hang on FC6 after mounting root filesystem
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-user@lists.sourceforge.net, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

On Wed, May 23, 2007 at 08:34:35AM -0400, Jeff Dike wrote:
> I figured out what was happening.  FC6 has a broken PTRACE_SYSEMU,
> resulting in system call interception being completely broken, and
> init going into an infinite segfault loop.
> 
> The patch below is a workaround, and fixes it for me.  I would
> appreciate anyone seeing early boot hangs trying this and let me know
> what happens.

It works for me as well, it fixes my long-running freeze with FC6.

I compiled UML 2.6.21.3 with and without the check-sysemu patch, on a
FC6/2.6.18-1.2849.fc6.

Without: hangs at "VFS: mount root (ext3 filesystem) readonly."
With: works like a charm :)

Thanks,

-- 
Sylvain

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
