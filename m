Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AL8z4-0000yt-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Sat, 15 Nov 2003 14:33:38 -0800
Received: from wavehammer.waldi.eu.org
	([82.139.196.55] helo=extern.mail.waldi.eu.org ident=postfix)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.24)
	id 1AL8z4-0007M0-9i
	for user-mode-linux-devel@lists.sourceforge.net; Sat, 15 Nov 2003 14:33:38 -0800
From: Bastian Blank <bastianb@gmx.de>
Subject: Re: [uml-devel] arch/um/sys-i386/bugs.c compile error
Message-ID: <20031115223329.GA24455@wavehammer.waldi.eu.org>
References: <20031115211955.GA4221@absolom.libra.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031115211955.GA4221@absolom.libra.net>
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
Date: Sat, 15 Nov 2003 23:33:29 +0100
To: user-mode-linux-devel@lists.sourceforge.net

On Sat, Nov 15, 2003 at 04:19:55PM -0500, Laurence J. Lane wrote:
> I get the same arch/um/sys-i386/bugs.c compile error on 2.6.0-test9-1-um
> and 2.4.22-6-um. Anyone have an idea of what causes the error?

debian unstable with linux-kernel-headers (2.6.0)?

i get this message since they do that change.

bastian

-- 
	"Get back to your stations!"
	"We're beaming down to the planet, sir."
		-- Kirk and Mr. Leslie, "This Side of Paradise",
		   stardate 3417.3


-------------------------------------------------------
This SF. Net email is sponsored by: GoToMyPC
GoToMyPC is the fast, easy and secure way to access your computer from
any Web browser or wireless device. Click here to Try it Free!
https://www.gotomypc.com/tr/OSDN/AW/Q4_2003/t/g22lp?Target=mm/g22lp.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
