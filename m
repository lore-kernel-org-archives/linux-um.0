Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AAqIe-00018b-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Sat, 18 Oct 2003 05:35:16 -0700
Received: from marasystems.com ([213.150.153.194] helo=filer.marasystems.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1AAqIb-00048a-0r
	for user-mode-linux-devel@lists.sourceforge.net; Sat, 18 Oct 2003 05:35:13 -0700
From: Henrik Nordstrom <hno@marasystems.com>
Subject: Re: [uml-devel] skas, block devices
In-Reply-To: <3F908967.D6633EFB@vitoni.de>
Message-ID: <Pine.LNX.4.44.0310181432200.30746-100000@filer.marasystems.com>
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
Date: Sat, 18 Oct 2003 14:34:54 +0200 (CEST)
To: Victor <user-mode-linux-devel@vitoni.de>
Cc: User-mode Linux Kernel Development <user-mode-linux-devel@lists.sourceforge.net>

On Sat, 18 Oct 2003, Victor wrote:

> 1. skas:
> What about including it into the UML-patch. This way there would be only
> one patch to apply and the source could just be copied to have to trees
> (one as host, one uml).

I think very few are using the exact same source tree for the host and the 
UML.

> A nice feature would be the possibility to use disk dumps as a block
> device. It would help to test automatic installations or distros which
> rely on normal filesystems or device. Something like "linux
> hda=hda-dump" would save some ubdX.

If ubd supports partitioning this should work straigt away as it is using
the hdX emulation mode of ubd. If not you need to dump each partition
separately.

Regards
Henrik



-------------------------------------------------------
This SF.net email sponsored by: Enterprise Linux Forum Conference & Expo
The Event For Linux Datacenter Solutions & Strategies in The Enterprise 
Linux in the Boardroom; in the Front Office; & in the Server Room 
http://www.enterpriselinuxforum.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
