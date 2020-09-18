Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Date: Fri, 18 Sep 2020 07:59:19 +0200
From: Dominique Martinet <asmadeus@codewreck.org>
Subject: Re: [V9fs-developer] [PATCH 02/13] 9p: Tell the VFS that readpage
 was synchronous
Message-ID: <20200918055919.GA30929@nautica>
References: <20200917151050.5363-1-willy@infradead.org>
 <20200917151050.5363-3-willy@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200917151050.5363-3-willy@infradead.org>
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
> diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
> index cce9ace651a2..506ca0ba2ec7 100644
> --- a/fs/9p/vfs_addr.c
> +++ b/fs/9p/vfs_addr.c
> @@ -280,6 +280,10 @@ static int v9fs_write_begin(struct file *filp, struct address_space *mapping,
>  		goto out;
>  
>  	retval = v9fs_fid_readpage(v9inode->writeback_fid, page);
> +	if (retval == AOP_UPDATED_PAGE) {
> +		retval = 0;
> +		goto out;
> +	}

FWIW this is a change of behaviour; for some reason the code used to
loop back to grab_cache_page_write_begin() and bail out on
PageUptodate() I suppose; some sort of race check?
The whole pattern is a bit weird to me and 9p has no guarantee on
concurrent writes to a file with cache enabled (except that it will
corrupt something), so this part is fine with me.

What I'm curious about is the page used to be both unlocked and put, but
now isn't either and the return value hasn't changed for the caller to
make a difference on write_begin / I don't see any code change in the
vfs  to handle that.
What did I miss?


(FWIW at least cifs in the series has the same pattern change; didn't
check all of them)


Thanks,
-- 
Dominique

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

