Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CZIBZ-0005p7-9a for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 30 Nov 2004 16:17:33 -0800
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CZIBW-00012b-QW for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 30 Nov 2004 16:17:33 -0800
From: Blaisorblade <blaisorblade_spam@yahoo.it>
References: <20041130200845.2C5058BAFE@zion.localdomain>
	<20041130152017.129e134c.akpm@osdl.org>
In-Reply-To: <20041130152017.129e134c.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412010120.39579.blaisorblade_spam@yahoo.it>
Subject: [uml-devel] VFS interactions with UML and other big UML changes (was:
	Re: [patch 1/2] Uml - first part rework of run_helper() and users.)
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
Date: Wed, 1 Dec 2004 01:20:39 +0100
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: jdike@addtoit.com, bstroesser@fujitsu-siemens.com, user-mode-linux-devel@lists.sourceforge.net, Gerd Knorr <kraxel@bytesex.org>

On Wednesday 01 December 2004 00:20, Andrew Morton wrote:
> blaisorblade_spam@yahoo.it wrote:
> > Fixed a file descriptor leak in the network driver when changing an IP
> > address.
> >
> > Fixed the error handling in run_helper.

> > Paolo notes:
> >
> > Actually, this is part one of the change, the exact one extracted from
> > Jeff Dike's incrementals tree before 2.6.9-rc big UML merge.
> >
> > There is some changes must be done, so I'm also sending a second patch
> > with this one, too. Separated for tracking purposes.
> >
> > Don't send this pair of ones to Linus before Jeff ACK's it - just put
> > into -mm for now.

> That makes five UML patches which I have queued up pending confirmation:
Ok, detailed answers for each one.


> hostfs-uml-set-sendfile-to-generic_file_sendfile.patch
> hostfs-uml-add-some-other-pagecache-methods.patch

For these two, I'm waiting mainline answers - the first one was tested and 
worked, while the second not, but is no more intrusive. In general, the 
patches themselves are good: hostfs already makes full use of the page cache.

My doubt (which actually is not related to the patches themselves) is here:

static struct address_space_operations hostfs_aops = {
        .writepage      = hostfs_writepage,
        .readpage       = hostfs_readpage,
/*      .set_page_dirty = __set_page_dirty_nobuffers, */
        .prepare_write  = hostfs_prepare_write,
        .commit_write   = hostfs_commit_write
};

Actually, hostfs is a nodev filesystem, but I simply don't know if that 
implies that it uses no buffers. So, should

 .set_page_dirty = __set_page_dirty_nobuffers

be uncommented? Or should it be deleted (leaving it there is not a good 
option).

I'm holding the patches because I don't know if using them could anyhow 
trigger data loss from this bug, if it's a bug.

> uml-terminal-cleanup.patch

I don't know technically this one. It won't probably go in 2.6.10, I think 
later... tested in the SuSE tree, but let's be quiet in merging _big_ things, 
ok? It was also tested in a different tree, so it perfectly working on 2.6.9 
does not mean perfectly working on current kernels.

Some other well tested patches (not these ones) are causing host problems, 
i.e. UML processes crashing and staying in D state (this seems some kind of 
ptrace bug, but still digging on this) - acked on 2.6.9 hosts.

Or dying completely but keeping some FS (a tmpfs mount used only for UML) from 
being unmounted (yes, checked lsof, which shows nothing - I've heard rumors 
of locks alive). It does not seem to be related to tmpfs in particular, 
however.

> uml-first-part-rework-of-run_helper-and-users.patch
> uml-finish-fixing-run_helper-failure-path.patch
These are littler and somehow widely tested... but nobody complained with the 
1st alone.

> Could you gents please put heads together and tell me whether and when
> these should go upstream?
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
