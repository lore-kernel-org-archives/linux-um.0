Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cnokn-0003mB-46 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 09 Jan 2005 17:53:57 -0800
Received: from marasystems.com ([83.241.133.2] helo=filer.marasystems.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1Cnokk-0000ld-1V for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 09 Jan 2005 17:53:56 -0800
From: Henrik Nordstrom <uml@hno.marasystems.com>
Subject: Re: [uml-devel] How stable is hostfs (and UML in general)?
In-Reply-To: <200501091706.58778.rob@landley.net>
Message-ID: <Pine.LNX.4.61.0501100141480.14613@filer.marasystems.com>
References: <200501082106.38306.rob@landley.net>
	<41E0C885.3020608@tuxrocks.com>
	<200501091706.58778.rob@landley.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
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
Date: Mon, 10 Jan 2005 02:53:48 +0100 (CET)
To: Rob Landley <rob@landley.net>
Cc: Frank Sorenson <frank@tuxrocks.com>, user-mode-linux-devel@lists.sourceforge.net

On Sun, 9 Jan 2005, Rob Landley wrote:

> I wonder if that old hack (deleting the file signalling there's no rush about
> writing stuff back to the disk anymore, although it's still your backing
> store) still works?

Probably not.

> Why does it do this instead of just mallocing stuff, anyway?  (Quick and dirty
> shared memory again?)

It needs to be able to remap (including temporarily unmap) the memory 
freely, not only share it among several processes.

> I'm more interested in correctness than performance at the moment.  As long as
> it WORKS, they can leave it running overnight for now...

Just to give you alternatives, an alternative to UML is to use a emulator 
such as qemu. Personally I prefer UML, but using an emulator eleminates 
the need of the user to even have Linux to start with as the same image 
also works on Windows.

Regards
Henrik


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
