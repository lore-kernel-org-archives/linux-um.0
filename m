Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EJauu-00070p-1q	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 25 Sep 2005 11:08:00 -0700
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1EJaut-0003KG-FA
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 25 Sep 2005 11:08:00 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] 2.6.13.2 + gcc 4.01 link error
References: <229e70f2050924085215707921@mail.gmail.com>
	<200509241854.53536.blaisorblade@yahoo.it>
	<20050924172420.GB5398@ccure.user-mode-linux.org>
In-Reply-To: <20050924172420.GB5398@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509252007.03289.blaisorblade@yahoo.it>
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
Date: Sun, 25 Sep 2005 20:07:02 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>, Etay Meiri <etay.meiri@gmail.com>

On Saturday 24 September 2005 19:24, Jeff Dike wrote:
> On Sat, Sep 24, 2005 at 06:54:53PM +0200, Blaisorblade wrote:
> > Disable CONFIG_HIGHMEM as a workaround (you likely don't need it), I'll
> > fix it later.

> Hmmm, maybe my previous answer is wrong, but I do have a recollection that
> I saw this after accidentally getting an i386 config.
Ok, fine, but:
You said you have 1G on your laptop, back in Ottawa, so you likely enable 
HIGHMEM in your host .config, while you never do on UML, and neither do I. 
That explains what you say.

But no, an i386 .config can produce bogus settings (i.e. an UML without UBD 
driver), but it shouldn't produce a non-compiling setting - make randconfig 
is supposed to produce a compiling configuration.

I just tested and got the *same* errors, and applied the "remove duplicated 
symbols export" you sent to Linus' git tree, which fixed it.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
