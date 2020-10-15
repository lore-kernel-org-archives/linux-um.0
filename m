Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Date: Thu, 15 Oct 2020 10:06:51 +0100
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 01/16] mm: Add AOP_UPDATED_PAGE return value
Message-ID: <20201015090651.GB12879@infradead.org>
References: <20201009143104.22673-1-willy@infradead.org>
 <20201009143104.22673-2-willy@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201009143104.22673-2-willy@infradead.org>
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

Don't we also need to handle the new return value in a few other places
like cachefiles_read_reissue swap_readpage?  Maybe those don't get
called on the currently converted instances, but just leaving them
without handling AOP_UPDATED_PAGE seems like a time bomb.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

