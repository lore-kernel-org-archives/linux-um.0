Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BC1WU-0007Jv-Iu for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 09 Apr 2004 12:18:42 -0700
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1BC1WU-0002Y8-0d for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 09 Apr 2004 12:18:42 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] A quick humfs HOWTO
References: <Pine.LNX.4.44.0404081039320.7910-100000@filer.marasystems.com>
In-Reply-To: <Pine.LNX.4.44.0404081039320.7910-100000@filer.marasystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200404092049.25126.blaisorblade_spam@yahoo.it>
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
Date: Fri, 9 Apr 2004 20:49:25 +0200
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Henrik Nordstrom <uml@henrik.marasystems.com>

Alle 10:43, gioved=EC 8 aprile 2004, Henrik Nordstrom ha scritto:
> On Thu, 8 Apr 2004, Nuno Silva wrote:
> > In the meanwhile I'm thinking about this system and it seems that this
> > will eat lots of inodes because every file will be present twice in the
> > [host] filesystem with the metadata version using only a few bytes.
>
> Indeed, so the host better use a filesystem which can handle this
> efficiently such as reiserfs if you plan on very large filesystems.

Actually, Reiser4 will even be more efficent: first because of the FS itsel=
f,=20
second because we could then use sys_reiser4. It's a syscall designed for=20
reading little amounts of data from little files, without opening a fd,=20
calling read() and closing it.

"Casually", it was designed to read little metadata files which store=20
attributes. However I think that syscall could also be supported by other=20
FS's - at least it is possible. However a compile-time option is worth of=20
note.

--=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id638&op=CCk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
