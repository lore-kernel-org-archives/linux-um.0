Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EMVUI-00084q-4E	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 03 Oct 2005 11:56:34 -0700
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1EMVUG-0006TI-Ay
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 03 Oct 2005 11:56:34 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Re: UML/2.6.14-rc3 doesn't work fixes
References: <200510021213.40191.blaisorblade@yahoo.it>
	<200510022001.21638.blaisorblade@yahoo.it>
	<20051002183758.GR7992@ftp.linux.org.uk>
In-Reply-To: <20051002183758.GR7992@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510032056.18439.blaisorblade@yahoo.it>
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
Date: Mon, 3 Oct 2005 20:56:18 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Al Viro <viro@ftp.linux.org.uk>, Jeff Dike <jdike@addtoit.com>, Alexander Viro <viro@zeniv.linux.org.uk>

On Sunday 02 October 2005 20:37, Al Viro wrote:
> On Sun, Oct 02, 2005 at 08:01:21PM +0200, Blaisorblade wrote:
> > On Sunday 02 October 2005 17:51, Jeff Dike wrote:

> > Al, is that ok for you if we follow this original plan?
> >
> > In this case, I'll post the dropping patch and re-send the Kbuild fix of
> > my last batch (conflicted with Al's patch, but now it's needed again).

> Up to Jeff; IMO it's easier to restore the variant past his review (with
> incremental replacing that DEFINE_LONGS), but maintainer gets to decide;
> that was the reason for Cc when patch got sent to Linus, after all...

My only worry is that some other bug may have slipped through - it's not the 
case that we are perfect, nor we have a real test-suite to catch this sort of 
thing (especially, there are sections of FPU handling which are buggy anyway 
- there is a really big patch which copies whole sections of i386 low level 
messing up with FPU, which I requested Jeff to hold some time ago).
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

		
___________________________________ 
Yahoo! Messenger: chiamate gratuite in tutto il mondo 
http://it.messenger.yahoo.com



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
