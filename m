Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
From: Henrik Nordstrom <uml@henrik.marasystems.com>
Subject: Re: [uml-devel] Re: [uml-user] Network lags
In-Reply-To: <407865A4.4070403@upb.de>
Message-ID: <Pine.LNX.4.44.0404110125420.6583-100000@filer.marasystems.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset="iso-8859-1"
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
Date: Sun, 11 Apr 2004 01:29:49 +0200 (CEST)
Content-Transfer-Encoding: quoted-printable
To: =?ISO-8859-1?Q?Sven_K=F6hler?= <skoehler@upb.de>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-user@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net

On Sat, 10 Apr 2004, Sven K=F6hler wrote:

> good point, but mlocking 128M should be like running the host with 128M=20
> less. so if i could tell the kernel not to touch a certain memory-area=20
> on the append-line, should there still be any VM issues?
> of course that would need further patching of the host-kernel so that=20
> UML can access and manage the reserved memory.

Just add your own patch to uml to mlock the memory if you seriously=20
think this is a good idea.

Myself would build me a host with ample memory, and no swap partition if
swapping of the host worries me. (Note: /dev/anon required to stop UMLs
from being swapped out).

> sound good too, but what i have in mind is a more static thing. even if=20
> the host goes mad and eats all the memory, i still want to be sure that=20
> the UML-kernels have their memory region and this won't get swapped out.

See first paragraph above.. or better yet, don't allow running anything on
the host which may go berserk and eat all the memory or cause heavy=20
I/O..

Regards
Henrik



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id638&op=CCk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
