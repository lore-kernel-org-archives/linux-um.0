Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CsxSN-00047a-8q for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 23 Jan 2005 22:12:11 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1CsxSL-0008Mz-Mp
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 23 Jan 2005 22:12:11 -0800
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] memory
References: <267988DEACEC5A4D86D5FCD780313FBB03B12C4B@exch-03.noida.hcltech.com>
	<200501240111.j0O1BtoI004687@ccure.user-mode-linux.org>
In-Reply-To: <200501240111.j0O1BtoI004687@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200501240010.23514.rob@landley.net>
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
Date: Mon, 24 Jan 2005 00:10:23 -0500
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>, "Vaibhav Sharma, Noida" <Vaibhavs@noida.hcltech.com>, Doug Dumitru <doug@easyco.com>

On Sunday 23 January 2005 08:11 pm, Jeff Dike wrote:
> It'll allocate a temp file of the appropriate size.  If it's larger than
> what it can use for physical memory, the rest will be allocated as highmem.
>  If you leave 2-level pagetables on, then you're limited to 4G. If you turn
> on 3-level pagetables, then you get up to 128G.

Interesting.  I wonder how that works?  (PAE on x86 only lets you have 64G.)

> rob@landley.net said:
> > Not  unless it's unmapping and remapping multiple mmaps.
>
> It is.

But an individual process running under UML can still only have 4 gigabytes.

> > (There's
> > large file  support, but trying to mmap a 5 gig chunk out of a large
> > file can't work:
>
> It does it a page at a time.
>
> > what would that mean?  How could you generate an
> > offset into the last meg?
>
> The LFS interfaces take 64-bit offsets.

Yeah.  (Ouch.  But yeah, I can see that working...)

> > What would the pointer _be_?)
>
> What pointer?

The virtual or physical address used to access memory.  (I'm guessing 
userspace programs running under UML are limited to 4 gigs, and UML is using 
page indexes and is thus limited to 4 billion pages, not 4 billion bytes.)

> > The parent kernel's highmem support still doesn't provide more than 4
> > gigabytes per application, and the UML kernel is one application.
>
> The host kernel's highmem support is totally irrelevant.  There doesn't
> even need to be highmem support on the host.

Just large file support, and the ability to mmap up to 4 gigs of memory at a 
time (with a starting offset potentially above 4 gigabytes), and unmap it and 
map a different 4 gigs when you switch to the next process...

Makes my brain hurt just thinking about it, but that could be caffeine 
withdrawl...

> 				Jeff

Rob


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
