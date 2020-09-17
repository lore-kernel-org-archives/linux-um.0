Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Message-ID: <57d35fdb5ea646f96b70fd8b8a29434761c3f1d3.camel@kernel.org>
Subject: Re: [PATCH 04/13] ceph: Tell the VFS that readpage was synchronous
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 17 Sep 2020 12:49:40 -0400
In-Reply-To: <20200917151050.5363-5-willy@infradead.org>
References: <20200917151050.5363-1-willy@infradead.org>
 <20200917151050.5363-5-willy@infradead.org>
MIME-Version: 1.0
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
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-fsdevel@vger.kernel.org
Cc: linux-cifs@vger.kernel.org, Richard Weinberger <richard@nod.at>, ecryptfs@vger.kernel.org, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-mtd@lists.infradead.org, v9fs-developer@lists.sourceforge.net, ceph-devel@vger.kernel.org, linux-afs@lists.infradead.org

On Thu, 2020-09-17 at 16:10 +0100, Matthew Wilcox (Oracle) wrote:
> The ceph readpage implementation was already synchronous, so use
> AOP_UPDATED_PAGE to avoid cycling the page lock.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/ceph/addr.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> index 6ea761c84494..b2bf8bf7a312 100644
> --- a/fs/ceph/addr.c
> +++ b/fs/ceph/addr.c
> @@ -291,10 +291,11 @@ static int ceph_do_readpage(struct file *filp, struct page *page)
>  static int ceph_readpage(struct file *filp, struct page *page)
>  {
>  	int r = ceph_do_readpage(filp, page);
> -	if (r != -EINPROGRESS)
> -		unlock_page(page);
> -	else
> -		r = 0;
> +	if (r == -EINPROGRESS)
> +		return 0;
> +	if (r == 0)
> +		return AOP_UPDATED_PAGE;
> +	unlock_page(page);
>  	return r;
>  }
>  

Looks good to me. I assume you'll merge all of these as a set since the
early ones are a prerequisite?

Reviewed-by: Jeff Layton <jlayton@kernel.org>


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

