Return-Path: <linux-arm-kernel-bounces+geert.uytterhoeven=gmail.com@lists.infradead.org>
Date: Mon, 25 Mar 2019 16:19:06 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v2 1/1] treewide: Switch printk users from %pf and %pF to
 %ps and %pS, respectively
Message-ID: <20190325211906.GA24180@google.com>
References: <20190325193229.23390-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190325193229.23390-1-sakari.ailus@linux.intel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+geert.uytterhoeven=gmail.com@lists.infradead.org
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Petr Mladek <pmladek@suse.com>, linux-scsi@vger.kernel.org, linux-pm@vger.kernel.org, linux-mmc@vger.kernel.org, linux-nvdimm@lists.01.org, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org, linux-acpi@vger.kernel.org, netdev@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-pci@vger.kernel.org, sparclinux@vger.kernel.org, xen-devel@lists.xenproject.org, ceph-devel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org, drbd-dev@lists.linbit.com
List-ID: <linux-um.lists.infradead.org>

On Mon, Mar 25, 2019 at 09:32:28PM +0200, Sakari Ailus wrote:
> %pF and %pf are functionally equivalent to %pS and %ps conversion
> specifiers. The former are deprecated, therefore switch the current users
> to use the preferred variant.
> 
> The changes have been produced by the following command:
> 
> 	git grep -l '%p[fF]' | grep -v '^\(tools\|Documentation\)/' | \
> 	while read i; do perl -i -pe 's/%pf/%ps/g; s/%pF/%pS/g;' $i; done
> 
> And verifying the result.
> 
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> Acked-by: David Sterba <dsterba@suse.com> (for btrfs)
> Acked-by: Mike Rapoport <rppt@linux.ibm.com> (for mm/memblock.c)
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com> (for drivers/pci)

Thanks a lot for cleaning this up.  This has been annoying for a long time.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

