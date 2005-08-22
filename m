Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E7Ewb-0002t8-WC	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 22 Aug 2005 09:14:41 -0700
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1E7EwZ-0002aZ-5C
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 22 Aug 2005 09:14:41 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Re: [patch 11/39] remap_file_pages protection
	support: add MAP_NOINHERIT flag
References: <20050812182123.C896324E7DD@zion.home.lan>
	<20050812204315.B21152@flint.arm.linux.org.uk>
In-Reply-To: <20050812204315.B21152@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508221806.33667.blaisorblade@yahoo.it>
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
Date: Mon, 22 Aug 2005 18:06:33 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, akpm@osdl.org, jdike@addtoit.com, linux-kernel@vger.kernel.org

On Friday 12 August 2005 21:43, Russell King wrote:
> On Fri, Aug 12, 2005 at 08:21:23PM +0200, blaisorblade@yahoo.it wrote:
> > From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
> >
> > Add the MAP_NOINHERIT flag to arch headers, for use with
> > remap-file-pages.

> Does this mean ARM will break when these patches are merged?
Sorry for missing answer, I was disconnected.

Well, when they'll be merged in -mm you(and other archs) will see a bit of 
things screwing up, but *this* patch is trivial to port to all archs.

The real problem will be updating the PTE encoding macros (see pte_file and 
sys_remap_file_pages) to also store the page protections. Or at least pretend 
they do - things won't compile otherwise.

However, those patches stayed around in -mm for a while, since 2.6.4-rc2-mm1 
to 2.6.5-mm1, so the (basic) fixes will be of the same kind.

VM_FAULT_SIGSEGV is much more though, however. When VMA pages can change 
protection, permission checking must move to the generic VM. See patches for 
i386 about that (patches for other architectures are compile-only, and don't 
handle properly this aspect).

However, don't worry for now, we'll be discussing this on next try. Mass arch 
updating will happen after the patch has been set into its definitive shape.
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
