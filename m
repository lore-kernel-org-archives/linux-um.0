Return-Path: <linux-mtd-bounces+geert=linux-m68k.org@lists.infradead.org>
Date: Thu, 15 Oct 2020 10:08:04 +0100
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 02/16] mm: Inline wait_on_page_read into its one caller
Message-ID: <20201015090804.GC12879@infradead.org>
References: <20201009143104.22673-1-willy@infradead.org>
 <20201009143104.22673-3-willy@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201009143104.22673-3-willy@infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+geert=linux-m68k.org@lists.infradead.org
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: linux-cifs@vger.kernel.org, Richard Weinberger <richard@nod.at>, ecryptfs@vger.kernel.org, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-mm@kvack.org, linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org, v9fs-developer@lists.sourceforge.net, ceph-devel@vger.kernel.org, linux-afs@lists.infradead.org
List-ID: <linux-um.lists.infradead.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/

