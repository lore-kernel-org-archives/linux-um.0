Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IMnA3-0001Ef-Vg for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 19 Aug 2007 08:57:56 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IMnA2-0001Qk-BA
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 19 Aug 2007 08:57:55 -0700
Date: Sun, 19 Aug 2007 11:57:46 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070819155746.GA5896@c2.user-mode-linux.org>
References: <200708191142.57281.toralf.foerster@gmx.de>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <200708191142.57281.toralf.foerster@gmx.de>
Subject: Re: [uml-devel] build error of an UML kernel with 2.6.2x sources
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Toralf =?iso-8859-1?Q?F=F6rster?= <toralf.foerster@gmx.de>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Sun, Aug 19, 2007 at 11:42:55AM +0200, Toralf F=F6rster wrote:
> arch/um/sys-i386/user-offsets.c:7:22: error: asm/user.h: No such file or =
directory
> arch/um/sys-i386/user-offsets.c: In function 'foo':
> arch/um/sys-i386/user-offsets.c:51: error: invalid application of 'sizeof=
' to incomplete type 'struct user_i387_struct'

What's the host distro?

Do you have either user_i387_struct or elf_fpregset_t anywhere in your
/usr/include?   If not, then your headers are broken, as there is no
way to use PTRACE_GETFPREG since you can't tell how big a buffer to
pass in.

				Jeff

-- =

Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
