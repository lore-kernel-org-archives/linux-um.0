Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BIqoF-0000Gj-Cy for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 28 Apr 2004 08:17:15 -0700
Received: from marasystems.com ([213.150.153.194] helo=filer.marasystems.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BIqoE-0004sn-OO for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 28 Apr 2004 08:17:14 -0700
From: Henrik Nordstrom <uml@henrik.marasystems.com>
Subject: Re: [uml-devel] 2.4.27-pre1 with 2.4.24-2 patch
In-Reply-To: <Pine.LNX.4.58.0404281051470.8296@sparrow>
Message-ID: <Pine.LNX.4.44.0404281713150.13085-100000@filer.marasystems.com>
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
Date: Wed, 28 Apr 2004 17:16:15 +0200 (CEST)
To: William Stearns <wstearns@pobox.com>
Cc: Henrik Nordstrom <uml@henrik.marasystems.com>, ML-uml-devel <user-mode-linux-devel@lists.sourceforge.net>

On Wed, 28 Apr 2004, William Stearns wrote:

> /usr/src/uml-linux/linux-2.4.27-pre1-uml24242-netfilter20040427/arch/um/include/init.h:103:1: 
> warning: "__initcall" redefined
> /usr/src/uml-linux/linux-2.4.27-pre1-uml24242-netfilter20040427/include/linux/init.h:54:1: 
> warning: this is the location of the previous definition

Looks like Linux has added a generic __initcall definition available to
all architectures.

Please look into if the two are compatible. If they are then delete the
one from arch/um/include/init.h, if not it is probably visible in 
include/linux/init.h how an arch should indicate it uses it's own 
__initcall method (usually done via a CONFIG_xx directive)

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
