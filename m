Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1ARB2q-0007YT-V7
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 02 Dec 2003 05:58:28 -0800
Received: from marasystems.com ([213.150.153.194] helo=filer.marasystems.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.24)
	id 1ARB2q-00058l-4p
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 02 Dec 2003 05:58:28 -0800
From: Henrik Nordstrom <hno@marasystems.com>
Subject: Re: [uml-devel] make failure with 2.4.23 and uml patch 2.4.22-6
In-Reply-To: <3FCC83A7.2080107@morpheux.org>
Message-ID: <Pine.LNX.4.44.0312021453520.25665-100000@filer.marasystems.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
Date: Tue, 2 Dec 2003 14:58:21 +0100 (CET)
To: Faye Gibbins <wibble@morpheux.org>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Tue, 2 Dec 2003, Faye Gibbins wrote:

> -iwithprefix include -DKBUILD_BASENAME=binfmt_elf  -c -o binfmt_elf.o 
> binfmt_elf.c
> binfmt_elf.c:806:44: macro "ELF_PLAT_INIT" passed 2 arguments, but takes 
> just 1

Looks like UML needs to be adjusted to match i386 platform changes in 
2.4.23. The UML patch you are using is designed for 2.4.22 not 2.4.23.

The um architecture is not entirely self-contained but uses a lot of files 
from the host architecture to avoid code duplication on common tasks. As a 
result the um architecture needs to be adjusted to match the host 
architecture on certain changes to the host architecture files.. which 
seems to be the case in 2.4.23.

Usually these changes are rather trivial and can easily be deduced by 
observing what has changed in the host architecture related to what the 
compile fails on.

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
