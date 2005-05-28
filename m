Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DbzQM-0002f5-SY	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 28 May 2005 04:24:14 -0700
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1DbzQK-0004wc-Vt	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 28 May 2005 04:24:14 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
References: <20050527003926.1FD861AEE92@zion.home.lan>
	<c915b004e775ff68517f3be2c95c6f93.IBX@taniwha.stupidest.org>
In-Reply-To: <c915b004e775ff68517f3be2c95c6f93.IBX@taniwha.stupidest.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505281326.15519.blaisorblade@yahoo.it>
Subject: [uml-devel] Re: [patch 1/1] [RFC] uml: add and use generic
	hw_controller_type->release
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
Date: Sat, 28 May 2005 13:26:15 +0200
To: Chris Wedgwood <cw@f00f.org>, Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Cc: akpm@osdl.org, jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, mingo@redhat.com

On Friday 27 May 2005 04:11, Chris Wedgwood wrote:
> On Fri, May 27, 2005 at 02:39:26AM +0200, blaisorblade@yahoo.it wrote:
> > From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>, Chris
> > Wedgwood <cw@f00f.org> CC: Ingo Molnar <mingo@redhat.com>
>
> [...]
>
> > This is heavily based on some work by Chris Wedgwood, which however
> > didn't get the patch merged for something I'd call a
> > "misunderstanding" (the need for this patch wasn't cleanly
> > explained, thus adding the generic hook was felt as undesirable).

> Looks very reasonable to me and your explaination is much better than
> mine was :-)
Yes, it took some time to me to go working on this and getting the time to 
explain it clearly.
> > diff -puN kernel/irq/manage.c~uml-gen-irq-release kernel/irq/manage.c
> > --- linux-2.6.git/kernel/irq/manage.c~uml-gen-irq-release	2005-05-25
> > 01:15:46.000000000 +0200 +++
> > linux-2.6.git-paolo/kernel/irq/manage.c	2005-05-25 01:15:46.000000000
> > +0200 @@ -255,6 +255,10 @@ void free_irq(unsigned int irq, void *de
> >
> >  			/* Found it - now remove it from the list of entries */
> >  			*pp = action->next;
> > +
> > +			if (desc->handler->release)
> > +				desc->handler->release(irq, dev_id);
> > +
>
> Because right now we know the *only* port that needs a release method
> is UML I wonder if we could do save a couple of bytes & cycles for
> everyone else by doing something like #ifdef CONFIG_IRQ_HAS_RELEASE,
> #endif around that and then letting the Kconfig magic set
> CONFIG_IRQ_HAS_RELEASE as required?  If other arches need it thay can
> do the same and if eventually almost everyone does we can kill the
> #ifdef crud?
Well, that's a point, even because a conditional jump needs to flush the 
pipeline when mispredicted (which won't happen on other ARCHs after the 
initial period, if this jump stays in the Branch Target Buffers).
> Longer term I wonder if some of the irq mechanics in UML couldn't end
> up being a bit more like the s390 stuff too?
Christoph Hellwig too suggested this, however anything such *must* be longer 
term (while this was earlier pointed as a reason to drop this patch, last 
time).
Beyond that, I've not a clear understanding of S390, so I cannot for now help 
(including any merit discussion) on this point... Bodo Stroesser is porting 
UML on S390 so probably he might help more on this point.
-- 
Paolo Giarrusso, aka Blaisorblade
Skype user "PaoloGiarrusso"
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
