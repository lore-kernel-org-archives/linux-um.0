Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BIj9i-0000up-IF for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 28 Apr 2004 00:06:54 -0700
Received: from marasystems.com ([213.150.153.194] helo=filer.marasystems.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BIj9h-00083N-Eh for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 28 Apr 2004 00:06:53 -0700
From: Henrik Nordstrom <uml@henrik.marasystems.com>
Subject: Re: [uml-devel] 2.4.27-pre1 with 2.4.24-2 patch
In-Reply-To: <Pine.LNX.4.58.0404280157180.8296@sparrow>
Message-ID: <Pine.LNX.4.44.0404280901550.4504-100000@filer.marasystems.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
Date: Wed, 28 Apr 2004 09:06:10 +0200 (CEST)
To: William Stearns <wstearns@pobox.com>
Cc: ML-uml-devel <user-mode-linux-devel@lists.sourceforge.net>

On Wed, 28 Apr 2004, William Stearns wrote:

> - include/asm-um/system-i386.h has a duplicate definition of __cmpxchg .  
> It looks close enough to the one in include/asm/arch/system.h that I
> just commented out asm-um's.

Patch was sent some weeks ago. It is needed for 2.4.26 as well. Your 
change is correct.

> - when compiling the aio code, there's a missing aio_abi.h.

Sent a patch for this some days ago. Also sent a patch which fixes hostfs 
which is somewhat broken in 2.4.24-2.

copying aio_abi.h from 2.6 is also ok, but does not fix hostfs..

> Thre are a bunch of warnings about __initcal, __exit_call, and
> __init_call redefinitions.

Which warnings?

Regards
Henrik



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE. 
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
