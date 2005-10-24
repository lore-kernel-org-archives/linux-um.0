Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EUBia-0007Ux-8f	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 24 Oct 2005 16:27:04 -0700
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1EUBiY-0005Rh-Nq
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 24 Oct 2005 16:27:04 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
References: <200510221838.17065.blaisorblade@yahoo.it>
	<20051024230352.GA11467@ccure.user-mode-linux.org>
In-Reply-To: <20051024230352.GA11467@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510250130.39622.blaisorblade@yahoo.it>
Subject: [uml-devel] Re: GFP_ATOMIC/GFP_KERNEL broken for use by block
	devices!!
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
Date: Tue, 25 Oct 2005 01:30:31 +0200
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Tuesday 25 October 2005 01:03, Jeff Dike wrote:
> On Sat, Oct 22, 2005 at 06:38:16PM +0200, Blaisorblade wrote:
> > In the write path of a ???lesystem, using
> > GFP_KERNEL or GFP_ATOMIC will lead to deadlocks
> > eventually. [...] GFP_NOFS is there for a reason, as is GFP_NOIO for
> > block device drivers.
>
> I know about this, and this is another reason I'm not sending it in.
I didn't know and you didn't mention, so I thought I'd better add about this.
> I 
> don't really understand it either.

> If GFP_ATOMIC can block, then I don't 
> know what good it is.
I _don't_ think it can block. I understand why GFP_KERNEL is broken there, but 
not why GFP_ATOMIC can't be used. The only pointer I found so far is that 
__GFP_HIGH allows the kernel to use up more memory without doing reclaim (see 
mm/page_alloc.c, calls to zone_watermark_ok).
> > Which means that we _must_ ask for help from somebody else.
>
> Yup.
>
> 				Jeff

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
