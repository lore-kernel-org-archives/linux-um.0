Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CnW89-0005re-8P for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 08 Jan 2005 22:00:49 -0800
Received: from www.tuxrocks.com ([64.62.190.123] helo=tuxrocks.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1CnW85-0001W9-TP
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 08 Jan 2005 22:00:49 -0800
Message-ID: <41E0C885.3020608@tuxrocks.com>
From: Frank Sorenson <frank@tuxrocks.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] How stable is hostfs (and UML in general)?
References: <200501082106.38306.rob@landley.net>
In-Reply-To: <200501082106.38306.rob@landley.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
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
Date: Sat, 08 Jan 2005 23:00:37 -0700
To: Rob Landley <rob@landley.net>
Cc: user-mode-linux-devel@lists.sourceforge.net

Rob Landley wrote:
<snip>

Rob,

I may not be able to answer all your questions, but I may be able to
offer a few pointers.

For the UML kernel version, the stock 2.6.x kernel is getting better,
but still isn't the most stable and reliable kernel.  Right now, the
most stable I've found is using 2.6.9 from kernel.org, with the -bb4
patches from
http://www.user-mode-linux.org/~blaisorblade/patches/guest/uml-2.6.9-bb4/

There are several thing you can do to improve the speed at which the UML
runs.  When UML starts, it opens a file in /tmp (or somewhere else if
TMPDIR is set), mmaps it, and uses that as its memory.  To speed this
up, make sure that it's located on a tmpfs-mounted filesystem (so it's
real memory).

fstab:
none   /UML/MEMORY      tmpfs   defaults,size=768M      0 0

Starting the UML:
export TMPDIR=/UML/MEMORY
/UML/linux ...


Also, with an unpatched host kernel, your UML will run slower.  If
possible, patch the host kernel to allow UMLs to run in SKAS mode and
take advantage of some SYSEMU code.  These patches are also here:
http://www.user-mode-linux.org/~blaisorblade/patchlist.html or you can
get the 2.6.10 host patch from
http://uml.tuxrocks.com/Patches/host-skas3-2.6.10-v7.patch

I don't know much about hostfs, so I can't give any real ideas there.
UML doesn't support TLS yet, so make sure that your UML root_fs doesn't
have a /lib/tls directory.

Hope this helps,

Frank
-- 
Frank Sorenson - KD7TZK
Systems Manager, Computer Science Department
Brigham Young University
frank@tuxrocks.com


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
