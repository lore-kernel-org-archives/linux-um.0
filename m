Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Co9rv-0002Np-Kt for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 10 Jan 2005 16:26:43 -0800
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1Co9rq-00040B-Vq for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 10 Jan 2005 16:26:43 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [PATCH] Put the check for NULL before the use of a
	potentially-null value
References: <41E2F90C.4020707@tuxrocks.com>
In-Reply-To: <41E2F90C.4020707@tuxrocks.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501110128.38523.blaisorblade@yahoo.it>
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
Date: Tue, 11 Jan 2005 01:28:38 +0100
To: user-mode-linux-devel@lists.sourceforge.net, Frank Sorenson <frank@tuxrocks.com>, Gerd Knorr <kraxel@bytesex.org>

On Monday 10 January 2005 22:52, Frank Sorenson wrote:
> This patch reorders two lines to check a variable for NULL before using
> the variable.
>
> Signed-off-by: Frank Sorenson <frank@tuxrocks.com>

diff -Naur linux-2.6.10-mm2.orig/arch/um/drivers/line.c 
linux-2.6.10-mm2/arch/um/drivers/line.c
--- linux-2.6.10-mm2.orig/arch/um/drivers/line.c        2005-01-10 
14:35:20.379815252 -0700
+++ linux-2.6.10-mm2/arch/um/drivers/line.c     2005-01-10 14:35:59.786829555 
-0700
@@ -593,8 +593,8 @@
                }
        }
        tty  = winch->tty;
-       line = tty->driver_data;
        if (tty != NULL) {
+               line = tty->driver_data;
                chan_window_size(&line->chan_list,
                                 &tty->winsize.ws_row, 
                                 &tty->winsize.ws_col);

Ok, correct and thanks a lot.

Sorry, a little question: against what tree does it apply?

I cannot apply it locally, but I see that it should apply on top of Gerd 
Knorr's terminal cleanup patch, which introduces the bug.

I hope I'll not forget it...
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
