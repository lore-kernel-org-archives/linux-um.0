Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Date: Thu, 17 Sep 2020 23:03:07 +0100
From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 01/13] mm: Add AOP_UPDATED_PAGE return value
Message-ID: <20200917220307.GX5449@casper.infradead.org>
References: <20200917151050.5363-1-willy@infradead.org>
 <20200917151050.5363-2-willy@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200917151050.5363-2-willy@infradead.org>
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
To: linux-fsdevel@vger.kernel.org
Cc: linux-cifs@vger.kernel.org, Richard Weinberger <richard@nod.at>, ecryptfs@vger.kernel.org, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-mtd@lists.infradead.org, v9fs-developer@lists.sourceforge.net, ceph-devel@vger.kernel.org, linux-afs@lists.infradead.org

On Thu, Sep 17, 2020 at 04:10:38PM +0100, Matthew Wilcox (Oracle) wrote:
> +++ b/mm/filemap.c
> @@ -2254,8 +2254,10 @@ ssize_t generic_file_buffered_read(struct kiocb *iocb,
>  		 * PG_error will be set again if readpage fails.
>  		 */
>  		ClearPageError(page);
> -		/* Start the actual read. The read will unlock the page. */
> +		/* Start the actual read. The read may unlock the page. */
>  		error = mapping->a_ops->readpage(filp, page);
> +		if (error == AOP_UPDATED_PAGE)
> +			goto page_ok;
>  
>  		if (unlikely(error)) {
>  			if (error == AOP_TRUNCATED_PAGE) {

If anybody wants to actually test this, this hunk is wrong.

+++ b/mm/filemap.c
@@ -2256,8 +2256,11 @@ ssize_t generic_file_buffered_read(struct kiocb *iocb,
                ClearPageError(page);
                /* Start the actual read. The read may unlock the page. */
                error = mapping->a_ops->readpage(filp, page);
-               if (error == AOP_UPDATED_PAGE)
+               if (error == AOP_UPDATED_PAGE) {
+                       unlock_page(page);
+                       error = 0;
                        goto page_ok;
+               }
 
                if (unlikely(error)) {
                        if (error == AOP_TRUNCATED_PAGE) {

> @@ -2619,7 +2621,7 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
>  	 */
>  	if (unlikely(!PageUptodate(page)))
>  		goto page_not_uptodate;
> -
> +page_ok:
>  	/*
>  	 * We've made it this far and we had to drop our mmap_lock, now is the
>  	 * time to return to the upper layer and have it re-find the vma and
> @@ -2654,6 +2656,8 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
>  	ClearPageError(page);
>  	fpin = maybe_unlock_mmap_for_io(vmf, fpin);
>  	error = mapping->a_ops->readpage(file, page);
> +	if (error == AOP_UPDATED_PAGE)
> +		goto page_ok;
>  	if (!error) {
>  		wait_on_page_locked(page);
>  		if (!PageUptodate(page))
> @@ -2867,6 +2871,10 @@ static struct page *do_read_cache_page(struct address_space *mapping,
>  			err = filler(data, page);
>  		else
>  			err = mapping->a_ops->readpage(data, page);
> +		if (err == AOP_UPDATED_PAGE) {
> +			unlock_page(page);
> +			goto out;
> +		}
>  
>  		if (err < 0) {
>  			put_page(page);
> -- 
> 2.28.0
> 

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

