Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Date: Sat, 19 Dec 2020 06:50:57 +0000
From: Matthew Wilcox <willy@infradead.org>
Subject: Re: set_page_dirty vs truncate
Message-ID: <20201219065057.GR15600@casper.infradead.org>
References: <20201218160531.GL15600@casper.infradead.org>
 <20201218220316.GO15600@casper.infradead.org>
 <20201219051852.GP15600@casper.infradead.org>
 <7a7c3052-74c7-c63b-5fe3-65d692c1c5d1@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7a7c3052-74c7-c63b-5fe3-65d692c1c5d1@nvidia.com>
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: John Hubbard <jhubbard@nvidia.com>
Cc: Martin Brandenburg <martin@omnibond.com>, linux-cifs@vger.kernel.org, jfs-discussion@lists.sourceforge.net, Miklos Szeredi <miklos@szeredi.hu>, Dave Kleikamp <shaggy@kernel.org>, Richard Weinberger <richard@nod.at>, Dominique Martinet <asmadeus@codewreck.org>, linux-um@lists.infradead.org, linux-nfs@vger.kernel.org, Trond Myklebust <trond.myklebust@hammerspace.com>, Steve French <sfrench@samba.org>, linux-ntfs-dev@lists.sourceforge.net, Hans de Goede <hdegoede@redhat.com>, devel@lists.orangefs.org, Anna Schumaker <anna.schumaker@netapp.com>, linux-fsdevel@vger.kernel.org, v9fs-developer@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>, Anton Altaparmakov <anton@tuxera.com>, Mike Marshall <hubcap@omnibond.com>

On Fri, Dec 18, 2020 at 10:10:01PM -0800, John Hubbard wrote:
> On 12/18/20 9:18 PM, Matthew Wilcox wrote:
> > On Fri, Dec 18, 2020 at 10:03:16PM +0000, Matthew Wilcox wrote:
> > > On Fri, Dec 18, 2020 at 04:05:31PM +0000, Matthew Wilcox wrote:
> > > > A number of implementations of ->set_page_dirty check whether the page
> > > > has been truncated (ie page->mapping has become NULL since entering
> > > > set_page_dirty()).  Several other implementations assume that they can do
> > > > page->mapping->host to get to the inode.  So either some implementations
> > > > are doing unnecessary checks or others are vulnerable to a NULL pointer
> > > > dereference if truncate() races with set_page_dirty().
> > > > 
> > > > I'm touching ->set_page_dirty() anyway as part of the page folio
> > > > conversion.  I'm thinking about passing in the mapping so there's no
> > > > need to look at page->mapping.
> > > > 
> > > > The comments on set_page_dirty() and set_page_dirty_lock() suggests
> > > > there's no consistency in whether truncation is blocked or not; we're
> > > > only guaranteed that the inode itself won't go away.  But maybe the
> > > > comments are stale.
> > > 
> > > The comments are, I believe, not stale.  Here's some syzbot
> > > reports which indicate that ext4 is seeing races between set_page_dirty()
> > > and truncate():
> > > 
> > >   https://groups.google.com/g/syzkaller-lts-bugs/c/s9fHu162zhQ/m/Phnf6ucaAwAJ
> > > 
> > > The reproducer includes calls to ftruncate(), so that would suggest
> > > that's what's going on.
> > 
> > Hmmm ... looks like __set_page_dirty_nobuffers() has a similar problem:
> > 
> > {
> >          lock_page_memcg(page);
> >          if (!TestSetPageDirty(page)) {
> >                  struct address_space *mapping = page_mapping(page);
> >                  unsigned long flags;
> > 
> >                  if (!mapping) {
> >                          unlock_page_memcg(page);
> >                          return 1;
> >                  }
> > 
> >                  xa_lock_irqsave(&mapping->i_pages, flags);
> >                  BUG_ON(page_mapping(page) != mapping);
> > 
> > sure, we check that the page wasn't truncated between set_page_dirty()
> > and the call to TestSetPageDirty(), but we can truncate dirty pages
> > with no problem.  So between the call to TestSetPageDirty() and
> > the call to xa_lock_irqsave(), the page can be truncated, and the
> > BUG_ON should fire.
> > 
> > I haven't been able to find any examples of this, but maybe it's just a very
> > narrow race.  Does anyone recognise this signature?  Adding the filesystems
> > which use __set_page_dirty_nobuffers() directly without extra locking.
> 
> 
> That sounds like the same *kind* of failure that Jan Kara and I were
> seeing on live systems[1], that led eventually to the gup-to-pup
> conversion exercise.
> 
> That crash happened due to calling set_page_dirty() on pages that had no
> buffers on them [2]. And that sounds like *exactly* the same thing as
> calling __set_page_dirty_nobuffers() without extra locking. So I'd
> expect that it's Just Wrong To Do, for the same reasons as Jan spells
> out very clearly in [1].

Interesting.  It's a bit different, *but* Jan's race might be what's
causing this symptom.  The reason is that the backtrace contains
set_page_dirty_lock() which holds the page lock.  So there can't be
a truncation race because truncate holds the page lock when calling
->invalidatepage.

That said, the syzbot reproducer doesn't have any O_DIRECT in it
either.  So maybe this is some other race?

> Hope that helps.
> 
> 
> [1] https://www.spinics.net/lists/linux-mm/msg142700.html
> 
> [2] which triggered this assertion:
> 
> #define page_buffers(page)					\
> 	({							\
> 		BUG_ON(!PagePrivate(page));			\
> 		((struct buffer_head *)page_private(page));	\
> 	})
> 
> 
> > 
> > $ git grep set_page_dirty.*=.*__set_page_dirty_nobuffers
> > fs/9p/vfs_addr.c:       .set_page_dirty = __set_page_dirty_nobuffers,
> > fs/cifs/file.c: .set_page_dirty = __set_page_dirty_nobuffers,
> > fs/cifs/file.c: .set_page_dirty = __set_page_dirty_nobuffers,
> > fs/fuse/file.c: .set_page_dirty = __set_page_dirty_nobuffers,
> > fs/hostfs/hostfs_kern.c:        .set_page_dirty = __set_page_dirty_nobuffers,
> > fs/jfs/jfs_metapage.c:  .set_page_dirty = __set_page_dirty_nobuffers,
> > fs/nfs/file.c:  .set_page_dirty = __set_page_dirty_nobuffers,
> > fs/ntfs/aops.c: .set_page_dirty = __set_page_dirty_nobuffers,   /* Set the page dirty
> > fs/orangefs/inode.c:    .set_page_dirty = __set_page_dirty_nobuffers,
> > fs/vboxsf/file.c:       .set_page_dirty = __set_page_dirty_nobuffers,
> > 
> 
> ...wow, long list of these.
> 
> thanks,
> -- 
> John Hubbard
> NVIDIA

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

