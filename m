Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AOcTk-0008IZ-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Tue, 25 Nov 2003 04:39:40 -0800
Received: from marasystems.com ([213.150.153.194] helo=filer.marasystems.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.24)
	id 1AOcTj-0007ox-F4
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 25 Nov 2003 04:39:39 -0800
From: Henrik Nordstrom <hno@marasystems.com>
Subject: Re: [uml-devel] Uml_tools compile error
In-Reply-To: <3507.1069763498@www12.gmx.net>
Message-ID: <Pine.LNX.4.44.0311251338150.30728-100000@filer.marasystems.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Tue, 25 Nov 2003 13:39:32 +0100 (CET)
To: Thonix@gmx.net
Cc: user-mode-linux-devel@lists.sourceforge.net

On Tue, 25 Nov 2003 Thonix@gmx.net wrote:

> cc -g -Wall   -c -o uml_mconsole.o uml_mconsole.c
> uml_mconsole.c:17: readline/readline.h: No such file or directory
> uml_mconsole.c:18: readline/history.h: No such file or directory

I think your system is missing the GNU readline development headers &
library.

On RedHat this is the readline-devel package.

Regards
Henrik



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
