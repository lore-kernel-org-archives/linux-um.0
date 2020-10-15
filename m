Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Date: Thu, 15 Oct 2020 10:02:42 +0100
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 00/16] Allow readpage to return a locked page
Message-ID: <20201015090242.GA12879@infradead.org>
References: <20201009143104.22673-1-willy@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201009143104.22673-1-willy@infradead.org>
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
Cc: linux-cifs@vger.kernel.org, Richard Weinberger <richard@nod.at>, ecryptfs@vger.kernel.org, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-mm@kvack.org, linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org, v9fs-developer@lists.sourceforge.net, ceph-devel@vger.kernel.org, linux-afs@lists.infradead.org

On Fri, Oct 09, 2020 at 03:30:48PM +0100, Matthew Wilcox (Oracle) wrote:
> Ideally all filesystems would return from ->readpage with the page
> Uptodate and Locked, but it's a bit painful to convert all the
> asynchronous readpage implementations to synchronous.  The first 14
> filesystems converted are already synchronous.  The last two patches
> convert iomap to synchronous readpage.

Is it really that bad?  It seems like a lot of the remainig file systems
use the generic mpage/buffer/nobh helpers.

But I guess this series is a good first step.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

