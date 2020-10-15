Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Date: Thu, 15 Oct 2020 15:06:31 +0100
From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2 01/16] mm: Add AOP_UPDATED_PAGE return value
Message-ID: <20201015140631.GZ20115@casper.infradead.org>
References: <20201009143104.22673-1-willy@infradead.org>
 <20201009143104.22673-2-willy@infradead.org>
 <20201015090651.GB12879@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201015090651.GB12879@infradead.org>
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
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-cifs@vger.kernel.org, Richard Weinberger <richard@nod.at>, ecryptfs@vger.kernel.org, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-mm@kvack.org, linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org, v9fs-developer@lists.sourceforge.net, ceph-devel@vger.kernel.org, linux-afs@lists.infradead.org

On Thu, Oct 15, 2020 at 10:06:51AM +0100, Christoph Hellwig wrote:
> Don't we also need to handle the new return value in a few other places
> like cachefiles_read_reissue swap_readpage?  Maybe those don't get
> called on the currently converted instances, but just leaving them
> without handling AOP_UPDATED_PAGE seems like a time bomb.

Er, right.  And nobh_truncate_page(), and read_page().  And then I
noticed the bug in cachefiles_read_reissue().  Sigh.

Updated patch series coming soon.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

