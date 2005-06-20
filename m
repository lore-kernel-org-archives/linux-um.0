Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DkNM6-0005Mk-C2	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 20 Jun 2005 07:34:30 -0700
Received: from mailgate2.dslextreme.com ([66.51.199.95])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DkNM6-0001Yr-0r	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 20 Jun 2005 07:34:30 -0700
Received: from www.dslextreme.com (unknown [192.168.7.122])
	by mailgate2.dslextreme.com (Postfix) with SMTP id CDF533A659E
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 20 Jun 2005 06:35:28 -0700 (PDT)
Message-ID: <7920a17820a19800a14b80a.20050620073424.pbqrznpuvar@www.dslextreme.com>
From: codemachine@dslextreme.com
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Subject: [uml-devel] problem booting uml without xterms
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
Date: Mon, 20 Jun 2005 07:34:24 -0700 (PDT)
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net



Hi,

I'm trying to  boot uml on a server, and I don't want to have to have X
installed to do it, so I want to boot without the xterm consoles.

For the life if me I can't figure out the right con=3D* command line params
and/or get them to work per:
http://user-mode-linux.sourceforge.net/input.html

I've spent about 4 hours trying every possible combination i think ;/

I don't care if uml's available via tty pty or whatever, I think my
preference would be to attach via a screen. So long as I don't have to
have X to load it i'm happy.

Could someone perhaps provide a current working example?

If it matters, my host is ubuntu with 2.6.12-rc4-skas3-v9-pre4, the uml is
gentoo I built 2.6.11-gentoo-r11, I'm not using devfs.

thanks!
Calin


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_idt77&alloc_id=16492&op=CCk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
