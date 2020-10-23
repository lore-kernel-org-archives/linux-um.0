Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from bhuna.collabora.co.uk ([2a00:1098:0:82:1000:25:2eeb:e3e3])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kVyMA-00059M-3g
 for linux-um@lists.infradead.org; Fri, 23 Oct 2020 14:47:51 +0000
From: Christopher Obbard <chris.obbard@collabora.com>
Subject: Re: [PATCH] um: Call pgtable_pmd_page_dtor() in __pmd_free_tlb()
Date: Fri, 23 Oct 2020 15:47:31 +0100
Message-Id: <20201023144731.303328-1-chris.obbard@collabora.com>
In-Reply-To: <20201019211049.22524-1-richard@nod.at>
References: <20201019211049.22524-1-richard@nod.at>
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
To: Richard Weinberger <richard@nod.at>
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, anton.ivanov@cambridgegreys.com

On Mon, Oct 19, 2020 at 11:10:49PM +0200, Richard Weinberger wrote:
> Commit b2b29d6d0119 ("mm: account PMD tables like PTE tables") uncovered
> a bug in uml, we forgot to call the destructor.
> While we are here, give x a sane name.
> 
> Reported-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> Co-developed-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Richard Weinberger <richard@nod.at>

Tested-by: Christopher Obbard <chris.obbard@collabora.com>

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

