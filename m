Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CZIOI-0006gW-83 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 30 Nov 2004 16:30:42 -0800
Received: from fw.osdl.org ([65.172.181.6] helo=mail.osdl.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CZIOD-00023S-G8 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 30 Nov 2004 16:30:41 -0800
From: Andrew Morton <akpm@osdl.org>
Message-Id: <20041130163352.62840d12.akpm@osdl.org>
In-Reply-To: <200412010120.39579.blaisorblade_spam@yahoo.it>
References: <20041130200845.2C5058BAFE@zion.localdomain>
	<20041130152017.129e134c.akpm@osdl.org>
	<200412010120.39579.blaisorblade_spam@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Re: VFS interactions with UML and other big UML changes
	(was: Re:
	[patch 1/2] Uml - first part rework of run_helper() and users.)
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
Date: Tue, 30 Nov 2004 16:33:52 -0800
To: Blaisorblade <blaisorblade_spam@yahoo.it>
Cc: linux-kernel@vger.kernel.org, jdike@addtoit.com, bstroesser@fujitsu-siemens.com, user-mode-linux-devel@lists.sourceforge.net, kraxel@bytesex.org

Blaisorblade <blaisorblade_spam@yahoo.it> wrote:
>
> static struct address_space_operations hostfs_aops = {
>         .writepage      = hostfs_writepage,
>         .readpage       = hostfs_readpage,
> /*      .set_page_dirty = __set_page_dirty_nobuffers, */
>         .prepare_write  = hostfs_prepare_write,
>         .commit_write   = hostfs_commit_write
> };
> 
> Actually, hostfs is a nodev filesystem, but I simply don't know if that 
> implies that it uses no buffers. So, should
> 
>  .set_page_dirty = __set_page_dirty_nobuffers
> 
> be uncommented? Or should it be deleted (leaving it there is not a good 
> option).

See the operation of set_page_dirty().

If you have NULL ->set_page_dirty a_op then set_page_dirty() will fall
through to __set_page_dirty_buffers().

If your fs never sets PG_private then __set_page_dirty_buffers() will just
do what __set_page_dirty_nobuffers() does.

Without having looked at it, I'm sure that hostfs does not use
buffer_heads.  So setting your ->set_page_dirty a_op to point at
__set_page_dirty_nobuffers() is a reasonable thing to do - it'll provide a
slight speedup.



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
