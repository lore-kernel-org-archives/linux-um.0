Return-Path: <openrisc-bounces@lists.librecores.org>
Message-ID: <48ab9e36-48be-916e-2ce7-03ef59d67dae@arm.com>
Date: Tue, 12 Jul 2022 08:09:53 +0530
MIME-Version: 1.0
Subject: Re: [PATCH V7 00/26] mm/mmap: Drop __SXXX/__PXXX macros from across
 platforms
Content-Language: en-US
References: <20220711070600.2378316-1-anshuman.khandual@arm.com>
 <20220711131417.9cac57d9b88eea8bbd7d8616@linux-foundation.org>
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20220711131417.9cac57d9b88eea8bbd7d8616@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Unsubscribe: <https://lists.librecores.org/options/openrisc>,
 <mailto:openrisc-request@lists.librecores.org?subject=unsubscribe>
List-Archive: <http://lists.librecores.org/pipermail/openrisc/>
List-Post: <mailto:openrisc@lists.librecores.org>
List-Help: <mailto:openrisc-request@lists.librecores.org?subject=help>
List-Subscribe: <https://lists.librecores.org/listinfo/openrisc>,
 <mailto:openrisc-request@lists.librecores.org?subject=subscribe>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-m68k@vger.kernel.org, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-csky@vger.kernel.org, sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-hexagon@vger.kernel.org, x86@kernel.org, christophe.leroy@csgroup.eu, hch@infradead.org, linux-snps-arc@lists.infradead.org, linux-xtensa@linux-xtensa.org, linux-um@lists.infradead.org, openrisc@lists.librecores.org, linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org, linux-mips@vger.kernel.org, linux-alpha@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-ID: <linux-um.lists.infradead.org>



On 7/12/22 01:44, Andrew Morton wrote:
> On Mon, 11 Jul 2022 12:35:34 +0530 Anshuman Khandual <anshuman.khandual@arm.com> wrote:
> 
>> This series drops __SXXX/__PXXX macros from across platforms in the tree.
> 
> I've updated mm-unstable to this version, thanks.  I skipped the added-to-mm
> emails to avoid wearing out people's inboxes.
> 
> Reissuing a 26-patch series N times is rather noisy.  Please prefer to send incremental
> fixes when changes are minor.  It makes it so much easier for reviewers to see what
> happened.

Sure, got it, will follow next time.

