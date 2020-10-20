Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Date: Tue, 20 Oct 2020 02:51:15 +0100
From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] um: Call pgtable_pmd_page_dtor() in __pmd_free_tlb()
Message-ID: <20201020015115.GX20115@casper.infradead.org>
References: <20201019211049.22524-1-richard@nod.at>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201019211049.22524-1-richard@nod.at>
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
To: Richard Weinberger <richard@nod.at>
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, anton.ivanov@cambridgegreys.com

On Mon, Oct 19, 2020 at 11:10:49PM +0200, Richard Weinberger wrote:
> Commit b2b29d6d0119 ("mm: account PMD tables like PTE tables") uncovered
> a bug in uml, we forgot to call the destructor.
> While we are here, give x a sane name.
> 
> Reported-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> Co-developed-by: Matthew Wilcox <willy@infradead.org>

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

> Signed-off-by: Richard Weinberger <richard@nod.at>

And as a bonus, $ grep PageTables /proc/meminfo 
PageTables:       128720 kB

gets more accurate!

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

