Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l2G0y-0003wc-5U
 for linux-um@lists.infradead.org; Wed, 20 Jan 2021 16:07:25 +0000
Subject: Re: [PATCH] init/module: split CONFIG_CONSTRUCTORS to fix module gcov
 on UML
References: <20210119121853.4e22b2506c9a.I1358f584b76f1898373adfed77f4462c8705b736@changeid>
From: Peter Oberparleiter <oberpar@linux.ibm.com>
Message-ID: <8191aa4a-3bd7-5de7-1ad2-73b851128ff3@linux.ibm.com>
Date: Wed, 20 Jan 2021 17:07:11 +0100
MIME-Version: 1.0
In-Reply-To: <20210119121853.4e22b2506c9a.I1358f584b76f1898373adfed77f4462c8705b736@changeid>
Content-Language: en-US
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
To: Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org
Cc: linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Johannes Berg <johannes.berg@intel.com>, linux-kernel@vger.kernel.org, Jessica Yu <jeyu@kernel.org>, Andrew Morton <akpm@linux-foundation.org>

On 19.01.2021 12:18, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> On ARCH=um, loading a module doesn't result in its constructors
> getting called, which breaks module gcov since the debugfs files
> are never registered. On the other hand, in-kernel constructors
> have already been called by the dynamic linker, so we can't call
> them again.
> 
> Get out of this conundrum by splitting CONFIG_CONSTRUCTORS into
> CONFIG_CONSTRUCTORS_KERNEL and CONFIG_CONSTRUCTORS_MODULE, both
> of which are enabled by default if CONFIG_CONSTRUCTORS is turned
> on, but CONFIG_CONSTRUCTORS_KERNEL depends on !UML so that it's
> not used on ARCH=um.
> 
> Also remove the "if !UML" from GCOV selecting CONSTRUCTORS now,
> since we really do want CONSTRUCTORS, just not kernel binary
> ones.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Do you expect other users for these new config symbols? If not it seems
to me that the goal of enabling module constructors for UML could also
be achieved without introducing new config symbols.

For example you could suppress calling any built-in kernel constructors
in case of UML by extending the ifdef in do_ctors() to depend on both
CONFIG_CONSTRUCTORS and !CONFIG_UML (maybe with an explanatory comment).

Of course you'd still need to remove the !UML dependency in
CONFIG_GCOV_KERNEL.

> ---
> Tested with a kernel configured with CONFIG_GCOV_KERNEL, without
> the patch nothing ever appears in /sys/kernel/debug/gcov/ (apart
> from the reset file), and with it we get the files and they work.
> 
> I have no idea which tree this might go through, any suggestions?

So far Andrew Morton was kind enough to pick up gcov-kernel related
changes, so that route might be an option.


-- 
Peter Oberparleiter
Linux on Z Development - IBM Germany

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

