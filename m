Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B3Q3w-0004lF-Un for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 16 Mar 2004 17:41:40 -0800
Received: from 208.177.141.226.ptr.us.xo.net ([208.177.141.226]
	helo=ash.lnxi.com)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1B3Q3v-00026J-GY for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 16 Mar 2004 17:41:39 -0800
From: Mike Snitzer <msnitzer@lnxi.com>
Message-ID: <20040316184108.A14721@lnxi.com>
References: <Pine.LNX.4.44.0403120222160.2524-100000@sparrow>
	<20040316151745.B12857@lnxi.com>
	<30b401c40bbb$a1858ad0$2000000a@schlepptopp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30b401c40bbb$a1858ad0$2000000a@schlepptopp>;
	from for_spam@gmx.de on Wed, Mar 17, 2004 at 02:03:15AM +0100
Subject: [uml-devel] Re: 2.6.4 UML kernel available
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
Date: Tue, 16 Mar 2004 18:41:08 -0700
To: roland <for_spam@gmx.de>
Cc: William Stearns <wstearns@pobox.com>, ML-uml-user <User-mode-linux-user@lists.sourceforge.net>, ML-uml-devel <user-mode-linux-devel@lists.sourceforge.net>

On Tue, Mar 16 2004 at 18:03,
roland <for_spam@gmx.de> wrote:

> could you post the contents of your inittab ?
> maybe it makes sense to compare your inittab with "ours" (i.e. people successfully booting 2.6.4)
> i can boot 2.6.4 with my suse9 rootfs
> regards
> roland

Sure, but like I posted in a previous mail; this appears to be an issue
with Debian testing's init:

...
1:2345:respawn:/sbin/getty 38400 tty1
2:23:respawn:/sbin/getty 38400 tty2
3:23:respawn:/sbin/getty 38400 tty3
#4:23:respawn:/sbin/getty 38400 tty4
#5:23:respawn:/sbin/getty 38400 tty5
#6:23:respawn:/sbin/getty 38400 tty6
...

So Debian's init tries to spawn a getty on each and fails.  I'm not using
devfs or anything; again the same debian testing FS works great with a
2.4.24 UML.

Mike


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
