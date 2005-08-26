Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E8gDV-00044w-Nb	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 26 Aug 2005 08:34:05 -0700
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1E8gDT-0002ZV-SB
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 26 Aug 2005 08:34:05 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] uml for 2.6.12 kernel
References: <838f7c500508231455607e9a7d@mail.gmail.com>
	<20050824034403.GA8036@mindspring.com>
	<838f7c50050824071665f2b081@mail.gmail.com>
In-Reply-To: <838f7c50050824071665f2b081@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508261729.10815.blaisorblade@yahoo.it>
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
Date: Fri, 26 Aug 2005 17:29:10 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: ashwin tanugula <ashwin.tanugula@gmail.com>, jleu@mindspring.com, user-mode-linux-user@lists.sourceforge.net

On Wednesday 24 August 2005 16:16, ashwin tanugula wrote:
> On 8/23/05, James R. Leu <jleu@mindspring.com> wrote:
> > Since you didn't specify, I assume your talking about building
> > a guest kernel.  In which case I just went through the the same ordeal.

> > I used a 2.6.12-mm2 kernel and applied jdike's patch set.  Here are the
> > URLs for the parts you need.

> > I'd be interested to see what others have gotten working.
Hmm, nobody told you using -mm is a bit *brave*? And Jeff Dike's patchset is 
mostly intended for development (Jeff has been recommending it for x86_64 
because the support has been introduced recently, so it got a fair amount of 
fixes in his tree).

The working combinations are:
* vanilla 2.6.12 (it works)
* 2.6.12 + patches on my site.
> > On Tue, Aug 23, 2005 at 05:55:27PM -0400, ashwin tanugula wrote:
> > > Hi,
> > > I want to build UML from source using a 2.6.12 kernel. Can somebody
> > > tell me whether to patch it or not as kernels from 2.6.9 have the UML
> > > included??
> > >
> > > Thanks,
> > > Ashwin

> Hi,
> I am more confused now...I want to build a basic UML for a 2.6.12
> kernel, just like the other kernels..for a 2.6.0 kernel one need to
> apply a uml-patch-2.6.12.tar.bz2 patch and build it.

> so do I need to apply the 2.6.12-mm2.bz2 and patches.tar patches and
> build??

> And can you tell me what a guest kernel is?

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
