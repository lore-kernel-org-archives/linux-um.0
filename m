Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CzPgy-0003mw-A2 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 10 Feb 2005 17:33:56 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1CzPgt-000715-Mm
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 10 Feb 2005 17:33:56 -0800
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] [Bug 49277] Compile of usermode-sources-2.6.x fails
References: <E1Cytuz-0002nD-OP@nuthatch.gentoo.org>
	<200502100916.55385.rob@landley.net>
	<200502101644.08326.blaisorblade@yahoo.it>
In-Reply-To: <200502101644.08326.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200502101931.19744.rob@landley.net>
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
Date: Thu, 10 Feb 2005 19:31:18 -0500
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Thursday 10 February 2005 10:44 am, Blaisorblade wrote:

> > And requiring SKAS mode to use uclibc
>
> uclibc doesn't allow static linking? It's strange...

Sorry, meant UML.  (I have a cold.)

> > is roughly equivalent to requiring a
> > kernel module in order to work.
>
> Ok, are you able to figure out a way to copy the whole binary (+ libs) to
> the VM file and remap it from the file to arbitrary address spaces?

Not with this cold and without a lot more study of how UML works, but first I 
want to confirm that you looked at the new 2.6 nonlinear mappings support 
(mm/fremap.c, sys_remap_file_pages() and friends...)

> This is why in TT mode UML is statically linked, it's done so that we must
> not understand where libraries are located and remap them, too. I don't
> think there is a clean way (other than parsing /proc/self/maps, but that is
> a horrible kludge).

Is there a post somewhere describing the problem in more detail?

> > Any idea when SKAS0 might be ready for testing?
>
> You can already test it I guess, but probably it's not for production yet.
>
> I (Wildly) guess a month could be enough, maybe... however for now you can
> do some testing in SKAS mode (the setup inside UML is not different).

So if I build 2.6.11-rc3-bk? I can fire up SKAS0 mode and run it on an 
unmodified kernel?  If so, I'm happy to test this...  (I read Jeff Dike's 
blog entry on SKAS0, but it didn't really have any implementation details.)

Rob


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
