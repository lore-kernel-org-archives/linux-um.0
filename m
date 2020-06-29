Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
MIME-Version: 1.0
References: <20200627143453.31835-1-rppt@kernel.org>
In-Reply-To: <20200627143453.31835-1-rppt@kernel.org>
From: Pekka Enberg <penberg@gmail.com>
Date: Mon, 29 Jun 2020 17:01:14 +0300
Message-ID: <CAOJsxLE47WP9aMY3nh=E7C1a_esHt=sBFWCnsVA2umZ7TZ6TTA@mail.gmail.com>
Subject: Re: [PATCH 0/8] mm: cleanup usage of <asm/pgalloc.h>
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
To: Mike Rapoport <rppt@kernel.org>
Cc: ia64 <linux-ia64@vger.kernel.org>, linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, linux-mips@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>, Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>, linux-csky@vger.kernel.org, sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org, "list@ebiederm.org:DOCUMENTATION <linux-doc@vger.kernel.org>," list@ebiederm.org, MEMORY MANAGEMENT <linux-mm@kvack.org>, " <linux-arch@vger.kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>," linux-hexagon@vger.kernel.org, Joerg Roedel <joro@8bytes.org>, Christophe Leroy <christophe.leroy@csgroup.eu>, Mike Rapoport <rppt@linux.ibm.com>, Abdul Haleem <abdhalee@linux.vnet.ibm.com>, linux-snps-arc@lists.infradead.org, linux-xtensa@linux-xtensa.org, Arnd Bergmann <arnd@arndb.de>, linux-s390@vger.kernel.org, linux-um@lists.infradead.org, Steven Rostedt <rostedt@goodmis.org>, linux-m68k@lists.linux-m68k.org, openrisc@lists.librecores.org, Andy Lutomirski <luto@kernel.org>, Stafford Horne <shorne@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-parisc@vger.kernel.org, "linux-mm@kvack.org" <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>, linux-alpha@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org

On Sat, Jun 27, 2020 at 5:35 PM Mike Rapoport <rppt@kernel.org> wrote:
> Most architectures have very similar versions of pXd_alloc_one() and
> pXd_free_one() for intermediate levels of page table.
> These patches add generic versions of these functions in
> <asm-generic/pgalloc.h> and enable use of the generic functions where
> appropriate.

Very nice cleanup series to the page table code!

FWIW:

Reviewed-by: Pekka Enberg <penberg@kernel.org>

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

