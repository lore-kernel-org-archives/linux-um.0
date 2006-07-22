Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1G4LJv-0003Sx-Tu for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 22 Jul 2006 10:31:20 -0700
Received: from smtp007.mail.ukl.yahoo.com ([217.12.11.96])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1G4LJs-0000ym-3T
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 22 Jul 2006 10:31:19 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Sat, 22 Jul 2006 19:31:06 +0200
References: <1153557998.5589.20.camel@ubuntu>
	<20060722120530.GA25188@ccure.user-mode-linux.org>
	<1153571552.7543.12.camel@ubuntu>
In-Reply-To: <1153571552.7543.12.camel@ubuntu>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200607221931.07137.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] UML hangs after forking gettys
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>, Pekka Enberg <penberg@cs.helsinki.fi>

On Saturday 22 July 2006 14:32, Pekka Enberg wrote:
> Hi,
>
> On Sat, Jul 22, 2006 at 02:22:31PM +0300, Pekka Enberg wrote:
> > > This is a new installation for me, so anything I should check?
>
> On Sat, 2006-07-22 at 08:05 -0400, Jeff Dike wrote:
> > I.e. both a new kernel and new filesystem?  If so, can you vary them
> > to see which is at fault?
>
> I have never run UML on this box, so yeah, everything is new including
> the host. I can try a known working image on Monday when I get access to
> that box. 2.6.18-rc2 works on the other box too.
>
> Could be Ubuntu userspace too. Any known problems with that?
No that I know of (and I run Ubuntu 6.06 64bit with 32bit UMLs).
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade
http://www.user-mode-linux.org/~blaisorblade
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
