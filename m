Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BrXKR-0002xv-Rh for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 02 Aug 2004 00:33:51 -0700
Received: from sccrmhc11.comcast.net ([204.127.202.55])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1BrXKR-0005cM-HA for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 02 Aug 2004 00:33:51 -0700
Message-ID: <410DEE57.9000503@hevanet.com>
From: Matt Clay <mattclay@hevanet.com>
MIME-Version: 1.0
References: <200407280315.08207.alydar@users.sourceforge.net>
	<20040801155231.GA19648@ccure.user-mode-linux.org>
	<410D4E2A.8020704@hevanet.com> <200408020115.47228.allen@home0.com>
In-Reply-To: <200408020115.47228.allen@home0.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Re: Bug#260111: user-mode-linux: upgrade hangs at "NET4:
	Linux TCP/IP 1.0 for NET4.0 "
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
Date: Mon, 02 Aug 2004 00:33:43 -0700
To: Allen Chan <allen@home0.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>, 260111@bugs.debian.org

Allen Chan wrote:
> After a little poking around, it appears that chan_kern.c and 
> chan_user.c have very different interpretations of what struct 
> termios should be . On my debian unstable system,

Now that you point it out, I see the same thing on my Slackware 10 system.

Here is the definition in my /usr/include/bits/termios.h

typedef unsigned char	cc_t;
typedef unsigned int	speed_t;
typedef unsigned int	tcflag_t;

#define NCCS 32
struct termios
   {
     tcflag_t c_iflag;		/* input mode flags */
     tcflag_t c_oflag;		/* output mode flags */
     tcflag_t c_cflag;		/* control mode flags */
     tcflag_t c_lflag;		/* local mode flags */
     cc_t c_line;			/* line discipline */
     cc_t c_cc[NCCS];		/* control characters */
     speed_t c_ispeed;		/* input speed */
     speed_t c_ospeed;		/* output speed */
   };

And the one from um/include/asm/arch/termbits.h

typedef unsigned char	cc_t;
typedef unsigned int	speed_t;
typedef unsigned int	tcflag_t;

#define NCCS 19
struct termios {
	tcflag_t c_iflag;		/* input mode flags */
	tcflag_t c_oflag;		/* output mode flags */
	tcflag_t c_cflag;		/* control mode flags */
	tcflag_t c_lflag;		/* local mode flags */
	cc_t c_line;			/* line discipline */
	cc_t c_cc[NCCS];		/* control characters */
};

This would certainly explain the random behavior I've been seeing with calls 
to tcsetattr failing sometimes.

  - Matt


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
