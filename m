Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B9AUH-0004et-GH for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 01 Apr 2004 14:16:37 -0800
Received: from pond72.drizzle.com ([216.162.218.72] helo=cac.seattle.wa.us)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30) id 1B9AUH-0003nP-0x
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 01 Apr 2004 14:16:37 -0800
Received: from cac.seattle.wa.us (localhost.localdomain [127.0.0.1])
	by cac.seattle.wa.us (8.12.10/8.12.10) with ESMTP id i31MGDxK015381
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 1 Apr 2004 14:16:13 -0800
Received: from localhost (cac@localhost)
	by cac.seattle.wa.us (8.12.10/8.12.10/Submit) with ESMTP id
	i31MGCCt015377 for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 1 Apr 2004 14:16:12 -0800
From: "Charles A. Clinton" <cac@cac.seattle.wa.us>
Subject: Re: [uml-devel] Segfault on UML load
In-Reply-To: <Pine.LNX.4.58.0403311549380.25444@cac>
Message-ID: <Pine.LNX.4.58.0404011358130.15283@cac>
References: <Pine.LNX.4.58.0403311549380.25444@cac>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
Date: Thu, 1 Apr 2004 14:16:12 -0800 (PST)
To: user-mode-linux-devel@lists.sourceforge.net

On Wed, 31 Mar 2004, I wrote:

> When I build a UML kernel on my Fedora Core 1 machine, it segfaults when 
> it tries to load.

Blaisorblade pointed me to a 2.6 patch set which provides the answer.
The link.ld script puts an empty 4K page at the front of the UML image.
The Fedora glibc expects the elf program headers to be at the start of the
image and searched them form information regarding stack executability. 
The empty page is not mapped, and the search segfaults. I suspect that 
there is a bug in binfmt_elf that is not taking into account the load 
offset when setting up the aux vector, but the code is so convoluted there 
that I am mostly dazed.

Anyway, the following patch (adapted from
http://toast.debian.net/~may/umlproject/unpackaged/align.patch) when 
applied on top of uml-patch-2.4.22-1, fixes the problem. It should work
for any of the 2.4.x patches.

Thanks to Blaisorblade for pointing me to the UML for Fedora page.

diff -Naur linux-2.4.22/arch/um/dyn_link.ld.in linux-2.4.22.works/arch/um/dyn_link.ld.in
--- linux-2.4.22/arch/um/dyn_link.ld.in	2004-04-01 11:26:04.000000000 -0800
+++ linux-2.4.22.works/arch/um/dyn_link.ld.in	2004-04-01 11:32:35.000000000 -0800
@@ -8,7 +8,6 @@
 {
   . = START() + SIZEOF_HEADERS;
   .interp         : { *(.interp) }
-  . = ALIGN(4096);
   __binary_start = .;
   . = ALIGN(4096);		/* Init code and data */
   _stext = .;
diff -Naur linux-2.4.22/arch/um/link.ld.in linux-2.4.22.works/arch/um/link.ld.in
--- linux-2.4.22/arch/um/link.ld.in	2004-04-01 11:26:07.000000000 -0800
+++ linux-2.4.22.works/arch/um/link.ld.in	2004-04-01 11:32:19.000000000 -0800
@@ -6,7 +6,6 @@
 {
   . = START() + SIZEOF_HEADERS;
 
-  . = ALIGN(4096);
   __binary_start = .;
 ifdef(`MODE_TT', `
   .thread_private : {


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
