Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Date: Fri, 18 Sep 2020 14:30:25 +0200
From: Dominique Martinet <asmadeus@codewreck.org>
Subject: Re: [V9fs-developer] [PATCH 02/13] 9p: Tell the VFS that readpage
 was synchronous
Message-ID: <20200918123025.GA735@nautica>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200918111916.GA32101@casper.infradead.org>
 <20200917151050.5363-3-willy@infradead.org>
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
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: linux-cifs@vger.kernel.org, Richard Weinberger <richard@nod.at>, ecryptfs@vger.kernel.org, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org, v9fs-developer@lists.sourceforge.net, ceph-devel@vger.kernel.org, linux-afs@lists.infradead.org

Matthew Wilcox (Oracle) wrote on Thu, Sep 17, 2020:
> The 9p readpage implementation was already synchronous, so use
> AOP_UPDATED_PAGE to avoid cycling the page lock.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Acked-by: Dominique Martinet <asmadeus@codewreck.org>

(I assume it'll be merged together with the rest)

> > What I'm curious about is the page used to be both unlocked and put, but
> > now isn't either and the return value hasn't changed for the caller to
> > make a difference on write_begin / I don't see any code change in the
> > vfs  to handle that.
> > What did I miss?
> 
> The page cache is kind of subtle.  The grab_cache_page_write_begin()
> will return a Locked page with an increased refcount.  If it's Uptodate,
> that's exactly what we want, and we return it.  If we have to read the
> page, readpage used to unlock the page before returning, and rather than
> re-lock it, we would drop the reference to the page and look it up again.
> It's possible that after dropping the lock on that page that the page
> was replaced in the page cache and so we'd get a different page.

Thanks for the explanation, I didn't realize the page already is
gotten/locked at the PageUptodate goto out.

> Anyway, now (unless fscache is involved), v9fs_fid_readpage will return
> the page without unlocking it.  So we don't need to do the dance of
> dropping the lock, putting the refcount and looking the page back up
> again.  We can just return the page.  The VFS doesn't need a special
> return code because nothing has changed from the VFS's point of view --
> it asked you to get a page and you got the page.

Yes, looks good to me.

Cheers,
-- 
Dominique

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

